Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CA44FAB85
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiDJCbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243279AbiDJCbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:31:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B564463397
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:28:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w18so14214173edi.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 19:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2GkARg2eLQk4U0SOAWwrR87e6jTIhF1FLiGo30eY7II=;
        b=bOPIg5nEnVq5/dOkk2slkVv0GnZs+Bq9ifiXYawxhM4d+vrwId4nLc9B54oAQOaJ5C
         F+jF6vAd8xSFJCqPXffBl+qOQOtJ/kSGx2mYert2MR5gK55+7tkudkhJMFL6FA3Wq4Cb
         K9dKfsIERDhI3NS/irXZtX6O5bWXs2AVjRjG3TNS6k1rv3vW4DmDGxOUrlzsx/XP6A2D
         iXtjfZTKDZ1n2o4qog3XVuXUEyfBJL+bAmMn5n+6L69gfJt+Cgeh2JzkYpKpzU5xDXvO
         RsOBLaUxgBNkK4SLQ7NUvew+MY4A3TyhDOO6xGmbL7o1mZop8pYb2oHYL7b8Zp8lrSZ4
         zrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2GkARg2eLQk4U0SOAWwrR87e6jTIhF1FLiGo30eY7II=;
        b=d+Rkq2axLD8zNUZ9z3e6GKKBPMQA/6kqxKM2ZNhNXPuObTJDVaGVSI4lGVYuSTFCUH
         EAMTbMiMLqRBRvUznrjOrxclELifmrOKHFqAESidx9lFQZDv+7cFGL/oaGsbW3n9HGwf
         zGQLDbjV2j4gFQMzwDVENbAW8MBloZagoGEqHb0rxgp7N+OqJa0L5d0KaV+GJ0BjZJTx
         R1yjfNW9Hr8TTi+Rryo6vP+HrwCZdN5k+ZmXzcXCImhq/2aMAghyS7i/s2NSl+BADbvg
         sZIHevpQvY7gkPk4JhICSNpnJyqSfwLiwXpMSUrziFekBGd/906dtnl3qbQyTHJ88+QX
         GDRw==
X-Gm-Message-State: AOAM531pz6vDEsdFWmiic20NaUksn757CAhGlutak+vBvwfWlbpHr0RH
        2MyToH10HQQrMSsy5uiPGeq06A==
X-Google-Smtp-Source: ABdhPJw7HwGZaK8WYofg/ix1YfzxwCkHaSYShdy2E6JN6OrpR+rX8DrYV/C47/rBx5BLt197ubBGSA==
X-Received: by 2002:a05:6402:1e88:b0:419:746e:fb05 with SMTP id f8-20020a0564021e8800b00419746efb05mr26139998edf.307.1649557732153;
        Sat, 09 Apr 2022 19:28:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id g9-20020a056402424900b0041d10255257sm3890598edb.46.2022.04.09.19.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 19:28:51 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:28:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 2/3] perf test: Shell - only run .sh shell files to skip
 other files
Message-ID: <20220410022846.GB14326@leoy-ThinkPad-X240s>
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
 <20220309122859.31487-2-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309122859.31487-2-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:28:58PM +0000, carsten.haitzler@foss.arm.com wrote:
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
>
> ---
>  tools/perf/tests/builtin-test.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 3c34cb766724..3a02ba7a7a89 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -296,9 +296,22 @@ static const char *shell_test__description(char *description, size_t size,
>  
>  #define for_each_shell_test(entlist, nr, base, ent)	                \
>  	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
> -		if (!is_directory(base, ent) && \
> +		if (ent->d_name[0] != '.' && \
> +			!is_directory(base, ent) && \
>  			is_executable_file(base, ent) && \
> -			ent->d_name[0] != '.')
> +			is_shell_script(ent->d_name))

Just nitpick: since multiple conditions are added, seems to me it's good
to use a single function is_executable_shell_script() to make decision
if a file is an executable shell script.

And the condition checking 'ent->d_name[0] != '.'' would be redundant
after we have checked the file suffix '.sh'.

Thanks,
Leo

> +
> +static bool is_shell_script(const char *file)
> +{
> +	const char *ext;
> +
> +	ext = strrchr(file, '.');
> +	if (!ext)
> +		return false;
> +	if (!strcmp(ext, ".sh"))
> +		return true;
> +	return false;
> +}
>  
>  static const char *shell_tests__dir(char *path, size_t size)
>  {
> -- 
> 2.32.0
> 
