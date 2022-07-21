Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A4E57D3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiGUTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGUTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:03:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1A88149C;
        Thu, 21 Jul 2022 12:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 234F962056;
        Thu, 21 Jul 2022 19:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAC5C3411E;
        Thu, 21 Jul 2022 19:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658430181;
        bh=anQnjW9PG4EeanzL+4g2Qw30QWe2NGaXF5sC67Ycjxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/rfziXrwufHY0vxfeaKgMnKUCaOs11GTr43D8rheOTi9TlkfndpNgLoMkcknzv9B
         qPWTrxHh33iOzCRAMH6FOVLWeYrh3BnGWw/cB34iQOzaUj8fHK+2OjvTKHvFrbHFgl
         cz6OD5QdzNMHbV/LLQUXupu5tY51I89FtsYgDl6cM3Yu9NCyYsj9TcqiYRyP/EdsF0
         fL8xeWvZhZdo57QrAeqnwnVSlNc3hqbbXwPoTyf65akcIcTEVvIns76Dbxq4gFhv3K
         Loc0zCuZDfZtSScoX9dQYq962lZaPGesMZeU2OHTFi9xNE4Y4mmlTwGrv0V1PCXQ0d
         QodoX1+m79Iqg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FA3C40374; Thu, 21 Jul 2022 16:02:58 -0300 (-03)
Date:   Thu, 21 Jul 2022 16:02:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 3/6] perf lock: Add lock aggregation enum
Message-ID: <Ytmi4otIpXA+zNSx@kernel.org>
References: <20220721043644.153718-1-namhyung@kernel.org>
 <20220721043644.153718-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220721043644.153718-4-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 20, 2022 at 09:36:41PM -0700, Namhyung Kim escreveu:
> Introduce the aggr_mode variable to prepare the later code change.
> The default is LOCK_AGGR_ADDR which aggregate the result for the lock
> instances.  When -t/--threads option is given, it'd be set to
> LOCK_AGGR_TASK.  The LOCK_AGGR_CALLER is for the contention analysis
> and it'd aggregate the stat by comparing the callstacks.

builtin-lock.c: In function ‘report_lock_contention_end_event’:
builtin-lock.c:1113:13: error: variable ‘key’ set but not used [-Werror=unused-but-set-variable]
 1113 |         u64 key;
      |             ^~~
cc1: all warnings being treated as errors


