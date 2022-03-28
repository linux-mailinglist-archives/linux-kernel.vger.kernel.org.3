Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065944E9A35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbiC1O6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244279AbiC1O6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:58:17 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5E25045F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:56:37 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z6so17399537iot.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xn5CPRiyBEC8Phc5T9mHlpINr2001VRnlOFT234SvvE=;
        b=DE21WS3Uri002Pr1QReulf3aDz87uH4itFX6ffaeqajeUuiWnbfdGAuv4BH71NOY7k
         Qz6wU/bEaQkTJNrnAzEEceBGiG+bJ6uT1crz6OQWk3G5vzz8dmH+h3+Zbi2hObLAyEWo
         y7iaQO1td8tPeaU+flW9Y1u+/HFn7d8lj/1tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xn5CPRiyBEC8Phc5T9mHlpINr2001VRnlOFT234SvvE=;
        b=lGUq9KwDh49MGuq072nu7BLgzsHFd3RcfkRsKhYbL0boKSu98VW2I/5Emwy/YRwg02
         N1+LMH8/RIT2XuiXDXUswAksiricLshpr5uOsNWn8yRpaTEMVV1LMzytK2HbpqBhFLPD
         I34qW08eO59EFqep9dOiYHNkbdzA91eRQHIjXzNVrYc/mII0fRFlTCUz0wxnT4u+eMZi
         Crf4gxawJLIbv9wyFmTdvLBBT209oujWyH0v5riax4jsUB8Xvs1u4ga707pfmdMGGXeL
         3XgCyuBAQa5QZA0UVXdWHu4ZvPQqnYtgYFyqp6rmXtFP/zvwW1zpcZQMW0icpv/qglTz
         t8FA==
X-Gm-Message-State: AOAM53398v5kLrKylc+rpwQPGw5R6iChirw6M2I5Y820qrUPyjD6ZJJQ
        OqXpdO6kNugqxUNZS761VQyyXg==
X-Google-Smtp-Source: ABdhPJwg199yKqqkaDayt2zOIHK98balymLx+ERu/H6cHCxDivkxD8bu0j9ZObYzOA7rAGFhQrJE3w==
X-Received: by 2002:a6b:5d19:0:b0:645:c7ca:7ca with SMTP id r25-20020a6b5d19000000b00645c7ca07camr6619071iob.104.1648479396566;
        Mon, 28 Mar 2022 07:56:36 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id z17-20020a92da11000000b002c83987c2ffsm7138242ilm.76.2022.03.28.07.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 07:56:36 -0700 (PDT)
Subject: Re: [PATCH 2/3] cpupower: Introduce a new unit test module for AMD
 P-State driver
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
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
References: <20220323071502.2674156-1-li.meng@amd.com>
 <20220323071502.2674156-3-li.meng@amd.com>
 <4c13d97e-1471-5642-39dd-d381fa441753@linuxfoundation.org>
 <MN2PR12MB360098136C287C84D99FD9B6F71D9@MN2PR12MB3600.namprd12.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6f52c49f-10c8-0097-9d0f-0ee99925ad9a@linuxfoundation.org>
Date:   Mon, 28 Mar 2022 08:56:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB360098136C287C84D99FD9B6F71D9@MN2PR12MB3600.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 7:57 AM, Meng, Li (Jassmine) wrote:
> [AMD Official Use Only]
> 
> Hi Shuah:
> 
> Thank you very much for your valuable suggestions.
> We will adapt it to test our AMD P-State driver. But we haven't decided which one to adapt, kunit or kselftest.
> 
> Requirements for our unit test module:
>   - It can access kernel internal structures and functions which aren't exposed to user space.
>   - It is implemented through the script trigger CPU benchmark app in conjunction with the kernel module.
> 
> Therefore, next, we will study which method can meet the above requirements.
> Can you give us some suggestions?
> 

No top posting please. If you need to access kernel internal structures
and functions KUNit is a better choice for you as long as all of the
testing can be done in the kernel driver.

If kernel internal structures and functions need to be tested from user-space,
then a kernel driver test module and a user-space kselftest shell or C program
is the approach to take.

> -----Original Message-----
> From: Shuah Khan <skhan@linuxfoundation.org>
> Sent: Wednesday, March 23, 2022 10:15 PM
> To: Meng, Li (Jassmine) <Li.Meng@amd.com>; Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Huang, Ray <Ray.Huang@amd.com>; linux-pm@vger.kernel.org
> Cc: Fontenot, Nathan <Nathan.Fontenot@amd.com>; Sharma, Deepak <Deepak.Sharma@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>; Borislav Petkov <bp@alien8.de>; linux-kernel@vger.kernel.org; Shuah Khan <skhan@linuxfoundation.org>
> Subject: Re: [PATCH 2/3] cpupower: Introduce a new unit test module for AMD P-State driver
> 
> [CAUTION: External Email]
> 
> On 3/23/22 1:15 AM, Meng Li wrote:
>> amd-pstate-ut is a kernel module for testing the functions of AMD P-State driver.
>>
>> It can verify the required conditions and basic functions of AMD
>> P-State driver before integration test.
>>
> 
> Can you elaborate on the need for a kernel module? It would be helpful to know tne value the mdoule adds and why it is necessary. Include details on why it can't be done as part of the user-space program.
> 
> I am not saying it isn't necssary, I would like to know the reasons before I review the patch.
> 
> Also if this is a driver test, why not use other test frameworks such as kunit or kselftest. cpupower is user-space utility and driver debug code would not belong in here.
> 

thanks,
-- Shuah
