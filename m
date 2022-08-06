Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5914D58B497
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiHFIhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiHFIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:37:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4164115A26
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 01:37:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p18so4473982plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ENYPjO+7DVwUTj8vFxUFRI0wdfEhcNOTkydmeMf0tRM=;
        b=yeNmY0mVpj+jW2O/eYyihs0v1xwAeVRFVZXTVBR05gTY5Ka/v+/28aqOTJ6abY83e4
         ZHgA/Z/GhyS/cPQV0vVm2gu4kP553m+YpGT3TQ0gGVBs2kpUxgaAzAiRxZKjUUFg8YN+
         kgIcgNmRi+T5YYr7QAoKy4MVPDcYSHWqA4IEF2dCrYfXIc2m2zp32rr8yEYdzf3qKkn3
         jvCyBRLuWatPWYvIyOJSw1h7WHMnmGC/36ENPfLqlNWVnnSZ31uAeHxbT7OFzWkfGyDi
         1s3EkkQ314/Lc9n51szTl0u5MHymD7jM/hD0heZgX0tyMKIoWE1EmgKqlnpZS9oK2Wzq
         B3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ENYPjO+7DVwUTj8vFxUFRI0wdfEhcNOTkydmeMf0tRM=;
        b=17sfrHVCfazOIXgKHyXuTXawz7yjFae710OM6RFGqgvxpbZfvW+yJ+EbRKfpq09R4P
         EOqi0nMzOXsNePeCjETSwHRMpxPRh2rCHL2vAJoIldD3nlJVHMQfHzcQZkJ3yAA9w+Qd
         qQYRNR8BNr1picbD7RcdWj11F62lScLYDfUBda6NdlWQCOOHMpH3HwYIfvMlA1CCdpfu
         PpARqkcEebSg/aJhRCWFghg1OZsg3pgByLGlORzQ+kKvTOsDaTn1cI/w+cngDjCxByKT
         d1ciqXiiPRPXFZmZNNFGBQC0nM7xVyj7OTQcWXMapmfnsebxdPZOlOgVkb7c1iYqVpao
         ewqA==
X-Gm-Message-State: ACgBeo0pDPUQ1qQchb0RSIXuu1ZXtUaALcHKOzZDcysDCQlTEzTX6O3C
        KX4ScvmQxQJsvJAF8fVW+4/+FA==
X-Google-Smtp-Source: AA6agR6CFVl1SfPVNSJVYdmGmPCzH4vLE0c9kh3k91EUOEh3sOr2FpZH31nDd1G0Kr+nHQipfxA73w==
X-Received: by 2002:a17:903:2113:b0:16f:6ee:65f2 with SMTP id o19-20020a170903211300b0016f06ee65f2mr10324209ple.76.1659775037417;
        Sat, 06 Aug 2022 01:37:17 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b0016be596c8afsm4373966ple.282.2022.08.06.01.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 01:37:16 -0700 (PDT)
Date:   Sat, 6 Aug 2022 16:37:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 01/14] perf test: Refactor shell tests allowing subdirs
Message-ID: <20220806083712.GA124146@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-2-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-2-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:43PM +0100, carsten.haitzler@foss.arm.com wrote:

[...]

> +int list_script_max_width(void)
> +{
> +	list_script_files(); /* Ensure we have scanned all scriptd */

s/scriptd/scripts/

> +	return files_max_width;
> +}

[...]

