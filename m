Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254CC58813F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiHBRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiHBRn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:43:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E954E4F1A4;
        Tue,  2 Aug 2022 10:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E2C6B81FE2;
        Tue,  2 Aug 2022 17:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E505DC433C1;
        Tue,  2 Aug 2022 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659462203;
        bh=JpSLV2pSf0Tq+89uqu5+RJglNUvUhxd5MJsBuzfmQmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0rJ8uXNqgSd2JVdaXo0Ehej7xwbGibYnuJSEYMNwzLNfuyS7H3f4EeF+yqOa+G8P
         o5LftWGFc20P29l/vOseKrOaDkN6ynZGxi2WyU5LjhC4w7coY6aRnvb8qwrxy94PQu
         vnBD/g7iXedbbjD66TmKN/wUFtHDlzGy7u2BFP76WV0ZbqnJMKdvD0LaAbLR8I6S4N
         aWs4ZFF7DP8kVlA0V3cyAr7EFOw9rTBxV7bgrJDN3+fRH/yDD3QH8yRkKmf5DBVIGl
         T6EuN16y+vyv3/wqNQfzOzF1pNwkZ/k2xBZHUpkY8LkgJ9nVILHjdM/5366lC72oTs
         eJpOyO76T/oUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF46440736; Tue,  2 Aug 2022 14:43:19 -0300 (-03)
Date:   Tue, 2 Aug 2022 14:43:19 -0300
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
Subject: Re: [PATCH 2/3] perf lock: Add -m/--map-length option
Message-ID: <YuliN2UDbls5uW3u@kernel.org>
References: <20220802073511.299459-1-namhyung@kernel.org>
 <20220802073511.299459-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802073511.299459-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 02, 2022 at 12:35:10AM -0700, Namhyung Kim escreveu:
> The -m/--map-length option is to control number of max entries in the
> perf lock contention BPF maps.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-lock.txt |  4 ++++
>  tools/perf/builtin-lock.c              | 23 ++++++++++++++++++++++-
>  tools/perf/util/bpf_lock_contention.c  |  3 +++
>  tools/perf/util/lock-contention.h      |  1 +
>  4 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 7949d2e6891b..2101644785e0 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -145,6 +145,10 @@ CONTENTION OPTIONS
>  --tid=::
>          Record events on existing thread ID (comma separated list).
>  
> +-m::
> +--map-length::
> +	Maximum number of BPF map entries (default: 10240).

--map-nr-entries?

I think we use this jargon "nr-entries" for arrays, lists, etc, better
try to stick to it.

Also what do you think about not using single letter options for things
that are not that used?

The map size has a default, one that seems generous, so changing it
should be something uncommon, and then, if it becomes common that more
entries are needed by default, we can change the default in the tool.

- Arnaldo

> +
>  
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index eef778b7d33d..e32fdcd497e0 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -55,6 +55,7 @@ static struct rb_root		thread_stats;
>  static bool combine_locks;
>  static bool show_thread_stats;
>  static bool use_bpf;
> +static unsigned long bpf_map_len = 10240;
>  
>  static enum {
>  	LOCK_AGGR_ADDR,
> @@ -1597,6 +1598,7 @@ static int __cmd_contention(int argc, const char **argv)
>  	struct lock_contention con = {
>  		.target = &target,
>  		.result = &lockhash_table[0],
> +		.map_len = bpf_map_len,
>  	};
>  
>  	session = perf_session__new(use_bpf ? NULL : &data, &eops);
> @@ -1786,6 +1788,24 @@ static int __cmd_record(int argc, const char **argv)
>  	return ret;
>  }
>  
> +static int parse_map_length(const struct option *opt, const char *str,
> +			    int unset __maybe_unused)
> +{
> +	unsigned long *len = (unsigned long *)opt->value;
> +	unsigned long val;
> +	char *endptr;
> +
> +	errno = 0;
> +	val = strtoul(str, &endptr, 0);
> +	if (*endptr != '\0' || errno != 0) {
> +		pr_err("invalid BPF map length: %s\n", str);
> +		return -1;
> +	}
> +
> +	*len = val;
> +	return 0;
> +}
> +
>  int cmd_lock(int argc, const char **argv)
>  {
>  	const struct option lock_options[] = {
> @@ -1835,9 +1855,10 @@ int cmd_lock(int argc, const char **argv)
>  		    "List of cpus to monitor"),
>  	OPT_STRING('p', "pid", &target.pid, "pid",
>  		   "Trace on existing process id"),
> -	/* TODO: Add short option -t after -t/--tracer can be removed. */
>  	OPT_STRING(0, "tid", &target.tid, "tid",
>  		   "Trace on existing thread id (exclusive to --pid)"),
> +	OPT_CALLBACK('m', "map-length", &bpf_map_len, "len",
> +		     "Max number of BPF map entries", parse_map_length),
>  	OPT_PARENT(lock_options)
>  	};
>  
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index f5e2b4f19a72..26128e5bb659 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -40,6 +40,9 @@ int lock_contention_prepare(struct lock_contention *con)
>  		return -1;
>  	}
>  
> +	bpf_map__set_max_entries(skel->maps.stacks, con->map_len);
> +	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_len);
> +
>  	if (target__has_cpu(target))
>  		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
>  	if (target__has_task(target))
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index a0df5308cca4..b09fd6eb978a 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -112,6 +112,7 @@ struct lock_contention {
>  	struct target *target;
>  	struct machine *machine;
>  	struct hlist_head *result;
> +	unsigned long map_len;
>  };
>  
>  #ifdef HAVE_BPF_SKEL
> -- 
> 2.37.1.455.g008518b4e5-goog

-- 

- Arnaldo
