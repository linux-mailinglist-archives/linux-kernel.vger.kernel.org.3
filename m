Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E79528560
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243394AbiEPN2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242909AbiEPN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6537F2C66B;
        Mon, 16 May 2022 06:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEEEF61333;
        Mon, 16 May 2022 13:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE26C385B8;
        Mon, 16 May 2022 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652707684;
        bh=pq5F82c3xq9eY6m2h7iLZ1Ycx3pY3Nx00v685EIaQIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGbc9djGi8KxMRCmaSMP8T7GJ2AvrtK7GJ3LWKAINJ42fxt7Dza5F+D4GPbloHP1m
         pKD3n35X6H43PGBHmGgOwrZnL0fiisS6lkBDtdZtQfitWzufKVuQA/+iR+AZEyyEfz
         rmkDOOV5CSeS6tBkMt5EbqHWpI8ypOUWI6TrCpjAeEm3fZsh20mKchF1B+DiZoPOWk
         vNvn4r6bnb+mKnRECne+cEIuC5dFvoS5gEnmMB6bA5jtMimUQQXaq3Wu/eXYN05TSO
         MHFQFI1/PWD/VggXhjR47upEqih6QExJEEckFOkhHmFVtrKjKBGSocvx5TiR7YgHlu
         PgPSSnYKC3AUw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA77F400B1; Mon, 16 May 2022 10:28:00 -0300 (-03)