>  struct shell_test {
>  	const char *dir;
>  	const char *file;
> @@ -385,33 +302,17 @@ static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
>  static int run_shell_tests(int argc, const char *argv[], int i, int width,
>  				struct intlist *skiplist)
>  {
> -	struct dirent **entlist;
> -	struct dirent *ent;
> -	int n_dirs, e;
> -	char path_dir[PATH_MAX];
> -	struct shell_test st = {
> -		.dir = shell_tests__dir(path_dir, sizeof(path_dir)),
> -	};
> -
> -	if (st.dir == NULL)
> -		return -1;
> +	struct shell_test st;
> +	const struct script_file *files, *file;
>  
> -	n_dirs = scandir(st.dir, &entlist, NULL, alphasort);
> -	if (n_dirs == -1) {
> -		pr_err("failed to open shell test directory: %s\n",
> -			st.dir);
> -		return -1;
> -	}
> -
> -	for_each_shell_test(entlist, n_dirs, st.dir, ent) {
> +	files = list_script_files();
> +	if (!files)
> +		return 0;
> +	for (file = files; file->dir; file++) {
>  		int curr = i++;
> -		char desc[256];
>  		struct test_case test_cases[] = {
>  			{
> -				.desc = shell_test__description(desc,
> -								sizeof(desc),
> -								st.dir,
> -								ent->d_name),
> +				.desc = file->desc,
>  				.run_case = shell_test__run,
>  			},
>  			{ .name = NULL, }
> @@ -421,12 +322,13 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
>  			.test_cases = test_cases,
>  			.priv = &st,
>  		};
> +		st.dir = file->dir;
>  
>  		if (test_suite.desc == NULL ||
>  		    !perf_test__matches(test_suite.desc, curr, argc, argv))
>  			continue;
>  
> -		st.file = ent->d_name;
> +		st.file = file->file;

I am just wandering if we can remove "st" in this function, finally I
found you are right, the "st" (struct shell_test) will be used in the
function shell_test__run(), so let's keep as it is.

>  		pr_info("%3d: %-*s:", i, width, test_suite.desc);
>  
>  		if (intlist__find(skiplist, i)) {
> @@ -436,10 +338,6 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
>  
>  		test_and_print(&test_suite, 0);
>  	}
> -
> -	for (e = 0; e < n_dirs; e++)
> -		zfree(&entlist[e]);
> -	free(entlist);
>  	return 0;
>  }
>  
> @@ -448,7 +346,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  	struct test_suite *t;
>  	unsigned int j, k;
>  	int i = 0;
> -	int width = shell_tests__max_desc_width();
> +	int width = list_script_max_width();
>  
>  	for_each_test(j, k, t) {
>  		int len = strlen(test_description(t, -1));
> @@ -529,36 +427,22 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  
>  static int perf_test__list_shell(int argc, const char **argv, int i)
>  {
> -	struct dirent **entlist;
> -	struct dirent *ent;
> -	int n_dirs, e;
> -	char path_dir[PATH_MAX];
> -	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
> -
> -	if (path == NULL)
> -		return -1;
> +	const struct script_file *files, *file;
>  
> -	n_dirs = scandir(path, &entlist, NULL, alphasort);
> -	if (n_dirs == -1)
> -		return -1;
> -
> -	for_each_shell_test(entlist, n_dirs, path, ent) {
> +	files = list_script_files();
> +	if (!files)
> +		return 0;
> +	for (file = files; file->dir; file++) {
>  		int curr = i++;
> -		char bf[256];
>  		struct test_suite t = {
> -			.desc = shell_test__description(bf, sizeof(bf), path, ent->d_name),
> +			.desc = file->desc
>  		};
>  
>  		if (!perf_test__matches(t.desc, curr, argc, argv))
>  			continue;
>  
>  		pr_info("%3d: %s\n", i, t.desc);
> -
>  	}
> -
> -	for (e = 0; e < n_dirs; e++)
> -		zfree(&entlist[e]);
> -	free(entlist);
>  	return 0;
>  }

Except a minor typo, the patch looks good to me, it's a good
refactoring and enhancement for shell script testing.

I reviewed the change one by one line, at least I cannot find any logic
error.

With typo fixing:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

I'd leave this patch for maintainers to review it.  Just a caveat, given
it's a big patch, as Carsten replied it's good that take the patch as a
total new code for searching shell scripts, this would be easier for
understanding the change.

Thanks,
Leo
