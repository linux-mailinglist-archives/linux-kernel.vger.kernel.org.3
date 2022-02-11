Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9E64B2BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352170AbiBKRby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:31:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbiBKRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:31:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C17D2C3;
        Fri, 11 Feb 2022 09:31:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C99B061C7A;
        Fri, 11 Feb 2022 17:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B586BC340E9;
        Fri, 11 Feb 2022 17:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644600710;
        bh=xf7S3uollxRYgX1Nn+fqIb9vcuRYPZFYBNDiYf9DuCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ri7pxZ9MkcVDI53SIAebE+x7CnkgVw612doJ1QWvl4cjWrBn8jCJ6UOBvc5nd/aDa
         7INrBpCZJOMgh2jO8SorUEziDbp0DivaPH9+Ikx9XlHPfRQs6gNUnJk4NS7PdVyKVC
         hZA6nA02wRzeq+eQoOOZbIofoat/xUS/Va3bAbOyJ6CPqLq9gutIWfXGfSBpKJTt51
         3ZvMMWxy94aqZGGEb6/CwszbxIYkz2GQlAL0n9hN0UukGHx6WP2IhqwpLQ0KhVSIo+
         1lfZ8fKCUiKFqOM4+UgxIvQpl1HW1NsCVQ4ywxyRpx0NHjSUA6Q22NBBFl7mr0Beaa
         wRp0rjtAadFRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B9187400FE; Fri, 11 Feb 2022 14:31:47 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:31:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Subject: Re: [PATCH v3 13/22] perf namespaces: Add functions to access nsinfo
Message-ID: <Ygadg3iSoHvyuBQw@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-14-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-14-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 11, 2022 at 02:34:06AM -0800, Ian Rogers escreveu:
> Having functions to access nsinfo reduces the places where reference
> counting checking needs to be added.

