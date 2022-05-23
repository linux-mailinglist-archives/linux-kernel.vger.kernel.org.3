Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8EA530D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiEWJEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiEWJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:04:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FABA44760;
        Mon, 23 May 2022 02:04:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg25so8295005wmb.4;
        Mon, 23 May 2022 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u8kDbKUhH6jkjODp8VrSUlBFIiA2YNyQkeo+Pu/y77o=;
        b=CXkI6vAUWS5v83vb3vw6wXOAf4CGgs7tdL17DVtTDOyo9oQFKSmtsu1yKONKu0Vbo6
         GhBbmywapERrDdMT+VV7cnvqqDLdTgbZXYx4QBM5ZPBWvDarJ2tDVleInIx4EoQ00TXp
         X+aXwiPZpphGxXBf6aw6B0DbCc2hCIKgmP+R/HKSLR+Wh2rXdncr4q31bKpJHLM6TA75
         m92tUuqzpT0wiVfDo1TRItxmLNYrjHp2YxlY6FWINlNM33ZjYm8b8P0Nr7fVtbGwSQBv
         FUbFpe9LZDCe0kpbopEHik7v89X8zJ/o0HZ5AIAtJrzgVVLMHBp+1t18RiR+/sgbvbNp
         jjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u8kDbKUhH6jkjODp8VrSUlBFIiA2YNyQkeo+Pu/y77o=;
        b=M1CrVC7uyUn7+AaMBJK3DoIhyJCo0ZsO+S0GY9Af3CPk0BANfkFDkIWeMGx/Mykpsu
         ul2cPWsd3hUBL5dhALbmyT1s3dqiCP6OFSf5yFLwGJz7hmdsSNKk3imsLnnJzop3LsV0
         Z38MQzOW48873/dzj/e3ajoC/gRwYT/bMJ2YUdMR6rswlTAVUMfpGcfwWhtXF37A+3QX
         n4ufrksECJZHmnsbawZYgbEAo7HWK2L0Xqt51p5lngXYTYmjQa4eWSZk26xTwC/bpx0o
         ZSyEu4MRF3qVNprkNSmBcEoP5bnK2qPFkUD2alyzQEwGfzCkZNdmz2fs+r+CTyGFQQ5f
         7/iQ==
X-Gm-Message-State: AOAM531mVOtas7P1TW0qKyYo3epdV4Hckvaa7Jgs4FsxGTstSI0g2M18
        BGYOfHjnU6UU8evb2Fr3GinZEcb72LzlYZH6
X-Google-Smtp-Source: ABdhPJySZaOak7/vdmnO6wswyhWfRs8lR2bDG4mYImn97LZJ54mY2VjQBIbL9N0Wid8ekXaipEqZxA==
X-Received: by 2002:a05:600c:4f03:b0:394:6499:21c7 with SMTP id l3-20020a05600c4f0300b00394649921c7mr18983081wmq.103.1653296679929;
        Mon, 23 May 2022 02:04:39 -0700 (PDT)
Received: from krava (net-93-65-240-241.cust.vodafonedsl.it. [93.65.240.241])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b0039736892653sm8928281wmj.27.2022.05.23.02.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 02:04:39 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 23 May 2022 11:04:36 +0200
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        rrichter@amd.com, mingo@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v4 2/5] perf header: Parse non-cpu pmu capabilities
Message-ID: <YotOJL0dJmKUQnlI@krava>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
 <20220523033945.1612-3-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523033945.1612-3-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 09:09:42AM +0530, Ravi Bangoria wrote:

SNIP

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index a27132e5a5ef..b4505dbb9f4a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1580,6 +1580,67 @@ static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>  	return 0;
>  }
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

should we check for the hybrid names as well?
there's a helper perf_pmu__is_hybrid,
aybe you can use that

jirka


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
> +	return 0;
> +}
> +
>  static void print_hostname(struct feat_fd *ff, FILE *fp)
>  {
>  	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
> @@ -2209,6 +2270,32 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
>  	}
>  }
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
>  static int __event_process_build_id(struct perf_record_header_build_id *bev,
>  				    char *filename,
>  				    struct perf_session *session)
> @@ -3319,6 +3406,103 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>  	return ret;
>  }
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
>  #define FEAT_OPR(n, func, __full_only) \
>  	[HEADER_##n] = {					\
>  		.name	    = __stringify(n),			\
> @@ -3382,6 +3566,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
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
> index 541889fa9f9c..4b45fd8da5a3 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -46,6 +46,8 @@ struct perf_pmu {
>  	struct perf_cpu_map *cpus;
>  	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>  	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
> +	bool caps_initialized;
> +	u32 nr_caps;
>  	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>  	struct list_head list;    /* ELEM */
>  	struct list_head hybrid_list;
> -- 
> 2.31.1
> 
