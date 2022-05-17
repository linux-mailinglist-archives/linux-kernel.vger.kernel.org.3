Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905F552AC61
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352423AbiEQUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbiEQUDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:03:09 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1408343499
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:03:07 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q10so122225oia.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ume0/+SZoFFON8dc+uE515Wu0Ph4fGUZ38Tn0hMV9MM=;
        b=HyAewg8gxIOA2pd/BFLiNGcS7NiS5LwNVEPsXhAaFyAlQdl9eTkItVKwfAf77I2vUY
         pVs7DhVb9DJf/o/q0SmfIVnBm1ZrEjN2cpGqsABTfMPkBngFX6e+7RTp2JolNY3o18F1
         78ynrzkGIz7P34UOYlN8Ac4pqeo0s6VR+hVxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ume0/+SZoFFON8dc+uE515Wu0Ph4fGUZ38Tn0hMV9MM=;
        b=lPr1nQlokLDYUNY3DFzxRUp+N2F8FV8rVHTsuSB7AOhBdAsT1M1RAtPKqvRfSektRk
         qZbS3czmzc1t+Q6oXw+wXf7bHyRnf4e2BeaGvVJAsQJgSqlCxfzMStHgg/kAmTZOJX6c
         Q0WMSxTbWSA/klHGRL4Gcmpvl0r6/0v1tAuSe6t8UDgPbx6jQTLX7ibaj1KMnemckeuG
         9dXKnyneZ7tXHrSSQuekrcsmcXP3bLEh4vMnq43OkjWp0o3lrNpAfHRbZbHEXpwMgJE1
         A7IJlNQkA2DRgKLWm/WpGTTtUBz+Y9yz7BSLvuHPL7wwKgGyBhs8LmcOQ04O6GAyxuJP
         Gaig==
X-Gm-Message-State: AOAM531vXi0AYJ8g97jot60EvmZlRFQOtmnbnrwsKOS7MVQwbNoijDXR
        xfN9mHo/1C+iEmIyguYuP2vbwA==
X-Google-Smtp-Source: ABdhPJzAe/MomCsoT65bGybnIprRY0kptNVht3n5CUB9wUCyAGfYnZEKqJLcSJKtq9HKpaG+A95QQg==
X-Received: by 2002:a05:6808:2108:b0:326:51c9:73a2 with SMTP id r8-20020a056808210800b0032651c973a2mr11187694oiw.175.1652817787190;
        Tue, 17 May 2022 13:03:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000e686d1386asm241432oao.4.2022.05.17.13.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 13:03:06 -0700 (PDT)
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
 <615adab4-515c-7d61-5662-bd342b759d6d@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <27434868-1d0f-4493-3265-bea4e1dc8494@linuxfoundation.org>
Date:   Tue, 17 May 2022 14:03:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <615adab4-515c-7d61-5662-bd342b759d6d@linuxfoundation.org>
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

On 5/17/22 8:45 AM, Shuah Khan wrote:
> On 5/5/22 12:41 AM, Huang Rui wrote:
>> On Thu, May 05, 2022 at 10:29:10AM +0800, Meng, Li (Jassmine) wrote:
>>> Hi all:
>>>
>>> AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
>>> the functions of amd-pstate driver.
>>> It could import as a module to launch some test tasks.
>>> 1) It can help all users to verify their processor support (SBIOS/
>>> Firmware or Hardware).
>>> 2) Kernel can have a basic function test to avoid the kernel regression
>>> during the update.
>>> 3) We can introduce more functional or performance tests to align the
>>> together, it will benefit power and performance scale optimization.
>>>
>>> We upstream out AMD P-state driver into Linux kernel and use this unit
>>> test module to verify the required conditions and basic functions of
>>> amd-pstate before integration test.
>>>
>>> We use test module in the kselftest frameworks to implement it.
>>> We create amd-pstate-ut module and tie it into kselftest.
>>>
>>> For example: The test case aput_acpi_cpc is used to check whether the
>>> _CPC object is exist in SBIOS.
>>> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
>>> existed at the detected processor, so it is a necessary condition.
>>>
>>> At present, it only implements the basic framework and some simple test
>>> cases.
>>>
>>> TODO : 1) we will add more test cases to improve the depth and coverage of
>>> the test.
>>>
>>> Please check the documentation amd-pstate.rst for details of the test steps.
>>>
>>> See patch series in below git repo:
>>> V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
>>> V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
>>> V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/
>>> V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/
>>>
> 
>>> Changes from V4 -> V5:
>>> - selftests: amd-pstate:
>>> - - add print the current scaling_driver.
>>> - - add amd-pstate-ut.ko into TEST_GEN_FILES.
>>> - - move "insmod/rmmod amd-pstate-ut.ko" stuff into script amd_pstate_ut.sh
>>> - - add a check of read back from X86_FEATURE_CPPC in get_shared_mem().
>>> - Documentation: amd-pstate:
>>> - - delete the test step about insmod/rmmod amd-pstate-ut.ko
>>>
>>> Thanks,
>>> Jasmine
>>>
> 
> Sorry for the delay on this. I will review the series in the next couple
> of days.
> 
> Did you consider using KUnit for this? I think asked that question when
> reviewing the previous version.
> 

I reviewed the patches and the test driver amd-pstate-ut doesn't belong under
selftests. I would recommend the following approach:

- add this test driver under drivers/cpufreq

- KUnit is a better fit for this unit test driver unless you want
   to be able to run this without KUnit configured

- add the test script under selftests - the script then can load the
   test driver and run tests and unload the driver.

thanks,
-- Shuah

