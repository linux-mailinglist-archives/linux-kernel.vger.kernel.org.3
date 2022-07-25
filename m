Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA35805FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiGYUxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiGYUxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:53:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79956140B8;
        Mon, 25 Jul 2022 13:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 200A3B80ECB;
        Mon, 25 Jul 2022 20:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE4DC341C6;
        Mon, 25 Jul 2022 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658782430;
        bh=mzHZrYNARuV2fP/lUtoNJQyD39WISseBwomweQs2pgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izGUPWlGgcfJkLH2jMFw0aP9cco4MAiQOtcuMKddySWNZPKMGq6CZ4Oe0XgiHvc/9
         JObDdLtYN7sbxMxxJY/pxT4Het4zGblnYeqoYyYwJmcBNbPDZ9OlWLxP8Ig6XmjEAU
         A55ow84lqhFNKGBzDrxf5PQ9cca+YCvOMnloqQjw5G2qQMw0uvaskRXg4T4K+aSH2u
         eO2zvif3G/XWq2Z2fW5kiGfAFyTjX++zWQp72HhdbfHDamKUaeSfi1JLXKa3/sRy+e
         dFDuw2Y4KYGjl7FyUcK4kikmbfW4fiPSQusKTT8qBfbYGtf3QyhAsIDwOTCentyC/Y
         EjOzfYHOn0Ebw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 825EA40374; Mon, 25 Jul 2022 17:53:46 -0300 (-03)
Date:   Mon, 25 Jul 2022 17:53:46 -0300
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
Subject: Re: [PATCH 1/5] perf lock: Add flags field in the lock_stat
Message-ID: <Yt8C2kuSAJM5LJZf@kernel.org>
References: <20220725183124.368304-1-namhyung@kernel.org>
 <20220725183124.368304-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725183124.368304-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 25, 2022 at 11:31:20AM -0700, Namhyung Kim escreveu:
> For lock contention tracepoint analysis, it needs to keep the flags.
> As nr_readlock and nr_trylock fields are not used for it, let's make
> it a union.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 0aae88fdf93a..1de459198b99 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -59,7 +59,10 @@ struct lock_stat {
>  	unsigned int		nr_contended;
>  	unsigned int		nr_release;
>  
> -	unsigned int		nr_readlock;
> +	union {
> +		unsigned int	nr_readlock;
> +		unsigned int	flags;
> +	};
>  	unsigned int		nr_trylock;
>  
>  	/* these times are in nano sec. */
> @@ -516,7 +519,7 @@ static struct lock_stat *lock_stat_find(u64 addr)
>  	return NULL;
>  }
>  
> -static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
> +static struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
>  {
>  	struct hlist_head *entry = lockhashentry(addr);
>  	struct lock_stat *ret, *new;
> @@ -531,13 +534,13 @@ static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
>  		goto alloc_failed;
>  
>  	new->addr = addr;
> -	new->name = zalloc(sizeof(char) * strlen(name) + 1);
> +	new->name = strdup(name);
>  	if (!new->name) {
>  		free(new);
>  		goto alloc_failed;
>  	}
>  
> -	strcpy(new->name, name);

I'm applying to speed things up, but please separate such unrelated bits
in another patch next time.

- Arnaldo

> +	new->flags = flags;
>  	new->wait_time_min = ULLONG_MAX;
>  
>  	hlist_add_head(&new->hash_entry, entry);
> @@ -624,7 +627,7 @@ static int report_lock_acquire_event(struct evsel *evsel,
>  	if (show_thread_stats)
>  		addr = sample->tid;
>  
> -	ls = lock_stat_findnew(addr, name);
> +	ls = lock_stat_findnew(addr, name, 0);
>  	if (!ls)
>  		return -ENOMEM;
>  
> @@ -696,7 +699,7 @@ static int report_lock_acquired_event(struct evsel *evsel,
>  	if (show_thread_stats)
>  		addr = sample->tid;
>  
> -	ls = lock_stat_findnew(addr, name);
> +	ls = lock_stat_findnew(addr, name, 0);
>  	if (!ls)
>  		return -ENOMEM;
>  
> @@ -758,7 +761,7 @@ static int report_lock_contended_event(struct evsel *evsel,
>  	if (show_thread_stats)
>  		addr = sample->tid;
>  
> -	ls = lock_stat_findnew(addr, name);
> +	ls = lock_stat_findnew(addr, name, 0);
>  	if (!ls)
>  		return -ENOMEM;
>  
> @@ -813,7 +816,7 @@ static int report_lock_release_event(struct evsel *evsel,
>  	if (show_thread_stats)
>  		addr = sample->tid;
>  
> -	ls = lock_stat_findnew(addr, name);
> +	ls = lock_stat_findnew(addr, name, 0);
>  	if (!ls)
>  		return -ENOMEM;
>  
> @@ -985,11 +988,12 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  	if (!ls) {
>  		char buf[128];
>  		const char *caller = buf;
> +		unsigned int flags = evsel__intval(evsel, sample, "flags");
>  
>  		if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
>  			caller = "Unknown";
>  
> -		ls = lock_stat_findnew(addr, caller);
> +		ls = lock_stat_findnew(addr, caller, flags);
>  		if (!ls)
>  			return -ENOMEM;
>  	}
> -- 
> 2.37.1.359.gd136c6c3e2-goog

-- 

- Arnaldo
