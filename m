Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE947599A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbhLON15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:27:57 -0500
Received: from foss.arm.com ([217.140.110.172]:51966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242840AbhLON14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:27:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8B6F11D4;
        Wed, 15 Dec 2021 05:27:55 -0800 (PST)
Received: from [10.57.33.238] (unknown [10.57.33.238])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B6AD3F774;
        Wed, 15 Dec 2021 05:27:54 -0800 (PST)
Subject: Re: [PATCH 01/12] perf test: Shell - Limit to only run executable
 scripts in tests
To:     carsten.haitzler@foss.arm.com
Cc:     coresight@lists.linaro.org, mike.leach@linaro.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <80b77a6f-3997-ff90-72b5-5613829a98ae@arm.com>
Date:   Wed, 15 Dec 2021 13:27:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/12/2021 12:53, carsten.haitzler@foss.arm.com wrote:
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

Hi Carsten,

Because these apply to tools/perf files rather than the coresight drivers
they will need to apply to Arnaldo's perf/core branch. At the moment I'm
getting merge conflicts so I can't test and review them.

I also think you would have to do to: linux-perf-users@vger.kernel.org and acme@kernel.org

James

> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  tools/perf/tests/builtin-test.c |  2 +-
>  tools/perf/util/path.c          | 12 ++++++++++++
>  tools/perf/util/path.h          |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index c4b888f18e9c..1a7e21e5acf1 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -512,7 +512,7 @@ static const char *shell_test__description(char *description, size_t size,
>  
>  #define for_each_shell_test(dir, base, ent)	\
>  	while ((ent = readdir(dir)) != NULL)	\
> -		if (!is_directory(base, ent) && ent->d_name[0] != '.')
> +		if (!is_directory(base, ent) && is_executable_file(base, ent) && ent->d_name[0] != '.')
>  
>  static const char *shell_tests__dir(char *path, size_t size)
>  {
> diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> index caed0336429f..7dde8c230ae8 100644
> --- a/tools/perf/util/path.c
> +++ b/tools/perf/util/path.c
> @@ -92,3 +92,15 @@ bool is_directory(const char *base_path, const struct dirent *dent)
>  
>  	return S_ISDIR(st.st_mode);
>  }
> +
> +bool is_executable_file(const char *base_path, const struct dirent *dent)
> +{
> +	char path[PATH_MAX];
> +	struct stat st;
> +
> +	sprintf(path, "%s/%s", base_path, dent->d_name);
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
> 
