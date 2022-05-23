Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6092530F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiEWMup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiEWMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:50:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E143A52B27;
        Mon, 23 May 2022 05:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 952C7B810AC;
        Mon, 23 May 2022 12:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB255C385A9;
        Mon, 23 May 2022 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653310240;
        bh=AFHTuwVEqGS1/GzxHMcy2QWyLwHy0DlBTWXVrK+J3rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEsOA5OS8NuAMMznaqfFMZ4Ues2z0LRTVj+Ak9G6qS5ok+BSNMovLWnHdfPQHbMvi
         wAW+jBgcxS7Jfaqngtzt6iOf7u1H+ZQprtymlK0P/7VDlzX4/bjH6ur8nrDIm7iG1I
         KejpURNMIYLcSMpZdJB5Iay27/Rr2qN2UWkquEX47jNqdMHgkTBiwNgl3RB/SFDhE/
         1LxPLj5BjVlKRxAlz67M39iKbr8L9coRoDvODsAUCPFFOdilFHs279yMYRsnBJ8dlS
         XdPLhF0zx1LVwImbgelta1aqAhVgsZRIFFJLQeDflV36Wr9D/jyLPQ/MsehobF25Ys
         DZE+LYq1J1c6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 100A4400B1; Mon, 23 May 2022 09:50:37 -0300 (-03)
Date:   Mon, 23 May 2022 09:50:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf lock: Add -t/--thread option for report
Message-ID: <YouDHRXZYqZSEutp@kernel.org>
References: <20220521010811.932703-1-namhyung@kernel.org>
 <20220521010811.932703-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220521010811.932703-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 20, 2022 at 06:08:11PM -0700, Namhyung Kim escreveu:
> The -t option is to show per-thread lock stat like below:
> 
>   $ perf lock report -t -F acquired,contended,avg_wait
> 
>                 Name   acquired  contended   avg wait (ns)
> 
>                 perf     240569          9            5784
>              swapper     106610         19             543
>               :15789      17370          2           14538
>         ContainerMgr       8981          6             874
>                sleep       5275          1           11281
>      ContainerThread       4416          4             944
>      RootPressureThr       3215          5            1215
>          rcu_preempt       2954          0               0
>         ContainerMgr       2560          0               0
>              unnamed       1873          0               0
>      EventManager_De       1845          1             636
>      futex-default-S       1609          0               0
>   ...

Applied both and added this:

⬢[acme@toolbox perf]$ git diff
diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index b43222229807672c..656b537b2fba078f 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -64,6 +64,27 @@ REPORT OPTIONS
 --combine-locks::
        Merge lock instances in the same class (based on name).
 
+-t::
+--threads::
+    The -t option is to show per-thread lock stat like below:
+
+      $ perf lock report -t -F acquired,contended,avg_wait
+
+                    Name   acquired  contended   avg wait (ns)
+
+                    perf     240569          9            5784
+                 swapper     106610         19             543
+                  :15789      17370          2           14538
+            ContainerMgr       8981          6             874
+                   sleep       5275          1           11281
+         ContainerThread       4416          4             944
+         RootPressureThr       3215          5            1215
+             rcu_preempt       2954          0               0
+            ContainerMgr       2560          0               0
+                 unnamed       1873          0               0
+         EventManager_De       1845          1             636
+         futex-default-S       1609          0               0
+
 INFO OPTIONS
 ------------

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 7ceb12e30719..b1200b7340a6 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -118,6 +118,7 @@ struct thread_stat {
>  static struct rb_root		thread_stats;
>  
>  static bool combine_locks;
> +static bool show_thread_stats;
>  
>  static struct thread_stat *thread_stat_find(u32 tid)
>  {
> @@ -542,6 +543,10 @@ static int report_lock_acquire_event(struct evsel *evsel,
>  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
>  	int flag = evsel__intval(evsel, sample, "flags");
>  
> +	/* abuse ls->addr for tid */
> +	if (show_thread_stats)
> +		addr = sample->tid;
> +
>  	ls = lock_stat_findnew(addr, name);
>  	if (!ls)
>  		return -ENOMEM;
> @@ -611,6 +616,9 @@ static int report_lock_acquired_event(struct evsel *evsel,
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
>  
> +	if (show_thread_stats)
> +		addr = sample->tid;
> +
>  	ls = lock_stat_findnew(addr, name);
>  	if (!ls)
>  		return -ENOMEM;
> @@ -670,6 +678,9 @@ static int report_lock_contended_event(struct evsel *evsel,
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
>  
> +	if (show_thread_stats)
> +		addr = sample->tid;
> +
>  	ls = lock_stat_findnew(addr, name);
>  	if (!ls)
>  		return -ENOMEM;
> @@ -722,6 +733,9 @@ static int report_lock_release_event(struct evsel *evsel,
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
>  
> +	if (show_thread_stats)
> +		addr = sample->tid;
> +
>  	ls = lock_stat_findnew(addr, name);
>  	if (!ls)
>  		return -ENOMEM;
> @@ -848,7 +862,17 @@ static void print_result(void)
>  
>  		if (strlen(st->name) < 20) {
>  			/* output raw name */
> -			pr_info("%20s ", st->name);
> +			const char *name = st->name;
> +
> +			if (show_thread_stats) {
> +				struct thread *t;
> +
> +				/* st->addr contains tid of thread */
> +				t = perf_session__findnew(session, st->addr);
> +				name = thread__comm_str(t);
> +			}
> +
> +			pr_info("%20s ", name);
>  		} else {
>  			strncpy(cut_name, st->name, 16);
>  			cut_name[16] = '.';
> @@ -1125,6 +1149,8 @@ int cmd_lock(int argc, const char **argv)
>  	/* TODO: type */
>  	OPT_BOOLEAN('c', "combine-locks", &combine_locks,
>  		    "combine locks in the same class"),
> +	OPT_BOOLEAN('t', "threads", &show_thread_stats,
> +		    "show per-thread lock stats"),
>  	OPT_PARENT(lock_options)
>  	};
>  
> -- 
> 2.36.1.124.g0e6072fb45-goog

-- 

- Arnaldo
