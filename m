Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72F9580935
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 03:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiGZB6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 21:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiGZB6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 21:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAA2A22519
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658800722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCUpOoOkHK4Qe7+MOCKP8H0h6UySF4kprz0bzSi+4/o=;
        b=BAqpShdD9ICVBYA8Q5CB1HgTaEYB4FwSao4wTCokeIwO93I4WTe7UAk7VDa/7lDbq6YNMH
        644wIC17sIoGfMe/JdTrgkMFXkbi3O0crxP1bn0xCrsXUoBqgb9X8SoavyMxbrdXVcTrhw
        a4+uqCgoZnaQ7DWeSG1WvJLk0ZRBglI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314--sTkGgEdONOrf6-PT-5z_A-1; Mon, 25 Jul 2022 21:58:41 -0400
X-MC-Unique: -sTkGgEdONOrf6-PT-5z_A-1
Received: by mail-qk1-f200.google.com with SMTP id m8-20020a05620a24c800b006b5d8eb23efso11176148qkn.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zCUpOoOkHK4Qe7+MOCKP8H0h6UySF4kprz0bzSi+4/o=;
        b=CRddYAMvC2Hd3glnsn07ie+xxYVM4WdWTcV1aSp9olwdbL7XGEjTMP4BweR5EjV1Ev
         breUt5EQt/Is9y6Uzmd4+9XuQVXaSQlxk1iYu9qUxMhOXigW4Pqem1FIisp7BEBc0yX7
         2VJfWltLInOaFir/wmufuIxPGi1keTgQzuATHEtdXBXKCzTzIExoq9xNtzQSuRakY7Bb
         wLFXsyyxMVwWWdfY7QNTEKfYNpabuv63VBlRsBfUFwzEl46OUKQSvg7ii4u3mqUn+min
         z6jBRTuh3Q4xCvOOl9KXyd/AREbKMWPIv8IVL4S3voZWArdBsGCvlvE+sOHLleuysO63
         b9Yw==
X-Gm-Message-State: AJIora/7qXLjw876C5I87oQWUmsnaQKQIiz4AoBUYX9T+EwN+jJPnT6e
        ByOT1AwnBWzC8LncownYrUMFRi6tgYT6MTcAGDtKw+n3tsq92p695k793eT6DFPgBBwu3H2FNfi
        ivY4RhWNK12lfcqb+PKqPwn0=
X-Received: by 2002:a05:620a:d82:b0:6a9:9102:3948 with SMTP id q2-20020a05620a0d8200b006a991023948mr11282372qkl.56.1658800721118;
        Mon, 25 Jul 2022 18:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vijl4P35Am0oiyyAfThVl94hZ38U1lqIf7jHZE+5jy7gGqYp+/8q5if2lc6ROMyQVWO3N4nw==
X-Received: by 2002:a05:620a:d82:b0:6a9:9102:3948 with SMTP id q2-20020a05620a0d8200b006a991023948mr11282365qkl.56.1658800720750;
        Mon, 25 Jul 2022 18:58:40 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id n4-20020a05622a11c400b0031ef366c9b5sm9068927qtk.34.2022.07.25.18.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:58:40 -0700 (PDT)
Date:   Mon, 25 Jul 2022 21:58:39 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 3/3] dm-verity: Add try_verify_in_tasklet
Message-ID: <Yt9KTzXUeA8xAiGv@redhat.com>
References: <20220722093823.4158756-1-nhuck@google.com>
 <20220722093823.4158756-4-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722093823.4158756-4-nhuck@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22 2022 at  5:38P -0400,
Nathan Huckleberry <nhuck@google.com> wrote:

