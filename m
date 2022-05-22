Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297F8530193
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiEVHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiEVHbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:31:53 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F52C665;
        Sun, 22 May 2022 00:31:50 -0700 (PDT)
Received: from [192.168.0.175] (ip5f5aea9a.dynamic.kabel-deutschland.de [95.90.234.154])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6816161EA1928;
        Sun, 22 May 2022 09:31:47 +0200 (CEST)
Message-ID: <62b09487-9223-db3d-2165-789a51230060@molgen.mpg.de>
Date:   Sun, 22 May 2022 09:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 12/15] md/raid5-cache: Add RCU protection to conf->log
 accesses
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220519191311.17119-1-logang@deltatee.com>
 <20220519191311.17119-13-logang@deltatee.com>
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <20220519191311.17119-13-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.22 21:13, Logan Gunthorpe wrote:
> The mdadm test 21raid5cache randomly fails with NULL pointer accesses
> conf->log when run repeatedly. conf->log was sort of protected with
> a RCU, but most dereferences were not done with the correct functions.
> 
> Add rcu_read_locks() and rcu_access_pointers() to the appropriate
> places.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/md/raid5-cache.c | 135 +++++++++++++++++++++++++++------------
>   drivers/md/raid5-log.h   |  14 ++--
>   drivers/md/raid5.c       |   4 +-
>   drivers/md/raid5.h       |   2 +-
>   4 files changed, 104 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index f7b402138d16..1dbc7c4b9a15 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -254,7 +254,14 @@ static bool __r5c_is_writeback(struct r5l_log *log)
>   
>   bool r5c_is_writeback(struct r5conf *conf)
>   {
> -	return __r5c_is_writeback(conf->log);
> +	struct r5l_log *log;
> +	bool ret;
> +
> +	rcu_read_lock();
> +	log = rcu_dereference(conf->log);
> +	ret = __r5c_is_writeback(log);
> +	rcu_read_unlock();
> +	return ret;
>   }
>   
>   static sector_t r5l_ring_add(struct r5l_log *log, sector_t start, sector_t inc)
> @@ -340,12 +347,23 @@ static void __r5l_wake_reclaim(struct r5l_log *log, sector_t space)
>   	md_wakeup_thread(log->reclaim_thread);
>   }
>   
> +static struct r5l_log *get_log_for_io(struct r5conf *conf)
> +{
> +	/*
> +	 * rcu_dereference_protected is safe because the array will be
> +	 * quiesced before log_exit() so it can't be called while
> +	 * an IO is in progress.
> +	 */
> +	return rcu_dereference_protected(conf->log, 1);
> +}
> +
>   /* Check whether we should flush some stripes to free up stripe cache */
>   void r5c_check_stripe_cache_usage(struct r5conf *conf)
>   {
> +	struct r5l_log *log = get_log_for_io(conf);
>   	int total_cached;
>   
> -	if (!r5c_is_writeback(conf))
> +	if (!__r5c_is_writeback(log))
>   		return;
>   
>   	total_cached = atomic_read(&conf->r5c_cached_partial_stripes) +
> @@ -361,7 +379,7 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
>   	 */
>   	if (total_cached > conf->min_nr_stripes * 1 / 2 ||
>   	    atomic_read(&conf->empty_inactive_list_nr) > 0)
> -		__r5l_wake_reclaim(conf->log, 0);
> +		__r5l_wake_reclaim(log, 0);
>   }
>   
>   /*
> @@ -370,8 +388,7 @@ void r5c_check_stripe_cache_usage(struct r5conf *conf)
>    */
>   void r5c_check_cached_full_stripe(struct r5conf *conf)
>   {
> -	if (!r5c_is_writeback(conf))
> -		return;
> +	struct r5l_log *log = get_log_for_io(conf);
>   
>   	/*
>   	 * wake up reclaim for R5C_FULL_STRIPE_FLUSH_BATCH cached stripes
> @@ -380,7 +397,7 @@ void r5c_check_cached_full_stripe(struct r5conf *conf)
>   	if (atomic_read(&conf->r5c_cached_full_stripes) >=
>   	    min(R5C_FULL_STRIPE_FLUSH_BATCH(conf),
>   		conf->chunk_sectors >> RAID5_STRIPE_SHIFT(conf)))
> -		__r5l_wake_reclaim(conf->log, 0);
> +		__r5l_wake_reclaim(log, 0);
>   }
>   
>   /*
> @@ -703,7 +720,7 @@ static void r5c_disable_writeback_async(struct work_struct *work)
>   
>   	/* wait superblock change before suspend */
>   	wait_event(mddev->sb_wait,
> -		   conf->log == NULL ||
> +		   rcu_access_pointer(conf->log) ||
>   		   (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags) &&
>   		    (locked = mddev_trylock(mddev))));
>   	if (locked) {
> @@ -1001,7 +1018,7 @@ static inline void r5l_add_no_space_stripe(struct r5l_log *log,
>    */
>   int r5l_write_stripe(struct r5conf *conf, struct stripe_head *sh)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log = get_log_for_io(conf);
>   	int write_disks = 0;
>   	int data_pages, parity_pages;
>   	int reserve;
> @@ -1099,7 +1116,8 @@ int r5l_write_stripe(struct r5conf *conf, struct stripe_head *sh)
>   
>   void r5l_write_stripe_run(struct r5conf *conf)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log = get_log_for_io(conf);
> +
>   	if (!log)
>   		return;
>   	mutex_lock(&log->io_mutex);
> @@ -1109,7 +1127,7 @@ void r5l_write_stripe_run(struct r5conf *conf)
>   
>   int r5l_handle_flush_request(struct r5conf *conf, struct bio *bio)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log = get_log_for_io(conf);
>   
>   	if (log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_THROUGH) {
>   		/*
> @@ -1297,7 +1315,7 @@ static void r5l_log_flush_endio(struct bio *bio)
>    */
>   void r5l_flush_stripe_to_raid(struct r5conf *conf)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log = get_log_for_io(conf);
>   	bool do_flush;
>   
>   	if (!log || !log->need_cache_flush)
> @@ -1412,7 +1430,7 @@ void r5c_flush_cache(struct r5conf *conf, int num)
>   	struct stripe_head *sh, *next;
>   
>   	lockdep_assert_held(&conf->device_lock);
> -	if (!conf->log)
> +	if (!rcu_access_pointer(conf->log))
>   		return;
>   
>   	count = 0;
> @@ -1431,9 +1449,8 @@ void r5c_flush_cache(struct r5conf *conf, int num)
>   	}
>   }
>   
> -static void r5c_do_reclaim(struct r5conf *conf)
> +static void r5c_do_reclaim(struct r5conf *conf, struct r5l_log *log)
>   {
> -	struct r5l_log *log = conf->log;
>   	struct stripe_head *sh;
>   	int count = 0;
>   	unsigned long flags;
> @@ -1441,7 +1458,7 @@ static void r5c_do_reclaim(struct r5conf *conf)
>   	int stripes_to_flush;
>   	int flushing_partial, flushing_full;
>   
> -	if (!r5c_is_writeback(conf))
> +	if (!__r5c_is_writeback(log))
>   		return;
>   
>   	flushing_partial = atomic_read(&conf->r5c_flushing_partial_stripes);
> @@ -1561,22 +1578,30 @@ static void r5l_reclaim_thread(struct md_thread *thread)
>   {
>   	struct mddev *mddev = thread->mddev;
>   	struct r5conf *conf = mddev->private;
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log;
>   
> +	/*
> +	 * This is safe, because the reclaim thread will be stopped before
> +	 * the log is freed in log_exit()
> +	 */
> +	log = rcu_dereference_protected(conf->log, 1);
>   	if (!log)
>   		return;
> -	r5c_do_reclaim(conf);
> +
> +	r5c_do_reclaim(conf, log);
>   	r5l_do_reclaim(log);
>   }
>   
>   void r5l_wake_reclaim(struct r5conf *conf, sector_t space)
>   {
> -	__r5l_wake_reclaim(conf->log, space);
> +	struct r5l_log *log = get_log_for_io(conf);
> +
> +	__r5l_wake_reclaim(log, space);
>   }
>   
>   void r5l_quiesce(struct r5conf *conf, int quiesce)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log = get_log_for_io(conf);
>   	struct mddev *mddev;
>   
>   	if (quiesce) {
> @@ -2534,16 +2559,20 @@ static void r5l_write_super(struct r5l_log *log, sector_t cp)
>   static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
>   {
>   	struct r5conf *conf;
> -	int ret;
> +	struct r5l_log *log;
> +	int ret = 0;
>   
>   	spin_lock(&mddev->lock);
>   	conf = mddev->private;
> -	if (!conf || !conf->log) {
> -		spin_unlock(&mddev->lock);
> -		return 0;
> -	}
> +	if (!conf)
> +		goto out_spin_unlock;
> +
> +	rcu_read_lock();
> +	log = rcu_dereference(conf->log);
> +	if (!log)
> +		goto out;
>   
> -	switch (conf->log->r5c_journal_mode) {
> +	switch (log->r5c_journal_mode) {
>   	case R5C_JOURNAL_MODE_WRITE_THROUGH:
>   		ret = snprintf(
>   			page, PAGE_SIZE, "[%s] %s\n",
> @@ -2559,6 +2588,10 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
>   	default:
>   		ret = 0;
>   	}
> +
> +out:
> +	rcu_read_unlock();
> +out_spin_unlock:
>   	spin_unlock(&mddev->lock);
>   	return ret;
>   }
> @@ -2572,13 +2605,15 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
>   int r5c_journal_mode_set(struct mddev *mddev, int mode)
>   {
>   	struct r5conf *conf;
> +	struct r5l_log *log;
> +	int ret = 0;
>   
>   	if (mode < R5C_JOURNAL_MODE_WRITE_THROUGH ||
>   	    mode > R5C_JOURNAL_MODE_WRITE_BACK)
>   		return -EINVAL;
>   
>   	conf = mddev->private;
> -	if (!conf || !conf->log)
> +	if (!conf || !rcu_access_pointer(conf->log))
>   		return -ENODEV;
>   
>   	if (raid5_calc_degraded(conf) > 0 &&
> @@ -2586,12 +2621,19 @@ int r5c_journal_mode_set(struct mddev *mddev, int mode)
>   		return -EINVAL;
>   
>   	mddev_suspend(mddev);
> -	conf->log->r5c_journal_mode = mode;
> +	rcu_read_lock();
> +	log = rcu_dereference(conf->log);
> +	if (log) {
> +		log->r5c_journal_mode = mode;
> +		pr_debug("md/raid:%s: setting r5c cache mode to %d: %s\n",
> +			 mdname(mddev), mode, r5c_journal_mode_str[mode]);
> +	} else {
> +		ret = -ENODEV;
> +	}
> +	rcu_read_unlock();
>   	mddev_resume(mddev);
>   
> -	pr_debug("md/raid:%s: setting r5c cache mode to %d: %s\n",
> -		 mdname(mddev), mode, r5c_journal_mode_str[mode]);
> -	return 0;
> +	return ret;
>   }
>   EXPORT_SYMBOL(r5c_journal_mode_set);
>   
> @@ -2637,7 +2679,7 @@ int r5c_try_caching_write(struct r5conf *conf,
>   			  struct stripe_head_state *s,
>   			  int disks)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log = get_log_for_io(conf);
>   	int i;
>   	struct r5dev *dev;
>   	int to_cache = 0;
> @@ -2804,7 +2846,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
>   				 struct stripe_head *sh,
>   				 struct stripe_head_state *s)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log = get_log_for_io(conf);
>   	int i;
>   	int do_wakeup = 0;
>   	sector_t tree_index;
> @@ -2887,7 +2929,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
>   
>   int r5c_cache_data(struct r5conf *conf, struct stripe_head *sh)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log = get_log_for_io(conf);
>   	int pages = 0;
>   	int reserve;
>   	int i;
> @@ -2943,7 +2985,7 @@ int r5c_cache_data(struct r5conf *conf, struct stripe_head *sh)
>   /* check whether this big stripe is in write back cache. */
>   bool r5c_big_stripe_cached(struct r5conf *conf, sector_t sect)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log = get_log_for_io(conf);
>   	sector_t tree_index;
>   	void *slot;
>   
> @@ -2953,6 +2995,7 @@ bool r5c_big_stripe_cached(struct r5conf *conf, sector_t sect)
>   	WARN_ON_ONCE(!rcu_read_lock_held());
>   	tree_index = r5c_tree_index(conf, sect);
>   	slot = radix_tree_lookup(&log->big_stripe_tree, tree_index);
> +
>   	return slot != NULL;
>   }
>   
> @@ -3033,30 +3076,38 @@ static int r5l_load_log(struct r5l_log *log)
>   
>   int r5l_start(struct r5conf *conf)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log;
>   	int ret;
>   
> +	log = rcu_dereference_protected(conf->log,
> +			lockdep_is_held(&conf->mddev->reconfig_mutex));
>   	if (!log)
>   		return 0;
>   
>   	ret = r5l_load_log(log);
>   	if (ret)
>   		r5l_exit_log(conf);
> +
>   	return ret;
>   }
>   
>   void r5c_update_on_rdev_error(struct mddev *mddev, struct md_rdev *rdev)
>   {
>   	struct r5conf *conf = mddev->private;
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log;
>   
> +	rcu_read_lock();
> +	log = rcu_dereference(conf->log);
>   	if (!log)
> -		return;
> +		goto out;
>   
>   	if ((raid5_calc_degraded(conf) > 0 ||
>   	     test_bit(Journal, &rdev->flags)) &&
> -	    conf->log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_BACK)
> +	    log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_BACK)
>   		schedule_work(&log->disable_writeback_work);
> +
> +out:
> +	rcu_read_unlock();
>   }
>   
>   int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
> @@ -3164,15 +3215,17 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
>   
>   void r5l_exit_log(struct r5conf *conf)
>   {
> -	struct r5l_log *log = conf->log;
> +	struct r5l_log *log;
>   
> -	conf->log = NULL;
> -	synchronize_rcu();
> +	lockdep_assert_held(&conf->mddev->reconfig_mutex);
> +	log = rcu_replace_pointer(conf->log, NULL, 1);
>   
>   	/* Ensure disable_writeback_work wakes up and exits */
>   	wake_up(&conf->mddev->sb_wait);
>   	flush_work(&log->disable_writeback_work);
>   	md_unregister_thread(&log->reclaim_thread);
> +	synchronize_rcu();
> +
>   	mempool_exit(&log->meta_pool);
>   	bioset_exit(&log->bs);
>   	mempool_exit(&log->io_pool);
> diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
> index f26e6f4c7f9a..24b4dbd5b25c 100644
> --- a/drivers/md/raid5-log.h
> +++ b/drivers/md/raid5-log.h
> @@ -58,7 +58,7 @@ static inline int log_stripe(struct stripe_head *sh, struct stripe_head_state *s
>   {
>   	struct r5conf *conf = sh->raid_conf;
>   
> -	if (conf->log) {
> +	if (rcu_access_pointer(conf->log)) {


A problem here is that `struct r5l_log` of `conf->log` is private to raid5-cache.c and gcc below version 10 (wrongly) regards the `typeof(*p) *local` declaration of __rcu_access_pointer as a dereference:

   CC      drivers/md/raid5.o

In file included from ./include/linux/rculist.h:11:0,

                  from ./include/linux/dcache.h:8,

                  from ./include/linux/fs.h:8,

                  from ./include/linux/highmem.h:5,

                  from ./include/linux/bvec.h:10,

                  from ./include/linux/blk_types.h:10,

                  from ./include/linux/blkdev.h:9,

                  from drivers/md/raid5.c:38:

drivers/md/raid5-log.h: In function ‘log_stripe’:

./include/linux/rcupdate.h:384:9: error: dereferencing pointer to incomplete type ‘struct r5l_log’

   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \

          ^

./include/linux/rcupdate.h:495:31: note: in expansion of macro ‘__rcu_access_pointer’

  #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)

                                ^~~~~~~~~~~~~~~~~~~~

drivers/md/raid5-log.h:61:6: note: in expansion of macro ‘rcu_access_pointer’

   if (rcu_access_pointer(conf->log)) {

       ^~~~~~~~~~~~~~~~~~

make[2]: *** [scripts/Makefile.build:288: drivers/md/raid5.o] Error 1

make[1]: *** [scripts/Makefile.build:550: drivers/md] Error 2

make: *** [Makefile:1834: drivers] Error 2


See https://godbolt.org/z/TPP8MdKbc to test compiler versions with this construct.

Best

   Donald


>   		if (!test_bit(STRIPE_R5C_CACHING, &sh->state)) {
>   			/* writing out phase */
>   			if (s->waiting_extra_page)
> @@ -79,7 +79,7 @@ static inline void log_stripe_write_finished(struct stripe_head *sh)
>   {
>   	struct r5conf *conf = sh->raid_conf;
>   
> -	if (conf->log)
> +	if (rcu_access_pointer(conf->log))
>   		r5l_stripe_write_finished(sh);
>   	else if (raid5_has_ppl(conf))
>   		ppl_stripe_write_finished(sh);
> @@ -87,7 +87,7 @@ static inline void log_stripe_write_finished(struct stripe_head *sh)
>   
>   static inline void log_write_stripe_run(struct r5conf *conf)
>   {
> -	if (conf->log)
> +	if (rcu_access_pointer(conf->log))
>   		r5l_write_stripe_run(conf);
>   	else if (raid5_has_ppl(conf))
>   		ppl_write_stripe_run(conf);
> @@ -95,7 +95,7 @@ static inline void log_write_stripe_run(struct r5conf *conf)
>   
>   static inline void log_flush_stripe_to_raid(struct r5conf *conf)
>   {
> -	if (conf->log)
> +	if (rcu_access_pointer(conf->log))
>   		r5l_flush_stripe_to_raid(conf);
>   	else if (raid5_has_ppl(conf))
>   		ppl_write_stripe_run(conf);
> @@ -105,7 +105,7 @@ static inline int log_handle_flush_request(struct r5conf *conf, struct bio *bio)
>   {
>   	int ret = -ENODEV;
>   
> -	if (conf->log)
> +	if (rcu_access_pointer(conf->log))
>   		ret = r5l_handle_flush_request(conf, bio);
>   	else if (raid5_has_ppl(conf))
>   		ret = ppl_handle_flush_request(bio);
> @@ -115,7 +115,7 @@ static inline int log_handle_flush_request(struct r5conf *conf, struct bio *bio)
>   
>   static inline void log_quiesce(struct r5conf *conf, int quiesce)
>   {
> -	if (conf->log)
> +	if (rcu_access_pointer(conf->log))
>   		r5l_quiesce(conf, quiesce);
>   	else if (raid5_has_ppl(conf))
>   		ppl_quiesce(conf, quiesce);
> @@ -123,7 +123,7 @@ static inline void log_quiesce(struct r5conf *conf, int quiesce)
>   
>   static inline void log_exit(struct r5conf *conf)
>   {
> -	if (conf->log)
> +	if (rcu_access_pointer(conf->log))
>   		r5l_exit_log(conf);
>   	else if (raid5_has_ppl(conf))
>   		ppl_exit_log(conf);
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 37fe2af77c93..c06c9ef88417 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7937,7 +7937,7 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>   	struct md_rdev *tmp;
>   
>   	print_raid5_conf(conf);
> -	if (test_bit(Journal, &rdev->flags) && conf->log) {
> +	if (test_bit(Journal, &rdev->flags) && rcu_access_pointer(conf->log)) {
>   		mddev_suspend(mddev);
>   		log_exit(conf);
>   		mddev_resume(mddev);
> @@ -8019,7 +8019,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   	int last = conf->raid_disks - 1;
>   
>   	if (test_bit(Journal, &rdev->flags)) {
> -		if (conf->log)
> +		if (rcu_access_pointer(conf->log))
>   			return -EBUSY;
>   
>   		rdev->raid_disk = 0;
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index 638d29863503..04fe5b6f679c 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -684,7 +684,7 @@ struct r5conf {
>   	struct r5worker_group	*worker_groups;
>   	int			group_cnt;
>   	int			worker_cnt_per_group;
> -	struct r5l_log		*log;
> +	struct r5l_log		__rcu *log;
>   	void			*log_private;
>   
>   	spinlock_t		pending_bios_lock;

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
