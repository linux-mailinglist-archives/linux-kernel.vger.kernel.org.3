Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA40476EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhLPKWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbhLPKWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:22:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:22:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a18so43269529wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZgHl57qt42y5Mn9/2Z6rq5Jx3ZGEQA1hxGUYuhGoD9c=;
        b=YZdyyd7+N4xz9owwm9QmAgi4VOE4VIcd0IEf7PzSo1nvSKibMCmzwMHBDyHPQt6D2V
         7XUfDzi4S+hZoowWz2FuJLMcF5OFfwVdN20ll1RTyxaRM2/XLfMKpNeStl6F58v2I4OZ
         wXTjRh5Guf8GKNbLoOKUIId12GPh6Sr55V4YaqAZHcmOlmbJriWhii/voLfitqYyPcC7
         iTiqJbDwlhTeK0+Gcjx5aYBBpUee0JcQIBQS6NVdxn4cxHWCEREq/721NR5AWoOzDat9
         cCrXyeSwZdDcLUVjFf2yKt3nc3iPot6qKFZ5+JK5LpFFDHvQYfaTiA9rGxX9ZjJbyctB
         KK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZgHl57qt42y5Mn9/2Z6rq5Jx3ZGEQA1hxGUYuhGoD9c=;
        b=ozXALNhHARQYyiYuXJn/IosvMGQDbKcnd84T4ZZoIrrLKpUAPqk0qW3b3zZJtG3/8z
         OW07e/muPwTZktcYhhXJpADR/A8evybTCcNFUOc7h7vTFyVARWHydPL4FW1qVUC6W+t9
         fJymDdk2rAgOTp4d7Jyd/xwAiAFpXRyl+sopzunOdZ2qF7XPXhCw45lE5fBCgyF6CkJM
         Aa2fIhxa3PoeWTyWVozTDdqiawqY5RYHiD56C987HAoOPfYBTCAesWvQ01GqsIOmmsyC
         fGhqpZxCqj/J2rNKWVFDvCNnCfw7bWlIwjrN1VRjvGNAzn+gLcHj8omT5veLjbD4NBAl
         q85Q==
X-Gm-Message-State: AOAM5317xQNgozLI+sxaBbVV+97Nq7GMdFYGRoU1baHOrinM1kiKcfDD
        RzQgGHwCDeywc64nroz9DA725A==
X-Google-Smtp-Source: ABdhPJzMVR+AajFmfjK4sHCRrAaFb4KaWxRzEaOKd/tZMh8wnoiEVEAndBjF8FBYt+cgNS8sWEscNQ==
X-Received: by 2002:adf:d1e4:: with SMTP id g4mr8499951wrd.249.1639650142908;
        Thu, 16 Dec 2021 02:22:22 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id k6sm3960022wmj.16.2021.12.16.02.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 02:22:22 -0800 (PST)
Date:   Thu, 16 Dec 2021 10:22:20 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        inux-perf-users@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH 02/12] perf test: Shell - only run .sh shell files to
 skip other files
Message-ID: <20211216102220.4q6dtfc4q4qyy2it@maple.lan>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-2-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215160403.69264-2-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 04:03:53PM +0000, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> You edit your scripts in the tests and end up with your usual shell
> backup files with ~ or .bak or something else at the end, but then your
> next perf test run wants to run the backups too. You might also have perf
> .data files in the directory or something else undesireable as well. You end
> up chasing which test is the one you edited and the backup and have to keep
> removing all the backup files, so automatically skip any files that are
> not plain *.sh scripts to limit the time wasted in chasing ghosts.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Why require both executable *and* endswith('.sh')?


> ---
>  tools/perf/tests/builtin-test.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index ece272b55587..849737ead9fd 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -297,7 +297,20 @@ static const char *shell_test__description(char *description, size_t size,
>  	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
>  		if (!is_directory(base, ent) && \
>  			is_executable_file(base, ent) && \
> -			ent->d_name[0] != '.')
> +			ent->d_name[0] != '.' && \
> +			(shell_file_is_sh(ent->d_name) == 0))
> +
> +static int shell_file_is_sh(const char *file)
> +{
> +	const char *ext;
> +
> +	ext = strchr(file, '.');

Shouldn't this be strrchr()?


Daniel.