trying to fix
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c | 112 +++++++++++++++++++++++++++++++-------
>  1 file changed, 93 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 1de459198b99..551bad905139 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -126,6 +126,12 @@ static struct rb_root		thread_stats;
>  static bool combine_locks;
>  static bool show_thread_stats;
>  
> +static enum {
> +	LOCK_AGGR_ADDR,
> +	LOCK_AGGR_TASK,
> +	LOCK_AGGR_CALLER,
> +} aggr_mode = LOCK_AGGR_ADDR;
> +
>  /*
>   * CONTENTION_STACK_DEPTH
>   * Number of stack trace entries to find callers
> @@ -622,12 +628,22 @@ static int report_lock_acquire_event(struct evsel *evsel,
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
>  	int flag = evsel__intval(evsel, sample, "flags");
> +	u64 key;
>  
> -	/* abuse ls->addr for tid */
> -	if (show_thread_stats)
> -		addr = sample->tid;
> +	switch (aggr_mode) {
> +	case LOCK_AGGR_ADDR:
> +		key = addr;
> +		break;
> +	case LOCK_AGGR_TASK:
> +		key = sample->tid;
> +		break;
> +	case LOCK_AGGR_CALLER:
> +	default:
> +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> +		return -EINVAL;
> +	}
>  
> -	ls = lock_stat_findnew(addr, name, 0);
> +	ls = lock_stat_findnew(key, name, 0);
>  	if (!ls)
>  		return -ENOMEM;
>  
> @@ -695,11 +711,22 @@ static int report_lock_acquired_event(struct evsel *evsel,
>  	u64 contended_term;
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> +	u64 key;
>  
> -	if (show_thread_stats)
> -		addr = sample->tid;
> +	switch (aggr_mode) {
> +	case LOCK_AGGR_ADDR:
> +		key = addr;
> +		break;
> +	case LOCK_AGGR_TASK:
> +		key = sample->tid;
> +		break;
> +	case LOCK_AGGR_CALLER:
> +	default:
> +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> +		return -EINVAL;
> +	}
>  
> -	ls = lock_stat_findnew(addr, name, 0);
> +	ls = lock_stat_findnew(key, name, 0);
>  	if (!ls)
>  		return -ENOMEM;
>  
> @@ -757,11 +784,22 @@ static int report_lock_contended_event(struct evsel *evsel,
>  	struct lock_seq_stat *seq;
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> +	u64 key;
>  
> -	if (show_thread_stats)
> -		addr = sample->tid;
> +	switch (aggr_mode) {
> +	case LOCK_AGGR_ADDR:
> +		key = addr;
> +		break;
> +	case LOCK_AGGR_TASK:
> +		key = sample->tid;
> +		break;
> +	case LOCK_AGGR_CALLER:
> +	default:
> +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> +		return -EINVAL;
> +	}
>  
> -	ls = lock_stat_findnew(addr, name, 0);
> +	ls = lock_stat_findnew(key, name, 0);
>  	if (!ls)
>  		return -ENOMEM;
>  
> @@ -812,11 +850,22 @@ static int report_lock_release_event(struct evsel *evsel,
>  	struct lock_seq_stat *seq;
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> +	u64 key;
>  
> -	if (show_thread_stats)
> -		addr = sample->tid;
> +	switch (aggr_mode) {
> +	case LOCK_AGGR_ADDR:
> +		key = addr;
> +		break;
> +	case LOCK_AGGR_TASK:
> +		key = sample->tid;
> +		break;
> +	case LOCK_AGGR_CALLER:
> +	default:
> +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> +		return -EINVAL;
> +	}
>  
> -	ls = lock_stat_findnew(addr, name, 0);
> +	ls = lock_stat_findnew(key, name, 0);
>  	if (!ls)
>  		return -ENOMEM;
>  
> @@ -980,11 +1029,22 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  	struct thread_stat *ts;
>  	struct lock_seq_stat *seq;
>  	u64 addr = evsel__intval(evsel, sample, "lock_addr");
> +	u64 key;
>  
> -	if (show_thread_stats)
> -		addr = sample->tid;
> +	switch (aggr_mode) {
> +	case LOCK_AGGR_ADDR:
> +		key = addr;
> +		break;
> +	case LOCK_AGGR_TASK:
> +		key = sample->tid;
> +		break;
> +	case LOCK_AGGR_CALLER:
> +	default:
> +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> +		return -EINVAL;
> +	}
>  
> -	ls = lock_stat_find(addr);
> +	ls = lock_stat_find(key);
>  	if (!ls) {
>  		char buf[128];
>  		const char *caller = buf;
> @@ -993,7 +1053,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  		if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
>  			caller = "Unknown";
>  
> -		ls = lock_stat_findnew(addr, caller, flags);
> +		ls = lock_stat_findnew(key, caller, flags);
>  		if (!ls)
>  			return -ENOMEM;
>  	}
> @@ -1050,9 +1110,20 @@ static int report_lock_contention_end_event(struct evsel *evsel,
>  	struct lock_seq_stat *seq;
>  	u64 contended_term;
>  	u64 addr = evsel__intval(evsel, sample, "lock_addr");
> +	u64 key;
>  
> -	if (show_thread_stats)
> -		addr = sample->tid;
> +	switch (aggr_mode) {
> +	case LOCK_AGGR_ADDR:
> +		key = addr;
> +		break;
> +	case LOCK_AGGR_TASK:
> +		key = sample->tid;
> +		break;
> +	case LOCK_AGGR_CALLER:
> +	default:
> +		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
> +		return -EINVAL;
> +	}
>  
>  	ls = lock_stat_find(addr);
>  	if (!ls)
> @@ -1416,6 +1487,9 @@ static int __cmd_report(bool display_info)
>  	if (select_key())
>  		goto out_delete;
>  
> +	if (show_thread_stats)
> +		aggr_mode = LOCK_AGGR_TASK;
> +
>  	err = perf_session__process_events(session);
>  	if (err)
>  		goto out_delete;
> -- 
> 2.37.0.170.g444d1eabd0-goog

-- 

- Arnaldo
