Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83839588142
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiHBRpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiHBRpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63963FEB;
        Tue,  2 Aug 2022 10:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F344661238;
        Tue,  2 Aug 2022 17:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BD8C433D6;
        Tue,  2 Aug 2022 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659462312;
        bh=fNLNp3SXi0T9cQ+M9a3/VF682i2Ilo5KyQltsQOukTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHonArg+Xrw5t/EDI1D4iP7MQ2H25Z/WUmcW7SS4igI0Hw14wYQm0TKYqXWxgJ3wp
         8jnp4e35pQor1X2YgxCu13z9BKrFXTHCwcPwqOubC/iTIHz5wxYdMcCb6c3Hc4SCpd
         77MCWCm7n4U3G0PJfebJ79iN6EbbJYLXW/ZjOHw5jlrf2C7yy9JxBRnwKaWf/5SMAb
         i/Yx661rrCuhwWXpd53MJSKDhoIvJAld5y7TFz9c9xpt/DFam97kJE2JlNkBjfrFFs
         UVzPMrMkuAnS/7yc//aklVCjMMafmOJqTNUUVfIIx2rs9OYUoKE/EbCuvzN/hg+0nj
         EBAB9RcXlV3wQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A8B140736; Tue,  2 Aug 2022 14:45:09 -0300 (-03)
Date:   Tue, 2 Aug 2022 14:45:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 3/3] perf lock: Print lost entries at the end
Message-ID: <YulipRqJZ7oYVWD/@kernel.org>
References: <20220802073511.299459-1-namhyung@kernel.org>
 <20220802073511.299459-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802073511.299459-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 02, 2022 at 12:35:11AM -0700, Namhyung Kim escreveu:
> Like the normal perf lock report output, it'd print bad stats at the end
> if exists or -v option is passed.  Currently it uses BROKEN_CONTENDED
 stat for the lost count (due to full stack maps).

"Print the number of lost entries in verbose mode"?
 
>   $ sudo perf lock con -a -b -m 128 sleep 5
>   ...
>   === output for debug===
> 
>   bad: 43, total: 14903
>   bad rate: 0.29 %
>   histogram of events caused bad sequence
>       acquire: 0
>      acquired: 0
>     contended: 43
>       release: 0
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c                      | 8 +++++++-
>  tools/perf/util/bpf_lock_contention.c          | 6 ++++--
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 9 +++++++--
>  tools/perf/util/lock-contention.h              | 1 +
>  4 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index e32fdcd497e0..8065f0268e55 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1471,8 +1471,11 @@ static void print_contention_result(void)
>  		pr_info("  %10s   %s\n\n", "type", "caller");
>  
>  	bad = total = 0;
> +	if (use_bpf)
> +		bad = bad_hist[BROKEN_CONTENDED];
> +
>  	while ((st = pop_from_result())) {
> -		total++;
> +		total += use_bpf ? st->nr_contended : 1;
>  		if (st->broken)
>  			bad++;
>  
> @@ -1686,6 +1689,9 @@ static int __cmd_contention(int argc, const char **argv)
>  
>  		lock_contention_stop();
>  		lock_contention_read(&con);
> +
> +		/* abuse bad hist stats for lost entries */
> +		bad_hist[BROKEN_CONTENDED] = con.lost;
>  	} else {
>  		err = perf_session__process_events(session);
>  		if (err)
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 26128e5bb659..65f51cc25236 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -16,7 +16,7 @@ static struct lock_contention_bpf *skel;
>  
>  /* should be same as bpf_skel/lock_contention.bpf.c */
>  struct lock_contention_key {
> -	u32 stack_id;
> +	s32 stack_id;
>  };
>  
>  struct lock_contention_data {
> @@ -110,7 +110,7 @@ int lock_contention_stop(void)
>  int lock_contention_read(struct lock_contention *con)
>  {
>  	int fd, stack;
> -	u32 prev_key, key;
> +	s32 prev_key, key;
>  	struct lock_contention_data data;
>  	struct lock_stat *st;
>  	struct machine *machine = con->machine;
> @@ -119,6 +119,8 @@ int lock_contention_read(struct lock_contention *con)
>  	fd = bpf_map__fd(skel->maps.lock_stat);
>  	stack = bpf_map__fd(skel->maps.stacks);
>  
> +	con->lost = skel->bss->lost;
> +
>  	prev_key = 0;
>  	while (!bpf_map_get_next_key(fd, &prev_key, &key)) {
>  		struct map *kmap;
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 67d46533e518..9e8b94eb6320 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -12,7 +12,7 @@
>  #define MAX_ENTRIES  10240
>  
>  struct contention_key {
> -	__u32 stack_id;
> +	__s32 stack_id;
>  };
>  
>  struct contention_data {
> @@ -27,7 +27,7 @@ struct tstamp_data {
>  	__u64 timestamp;
>  	__u64 lock;
>  	__u32 flags;
> -	__u32 stack_id;
> +	__s32 stack_id;
>  };
>  
>  /* callstack storage  */
> @@ -73,6 +73,9 @@ int enabled;
>  int has_cpu;
>  int has_task;
>  
> +/* error stat */
> +unsigned long lost;
> +
>  static inline int can_record(void)
>  {
>  	if (has_cpu) {
> @@ -116,6 +119,8 @@ int contention_begin(u64 *ctx)
>  	pelem->flags = (__u32)ctx[1];
>  	pelem->stack_id = bpf_get_stackid(ctx, &stacks, BPF_F_FAST_STACK_CMP);
>  
> +	if (pelem->stack_id < 0)
> +		lost++;
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index b09fd6eb978a..d9fc5f076567 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -113,6 +113,7 @@ struct lock_contention {
>  	struct machine *machine;
>  	struct hlist_head *result;
>  	unsigned long map_len;
> +	unsigned long lost;
>  };
>  
>  #ifdef HAVE_BPF_SKEL
> -- 
> 2.37.1.455.g008518b4e5-goog

-- 

- Arnaldo
