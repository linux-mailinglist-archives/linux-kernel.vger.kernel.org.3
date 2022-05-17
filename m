Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8E52A525
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349195AbiEQOpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbiEQOpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:45:38 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD640E6C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:45:37 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f189b07f57so10951567fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hU7G7S+95X8uKEDpImFotwWuDqrirnkCAEdpX3raMwY=;
        b=M3/HCAetf4hTHAQ0wa/H05Ak/DdE/puyPcqdqWE4o2+0jyzI9As8QI17obBpUUiKw8
         P1ysIHMSzmMkGk0V4+mWsAPTShdXJ5Q+Meg4ch8NVid4yXSq43Xvyyy4pFRwgJKhD6Yc
         yH17WpVOJvjT1xcn3x/4OfEGN98EbBwaheNlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hU7G7S+95X8uKEDpImFotwWuDqrirnkCAEdpX3raMwY=;
        b=Pi97W9VvtTKngycuCVz3suwC7es/FjgGNjIE6SxMa3J0uhZnLPMm2QFtVNzIKBey+3
         M5lgHeEFbW9efT/u1bSCr1vcikOusJ68t7vONLeVGL543pEfjxzzHn9GuYOfceepyOTs
         p5jS2TQnfrMxfP+D/t1medgTQTnjPJNLg7j9mPrcXXiqZMbNWk8uLiMqMRPm99ySBhYC
         FKZsQb/AYPQ1Y0di9U5W8sbN5As55PDwjpbPH7mJ6VQZUebnX3cQWQ+fd5VxDUseKNtv
         ryNkehhRSR/NpDAa0K/o+jQeBb40eYiz4rb2KvkGqdm+dUcTSqaXkqz5x4icWoWiwnpZ
         fu7w==
X-Gm-Message-State: AOAM530Z9iGxfsaOnIlov4YPR5E/I4AgA/0x87gptFHcllWhWcgBM2eO
        sMY7PQmVSHEr8E2nJ7/5OKWaPg==
X-Google-Smtp-Source: ABdhPJzQGi1jRVS3Ds4jOGiXPt0AlKWitHFERYSHqcj1j4MYS9RQunGY1pYsbpCLywXI/xskPyH7Iw==
X-Received: by 2002:a05:6870:9724:b0:f1:b413:8aa8 with SMTP id n36-20020a056870972400b000f1b4138aa8mr3935343oaq.39.1652798736791;
        Tue, 17 May 2022 07:45:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i20-20020a4a8d94000000b0035eb4e5a6c5sm5279711ook.27.2022.05.17.07.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:45:36 -0700 (PDT)
Subject: Re: [PATCH V5 0/3] Add unit test module for AMD P-State driver
To:     Huang Rui <ray.huang@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220505022913.329259-1-li.meng@amd.com>
 <YnNxlzRW2NGCx5dO@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <615adab4-515c-7d61-5662-bd342b759d6d@linuxfoundation.org>
Date:   Tue, 17 May 2022 08:45:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YnNxlzRW2NGCx5dO@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 12:41 AM, Huang Rui wrote:
> On Thu, May 05, 2022 at 10:29:10AM +0800, Meng, Li (Jassmine) wrote:
>> Hi all:
>>
>> AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
>> the functions of amd-pstate driver.
>> It could import as a module to launch some test tasks.
>> 1) It can help all users to verify their processor support (SBIOS/
>> Firmware or Hardware).
>> 2) Kernel can have a basic function test to avoid the kernel regression
>> during the update.
>> 3) We can introduce more functional or performance tests to align the
>> together, it will benefit power and performance scale optimization.
>>
>> We upstream out AMD P-state driver into Linux kernel and use this unit
>> test module to verify the required conditions and basic functions of
>> amd-pstate before integration test.
>>
>> We use test module in the kselftest frameworks to implement it.
>> We create amd-pstate-ut module and tie it into kselftest.
>>
>> For example: The test case aput_acpi_cpc is used to check whether the
>> _CPC object is exist in SBIOS.
>> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
>> existed at the detected processor, so it is a necessary condition.
>>
>> At present, it only implements the basic framework and some simple test
>> cases.
>>
>> TODO : 1) we will add more test cases to improve the depth and coverage of
>> the test.
>>
>> Please check the documentation amd-pstate.rst for details of the test steps.
>>
>> See patch series in below git repo:
>> V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
>> V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
>> V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/
>> V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/
>>

>> Changes from V4 -> V5:
>> - selftests: amd-pstate:
>> - - add print the current scaling_driver.
>> - - add amd-pstate-ut.ko into TEST_GEN_FILES.
>> - - move "insmod/rmmod amd-pstate-ut.ko" stuff into script amd_pstate_ut.sh
>> - - add a check of read back from X86_FEATURE_CPPC in get_shared_mem().
>> - Documentation: amd-pstate:
>> - - delete the test step about insmod/rmmod amd-pstate-ut.ko
>>
>> Thanks,
>> Jasmine
>>

Sorry for the delay on this. I will review the series in the next couple
of days.

Did you consider using KUnit for this? I think asked that question when
reviewing the previous version.

thanks,
-- Shuah
