Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D853309F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiEXSq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiEXSqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:46:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DC016598;
        Tue, 24 May 2022 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653418013; x=1684954013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A2gPSC53emycXd2amA2D6MhP+BXPtWcHw7Z+UvyzPqE=;
  b=mRmknRj2IZtgLW2fu+yWkxw00vyMrlXLfO9B1xXsQa6wjAFOZ8SaeDVh
   PD+OPdPVay2HN0FSvljYzYEBjZtX9VklijdjK5Zv6QS3BKQDqRGgzFMym
   NWxVsQttO/CjjrPnfCNW7v7CgLro1YRtHWpU0us05wAIeAu3/1DL7gy7H
   xnMXNNfl8kXZQMrmgoSWMWrOTTD+FMU01T+hIsPckA0y8AnpbgsHhwFxN
   frqavRsn+7lrCVEx9d5m0tv5LtcvKbJZZytJlMLgm1BwSTsnS9cYh/OU6
   DZIqR/OlakWOqlOK/D+ea9TSlyms8EsWCxr62rPDkuqp+mLOkYqPy2mTA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273736233"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273736233"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="820415538"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2022 11:46:52 -0700
Received: from [10.252.209.117] (kliang2-MOBL.ccr.corp.intel.com [10.252.209.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D2E04580971;
        Tue, 24 May 2022 11:46:48 -0700 (PDT)
Message-ID: <7c072dd2-de6f-e083-a400-17467d6fe6e8@linux.intel.com>
Date:   Tue, 24 May 2022 14:46:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 2/5] perf header: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org
Cc:     irogers@google.com, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, ak@linux.intel.com,
        eranian@google.com, like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
 <20220523033945.1612-3-ravi.bangoria@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220523033945.1612-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2022 11:39 PM, Ravi Bangoria wrote:
> Pmus advertise their capabilities via sysfs attribute files but
> perf tool currently parses only core(cpu) pmu capabilities. Add
> support for parsing non-cpu pmu capabilities.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>   .../Documentation/perf.data-file-format.txt   |  17 ++
>   tools/perf/util/env.c                         |  47 +++++
>   tools/perf/util/env.h                         |  10 +
>   tools/perf/util/header.c                      | 185 ++++++++++++++++++
>   tools/perf/util/header.h                      |   1 +
>   tools/perf/util/pmu.c                         |  15 +-
>   tools/perf/util/pmu.h                         |   2 +
>   7 files changed, 273 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index f56d0e0fbff6..64dddaecda21 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -435,6 +435,23 @@ struct {
>   	} [nr_pmu];
>   };
>   
> +	HEADER_PMU_CAPS = 32,
> +
> +	List of pmu capabilities (except cpu pmu which is already
> +	covered by HEADER_CPU_PMU_CAPS / HEADER_HYBRID_CPU_PMU_CAPS)
> +
> +struct {
> +	u32 nr_pmus;
> +	struct {
> +		char pmu_name[];
> +		u32 nr_caps;
> +		struct {
> +			char name[];
> +			char value[];
> +		} [nr_caps];
> +	} [nr_pmus];
> +};
> +
>   	other bits are reserved and should ignored for now
>   	HEADER_FEAT_BITS	= 256,
>   
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 579e44c59914..3ecdd7683e45 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -180,6 +180,7 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
>   void perf_env__exit(struct perf_env *env)
>   {
>   	int i;
> +	u32 j;
>   
>   	perf_env__purge_bpf(env);
>   	perf_env__purge_cgroups(env);
> @@ -222,6 +223,14 @@ void perf_env__exit(struct perf_env *env)
>   		zfree(&env->hybrid_cpc_nodes[i].pmu_name);
>   	}
>   	zfree(&env->hybrid_cpc_nodes);
> +
> +	for (i = 0; i < env->nr_pmus_with_caps; i++) {
> +		zfree(&env->env_pmu_caps[i].pmu_name);
> +		for (j = 0; j < env->env_pmu_caps[i].nr_caps; j++)
> +			zfree(&env->env_pmu_caps[i].pmu_caps[j]);
> +		zfree(&env->env_pmu_caps[i].pmu_caps);
> +	}
> +	zfree(&env->env_pmu_caps);
>   }
>   
>   void perf_env__init(struct perf_env *env)
> @@ -527,3 +536,41 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
>   
>   	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
>   }
> +
> +char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
> +			     const char *cap)
> +{
> +	struct env_pmu_caps *env_pmu_caps = env->env_pmu_caps;
> +	char *cap_eq;
> +	int cap_size;
> +	char **ptr;
> +	int i;
> +	u32 j;
> +
> +	if (!pmu_name || !cap)
> +		return NULL;
> +
> +	cap_size = strlen(cap);
> +	cap_eq = zalloc(cap_size + 2);
> +	if (!cap_eq)
> +		return NULL;
> +
> +	memcpy(cap_eq, cap, cap_size);
> +	cap_eq[cap_size] = '=';
> +
> +	for (i = 0; i < env->nr_pmus_with_caps; i++) {
> +		if (strcmp(env_pmu_caps[i].pmu_name, pmu_name))
> +			continue;
> +
> +		ptr = env_pmu_caps[i].pmu_caps;
> +
> +		for (j = 0; j < env_pmu_caps[i].nr_caps; j++) {
> +			if (!strncmp(ptr[j], cap_eq, cap_size + 1)) {
> +				free(cap_eq);
> +				return &ptr[j][cap_size + 1];
> +			}
> +		}
> +	}
> +	free(cap_eq);
> +	return NULL;
> +}
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index a3541f98e1fc..a21d62ee9de8 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -50,6 +50,12 @@ struct hybrid_cpc_node {
>   	char            *pmu_name;
>   };
>   
> +struct env_pmu_caps {
> +	char	*pmu_name;
> +	u32	nr_caps;
> +	char	**pmu_caps;
> +};
> +
>   struct perf_env {
>   	char			*hostname;
>   	char			*os_release;
> @@ -75,6 +81,7 @@ struct perf_env {
>   	int			nr_cpu_pmu_caps;
>   	int			nr_hybrid_nodes;
>   	int			nr_hybrid_cpc_nodes;
> +	int			nr_pmus_with_caps;
>   	char			*cmdline;
>   	const char		**cmdline_argv;
>   	char			*sibling_cores;
> @@ -95,6 +102,7 @@ struct perf_env {
>   	unsigned long long	 memory_bsize;
>   	struct hybrid_node	*hybrid_nodes;
>   	struct hybrid_cpc_node	*hybrid_cpc_nodes;
> +	struct env_pmu_caps	*env_pmu_caps;
>   #ifdef HAVE_LIBBPF_SUPPORT
>   	/*
>   	 * bpf_info_lock protects bpf rbtrees. This is needed because the
> @@ -172,4 +180,6 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
>   struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
>   
>   int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
> +char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
> +			     const char *cap);
>   #endif /* __PERF_ENV_H */
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index a27132e5a5ef..b4505dbb9f4a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1580,6 +1580,67 @@ static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>   	return 0;
>   }
>   
> +/*
> + * File format:
> + *
> + * struct {
> + *	u32 nr_pmus;
> + *	struct {
> + *		char pmu_name[];
> + *		u32 nr_caps;
> + *		struct {
> + *			char name[];
> + *			char value[];
> + *		} [nr_caps];
> + *	} [nr_pmus];
> + * };
> + */
> +static int write_pmu_caps(struct feat_fd *ff, struct evlist *evlist __maybe_unused)
> +{
> +	struct perf_pmu_caps *caps = NULL;
> +	struct perf_pmu *pmu = NULL;
> +	u32 nr_pmus = 0;
> +	int ret;
> +
> +	while ((pmu = perf_pmu__scan(pmu))) {
> +		if (!pmu->name || !strncmp(pmu->name, "cpu", 3) ||
> +		    perf_pmu__caps_parse(pmu) <= 0)
> +			continue;
> +		nr_pmus++;
> +	}
> +
> +	ret = do_write(ff, &nr_pmus, sizeof(nr_pmus));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!nr_pmus)
> +		return 0;
> +
> +	while ((pmu = perf_pmu__scan(pmu))) {
> +		if (!pmu->name || !strncmp(pmu->name, "cpu", 3) || !pmu->nr_caps)
> +			continue;
> +
> +		ret = do_write_string(ff, pmu->name);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = do_write(ff, &pmu->nr_caps, sizeof(pmu->nr_caps));
> +		if (ret < 0)
> +			return ret;
> +
> +		list_for_each_entry(caps, &pmu->caps, list) {
> +			ret = do_write_string(ff, caps->name);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = do_write_string(ff, caps->value);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}

The write_per_cpu_pmu_caps() also does a similar thing. Can we factor 
out a generic write_pmu_caps() which works for both cpu and non-cpu pmu 
capabilities?

It seems the print_pmu_caps()/process_pmu_caps() can also does similar 
factor out.


Actually, more aggressively, why not use the HEADER_PMU_CAPS to replace 
the HEADER_HYBRID_CPU_PMU_CAPS? The HEADER_HYBRID_CPU_PMU_CAPS is the 
last header feature. It seems doable. We can always write/print the 
"cpu_" kind of PMU first to be compatible with the old tools.

Thanks,
Kan

> +	return 0;
> +}
> +
>   static void print_hostname(struct feat_fd *ff, FILE *fp)
>   {
>   	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
> @@ -2209,6 +2270,32 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
>   	}
>   }
>   
> +static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
> +{
> +	struct env_pmu_caps *env_pmu_caps = ff->ph->env.env_pmu_caps;
> +	int nr_pmus_with_caps = ff->ph->env.nr_pmus_with_caps;
> +	const char *delimiter = "";
> +	char **ptr;
> +	int i;
> +	u32 j;
> +
> +	if (!nr_pmus_with_caps)
> +		return;
> +
> +	for (i = 0; i < nr_pmus_with_caps; i++) {
> +		fprintf(fp, "# %s pmu capabilities: ", env_pmu_caps[i].pmu_name);
> +
> +		ptr = env_pmu_caps[i].pmu_caps;
> +
> +		delimiter = "";
> +		for (j = 0; j < env_pmu_caps[i].nr_caps; j++) {
> +			fprintf(fp, "%s%s", delimiter, ptr[j]);
> +			delimiter = ", ";
> +		}
> +		fprintf(fp, "\n");
> +	}
> +}
> +
>   static int __event_process_build_id(struct perf_record_header_build_id *bev,
>   				    char *filename,
>   				    struct perf_session *session)
> @@ -3319,6 +3406,103 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>   	return ret;
>   }
>   
> +static int __process_pmu_caps(struct feat_fd *ff, struct env_pmu_caps *env_pmu_caps)
> +{
> +	u32 nr_caps = env_pmu_caps->nr_caps;
> +	int name_size, value_size;
> +	char *name, *value, *ptr;
> +	u32 i;
> +
> +	env_pmu_caps->pmu_caps = zalloc(sizeof(char *) * nr_caps);
> +	if (!env_pmu_caps->pmu_caps)
> +		return -1;
> +
> +	for (i = 0; i < nr_caps; i++) {
> +		name = do_read_string(ff);
> +		if (!name)
> +			goto error;
> +
> +		value = do_read_string(ff);
> +		if (!value)
> +			goto free_name;
> +
> +		name_size = strlen(name);
> +		value_size = strlen(value);
> +		ptr = zalloc(sizeof(char) * (name_size + value_size + 2));
> +		if (!ptr)
> +			goto free_value;
> +
> +		memcpy(ptr, name, name_size);
> +		ptr[name_size] = '=';
> +		memcpy(ptr + name_size + 1, value, value_size);
> +		env_pmu_caps->pmu_caps[i] = ptr;
> +
> +		free(value);
> +		free(name);
> +	}
> +	return 0;
> +
> +free_value:
> +	free(value);
> +free_name:
> +	free(name);
> +error:
> +	for (; i > 0; i--)
> +		free(env_pmu_caps->pmu_caps[i - 1]);
> +	free(env_pmu_caps->pmu_caps);
> +	return -1;
> +}
> +
> +static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
> +{
> +	struct env_pmu_caps *env_pmu_caps;
> +	u32 nr_pmus;
> +	u32 i, j;
> +
> +	ff->ph->env.nr_pmus_with_caps = 0;
> +	ff->ph->env.env_pmu_caps = NULL;
> +
> +	if (do_read_u32(ff, &nr_pmus))
> +		return -1;
> +
> +	if (!nr_pmus)
> +		return 0;
> +
> +	env_pmu_caps = zalloc(sizeof(struct env_pmu_caps) * nr_pmus);
> +	if (!env_pmu_caps)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr_pmus; i++) {
> +		env_pmu_caps[i].pmu_name = do_read_string(ff);
> +		if (!env_pmu_caps[i].pmu_name)
> +			goto error;
> +
> +		if (do_read_u32(ff, &env_pmu_caps[i].nr_caps))
> +			goto free_pmu_name;
> +
> +		if (!__process_pmu_caps(ff, &env_pmu_caps[i]))
> +			continue;
> +
> +free_pmu_name:
> +		free(env_pmu_caps[i].pmu_name);
> +		goto error;
> +	}
> +
> +	ff->ph->env.nr_pmus_with_caps = nr_pmus;
> +	ff->ph->env.env_pmu_caps = env_pmu_caps;
> +	return 0;
> +
> +error:
> +	for (; i > 0; i--) {
> +		free(env_pmu_caps[i - 1].pmu_name);
> +		for (j = 0; j < env_pmu_caps[i - 1].nr_caps; j++)
> +			free(env_pmu_caps[i - 1].pmu_caps[j]);
> +		free(env_pmu_caps[i - 1].pmu_caps);
> +	}
> +	free(env_pmu_caps);
> +	return -1;
> +}
> +
>   #define FEAT_OPR(n, func, __full_only) \
>   	[HEADER_##n] = {					\
>   		.name	    = __stringify(n),			\
> @@ -3382,6 +3566,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>   	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
>   	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
>   	FEAT_OPR(HYBRID_CPU_PMU_CAPS,	hybrid_cpu_pmu_caps,	false),
> +	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
>   };
>   
>   struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 0eb4bc29a5a4..e9a067bb8b9e 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -47,6 +47,7 @@ enum {
>   	HEADER_CLOCK_DATA,
>   	HEADER_HYBRID_TOPOLOGY,
>   	HEADER_HYBRID_CPU_PMU_CAPS,
> +	HEADER_PMU_CAPS,
>   	HEADER_LAST_FEATURE,
>   	HEADER_FEAT_BITS	= 256,
>   };
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 9a1c7e63e663..8d599acb7569 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1890,16 +1890,22 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>   	const char *sysfs = sysfs__mountpoint();
>   	DIR *caps_dir;
>   	struct dirent *evt_ent;
> -	int nr_caps = 0;
> +
> +	if (pmu->caps_initialized)
> +		return pmu->nr_caps;
>   
>   	if (!sysfs)
>   		return -1;
>   
> +	pmu->nr_caps = 0;
> +
>   	snprintf(caps_path, PATH_MAX,
>   		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
>   
> -	if (stat(caps_path, &st) < 0)
> +	if (stat(caps_path, &st) < 0) {
> +		pmu->caps_initialized = true;
>   		return 0;	/* no error if caps does not exist */
> +	}
>   
>   	caps_dir = opendir(caps_path);
>   	if (!caps_dir)
> @@ -1926,13 +1932,14 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>   			continue;
>   		}
>   
> -		nr_caps++;
> +		pmu->nr_caps++;
>   		fclose(file);
>   	}
>   
>   	closedir(caps_dir);
>   
> -	return nr_caps;
> +	pmu->caps_initialized = true;
> +	return pmu->nr_caps;
>   }
>   
>   void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 541889fa9f9c..4b45fd8da5a3 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -46,6 +46,8 @@ struct perf_pmu {
>   	struct perf_cpu_map *cpus;
>   	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>   	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
> +	bool caps_initialized;
> +	u32 nr_caps;
>   	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>   	struct list_head list;    /* ELEM */
>   	struct list_head hybrid_list;