Looks sensible, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c  |  2 +-
>  tools/perf/builtin-probe.c   |  2 +-
>  tools/perf/util/build-id.c   |  4 +--
>  tools/perf/util/jitdump.c    | 10 ++++----
>  tools/perf/util/map.c        |  4 +--
>  tools/perf/util/namespaces.c | 50 ++++++++++++++++++++++++++++--------
>  tools/perf/util/namespaces.h | 10 ++++++--
>  tools/perf/util/symbol.c     |  8 +++---
>  8 files changed, 63 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index bede332bf0e2..f7917c390e96 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -354,7 +354,7 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
>  		nnsi = nsinfo__copy(nsi);
>  		if (nnsi) {
>  			nsinfo__put(nsi);
> -			nnsi->need_setns = false;
> +			nsinfo__clear_need_setns(nnsi);
>  			nsi = nnsi;
>  		}
>  		dso = machine__findnew_vdso(machine, thread);
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index c31627af75d4..f62298f5db3b 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -217,7 +217,7 @@ static int opt_set_target_ns(const struct option *opt __maybe_unused,
>  			return ret;
>  		}
>  		nsip = nsinfo__new(ns_pid);
> -		if (nsip && nsip->need_setns)
> +		if (nsip && nsinfo__need_setns(nsip))
>  			params.nsi = nsinfo__get(nsip);
>  		nsinfo__put(nsip);
>  
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index e32e8f2ff3bd..7a5821c87f94 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -706,7 +706,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
>  		if (is_kallsyms) {
>  			if (copyfile("/proc/kallsyms", filename))
>  				goto out_free;
> -		} else if (nsi && nsi->need_setns) {
> +		} else if (nsi && nsinfo__need_setns(nsi)) {
>  			if (copyfile_ns(name, filename, nsi))
>  				goto out_free;
>  		} else if (link(realname, filename) && errno != EEXIST &&
> @@ -730,7 +730,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
>  				goto out_free;
>  			}
>  			if (access(filename, F_OK)) {
> -				if (nsi && nsi->need_setns) {
> +				if (nsi && nsinfo__need_setns(nsi)) {
>  					if (copyfile_ns(debugfile, filename,
>  							nsi))
>  						goto out_free;
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 917a9c707371..a23255773c60 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -382,15 +382,15 @@ jit_inject_event(struct jit_buf_desc *jd, union perf_event *event)
>  
>  static pid_t jr_entry_pid(struct jit_buf_desc *jd, union jr_entry *jr)
>  {
> -	if (jd->nsi && jd->nsi->in_pidns)
> -		return jd->nsi->tgid;
> +	if (jd->nsi && nsinfo__in_pidns(jd->nsi))
> +		return nsinfo__tgid(jd->nsi);
>  	return jr->load.pid;
>  }
>  
>  static pid_t jr_entry_tid(struct jit_buf_desc *jd, union jr_entry *jr)
>  {
> -	if (jd->nsi && jd->nsi->in_pidns)
> -		return jd->nsi->pid;
> +	if (jd->nsi && nsinfo__in_pidns(jd->nsi))
> +		return nsinfo__pid(jd->nsi);
>  	return jr->load.tid;
>  }
>  
> @@ -779,7 +779,7 @@ jit_detect(char *mmap_name, pid_t pid, struct nsinfo *nsi)
>  	 * pid does not match mmap pid
>  	 * pid==0 in system-wide mode (synthesized)
>  	 */
> -	if (pid && pid2 != nsi->nstgid)
> +	if (pid && pid2 != nsinfo__nstgid(nsi))
>  		return -1;
>  	/*
>  	 * validate suffix
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index dfa5f6b7381f..166c84c829f6 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -139,7 +139,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  
>  		if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
>  			snprintf(newfilename, sizeof(newfilename),
> -				 "/tmp/perf-%d.map", nsi->pid);
> +				 "/tmp/perf-%d.map", nsinfo__pid(nsi));
>  			filename = newfilename;
>  		}
>  
> @@ -156,7 +156,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  			nnsi = nsinfo__copy(nsi);
>  			if (nnsi) {
>  				nsinfo__put(nsi);
> -				nnsi->need_setns = false;
> +				nsinfo__clear_need_setns(nnsi);
>  				nsi = nnsi;
>  			}
>  			pgoff = 0;
> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index 48aa3217300b..dd536220cdb9 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c
> @@ -76,7 +76,7 @@ static int nsinfo__get_nspid(struct nsinfo *nsi, const char *path)
>  		if (strstr(statln, "Tgid:") != NULL) {
>  			nsi->tgid = (pid_t)strtol(strrchr(statln, '\t'),
>  						     NULL, 10);
> -			nsi->nstgid = nsi->tgid;
> +			nsi->nstgid = nsinfo__tgid(nsi);
>  		}
>  
>  		if (strstr(statln, "NStgid:") != NULL) {
> @@ -108,7 +108,7 @@ int nsinfo__init(struct nsinfo *nsi)
>  	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
>  		return rv;
>  
> -	if (asprintf(&newns, "/proc/%d/ns/mnt", nsi->pid) == -1)
> +	if (asprintf(&newns, "/proc/%d/ns/mnt", nsinfo__pid(nsi)) == -1)
>  		return rv;
>  
>  	if (stat(oldns, &old_stat) < 0)
> @@ -129,7 +129,7 @@ int nsinfo__init(struct nsinfo *nsi)
>  	/* If we're dealing with a process that is in a different PID namespace,
>  	 * attempt to work out the innermost tgid for the process.
>  	 */
> -	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsi->pid) >= PATH_MAX)
> +	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsinfo__pid(nsi)) >= PATH_MAX)
>  		goto out;
>  
>  	rv = nsinfo__get_nspid(nsi, spath);
> @@ -166,7 +166,7 @@ struct nsinfo *nsinfo__new(pid_t pid)
>  	return nsi;
>  }
>  
> -struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
> +struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
>  {
>  	struct nsinfo *nnsi;
>  
> @@ -175,11 +175,11 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
>  
>  	nnsi = calloc(1, sizeof(*nnsi));
>  	if (nnsi != NULL) {
> -		nnsi->pid = nsi->pid;
> -		nnsi->tgid = nsi->tgid;
> -		nnsi->nstgid = nsi->nstgid;
> -		nnsi->need_setns = nsi->need_setns;
> -		nnsi->in_pidns = nsi->in_pidns;
> +		nnsi->pid = nsinfo__pid(nsi);
> +		nnsi->tgid = nsinfo__tgid(nsi);
> +		nnsi->nstgid = nsinfo__nstgid(nsi);
> +		nnsi->need_setns = nsinfo__need_setns(nsi);
> +		nnsi->in_pidns = nsinfo__in_pidns(nsi);
>  		if (nsi->mntns_path) {
>  			nnsi->mntns_path = strdup(nsi->mntns_path);
>  			if (!nnsi->mntns_path) {
> @@ -193,7 +193,7 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
>  	return nnsi;
>  }
>  
> -void nsinfo__delete(struct nsinfo *nsi)
> +static void nsinfo__delete(struct nsinfo *nsi)
>  {
>  	zfree(&nsi->mntns_path);
>  	free(nsi);
> @@ -212,6 +212,36 @@ void nsinfo__put(struct nsinfo *nsi)
>  		nsinfo__delete(nsi);
>  }
>  
> +bool nsinfo__need_setns(const struct nsinfo *nsi)
> +{
> +        return nsi->need_setns;
> +}
> +
> +void nsinfo__clear_need_setns(struct nsinfo *nsi)
> +{
> +        nsi->need_setns = false;
> +}
> +
> +pid_t nsinfo__tgid(const struct nsinfo  *nsi)
> +{
> +        return nsi->tgid;
> +}
> +
> +pid_t nsinfo__nstgid(const struct nsinfo  *nsi)
> +{
> +        return nsi->nstgid;
> +}
> +
> +pid_t nsinfo__pid(const struct nsinfo  *nsi)
> +{
> +        return nsi->pid;
> +}
> +
> +pid_t nsinfo__in_pidns(const struct nsinfo  *nsi)
> +{
> +        return nsi->in_pidns;
> +}
> +
>  void nsinfo__mountns_enter(struct nsinfo *nsi,
>  				  struct nscookie *nc)
>  {
> diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
> index 9ceea9643507..567829262c42 100644
> --- a/tools/perf/util/namespaces.h
> +++ b/tools/perf/util/namespaces.h
> @@ -47,12 +47,18 @@ struct nscookie {
>  
>  int nsinfo__init(struct nsinfo *nsi);
>  struct nsinfo *nsinfo__new(pid_t pid);
> -struct nsinfo *nsinfo__copy(struct nsinfo *nsi);
> -void nsinfo__delete(struct nsinfo *nsi);
> +struct nsinfo *nsinfo__copy(const struct nsinfo *nsi);
>  
>  struct nsinfo *nsinfo__get(struct nsinfo *nsi);
>  void nsinfo__put(struct nsinfo *nsi);
>  
> +bool nsinfo__need_setns(const struct nsinfo *nsi);
> +void nsinfo__clear_need_setns(struct nsinfo *nsi);
> +pid_t nsinfo__tgid(const struct nsinfo  *nsi);
> +pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
> +pid_t nsinfo__pid(const struct nsinfo  *nsi);
> +pid_t nsinfo__in_pidns(const struct nsinfo  *nsi);
> +
>  void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
>  void nsinfo__mountns_exit(struct nscookie *nc);
>  
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 266c65bb8bbb..e8045b1c8700 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1784,8 +1784,8 @@ static int dso__find_perf_map(char *filebuf, size_t bufsz,
>  
>  	nsi = *nsip;
>  
> -	if (nsi->need_setns) {
> -		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsi->nstgid);
> +	if (nsinfo__need_setns(nsi)) {
> +		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsinfo__nstgid(nsi));
>  		nsinfo__mountns_enter(nsi, &nsc);
>  		rc = access(filebuf, R_OK);
>  		nsinfo__mountns_exit(&nsc);
> @@ -1797,8 +1797,8 @@ static int dso__find_perf_map(char *filebuf, size_t bufsz,
>  	if (nnsi) {
>  		nsinfo__put(nsi);
>  
> -		nnsi->need_setns = false;
> -		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nnsi->tgid);
> +		nsinfo__clear_need_setns(nnsi);
> +		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsinfo__tgid(nnsi));
>  		*nsip = nnsi;
>  		rc = 0;
>  	}
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
