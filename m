Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1694253A876
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiFAOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354574AbiFAOEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:04:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF218B0B2;
        Wed,  1 Jun 2022 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654091938; x=1685627938;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=MGmkomGG1yme/8K6lyicSW03EJeljfEXQa4rACQnZlo=;
  b=e01G49fZ1kiS0s+eyylBUUNTNERDQzzqd9HwfjF6lQrHwk22FXxgJQAy
   gxvS9R0U2xPE1ml3gbrZjDsVvcDx59uLZkRw32jndF5NpZL/+OJAr7nWa
   XFaZf/a+TUMBs94cfT7WFJ71NPGZruMcyiwS/9GvTyGmmhUzWJFHfso3k
   4pFa+AP5LCLwlDGfuLTP2qSLHE/eJgT7Y6BJSIWQjxV/9anbpQqoLiZZG
   4ZoTuV+j8LhQoSrZk8T7Pj3P5OvtHDwQmEpnHWxH6lOHgfgpVgfX16A2m
   ay3HrgnFYI40LLN9Xsatm4dwgw7/ftduytmUIjwzWoJOV8DCdeaz1VsPG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="255466286"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="255466286"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="612330282"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2022 06:58:44 -0700
Received: from [10.252.214.178] (kliang2-MOBL.ccr.corp.intel.com [10.252.214.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E5AC4580931;
        Wed,  1 Jun 2022 06:58:41 -0700 (PDT)
Message-ID: <ad9e8ab3-f3eb-6a62-2ec4-d502ab84ccbe@linux.intel.com>
Date:   Wed, 1 Jun 2022 09:58:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 5/8] perf headers: Record non-cpu pmu capabilities
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
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
 <20220601032608.1034-6-ravi.bangoria@amd.com>
 <961e538e-9d1a-741c-56e9-bb546eab2aec@linux.intel.com>
In-Reply-To: <961e538e-9d1a-741c-56e9-bb546eab2aec@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2022 9:37 AM, Liang, Kan wrote:
> 
> 
> On 5/31/2022 11:26 PM, Ravi Bangoria wrote:
>> Pmus advertise their capabilities via sysfs attribute files but
>> perf tool currently parses only core(cpu) or hybrid core pmu
>> capabilities. Add support of recording non-core pmu capabilities
>> int perf.data header.
>>
>> Note that a newly proposed HEADER_PMU_CAPS is replacing existing
>> HEADER_HYBRID_CPU_PMU_CAPS. Special care is taken for hybrid core
>> pmus by writing their capabilities first in the perf.data header
>> to make sure new perf.data file being read by old perf tool does
>> not break.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Since the perf_pmu__caps_parse() cached issue has been addressed, the 
patch looks good to me.

	Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>> ---
>>   .../Documentation/perf.data-file-format.txt   |  10 +-
>>   tools/perf/builtin-inject.c                   |   2 +-
>>   tools/perf/util/env.c                         |  60 ++++++-
>>   tools/perf/util/env.h                         |  12 +-
>>   tools/perf/util/header.c                      | 160 ++++++++++--------
>>   tools/perf/util/header.h                      |   2 +-
>>   6 files changed, 158 insertions(+), 88 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt 
>> b/tools/perf/Documentation/perf.data-file-format.txt
>> index f56d0e0fbff6..2233534e508a 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -419,18 +419,20 @@ Example:
>>     cpu_core cpu list : 0-15
>>     cpu_atom cpu list : 16-23
>> -    HEADER_HYBRID_CPU_PMU_CAPS = 31,
>> +    HEADER_PMU_CAPS = 31,
>> -    A list of hybrid CPU PMU capabilities.
>> +    List of pmu capabilities (except cpu pmu which is already
>> +    covered by HEADER_CPU_PMU_CAPS). Note that hybrid cpu pmu
>> +    capabilities are also stored here.
>>   struct {
>>       u32 nr_pmu;
>>       struct {
>> -        u32 nr_cpu_pmu_caps;
>> +        u32 nr_caps;
>>           {
>>               char    name[];
>>               char    value[];
>> -        } [nr_cpu_pmu_caps];
>> +        } [nr_caps];
>>           char pmu_name[];
>>       } [nr_pmu];
>>   };
>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>> index a75bf11585b5..05bc0cfccf83 100644
>> --- a/tools/perf/builtin-inject.c
>> +++ b/tools/perf/builtin-inject.c
>> @@ -809,7 +809,7 @@ static bool keep_feat(int feat)
>>       case HEADER_CPU_PMU_CAPS:
>>       case HEADER_CLOCK_DATA:
>>       case HEADER_HYBRID_TOPOLOGY:
>> -    case HEADER_HYBRID_CPU_PMU_CAPS:
>> +    case HEADER_PMU_CAPS:
>>           return true;
>>       /* Information that can be updated */
>>       case HEADER_BUILD_ID:
>> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
>> index 7d3aeb2e4622..5b8cf6a421a4 100644
>> --- a/tools/perf/util/env.c
>> +++ b/tools/perf/util/env.c
>> @@ -219,13 +219,13 @@ void perf_env__exit(struct perf_env *env)
>>       }
>>       zfree(&env->hybrid_nodes);
>> -    for (i = 0; i < env->nr_hybrid_cpc_nodes; i++) {
>> -        for (j = 0; j < env->hybrid_cpc_nodes[i].nr_cpu_pmu_caps; j++)
>> -            zfree(&env->hybrid_cpc_nodes[i].cpu_pmu_caps[j]);
>> -        zfree(&env->hybrid_cpc_nodes[i].cpu_pmu_caps);
>> -        zfree(&env->hybrid_cpc_nodes[i].pmu_name);
>> +    for (i = 0; i < env->nr_pmus_with_caps; i++) {
>> +        for (j = 0; j < env->pmu_caps[i].nr_caps; j++)
>> +            zfree(&env->pmu_caps[i].caps[j]);
>> +        zfree(&env->pmu_caps[i].caps);
>> +        zfree(&env->pmu_caps[i].pmu_name);
>>       }
>> -    zfree(&env->hybrid_cpc_nodes);
>> +    zfree(&env->pmu_caps);
>>   }
>>   void perf_env__init(struct perf_env *env)
>> @@ -531,3 +531,51 @@ int perf_env__numa_node(struct perf_env *env, 
>> struct perf_cpu cpu)
>>       return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? 
>> env->numa_map[cpu.cpu] : -1;
>>   }
>> +
>> +char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
>> +                 const char *cap)
>> +{
>> +    char *cap_eq;
>> +    int cap_size;
>> +    char **ptr;
>> +    int i, j;
>> +
>> +    if (!pmu_name || !cap)
>> +        return NULL;
>> +
>> +    cap_size = strlen(cap);
>> +    cap_eq = zalloc(cap_size + 2);
>> +    if (!cap_eq)
>> +        return NULL;
>> +
>> +    memcpy(cap_eq, cap, cap_size);
>> +    cap_eq[cap_size] = '=';
>> +
>> +    if (!strcmp(pmu_name, "cpu")) {
>> +        for (i = 0; i < env->nr_cpu_pmu_caps; i++) {
>> +            if (!strncmp(env->cpu_pmu_caps[i], cap_eq, cap_size + 1)) {
>> +                free(cap_eq);
>> +                return &env->cpu_pmu_caps[i][cap_size + 1];
>> +            }
>> +        }
>> +        goto out;
>> +    }
>> +
>> +    for (i = 0; i < env->nr_pmus_with_caps; i++) {
>> +        if (strcmp(env->pmu_caps[i].pmu_name, pmu_name))
>> +            continue;
>> +
>> +        ptr = env->pmu_caps[i].caps;
>> +
>> +        for (j = 0; j < env->pmu_caps[i].nr_caps; j++) {
>> +            if (!strncmp(ptr[j], cap_eq, cap_size + 1)) {
>> +                free(cap_eq);
>> +                return &ptr[j][cap_size + 1];
>> +            }
>> +        }
>> +    }
>> +
>> +out:
>> +    free(cap_eq);
>> +    return NULL;
>> +}
>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>> index 43aab59f7322..4566c51f2fd9 100644
>> --- a/tools/perf/util/env.h
>> +++ b/tools/perf/util/env.h
>> @@ -43,10 +43,10 @@ struct hybrid_node {
>>       char    *cpus;
>>   };
>> -struct hybrid_cpc_node {
>> -    int        nr_cpu_pmu_caps;
>> +struct pmu_caps {
>> +    int        nr_caps;
>>       unsigned int    max_branches;
>> -    char            **cpu_pmu_caps;
>> +    char            **caps;
>>       char            *pmu_name;
>>   };
>> @@ -74,7 +74,7 @@ struct perf_env {
>>       int            nr_groups;
>>       int            nr_cpu_pmu_caps;
>>       int            nr_hybrid_nodes;
>> -    int            nr_hybrid_cpc_nodes;
>> +    int            nr_pmus_with_caps;
>>       char            *cmdline;
>>       const char        **cmdline_argv;
>>       char            *sibling_cores;
>> @@ -94,7 +94,7 @@ struct perf_env {
>>       struct memory_node    *memory_nodes;
>>       unsigned long long     memory_bsize;
>>       struct hybrid_node    *hybrid_nodes;
>> -    struct hybrid_cpc_node    *hybrid_cpc_nodes;
>> +    struct pmu_caps        *pmu_caps;
>>   #ifdef HAVE_LIBBPF_SUPPORT
>>       /*
>>        * bpf_info_lock protects bpf rbtrees. This is needed because the
>> @@ -172,4 +172,6 @@ bool perf_env__insert_btf(struct perf_env *env, 
>> struct btf_node *btf_node);
>>   struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 
>> btf_id);
>>   int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
>> +char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
>> +                 const char *cap);
>>   #endif /* __PERF_ENV_H */
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index a1e4ec53333d..67bf897e8f89 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -1512,18 +1512,13 @@ static int write_compressed(struct feat_fd *ff 
>> __maybe_unused,
>>       return do_write(ff, &(ff->ph->env.comp_mmap_len), 
>> sizeof(ff->ph->env.comp_mmap_len));
>>   }
>> -static int write_per_cpu_pmu_caps(struct feat_fd *ff, struct perf_pmu 
>> *pmu,
>> -                  bool write_pmu)
>> +static int __write_pmu_caps(struct feat_fd *ff, struct perf_pmu *pmu,
>> +                bool write_pmu)
>>   {
>>       struct perf_pmu_caps *caps = NULL;
>> -    int nr_caps;
>>       int ret;
>> -    nr_caps = perf_pmu__caps_parse(pmu);
>> -    if (nr_caps < 0)
>> -        return nr_caps;
>> -
>> -    ret = do_write(ff, &nr_caps, sizeof(nr_caps));
>> +    ret = do_write(ff, &pmu->nr_caps, sizeof(pmu->nr_caps));
> 
> The nr_caps can be retrieved from the cached perf_pmu__caps_parse().
> Seems we only need to pass the nr_caps as a parameter of the 
> __write_pmu_caps().
> 
>>       if (ret < 0)
>>           return ret;
>> @@ -1550,33 +1545,60 @@ static int write_cpu_pmu_caps(struct feat_fd *ff,
>>                     struct evlist *evlist __maybe_unused)
>>   {
>>       struct perf_pmu *cpu_pmu = perf_pmu__find("cpu");
>> +    int ret;
>>       if (!cpu_pmu)
>>           return -ENOENT;
>> -    return write_per_cpu_pmu_caps(ff, cpu_pmu, false);
>> +    ret = perf_pmu__caps_parse(cpu_pmu);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    return __write_pmu_caps(ff, cpu_pmu, false);
>>   }
>> -static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>> -                     struct evlist *evlist __maybe_unused)
>> +static int write_pmu_caps(struct feat_fd *ff,
>> +              struct evlist *evlist __maybe_unused)
>>   {
>> -    struct perf_pmu *pmu;
>> -    u32 nr_pmu = perf_pmu__hybrid_pmu_num();
>> +    struct perf_pmu *pmu = NULL;
>> +    int nr_pmu = 0;
>>       int ret;
>> -    if (nr_pmu == 0)
>> -        return -ENOENT;
>> +    while ((pmu = perf_pmu__scan(pmu))) {
>> +        if (!pmu->name || !strcmp(pmu->name, "cpu") ||
>> +            perf_pmu__caps_parse(pmu) <= 0)
>> +            continue;
>> +        nr_pmu++;
>> +    }
>>       ret = do_write(ff, &nr_pmu, sizeof(nr_pmu));
>>       if (ret < 0)
>>           return ret;
>> +    if (!nr_pmu)
>> +        return 0;
>> +
>> +    /*
>> +     * Write hybrid pmu caps first to maintain compatibility with
>> +     * older perf tool.
>> +     */
>> +    pmu = NULL;
>>       perf_pmu__for_each_hybrid_pmu(pmu) {
>> -        ret = write_per_cpu_pmu_caps(ff, pmu, true);
>> +        ret = __write_pmu_caps(ff, pmu, true);
>>           if (ret < 0)
>>               return ret;
>>       }
>> +    pmu = NULL;
>> +    while ((pmu = perf_pmu__scan(pmu))) {
>> +        if (!pmu->name || !strcmp(pmu->name, "cpu") ||
>> +            !pmu->nr_caps || perf_pmu__is_hybrid(pmu->name))
> 
> The perf_pmu__caps_parse() can used to replace the pmu->nr_caps.
> 
> It seems we can factor out a macro to replace the repeat check 
> !pmu->name || !strcmp(pmu->name, "cpu") || perf_pmu__caps_parse(pmu) <= 0.
> 
> Thanks,
> Kan
> 
>> +            continue;
>> +
>> +        ret = __write_pmu_caps(ff, pmu, true);
>> +        if (ret < 0)
>> +            return ret;
>> +    }
>>       return 0;
>>   }
>> @@ -2051,8 +2073,7 @@ static void print_compressed(struct feat_fd *ff, 
>> FILE *fp)
>>           ff->ph->env.comp_level, ff->ph->env.comp_ratio);
>>   }
>> -static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char 
>> **cpu_pmu_caps,
>> -                   char *pmu_name)
>> +static void __print_pmu_caps(FILE *fp, int nr_caps, char **caps, char 
>> *pmu_name)
>>   {
>>       const char *delimiter = "";
>>       int i;
>> @@ -2064,7 +2085,7 @@ static void print_per_cpu_pmu_caps(FILE *fp, int 
>> nr_caps, char **cpu_pmu_caps,
>>       fprintf(fp, "# %s pmu capabilities: ", pmu_name);
>>       for (i = 0; i < nr_caps; i++) {
>> -        fprintf(fp, "%s%s", delimiter, cpu_pmu_caps[i]);
>> +        fprintf(fp, "%s%s", delimiter, caps[i]);
>>           delimiter = ", ";
>>       }
>> @@ -2073,19 +2094,18 @@ static void print_per_cpu_pmu_caps(FILE *fp, 
>> int nr_caps, char **cpu_pmu_caps,
>>   static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
>>   {
>> -    print_per_cpu_pmu_caps(fp, ff->ph->env.nr_cpu_pmu_caps,
>> -                   ff->ph->env.cpu_pmu_caps, (char *)"cpu");
>> +    __print_pmu_caps(fp, ff->ph->env.nr_cpu_pmu_caps,
>> +             ff->ph->env.cpu_pmu_caps, (char *)"cpu");
>>   }
>> -static void print_hybrid_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
>> +static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
>>   {
>> -    struct hybrid_cpc_node *n;
>> +    struct pmu_caps *pmu_caps;
>> -    for (int i = 0; i < ff->ph->env.nr_hybrid_cpc_nodes; i++) {
>> -        n = &ff->ph->env.hybrid_cpc_nodes[i];
>> -        print_per_cpu_pmu_caps(fp, n->nr_cpu_pmu_caps,
>> -                       n->cpu_pmu_caps,
>> -                       n->pmu_name);
>> +    for (int i = 0; i < ff->ph->env.nr_pmus_with_caps; i++) {
>> +        pmu_caps = &ff->ph->env.pmu_caps[i];
>> +        __print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
>> +                 pmu_caps->pmu_name);
>>       }
>>   }
>> @@ -3196,28 +3216,27 @@ static int process_compressed(struct feat_fd *ff,
>>       return 0;
>>   }
>> -static int process_per_cpu_pmu_caps(struct feat_fd *ff, int 
>> *nr_cpu_pmu_caps,
>> -                    char ***cpu_pmu_caps,
>> -                    unsigned int *max_branches)
>> +static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
>> +                  char ***caps, unsigned int *max_branches)
>>   {
>>       int name_size, value_size;
>>       char *name, *value, *ptr;
>> -    u32 nr_caps, i;
>> +    u32 nr_pmu_caps, i;
>> -    *nr_cpu_pmu_caps = 0;
>> -    *cpu_pmu_caps = NULL;
>> +    *nr_caps = 0;
>> +    *caps = NULL;
>> -    if (do_read_u32(ff, &nr_caps))
>> +    if (do_read_u32(ff, &nr_pmu_caps))
>>           return -1;
>> -    if (!nr_caps)
>> +    if (!nr_pmu_caps)
>>           return 0;
>> -    *cpu_pmu_caps = zalloc(sizeof(char *) * nr_caps);
>> -    if (!*cpu_pmu_caps)
>> +    *caps = zalloc(sizeof(char *) * nr_pmu_caps);
>> +    if (!*caps)
>>           return -1;
>> -    for (i = 0; i < nr_caps; i++) {
>> +    for (i = 0; i < nr_pmu_caps; i++) {
>>           name = do_read_string(ff);
>>           if (!name)
>>               goto error;
>> @@ -3235,7 +3254,7 @@ static int process_per_cpu_pmu_caps(struct 
>> feat_fd *ff, int *nr_cpu_pmu_caps,
>>           memcpy(ptr, name, name_size);
>>           ptr[name_size] = '=';
>>           memcpy(ptr + name_size + 1, value, value_size);
>> -        (*cpu_pmu_caps)[i] = ptr;
>> +        (*caps)[i] = ptr;
>>           if (!strcmp(name, "branches"))
>>               *max_branches = atoi(value);
>> @@ -3243,7 +3262,7 @@ static int process_per_cpu_pmu_caps(struct 
>> feat_fd *ff, int *nr_cpu_pmu_caps,
>>           free(value);
>>           free(name);
>>       }
>> -    *nr_cpu_pmu_caps = nr_caps;
>> +    *nr_caps = nr_pmu_caps;
>>       return 0;
>>   free_value:
>> @@ -3252,29 +3271,28 @@ static int process_per_cpu_pmu_caps(struct 
>> feat_fd *ff, int *nr_cpu_pmu_caps,
>>       free(name);
>>   error:
>>       for (; i > 0; i--)
>> -        free((*cpu_pmu_caps)[i - 1]);
>> -    free(*cpu_pmu_caps);
>> -    *cpu_pmu_caps = NULL;
>> -    *nr_cpu_pmu_caps = 0;
>> +        free((*caps)[i - 1]);
>> +    free(*caps);
>> +    *caps = NULL;
>> +    *nr_caps = 0;
>>       return -1;
>>   }
>>   static int process_cpu_pmu_caps(struct feat_fd *ff,
>>                   void *data __maybe_unused)
>>   {
>> -    int ret = process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
>> -                    &ff->ph->env.cpu_pmu_caps,
>> -                    &ff->ph->env.max_branches);
>> +    int ret = __process_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
>> +                     &ff->ph->env.cpu_pmu_caps,
>> +                     &ff->ph->env.max_branches);
>>       if (!ret && !ff->ph->env.cpu_pmu_caps)
>>           pr_debug("cpu pmu capabilities not available\n");
>>       return ret;
>>   }
>> -static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>> -                       void *data __maybe_unused)
>> +static int process_pmu_caps(struct feat_fd *ff, void *data 
>> __maybe_unused)
>>   {
>> -    struct hybrid_cpc_node *nodes;
>> +    struct pmu_caps *pmu_caps;
>>       u32 nr_pmu, i;
>>       int ret;
>>       int j;
>> @@ -3283,45 +3301,45 @@ static int process_hybrid_cpu_pmu_caps(struct 
>> feat_fd *ff,
>>           return -1;
>>       if (!nr_pmu) {
>> -        pr_debug("hybrid cpu pmu capabilities not available\n");
>> +        pr_debug("pmu capabilities not available\n");
>>           return 0;
>>       }
>> -    nodes = zalloc(sizeof(*nodes) * nr_pmu);
>> -    if (!nodes)
>> +    pmu_caps = zalloc(sizeof(*pmu_caps) * nr_pmu);
>> +    if (!pmu_caps)
>>           return -ENOMEM;
>>       for (i = 0; i < nr_pmu; i++) {
>> -        struct hybrid_cpc_node *n = &nodes[i];
>> -
>> -        ret = process_per_cpu_pmu_caps(ff, &n->nr_cpu_pmu_caps,
>> -                           &n->cpu_pmu_caps,
>> -                           &n->max_branches);
>> +        ret = __process_pmu_caps(ff, &pmu_caps[i].nr_caps,
>> +                     &pmu_caps[i].caps,
>> +                     &pmu_caps[i].max_branches);
>>           if (ret)
>>               goto err;
>> -        n->pmu_name = do_read_string(ff);
>> -        if (!n->pmu_name) {
>> +        pmu_caps[i].pmu_name = do_read_string(ff);
>> +        if (!pmu_caps[i].pmu_name) {
>>               ret = -1;
>>               goto err;
>>           }
>> -        if (!n->nr_cpu_pmu_caps)
>> -            pr_debug("%s pmu capabilities not available\n", 
>> n->pmu_name);
>> +        if (!pmu_caps[i].nr_caps) {
>> +            pr_debug("%s pmu capabilities not available\n",
>> +                 pmu_caps[i].pmu_name);
>> +        }
>>       }
>> -    ff->ph->env.nr_hybrid_cpc_nodes = nr_pmu;
>> -    ff->ph->env.hybrid_cpc_nodes = nodes;
>> +    ff->ph->env.nr_pmus_with_caps = nr_pmu;
>> +    ff->ph->env.pmu_caps = pmu_caps;
>>       return 0;
>>   err:
>>       for (i = 0; i < nr_pmu; i++) {
>> -        for (j = 0; j < nodes[i].nr_cpu_pmu_caps; j++)
>> -            free(nodes[i].cpu_pmu_caps[j]);
>> -        free(nodes[i].cpu_pmu_caps);
>> -        free(nodes[i].pmu_name);
>> +        for (j = 0; j < pmu_caps[i].nr_caps; j++)
>> +            free(pmu_caps[i].caps[j]);
>> +        free(pmu_caps[i].caps);
>> +        free(pmu_caps[i].pmu_name);
>>       }
>> -    free(nodes);
>> +    free(pmu_caps);
>>       return ret;
>>   }
>> @@ -3387,7 +3405,7 @@ const struct perf_header_feature_ops 
>> feat_ops[HEADER_LAST_FEATURE] = {
>>       FEAT_OPR(CPU_PMU_CAPS,    cpu_pmu_caps,    false),
>>       FEAT_OPR(CLOCK_DATA,    clock_data,    false),
>>       FEAT_OPN(HYBRID_TOPOLOGY,    hybrid_topology,    true),
>> -    FEAT_OPR(HYBRID_CPU_PMU_CAPS,    hybrid_cpu_pmu_caps,    false),
>> +    FEAT_OPR(PMU_CAPS,    pmu_caps,    false),
>>   };
>>   struct header_print_data {
>> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
>> index 08563c1f1bff..5790bf556b90 100644
>> --- a/tools/perf/util/header.h
>> +++ b/tools/perf/util/header.h
>> @@ -46,7 +46,7 @@ enum {
>>       HEADER_CPU_PMU_CAPS,
>>       HEADER_CLOCK_DATA,
>>       HEADER_HYBRID_TOPOLOGY,
>> -    HEADER_HYBRID_CPU_PMU_CAPS,
>> +    HEADER_PMU_CAPS,
>>       HEADER_LAST_FEATURE,
>>       HEADER_FEAT_BITS    = 256,
>>   };