> Using tasklets for disk verification can reduce IO latency.  When there are
> accelerated hash instructions it is often better to compute the hash immediately
> using a tasklet rather than deferring verification to a work-queue.  This
> reduces time spent waiting to schedule work-queue jobs, but requires spending
> slightly more time in interrupt context.
> 
> If the dm-bufio cache does not have the required hashes we fallback to
> the work-queue implementation.
> 
> The following shows a speed comparison of random reads on a dm-verity device.
> The dm-verity device uses a 1G ramdisk for data and a 1G ramdisk for hashes.
> One test was run using tasklets and one test was run using the existing
> work-queue solution.  Both tests were run when the dm-bufio cache was hot.  The
> tasklet implementation performs significantly better since there is no time
> waiting for work-queue jobs to be scheduled.
> 
> # /data/fio /data/tasklet.fio | grep READ
>    READ: bw=181MiB/s (190MB/s), 181MiB/s-181MiB/s (190MB/s-190MB/s), io=512MiB
>    (537MB), run=2827-2827msec
> # /data/fio /data/workqueue.fio | grep READ
>    READ: bw=23.6MiB/s (24.8MB/s), 23.6MiB/s-23.6MiB/s (24.8MB/s-24.8MB/s),
>    io=512MiB (537MB), run=21688-21688msec
> 
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  drivers/md/dm-bufio.c         | 14 +++---
>  drivers/md/dm-verity-target.c | 87 ++++++++++++++++++++++++++++++-----
>  drivers/md/dm-verity.h        |  5 ++
>  3 files changed, 87 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> index 3edeca7cfca6..039f39c29594 100644
> --- a/drivers/md/dm-bufio.c
> +++ b/drivers/md/dm-bufio.c
> @@ -92,7 +92,7 @@ struct dm_bufio_client {
>  	s8 sectors_per_block_bits;
>  	void (*alloc_callback)(struct dm_buffer *);
>  	void (*write_callback)(struct dm_buffer *);
> -	bool may_sleep;
> +	bool get_may_sleep;
>  
>  	struct kmem_cache *slab_buffer;
>  	struct kmem_cache *slab_cache;
> @@ -170,7 +170,7 @@ struct dm_buffer {
>  
>  static void dm_bufio_lock(struct dm_bufio_client *c)
>  {
> -	if (c->may_sleep)
> +	if (c->get_may_sleep)
>  		mutex_lock_nested(&c->lock, dm_bufio_in_request());
>  	else
>  		spin_lock_irqsave_nested(&c->spinlock, c->spinlock_flags, dm_bufio_in_request());
> @@ -178,7 +178,7 @@ static void dm_bufio_lock(struct dm_bufio_client *c)
>  
>  static int dm_bufio_trylock(struct dm_bufio_client *c)
>  {
> -	if (c->may_sleep)
> +	if (c->get_may_sleep)
>  		return mutex_trylock(&c->lock);
>  	else
>  		return spin_trylock_irqsave(&c->spinlock, c->spinlock_flags);
> @@ -186,7 +186,7 @@ static int dm_bufio_trylock(struct dm_bufio_client *c)
>  
>  static void dm_bufio_unlock(struct dm_bufio_client *c)
>  {
> -	if (c->may_sleep)
> +	if (c->get_may_sleep)
>  		mutex_unlock(&c->lock);
>  	else
>  		spin_unlock_irqrestore(&c->spinlock, c->spinlock_flags);
> @@ -890,7 +890,7 @@ static struct dm_buffer *__alloc_buffer_wait_no_callback(struct dm_bufio_client
>  	 * be allocated.
>  	 */
>  	while (1) {
> -		if (dm_bufio_cache_size_latch != 1 && c->may_sleep) {
> +		if (dm_bufio_cache_size_latch != 1 && c->get_may_sleep) {
>  			b = alloc_buffer(c, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
>  			if (b)
>  				return b;
> @@ -1761,9 +1761,9 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
>  	c->alloc_callback = alloc_callback;
>  	c->write_callback = write_callback;
>  
> -	c->may_sleep = true;
> +	c->get_may_sleep = true;
>  	if (flags & DM_BUFIO_GET_CANT_SLEEP)
> -		c->may_sleep = false;
> +		c->get_may_sleep = false;
>  
>  	for (i = 0; i < LIST_SIZE; i++) {
>  		INIT_LIST_HEAD(&c->lru[i]);

I ended up inverting the logic and went with the name "no_sleep", see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.20&id=fa9b59cc264f350c1e34ea784ac4c12fcee1aed1

My reasoning is that: the bufio change has broader implications than
just the _get method. So I expanded the scope of the naming to reflect
that the locking and buffers allocations will not sleep if
DM_BUFIO_CLIENT_NO_SLEEP is set.

> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 5d3fc58a3c34..e4d1b674a278 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -34,6 +34,7 @@
>  #define DM_VERITY_OPT_PANIC		"panic_on_corruption"
>  #define DM_VERITY_OPT_IGN_ZEROES	"ignore_zero_blocks"
>  #define DM_VERITY_OPT_AT_MOST_ONCE	"check_at_most_once"
> +#define DM_VERITY_OPT_TASKLET_VERIFY	"try_verify_in_tasklet"
>  
>  #define DM_VERITY_OPTS_MAX		(3 + DM_VERITY_OPTS_FEC + \
>  					 DM_VERITY_ROOT_HASH_VERIFICATION_OPTS)
> @@ -286,7 +287,20 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
>  
>  	verity_hash_at_level(v, block, level, &hash_block, &offset);
>  
> -	data = dm_bufio_read(v->bufio, hash_block, &buf);
> +	if (io->in_tasklet)
> +		data = dm_bufio_get(v->bufio, hash_block, &buf);
> +	else
> +		data = dm_bufio_read(v->bufio, hash_block, &buf);
> +
> +	if (data == NULL) {
> +		/*
> +		 * We're running as a tasklet and the hash was not in the bufio
> +		 * cache.  Return early and resume execution from a work-queue
> +		 * so that we can read the hash from disk.
> +		 */
> +		return -EAGAIN;
> +	}
> +
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
>  

I tweaked various things in the dm-verity-target.c portion of this
patch.  Ranging from whitespace and style tweaks to code flow tweaks.
I'll include an incremental patch at the end of this email.

<snip>

> @@ -1156,7 +1217,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  		goto bad;
>  	}
>  
> -	v->tfm = crypto_alloc_ahash(v->alg_name, 0, 0);
> +	v->tfm = crypto_alloc_ahash(v->alg_name, 0, CRYPTO_ALG_ASYNC);
>  	if (IS_ERR(v->tfm)) {
>  		ti->error = "Cannot initialize hash function";
>  		r = PTR_ERR(v->tfm);

This hunk that adds the CRYPTO_ALG_ASYNC flag _seems_ unrelated.

> @@ -1281,7 +1343,8 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  	}
>  
>  	/* WQ_UNBOUND greatly improves performance when running on ramdisk */
> -	v->verify_wq = alloc_workqueue("kverityd", WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND, num_online_cpus());
> +	v->verify_wq = alloc_workqueue("kverityd", WQ_HIGHPRI | WQ_MEM_RECLAIM |
> +						   WQ_UNBOUND, num_online_cpus());
>  	if (!v->verify_wq) {
>  		ti->error = "Cannot allocate workqueue";
>  		r = -ENOMEM;

Likewise, the removal of WQ_CPU_INTENSIVE _seems_ unrelated to this
patch.  If you'd like these 2 changes made please send an incremental
patch with a header that explains these changes.

Here is an earlier incremental patch that I folded into this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.20&id=a5beaa11a1a225860fdf9ae80f0bd54bf9125c4c

(Also, if the performance you quoted in the commit header depends on
the 2 above flags changes (which I dropped) please let me know.)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 73215a4baf1f..356a11f36100 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -221,7 +221,7 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	struct mapped_device *md = dm_table_get_md(v->ti->table);
 
 	/* Corruption should be visible in device status in all modes */
-	v->hash_failed = 1;
+	v->hash_failed = true;
 
 	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
 		goto out;
@@ -287,20 +287,19 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 
 	verity_hash_at_level(v, block, level, &hash_block, &offset);
 
-	if (io->in_tasklet)
+	if (io->in_tasklet) {
 		data = dm_bufio_get(v->bufio, hash_block, &buf);
-	else
+		if (data == NULL) {
+			/*
+			 * In tasklet and the hash was not in the bufio cache.
+			 * Return early and resume execution from a work-queue
+			 * to read the hash from disk.
+			 */
+			return -EAGAIN;
+		}
+	} else
 		data = dm_bufio_read(v->bufio, hash_block, &buf);
 
-	if (data == NULL) {
-		/*
-		 * We're running as a tasklet and the hash was not in the bufio
-		 * cache.  Return early and resume execution from a work-queue
-		 * so that we can read the hash from disk.
-		 */
-		return -EAGAIN;
-	}
-
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -321,14 +320,12 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 		if (likely(memcmp(verity_io_real_digest(v, io), want_digest,
 				  v->digest_size) == 0))
 			aux->hash_verified = 1;
-		else if (io->in_tasklet) {
+		else if (io->in_tasklet)
 			/*
 			 * FEC code cannot be run in a tasklet since it may
-			 * sleep.  We need to resume execution in a work-queue
-			 * to handle FEC.
+			 * sleep, so fallback to using a work-queue.
 			 */
 			return -EAGAIN;
-		}
 		else if (verity_fec_decode(v, io,
 					   DM_VERITY_BLOCK_TYPE_METADATA,
 					   hash_block, data, NULL) == 0)
@@ -527,13 +524,6 @@ static int verity_verify_io(struct dm_verity_io *io)
 				return r;
 
 			continue;
-		} else if (io->in_tasklet) {
-			/*
-			 * FEC code cannot be run in a tasklet since it may
-			 * sleep.  We need to resume execution in a work-queue
-			 * to handle FEC.
-			 */
-			return -EAGAIN;
 		}
 
 		r = verity_hash_init(v, req, &wait);
@@ -555,8 +545,14 @@ static int verity_verify_io(struct dm_verity_io *io)
 			if (v->validated_blocks)
 				set_bit(cur_block, v->validated_blocks);
 			continue;
+		} else if (io->in_tasklet) {
+			/*
+			 * FEC code cannot be run in a tasklet since it may
+			 * sleep, so fallback to using a work-queue.
+			 */
+			return -EAGAIN;
 		} else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
-					   cur_block, NULL, &start) == 0) {
+					     cur_block, NULL, &start) == 0) {
 			continue;
 		} else {
 			if (bio->bi_status) {
@@ -603,22 +599,20 @@ static void verity_finish_io(struct dm_verity_io *io, blk_status_t status)
 static void verity_work(struct work_struct *w)
 {
 	struct dm_verity_io *io = container_of(w, struct dm_verity_io, work);
-	int err;
 
-	io->in_tasklet = false;
-	err = verity_verify_io(io);
-
-	verity_finish_io(io, errno_to_blk_status(err));
+	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
 }
 
 static void verity_tasklet(unsigned long data)
 {
-	struct dm_verity_io *io = (struct dm_verity_io *) data;
+	struct dm_verity_io *io = (struct dm_verity_io *)data;
 	int err;
 
 	io->in_tasklet = true;
 	err = verity_verify_io(io);
-	if (err) {
+	if (err == -EAGAIN) {
+		/* fallback to retrying with work-queue */
+		io->in_tasklet = false;
 		INIT_WORK(&io->work, verity_work);
 		queue_work(io->v->verify_wq, &io->work);
 		return;
@@ -1069,13 +1063,13 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 		} else if (!strcasecmp(arg_name, DM_VERITY_OPT_TASKLET_VERIFY)) {
 			v->use_tasklet = true;
 			continue;
-		}
 
-		else if (verity_is_fec_opt_arg(arg_name)) {
+		} else if (verity_is_fec_opt_arg(arg_name)) {
 			r = verity_fec_parse_opt_args(as, v, &argc, arg_name);
 			if (r)
 				return r;
 			continue;
+
 		} else if (verity_verify_is_sig_opt_arg(arg_name)) {
 			r = verity_verify_sig_parse_opt_args(as, v,
 							     verify_args,
@@ -1083,7 +1077,6 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 			if (r)
 				return r;
 			continue;
-
 		}
 
 		ti->error = "Unrecognized verity feature request";
@@ -1127,7 +1120,6 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	}
 	ti->private = v;
 	v->ti = ti;
-	v->use_tasklet = false;
 
 	r = verity_fec_ctr_alloc(v);
 	if (r)
@@ -1216,7 +1208,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		goto bad;
 	}
 
-	v->tfm = crypto_alloc_ahash(v->alg_name, 0, CRYPTO_ALG_ASYNC);
+	v->tfm = crypto_alloc_ahash(v->alg_name, 0, 0);
 	if (IS_ERR(v->tfm)) {
 		ti->error = "Cannot initialize hash function";
 		r = PTR_ERR(v->tfm);
@@ -1326,8 +1318,8 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 	v->bufio = dm_bufio_client_create(v->hash_dev->bdev,
 		1 << v->hash_dev_block_bits, 1, sizeof(struct buffer_aux),
-		dm_bufio_alloc_callback, NULL, v->use_tasklet ?
-		DM_BUFIO_CLIENT_NO_SLEEP : 0);
+		dm_bufio_alloc_callback, NULL,
+		v->use_tasklet ? DM_BUFIO_CLIENT_NO_SLEEP : 0);
 	if (IS_ERR(v->bufio)) {
 		ti->error = "Cannot initialize dm-bufio";
 		r = PTR_ERR(v->bufio);
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 4e65f93bd8d6..26fbe553ca15 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -51,11 +51,11 @@ struct dm_verity {
 	unsigned char hash_dev_block_bits;	/* log2(hash blocksize) */
 	unsigned char hash_per_block_bits;	/* log2(hashes in hash block) */
 	unsigned char levels;	/* the number of tree levels */
-	bool use_tasklet;	/* try to verify in tasklet before work-queue */
 	unsigned char version;
 	unsigned digest_size;	/* digest size for the current hash algorithm */
 	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
-	int hash_failed;	/* set to 1 if hash of any block failed */
+	bool hash_failed:1;	/* set to 1 if hash of any block failed */
+	bool use_tasklet:1;	/* try to verify in tasklet before work-queue */
 	enum verity_mode mode;	/* mode for handling verification errors */
 	unsigned corrupted_errs;/* Number of errors for corrupted blocks */
 