Date:   Mon, 16 May 2022 10:28:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2 6/8] perf header: Parse non-cpu pmu capabilities
Message-ID: <YoJRYI2P0EEnhZXv@kernel.org>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-7-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509044914.1473-7-ravi.bangoria@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 09, 2022 at 10:19:12AM +0530, Ravi Bangoria escreveu:
> Pmus advertise their capabilities via sysfs attribute files but
> perf tool currently parses only core(cpu) pmu capabilities. Add
> support for parsing non-cpu pmu capabilities.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  .../Documentation/perf.data-file-format.txt   |  18 ++
>  tools/perf/util/env.c                         |  48 +++-
>  tools/perf/util/env.h                         |  11 +
>  tools/perf/util/header.c                      | 211 ++++++++++++++++++
>  tools/perf/util/header.h                      |   1 +
>  tools/perf/util/pmu.c                         |  15 +-
>  tools/perf/util/pmu.h                         |   2 +
>  7 files changed, 301 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index f56d0e0fbff6..dea3acb36558 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -435,6 +435,24 @@ struct {
>  	} [nr_pmu];
>  };
>  
> +	HEADER_PMU_CAPS = 32,
> +
> +	List of pmu capabilities (except cpu pmu which is already
> +	covered by HEADER_CPU_PMU_CAPS)
> +
> +struct {
> +	u32 nr_pmus;
> +	struct {
> +		u8 core_type;	/* For hybrid topology */

Humm, I'd say use u32 here and..

> +		char pmu_name[];
> +		u16 nr_caps;

Here, no need to save space here, I guess.

> +		struct {
> +			char name[];
> +			char value[];
> +		} [nr_caps];
> +	} [nr_pmus];
> +};
> +
>  	other bits are reserved and should ignored for now
>  	HEADER_FEAT_BITS	= 256,
>  
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 579e44c59914..928633f07086 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -179,7 +179,7 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
>  
>  void perf_env__exit(struct perf_env *env)
>  {
> -	int i;
> +	int i, j;
>  
>  	perf_env__purge_bpf(env);
>  	perf_env__purge_cgroups(env);
> @@ -222,6 +222,14 @@ void perf_env__exit(struct perf_env *env)
>  		zfree(&env->hybrid_cpc_nodes[i].pmu_name);
>  	}
>  	zfree(&env->hybrid_cpc_nodes);
> +
> +	for (i = 0; i < env->nr_pmus_with_caps; i++) {
> +		zfree(&env->env_pmu_caps[i].pmu_name);
> +		for (j = 0; j < env->env_pmu_caps[i].nr_caps; j++)
> +			zfree(&env->env_pmu_caps[i].pmu_caps[j]);
> +		zfree(&env->env_pmu_caps[i].pmu_caps);
> +	}
> +	zfree(&env->env_pmu_caps);
>  }
>  
>  void perf_env__init(struct perf_env *env)
> @@ -527,3 +535,41 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
>  
>  	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
>  }
> +
> +char *perf_env__find_pmu_cap(struct perf_env *env, u8 core_type,
> +			     const char *pmu_name, const char *cap)
> +{
> +	struct env_pmu_caps *env_pmu_caps = env->env_pmu_caps;
> +	char *cap_eq;
> +	int cap_size;
> +	char **ptr;
> +	int i, j;
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
> +		if (env_pmu_caps[i].core_type != core_type ||
> +		    strcmp(env_pmu_caps[i].pmu_name, pmu_name))
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
> index a3541f98e1fc..2b767f4ae6e0 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -50,6 +50,13 @@ struct hybrid_cpc_node {
>  	char            *pmu_name;
>  };
>  
> +struct env_pmu_caps {
> +	u8	core_type;
> +	char	*pmu_name;
> +	u16	nr_caps;
> +	char	**pmu_caps;
> +};
> +
>  struct perf_env {
>  	char			*hostname;
>  	char			*os_release;
> @@ -75,6 +82,7 @@ struct perf_env {
>  	int			nr_cpu_pmu_caps;
>  	int			nr_hybrid_nodes;
>  	int			nr_hybrid_cpc_nodes;
> +	int			nr_pmus_with_caps;
>  	char			*cmdline;
>  	const char		**cmdline_argv;
>  	char			*sibling_cores;
> @@ -95,6 +103,7 @@ struct perf_env {
>  	unsigned long long	 memory_bsize;
>  	struct hybrid_node	*hybrid_nodes;
>  	struct hybrid_cpc_node	*hybrid_cpc_nodes;
> +	struct env_pmu_caps	*env_pmu_caps;
>  #ifdef HAVE_LIBBPF_SUPPORT
>  	/*
>  	 * bpf_info_lock protects bpf rbtrees. This is needed because the
> @@ -172,4 +181,6 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
>  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
>  
>  int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
> +char *perf_env__find_pmu_cap(struct perf_env *env, u8 core_type,
> +			     const char *pmu_name, const char *cap);
>  #endif /* __PERF_ENV_H */
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index a27132e5a5ef..23d89dbfcd96 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -217,6 +217,19 @@ static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
>  	return __do_read_buf(ff, addr, size);
>  }
>  
> +static int do_read_u16(struct feat_fd *ff, u16 *addr)
> +{
> +	int ret;
> +
> +	ret = __do_read(ff, addr, sizeof(*addr));
> +	if (ret)
> +		return ret;
> +
> +	if (ff->ph->needs_swap)
> +		*addr = bswap_16(*addr);
> +	return 0;
> +}
> +

You will not need the do_read_u16, use do_read_u32.

Then change the other parts to the u32 type.

- Arnaldo

>  static int do_read_u32(struct feat_fd *ff, u32 *addr)
>  {
>  	int ret;
> @@ -1580,6 +1593,77 @@ static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>  	return 0;
>  }
>  
> +/*
> + * File format:
> + *
> + * struct {
> + *	u32 nr_pmus;
> + *	struct {
> + *		u8 core_type;
> + *		char pmu_name[];
> + *		u16 nr_caps;

Update here.

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
> +	u8 core_type = 0;
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
> +		/*
> +		 * Currently core_type is always set to 0. But it can be
> +		 * used in future for hybrid topology pmus.
> +		 */
> +		ret = do_write(ff, &core_type, sizeof(core_type));
> +		if (ret < 0)
> +			return ret;
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
> +	return 0;
> +}
> +
>  static void print_hostname(struct feat_fd *ff, FILE *fp)
>  {
>  	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
> @@ -2209,6 +2293,31 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
>  	}
>  }
>  
> +static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
> +{
> +	struct env_pmu_caps *env_pmu_caps = ff->ph->env.env_pmu_caps;
> +	int nr_pmus_with_caps = ff->ph->env.nr_pmus_with_caps;
> +	const char *delimiter = "";
> +	char **ptr;
> +	int i, j;
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
>  static int __event_process_build_id(struct perf_record_header_build_id *bev,
>  				    char *filename,
>  				    struct perf_session *session)
> @@ -3319,6 +3428,107 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>  	return ret;
>  }
>  
> +static int __process_pmu_caps(struct feat_fd *ff, struct env_pmu_caps *env_pmu_caps)
> +{
> +	u16 nr_caps = env_pmu_caps->nr_caps;
> +	int name_size, value_size;
> +	char *name, *value, *ptr;
> +	u16 i;
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
> +	u32 i;
> +	u16 j;
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
> +		if (__do_read(ff, &env_pmu_caps[i].core_type, sizeof(env_pmu_caps[i].core_type)))
> +			goto error;
> +
> +		env_pmu_caps[i].pmu_name = do_read_string(ff);
> +		if (!env_pmu_caps[i].pmu_name)
> +			goto error;
> +
> +		if (do_read_u16(ff, &env_pmu_caps[i].nr_caps))
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
>  #define FEAT_OPR(n, func, __full_only) \
>  	[HEADER_##n] = {					\
>  		.name	    = __stringify(n),			\
> @@ -3382,6 +3592,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
>  	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
>  	FEAT_OPR(HYBRID_CPU_PMU_CAPS,	hybrid_cpu_pmu_caps,	false),
> +	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 0eb4bc29a5a4..e9a067bb8b9e 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -47,6 +47,7 @@ enum {
>  	HEADER_CLOCK_DATA,
>  	HEADER_HYBRID_TOPOLOGY,
>  	HEADER_HYBRID_CPU_PMU_CAPS,
> +	HEADER_PMU_CAPS,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 9a1c7e63e663..8d599acb7569 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1890,16 +1890,22 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>  	const char *sysfs = sysfs__mountpoint();
>  	DIR *caps_dir;
>  	struct dirent *evt_ent;
> -	int nr_caps = 0;
> +
> +	if (pmu->caps_initialized)
> +		return pmu->nr_caps;
>  
>  	if (!sysfs)
>  		return -1;
>  
> +	pmu->nr_caps = 0;
> +
>  	snprintf(caps_path, PATH_MAX,
>  		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
>  
> -	if (stat(caps_path, &st) < 0)
> +	if (stat(caps_path, &st) < 0) {
> +		pmu->caps_initialized = true;
>  		return 0;	/* no error if caps does not exist */
> +	}
>  
>  	caps_dir = opendir(caps_path);
>  	if (!caps_dir)
> @@ -1926,13 +1932,14 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>  			continue;
>  		}
>  
> -		nr_caps++;
> +		pmu->nr_caps++;
>  		fclose(file);
>  	}
>  
>  	closedir(caps_dir);
>  
> -	return nr_caps;
> +	pmu->caps_initialized = true;
> +	return pmu->nr_caps;
>  }
>  
>  void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 541889fa9f9c..593005e68bea 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -46,6 +46,8 @@ struct perf_pmu {
>  	struct perf_cpu_map *cpus;
>  	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>  	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
> +	bool caps_initialized;
> +	u16 nr_caps;
>  	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>  	struct list_head list;    /* ELEM */
>  	struct list_head hybrid_list;
> -- 
> 2.27.0

-- 

- Arnaldo
