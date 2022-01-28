Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F200749FF9F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbiA1RfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245539AbiA1RfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:35:06 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0331C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:35:06 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c188so8634752iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ooRaQahwlszy2jxWEsQ38+6ol3WBy3QdqHWpkG1atKA=;
        b=CJJPmBPPrNEVxXfAcJO5dgSvYGDpY4Nub6/hiB5x4NgO2LMQuQRhjlFP43kEQpCFCC
         nuiwxM9Be5tgMNM0rNobOtwnJRcoBGwzNRs5Gyzo9kUBT1qHuQlmcoKLI2C06Ffkv4FM
         2bIVm8As7WoR74mKgjpzywfZRvHj0h/H2ojsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ooRaQahwlszy2jxWEsQ38+6ol3WBy3QdqHWpkG1atKA=;
        b=Q3RjEmJ6tWZliQUbbRojDNH/HJQWgBa9fP2JlERKlfwa6MxV6Cb2tzs6v7k+8sU/tZ
         NsNEgeuisRsPhTRosbkMAtt0mgaKuYM84PPWSrq0J5jQphYaK/OToI152dj60nla9lQV
         pzcJQ7QQFqTF5Wbhg0nRZQk38hjzVlChknpuuIjGmJ3CanXiuuXCdGEO2mOcm4HRt5/l
         mheu9fKfjRoHEnNqlHNkOHvJpxZbN89isYN+o1WwgYCfthxNVirzSCeec58B6Z+TmxN+
         TMf5YTc3p+orzXB/NXKedzqlOVthOWM49icdF3GM5b/lbIFI7UNiDtFdVifgTAKNeiBj
         tGVQ==
X-Gm-Message-State: AOAM532v+2Po51ENcmZf0IEMbs4norWR2b7JDv36q7VuXZXvXTjWZmWT
        iqJ54LydE7yGgAbCRw1tFl63Dbz+FrfPcA==
X-Google-Smtp-Source: ABdhPJyNmvaCT5yBvmYFewlDRugKPX6g0ozFAAlv/PqPHRPF4+uoK/ZXUhTd5nofVDVe93L3bj4BCA==
X-Received: by 2002:a05:6638:38a0:: with SMTP id b32mr3822730jav.228.1643391306233;
        Fri, 28 Jan 2022 09:35:06 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c24sm6051767ioh.40.2022.01.28.09.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:35:06 -0800 (PST)
Subject: Re: [PATCH v3] kselftest: Fix vdso_test_abi return status
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220128130701.17511-1-vincenzo.frascino@arm.com>
 <20220128144451.GC5776@e120937-lin>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <82d59ef7-39a1-c1f7-2746-f4fc19593add@linuxfoundation.org>
Date:   Fri, 28 Jan 2022 10:35:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220128144451.GC5776@e120937-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 7:44 AM, Cristian Marussi wrote:
> On Fri, Jan 28, 2022 at 01:07:01PM +0000, Vincenzo Frascino wrote:
>> vdso_test_abi contains a batch of tests that verify the validity of the
>> vDSO ABI.
>>
>> When a vDSO symbol is not found the relevant test is skipped reporting
>> KSFT_SKIP. All the tests return values are then added in a single
>> variable which is checked to verify failures. This approach can have
>> side effects which result in reporting the wrong kselftest exit status.
>>
>> Fix vdso_test_abi verifying the return code of each test separately.
>>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Reported-by: Cristian Marussi <cristian.marussi@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
> 
> Hi,
> 
> LGTM.
> 
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Thanks,
> Cristian

Thank you both. Will queue this up for 5.17 rc3.

thanks,
-- Shuah

