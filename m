Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D5588349
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiHBVEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiHBVEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:04:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76045077;
        Tue,  2 Aug 2022 14:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58136614B8;
        Tue,  2 Aug 2022 21:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C619C433C1;
        Tue,  2 Aug 2022 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659474272;
        bh=wJtT9GHNrpPgl7ieiEvee76VOHI23x/7v0i9zeXxLtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdTyLCPwcuuIT9VextDI7wfdar3USX+1v0+sjcqzEG5J4zax5uTx+eslkEUGmiWxX
         RbUOTvSfncEBORL0AOmm0yn6csLfji3/pbxrgnv65acVW5+pk0o/frkUiJpt72zzcP
         7YcXPWYdoABiPSkOAtKVh+gkyGRPYpVAOnm5c1QVX/eSW7rRbx8A8bGJAHaJ9mBtHT
         PSmEYjQWhYZpNn6GmZFnS8BuOxnfiz3Mltly7XwANPmVLMwUPQGf/0mTEI1CmyLb8q
         m4jzFDEj7YohW9zaJcjw6ovX3gWxI0aNOT+SDkcMVkbtmK9j9qXlY19XnY2gd4Y4Gq
         RmPq+cSCidBTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 548FC40736; Tue,  2 Aug 2022 18:04:29 -0300 (-03)
Date:   Tue, 2 Aug 2022 18:04:29 -0300
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
Subject: Re: [PATCH v2 1/3] perf lock: Introduce struct lock_contention
Message-ID: <YumRXcxc5XIUwlBO@kernel.org>
References: <20220802191004.347740-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802191004.347740-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 02, 2022 at 12:10:02PM -0700, Namhyung Kim escreveu:
> The lock_contention struct is to carry related fields together and to
> minimize the change when we add new config options.


Thanks, applied. Forgot the cover letter? :-)

- Arnaldo

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c             | 23 ++++++++++++++---------
>  tools/perf/util/bpf_lock_contention.c |  9 ++++++---
>  tools/perf/util/lock-contention.h     | 17 +++++++++++------
>  3 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 7897a33fec1b..eef778b7d33d 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1594,7 +1594,10 @@ static int __cmd_contention(int argc, const char **argv)
>  		.mode  = PERF_DATA_MODE_READ,
>  		.force = force,
>  	};
> -	struct evlist *evlist = NULL;
> +	struct lock_contention con = {
> +		.target = &target,
> +		.result = &lockhash_table[0],
> +	};
>  
>  	session = perf_session__new(use_bpf ? NULL : &data, &eops);
>  	if (IS_ERR(session)) {
> @@ -1620,24 +1623,26 @@ static int __cmd_contention(int argc, const char **argv)
>  		signal(SIGCHLD, sighandler);
>  		signal(SIGTERM, sighandler);
>  
> -		evlist = evlist__new();
> -		if (evlist == NULL) {
> +		con.machine = &session->machines.host;
> +
> +		con.evlist = evlist__new();
> +		if (con.evlist == NULL) {
>  			err = -ENOMEM;
>  			goto out_delete;
>  		}
>  
> -		err = evlist__create_maps(evlist, &target);
> +		err = evlist__create_maps(con.evlist, &target);
>  		if (err < 0)
>  			goto out_delete;
>  
>  		if (argc) {
> -			err = evlist__prepare_workload(evlist, &target,
> +			err = evlist__prepare_workload(con.evlist, &target,
>  						       argv, false, NULL);
>  			if (err < 0)
>  				goto out_delete;
>  		}
>  
> -		if (lock_contention_prepare(evlist, &target) < 0) {
> +		if (lock_contention_prepare(&con) < 0) {
>  			pr_err("lock contention BPF setup failed\n");
>  			goto out_delete;
>  		}
> @@ -1672,13 +1677,13 @@ static int __cmd_contention(int argc, const char **argv)
>  	if (use_bpf) {
>  		lock_contention_start();
>  		if (argc)
> -			evlist__start_workload(evlist);
> +			evlist__start_workload(con.evlist);
>  
>  		/* wait for signal */
>  		pause();
>  
>  		lock_contention_stop();
> -		lock_contention_read(&session->machines.host, &lockhash_table[0]);
> +		lock_contention_read(&con);
>  	} else {
>  		err = perf_session__process_events(session);
>  		if (err)
> @@ -1691,7 +1696,7 @@ static int __cmd_contention(int argc, const char **argv)
>  	print_contention_result();
>  
>  out_delete:
> -	evlist__delete(evlist);
> +	evlist__delete(con.evlist);
>  	lock_contention_finish();
>  	perf_session__delete(session);
>  	return err;
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 16b7451b4b09..f5e2b4f19a72 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -27,10 +27,12 @@ struct lock_contention_data {
>  	u32 flags;
>  };
>  
> -int lock_contention_prepare(struct evlist *evlist, struct target *target)
> +int lock_contention_prepare(struct lock_contention *con)
>  {
>  	int i, fd;
>  	int ncpus = 1, ntasks = 1;
> +	struct evlist *evlist = con->evlist;
> +	struct target *target = con->target;
>  
>  	skel = lock_contention_bpf__open();
>  	if (!skel) {
> @@ -102,12 +104,13 @@ int lock_contention_stop(void)
>  	return 0;
>  }
>  
> -int lock_contention_read(struct machine *machine, struct hlist_head *head)
> +int lock_contention_read(struct lock_contention *con)
>  {
>  	int fd, stack;
>  	u32 prev_key, key;
>  	struct lock_contention_data data;
>  	struct lock_stat *st;
> +	struct machine *machine = con->machine;
>  	u64 stack_trace[CONTENTION_STACK_DEPTH];
>  
>  	fd = bpf_map__fd(skel->maps.lock_stat);
> @@ -163,7 +166,7 @@ int lock_contention_read(struct machine *machine, struct hlist_head *head)
>  			return -1;
>  		}
>  
> -		hlist_add_head(&st->hash_entry, head);
> +		hlist_add_head(&st->hash_entry, con->result);
>  		prev_key = key;
>  	}
>  
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index 092c84441f9f..a0df5308cca4 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -107,18 +107,24 @@ struct evlist;
>  struct machine;
>  struct target;
>  
> +struct lock_contention {
> +	struct evlist *evlist;
> +	struct target *target;
> +	struct machine *machine;
> +	struct hlist_head *result;
> +};
> +
>  #ifdef HAVE_BPF_SKEL
>  
> -int lock_contention_prepare(struct evlist *evlist, struct target *target);
> +int lock_contention_prepare(struct lock_contention *con);
>  int lock_contention_start(void);
>  int lock_contention_stop(void);
> -int lock_contention_read(struct machine *machine, struct hlist_head *head);
> +int lock_contention_read(struct lock_contention *con);
>  int lock_contention_finish(void);
>  
>  #else  /* !HAVE_BPF_SKEL */
>  
> -static inline int lock_contention_prepare(struct evlist *evlist __maybe_unused,
> -					  struct target *target __maybe_unused)
> +static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
>  {
>  	return 0;
>  }
> @@ -127,8 +133,7 @@ static inline int lock_contention_start(void) { return 0; }
>  static inline int lock_contention_stop(void) { return 0; }
>  static inline int lock_contention_finish(void) { return 0; }
>  
> -static inline int lock_contention_read(struct machine *machine __maybe_unused,
> -				       struct hlist_head *head __maybe_unused)
> +static inline int lock_contention_read(struct lock_contention *con __maybe_unused)
>  {
>  	return 0;
>  }
> -- 
> 2.37.1.455.g008518b4e5-goog

-- 

- Arnaldo
