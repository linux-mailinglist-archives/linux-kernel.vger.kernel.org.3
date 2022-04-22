Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C50450BF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiDVSBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiDVR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:59:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32934E6C51
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:56:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j6so6345883pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rAEYxsDdc/xUF7/YdgZVrEC2tMcbDi1Ne7lOu482LaQ=;
        b=Y739RqGGXNszvqEDnhFIgMzwSNPdNL24jME4YSlAnV5TF2tQyAMZJHewkkjGBDln8v
         WYM4VgnxxhgsltUJB12VNaGbwgn7Qdt4IrNCxMQ2iF369snlZl2v9ro6KkYF2gowzXjM
         5jBPOCO7AqQPlVj9UCWnJtmq4tJzQYFjhTtfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rAEYxsDdc/xUF7/YdgZVrEC2tMcbDi1Ne7lOu482LaQ=;
        b=zb+/M6XRgQwJnlr2r7A83wP0Kay4CM4sJUdVFMBMtC3iZKmtJ6plgjEK0HHml3eHxd
         /XoNO8DLDqSC5sk8UUN67vhvBMbbssI0oOqne/WzccvYIYUNx3m9p4IjuYumnPDnfKyH
         PLrd14lsT+w7RRRMEri4LyDvW57LjUg3TsR1xbuP4Hla9UQDCGclqRt7xQSs2h4z7gtR
         21mo0t8icPk6nviq9lERaKldOgwMnzDaS8kWEbFoh33uOsYPmsBmwEBdamQc5qAYn2qz
         APJZ1LV9iErmFqa/hbDo3TbYqFwBIssk5TXvHDDPQw8lnWy7PZG5FzqokeD6NanzJQ25
         uo+A==
X-Gm-Message-State: AOAM530l3fIHirlbU18ExcGEeI2ybfans0JZikeBb/k1AlsaDpArAey6
        WNXo/c3E2SmpILvojNLzV4CUjkk6JwoPKA==
X-Google-Smtp-Source: ABdhPJzjYoLNenF6TJrF7NKuxnvAluyuVVwPXg5y87rTFHEDk9YmQFnVHeDMGRaWdEPSEUntjg2yiw==
X-Received: by 2002:a05:6602:15cf:b0:614:52d4:952 with SMTP id f15-20020a05660215cf00b0061452d40952mr2465969iow.185.1650649725051;
        Fri, 22 Apr 2022 10:48:45 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id f15-20020a056e020c6f00b002cbc9935527sm1652594ilj.83.2022.04.22.10.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:48:44 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] selftests: cpufreq: Add wapper script for test AMD
 P-State
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220421074152.599419-1-li.meng@amd.com>
 <20220421074152.599419-3-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e301e6f0-0940-1db9-31a9-b066363b1ea2@linuxfoundation.org>
Date:   Fri, 22 Apr 2022 11:48:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220421074152.599419-3-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 1:41 AM, Meng Li wrote:
> Adds a wrapper shell script for the amd_pstate_testmod module.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   tools/testing/selftests/cpufreq/amd_pstate_testmod.sh | 4 ++++
>   tools/testing/selftests/cpufreq/config                | 1 +
>   tools/testing/selftests/cpufreq/main.sh               | 1 +
>   3 files changed, 6 insertions(+)
>   create mode 100755 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
> 
> diff --git a/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh b/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
> new file mode 100755
> index 000000000000..5398ad568885
> --- /dev/null
> +++ b/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Tests the AMD P-State unit test infrastructure using amd_pstate_testmod kernel module.
> +$(dirname $0)/../kselftest/module.sh "amd_pstate_testmod" amd_pstate_testmod

The script could load the module and unload once the test is complete.

> diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
> index 75e900793e8a..374a8adbb34c 100644
> --- a/tools/testing/selftests/cpufreq/config
> +++ b/tools/testing/selftests/cpufreq/config
> @@ -13,3 +13,4 @@ CONFIG_DEBUG_LOCK_ALLOC=y
>   CONFIG_PROVE_LOCKING=y
>   CONFIG_LOCKDEP=y
>   CONFIG_DEBUG_ATOMIC_SLEEP=y
> +CONFIG_AMD_PSTATE_TESTMOD=m
> diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
> index 60ce18ed0666..d3602fa11392 100755
> --- a/tools/testing/selftests/cpufreq/main.sh
> +++ b/tools/testing/selftests/cpufreq/main.sh
> @@ -6,6 +6,7 @@ source cpufreq.sh
>   source governor.sh
>   source module.sh
>   source special-tests.sh
> +source amd_pstate_testmod.sh
>   

Does the script check if the test module is loaded and bail out?
I don't see the check for CONFIG_AMD_PSTATE_TESTMOD enable and
module load.

>   FUNC=basic	# do basic tests by default
>   OUTFILE=cpufreq_selftest
> 

thanks,
-- Shuah
