Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67A53A601
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353278AbiFANhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348663AbiFANh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:37:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992665BD0F;
        Wed,  1 Jun 2022 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654090646; x=1685626646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y0A7My6YrMaz3ZUl2F+l5zE2By1x35z+NPAjRWT7Nak=;
  b=fuZJWNjTmmTyuMUnggMyZ3BAP6MpJqzS8mnP/6ALU8d1/+JYYsyvKHYo
   HSI04Mf+W37HimlnyEXgNB/t1NjLHMh2nnSKz9wO+I9+WO0NtBONTok9G
   tx/W1rInEOSNtF2AAaWRvZxS8vY0KLlGxnGuKS2xmL19XPIseyt0vFagQ
   Awpigv6zzhlh/Azv5HYNTWW/NjY1SzZQ6q9ezJQfsnc8XAtwbNYuIdekm
   LZ41UCQjEF5QHo8gRzHZYSbs0pRHtvnnh095WsXBf6Bz1e3D3OHiDOoAR
   PpAxTCnuU2949GsY0PfGHYb93tHIs2lqyzAgcS+3VMQeCG/xCAEdvvqDr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="274391242"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="274391242"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="633539127"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2022 06:36:20 -0700
Received: from [10.252.214.178] (kliang2-MOBL.ccr.corp.intel.com [10.252.214.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4E776580931;
        Wed,  1 Jun 2022 06:36:17 -0700 (PDT)
Message-ID: <759fea44-0d57-1588-6085-846f356b438f@linux.intel.com>
Date:   Wed, 1 Jun 2022 09:36:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 4/8] perf headers: Store pmu caps in an array of
 strings
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org
Cc:     jolsa@kernel.org, irogers@google.com, peterz@infradead.org,
        rrichter@amd.com, mingo@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, ak@linux.intel.com,
        eranian@google.com, like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
 <20220601032608.1034-5-ravi.bangoria@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220601032608.1034-5-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2022 11:26 PM, Ravi Bangoria wrote:
> Currently all capabilities are stored in a single string separated
> by NULL character. Instead, store them in an array which makes
> searching of capability easier.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>   tools/perf/util/env.c    |  6 +++-
>   tools/perf/util/env.h    |  4 +--
>   tools/perf/util/header.c | 70 +++++++++++++++++++++++-----------------
>   3 files changed, 48 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 579e44c59914..7d3aeb2e4622 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -179,7 +179,7 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
>   
>   void perf_env__exit(struct perf_env *env)
>   {
> -	int i;
> +	int i, j;
>   
>   	perf_env__purge_bpf(env);
>   	perf_env__purge_cgroups(env);
> @@ -196,6 +196,8 @@ void perf_env__exit(struct perf_env *env)
>   	zfree(&env->sibling_threads);
>   	zfree(&env->pmu_mappings);
>   	zfree(&env->cpu);
> +	for (i = 0; i < env->nr_cpu_pmu_caps; i++)
> +		zfree(&env->cpu_pmu_caps[i]);
>   	zfree(&env->cpu_pmu_caps);
>   	zfree(&env->numa_map);
>   
> @@ -218,6 +220,8 @@ void perf_env__exit(struct perf_env *env)
>   	zfree(&env->hybrid_nodes);
>   
>   	for (i = 0; i < env->nr_hybrid_cpc_nodes; i++) {
> +		for (j = 0; j < env->hybrid_cpc_nodes[i].nr_cpu_pmu_caps; j++)
> +			zfree(&env->hybrid_cpc_nodes[i].cpu_pmu_caps[j]);
>   		zfree(&env->hybrid_cpc_nodes[i].cpu_pmu_caps);
>   		zfree(&env->hybrid_cpc_nodes[i].pmu_name);
>   	}
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index a3541f98e1fc..43aab59f7322 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -46,7 +46,7 @@ struct hybrid_node {
>   struct hybrid_cpc_node {
>   	int		nr_cpu_pmu_caps;
>   	unsigned int    max_branches;
> -	char            *cpu_pmu_caps;
> +	char            **cpu_pmu_caps;
>   	char            *pmu_name;
>   };
>   
> @@ -81,7 +81,7 @@ struct perf_env {
>   	char			*sibling_dies;
>   	char			*sibling_threads;
>   	char			*pmu_mappings;
> -	char			*cpu_pmu_caps;
> +	char			**cpu_pmu_caps;
>   	struct cpu_topology_map	*cpu;
>   	struct cpu_cache_level	*caches;
>   	int			 caches_cnt;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index ee7ccd94e272..a1e4ec53333d 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2051,26 +2051,21 @@ static void print_compressed(struct feat_fd *ff, FILE *fp)
>   		ff->ph->env.comp_level, ff->ph->env.comp_ratio);
>   }
>   
> -static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char *cpu_pmu_caps,
> +static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char **cpu_pmu_caps,
>   				   char *pmu_name)
>   {
> -	const char *delimiter;
> -	char *str, buf[128];
> +	const char *delimiter = "";
> +	int i;
>   
>   	if (!nr_caps) {
>   		fprintf(fp, "# %s pmu capabilities: not available\n", pmu_name);
>   		return;
>   	}
>   
> -	scnprintf(buf, sizeof(buf), "# %s pmu capabilities: ", pmu_name);
> -
> -	delimiter = buf;
> -
> -	str = cpu_pmu_caps;
> -	while (nr_caps--) {
> -		fprintf(fp, "%s%s", delimiter, str);
> +	fprintf(fp, "# %s pmu capabilities: ", pmu_name);
> +	for (i = 0; i < nr_caps; i++) {
> +		fprintf(fp, "%s%s", delimiter, cpu_pmu_caps[i]);
>   		delimiter = ", ";
> -		str += strlen(str) + 1;
>   	}
>   
>   	fprintf(fp, "\n");
> @@ -3202,27 +3197,27 @@ static int process_compressed(struct feat_fd *ff,
>   }
>   
>   static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
> -				    char **cpu_pmu_caps,
> +				    char ***cpu_pmu_caps,
>   				    unsigned int *max_branches)
>   {
> -	char *name, *value;
> -	struct strbuf sb;
> -	u32 nr_caps;
> +	int name_size, value_size;
> +	char *name, *value, *ptr;
> +	u32 nr_caps, i;
> +
> +	*nr_cpu_pmu_caps = 0;
> +	*cpu_pmu_caps = NULL;
>   
>   	if (do_read_u32(ff, &nr_caps))
>   		return -1;
>   
> -	if (!nr_caps) {
> -		pr_debug("cpu pmu capabilities not available\n");
> +	if (!nr_caps)
>   		return 0;
> -	}
> -
> -	*nr_cpu_pmu_caps = nr_caps;
>   
> -	if (strbuf_init(&sb, 128) < 0)
> +	*cpu_pmu_caps = zalloc(sizeof(char *) * nr_caps);
> +	if (!*cpu_pmu_caps)
>   		return -1;
>   
> -	while (nr_caps--) {
> +	for (i = 0; i < nr_caps; i++) {
>   		name = do_read_string(ff);
>   		if (!name)
>   			goto error;
> @@ -3231,12 +3226,16 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
>   		if (!value)
>   			goto free_name;
>   
> -		if (strbuf_addf(&sb, "%s=%s", name, value) < 0)
> +		name_size = strlen(name);
> +		value_size = strlen(value);
> +		ptr = zalloc(sizeof(char) * (name_size + value_size + 2));
> +		if (!ptr)
>   			goto free_value;
>   
> -		/* include a NULL character at the end */
> -		if (strbuf_add(&sb, "", 1) < 0)
> -			goto free_value;
> +		memcpy(ptr, name, name_size);
> +		ptr[name_size] = '=';
> +		memcpy(ptr + name_size + 1, value, value_size);
> +		(*cpu_pmu_caps)[i] = ptr;
>   
>   		if (!strcmp(name, "branches"))
>   			*max_branches = atoi(value);
> @@ -3244,7 +3243,7 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
>   		free(value);
>   		free(name);
>   	}
> -	*cpu_pmu_caps = strbuf_detach(&sb, NULL);
> +	*nr_cpu_pmu_caps = nr_caps;
>   	return 0;
>   
>   free_value:
> @@ -3252,16 +3251,24 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
>   free_name:
>   	free(name);
>   error:
> -	strbuf_release(&sb);
> +	for (; i > 0; i--)
> +		free((*cpu_pmu_caps)[i - 1]);
> +	free(*cpu_pmu_caps);
> +	*cpu_pmu_caps = NULL;
> +	*nr_cpu_pmu_caps = 0;
>   	return -1;
>   }
>   
>   static int process_cpu_pmu_caps(struct feat_fd *ff,
>   				void *data __maybe_unused)
>   {
> -	return process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
> +	int ret = process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
>   					&ff->ph->env.cpu_pmu_caps,
>   					&ff->ph->env.max_branches);
> +
> +	if (!ret && !ff->ph->env.cpu_pmu_caps)
> +		pr_debug("cpu pmu capabilities not available\n");
> +	return ret;
>   }
>   
>   static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
> @@ -3270,6 +3277,7 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>   	struct hybrid_cpc_node *nodes;
>   	u32 nr_pmu, i;
>   	int ret;
> +	int j;
>   
>   	if (do_read_u32(ff, &nr_pmu))
>   		return -1;
> @@ -3297,6 +3305,8 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>   			ret = -1;
>   			goto err;
>   		}
> +		if (!n->nr_cpu_pmu_caps)
> +			pr_debug("%s pmu capabilities not available\n", n->pmu_name);
>   	}
>   
>   	ff->ph->env.nr_hybrid_cpc_nodes = nr_pmu;
> @@ -3305,6 +3315,8 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>   
>   err:
>   	for (i = 0; i < nr_pmu; i++) {
> +		for (j = 0; j < nodes[i].nr_cpu_pmu_caps; j++)
> +			free(nodes[i].cpu_pmu_caps[j]);
>   		free(nodes[i].cpu_pmu_caps);
>   		free(nodes[i].pmu_name);
>   	}
