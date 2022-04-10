Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FC74FAB5A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiDJB0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiDJB01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:26:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59894DF58
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 18:24:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bh17so24214957ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 18:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYyl3H7DZOdvVyjoBwIeVjzarKMqTNEfyGOsHkNP3bQ=;
        b=XXQv+s3FHjWgeL4YghCdeqSJ9IFqyjYH2qzZaPl2d/Af4wxT03hbRm3uhpM+rcHfO+
         4S8wcLwagyH2wjdmYL+QYCIDHktjTaxkz89+3/tkAF0dOUtXplgEyUKyZPR3COKFFGhS
         ovZq4Sydovf/j2+PIEd3qEM/z9sUmOcjby2QFxnZb2nk3g8PbSABKT7n0MegwU0W3WMO
         LqqedaiKS0/4auz0LKI2BBCZz/VXbAu51BIQaFfMkB+be3zMWTxI0um/lMV4q+bpQZgB
         iHqCiS/dPv8hXmtP+onNlRQTZ46GO6RJZfZpWcmbRMchXzgTPItrfC8MmHDyKLij7uQU
         YLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYyl3H7DZOdvVyjoBwIeVjzarKMqTNEfyGOsHkNP3bQ=;
        b=OH2QpLvRtQEYTEo4qvho8e6fUI+j7qt1hy/jaF3SKsT4i4+UAf7O/0bbYlME42cXu1
         cWQOrPsMK/fSR8GA1n8yPZ/Gru3usARtPGmIviTFVzGf1ymUzKjIyx6QKkutHEGfCK50
         JyPXJH7MMY0lAw2vT6bpbqpTd1geKHGgoy/yVrFk0ohsxmV6MPd30BzMIWy71L7Y3UeE
         ZYX+uoumaIh1NnfouVbxFE3+6rYxpTDAXoOjF1ar8J3CJ9cwaBx1kn6UQr1T4mCmrt6O
         Z5dyLYalil2sPoDz1XteIn+G4ckfdtCHW48NfxD5S7uDsN0POPnDn624A9fhHHRhYjzc
         9WRw==
X-Gm-Message-State: AOAM530fmaV91MCrmWZy0TPLDgWwj51KvMyD26Vt0p8EVjLUAyhRg0ty
        hu2aznmAiZFWnzftY0c1OQ6Us1bfQM5uwh3LYsRfGg==
X-Google-Smtp-Source: ABdhPJzKIw6527Dw7iJvBaylX1uYDP/tK55dKKO2c3xESsWPQba6+f0lfjtYcWfJAjGwCXjGbia3WQ==
X-Received: by 2002:a17:907:2cc3:b0:6e6:45fb:39fa with SMTP id hg3-20020a1709072cc300b006e645fb39famr23724307ejc.545.1649553855848;
        Sat, 09 Apr 2022 18:24:15 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709067e5900b006e7fe2a1308sm6297770ejr.48.2022.04.09.18.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 18:24:15 -0700 (PDT)
Date:   Sun, 10 Apr 2022 09:24:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 1/3] perf test: Shell - Limit to only run executable
 scripts in tests
Message-ID: <20220410012410.GA14326@leoy-ThinkPad-X240s>
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:28:57PM +0000, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> Perf test's shell runner will just run everything in the tests
> directory (as long as it's not another directory or does not begin
> with a dot), but sometimes you find files in there that are not shell
> scripts - perf.data output for example if you do some testing and then
> the next time you run perf test it tries to run these. Check the files
> are executable so they are actually intended to be test scripts and
> not just some "random junk" files there.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/tests/builtin-test.c |  4 +++-
>  tools/perf/util/path.c          | 14 +++++++++++++-
>  tools/perf/util/path.h          |  1 +
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index fac3717d9ba1..3c34cb766724 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -296,7 +296,9 @@ static const char *shell_test__description(char *description, size_t size,
>  
>  #define for_each_shell_test(entlist, nr, base, ent)	                \
>  	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
> -		if (!is_directory(base, ent) && ent->d_name[0] != '.')
> +		if (!is_directory(base, ent) && \
> +			is_executable_file(base, ent) && \
> +			ent->d_name[0] != '.')
>  
>  static const char *shell_tests__dir(char *path, size_t size)
>  {
> diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> index caed0336429f..ce80b79be103 100644
> --- a/tools/perf/util/path.c
> +++ b/tools/perf/util/path.c
> @@ -86,9 +86,21 @@ bool is_directory(const char *base_path, const struct dirent *dent)
>  	char path[PATH_MAX];
>  	struct stat st;
>  
> -	sprintf(path, "%s/%s", base_path, dent->d_name);
> +	snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
>  	if (stat(path, &st))
>  		return false;
>  
>  	return S_ISDIR(st.st_mode);
>  }
> +
> +bool is_executable_file(const char *base_path, const struct dirent *dent)
> +{
> +	char path[PATH_MAX];
> +	struct stat st;
> +
> +	snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
> +	if (stat(path, &st))
> +		return false;
> +
> +	return !S_ISDIR(st.st_mode) && (st.st_mode & S_IXUSR);
> +}
> diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
> index 083429b7efa3..d94902c22222 100644
> --- a/tools/perf/util/path.h
> +++ b/tools/perf/util/path.h
> @@ -12,5 +12,6 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
>  
>  bool is_regular_file(const char *file);
>  bool is_directory(const char *base_path, const struct dirent *dent);
> +bool is_executable_file(const char *base_path, const struct dirent *dent);
>  
>  #endif /* _PERF_PATH_H */
> -- 
> 2.32.0
> 
