Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7208149FCD6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349565AbiA1Pai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349549AbiA1Pah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643383836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1MzpLEHNt998Fp+0Cju8ZrRTa2fyOAxv9mE2xz2mj8=;
        b=RHCWMW/M80xhF6VAmDFK9fitsDJxxnM3wnsaF79bbSMisX8fwMzm1bk+tPquR9uORVHjTc
        0NDlFeZhnCxo04d1Zw9T5TgSxGwzf8Dq1vKQTL5iy/KBE7NqejNIknYHX5uSslUkbJ6WGb
        JnezzaM0jBbGhj0AF669oPbbHkZc4tY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-cJn6qmtYPCGS7kgdcdFd_w-1; Fri, 28 Jan 2022 10:30:35 -0500
X-MC-Unique: cJn6qmtYPCGS7kgdcdFd_w-1
Received: by mail-oo1-f72.google.com with SMTP id a7-20020a4ad5c7000000b002dacfc3d40cso3325080oot.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R1MzpLEHNt998Fp+0Cju8ZrRTa2fyOAxv9mE2xz2mj8=;
        b=j0q1Un2orT7dSxfVWgPR16xWsJRdClPrtb9HbtflGM7Vn3vxfet6E7/gLJGMQlVyBs
         aUvIMc84EdAr9N4YFpR7kJyBP5t2hvMR1Je7fbVqok024YOb3lrAyYyAIo6QNbHZB4jd
         0dcqNeCGQkGMNyUfjM+iw8JlCwcaQVVS5e7HwRCwppqbow7xkwYrkhZ0tobMFO9KohJn
         MvqckN+rdzG1BW/waKQ60xnZoYYnM1K6FO4oh5ex42/hoaGoGdvnxTqcgFdWU4WKt5Bb
         Joy9it3+iL8sa7s7MPy+fmpJT4pmMtdKuY24nMcbeTbYi9zOvCDjjnA7pruIzZNd2kzq
         JOiw==
X-Gm-Message-State: AOAM533ktk3Pk8wfEhosUOTAjiH5xkeTvyRI+FAvZnuS2MhCgu+zT3Dx
        SYoPMKqpcYue7Y5tdUQRdDQG+RdJG0tdlewqy0FyEwUsKgfPhftZm7Iz4SjBQF/IYQzoeIVkzTc
        rzq80+CQEwB8yk4YTmwba1ZgL
X-Received: by 2002:a9d:69c1:: with SMTP id v1mr5199551oto.134.1643383834425;
        Fri, 28 Jan 2022 07:30:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrc2gAf4ubCCj0EwhXokMaa2jqu7rpkjWiv6FEjBV/7u+RmiWHylH0XXldFnbrntjxa/Fp/Q==
X-Received: by 2002:a9d:69c1:: with SMTP id v1mr5199538oto.134.1643383834219;
        Fri, 28 Jan 2022 07:30:34 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id ay14sm13152476oib.5.2022.01.28.07.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 07:30:33 -0800 (PST)
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220127151945.1244439-1-trix@redhat.com>
 <953eb015-4b78-f7b-5dc1-6491c6bf27e@linux-m68k.org>
 <CAKwvOdnWHVV+3s8SO=Q8FfZ7hVekRVDL5q+7CwAk_z44xaex8w@mail.gmail.com>
 <fb308f51-f16b-3d9b-80c2-180940236b00@redhat.com>
 <5554a75f65fddab4de60d61fd503fe73773dafbb.camel@perches.com>
 <c801989d-5f3e-84d2-24a0-7022be70da98@redhat.com>
 <7bff2de309384b7c9ee71ad90881d1e0bbe0a781.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0567fce4-256a-e1b1-dc66-221ba97153d5@redhat.com>
Date:   Fri, 28 Jan 2022 07:30:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7bff2de309384b7c9ee71ad90881d1e0bbe0a781.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/28/22 12:41 AM, Joe Perches wrote:
> On Thu, 2022-01-27 at 21:31 -0800, Tom Rix wrote:
>> On 1/27/22 6:43 PM, Joe Perches wrote:
>>> On Thu, 2022-01-27 at 16:32 -0800, Tom Rix wrote:
>>>> On 1/27/22 2:47 PM, Nick Desaulniers wrote:
>>>>> + Miguel (the clang-format maintainer), Joe (checkpatch maintainer)
>>>>> These criticisms are worth reviewing.
>>>>>
>>>>> On Thu, Jan 27, 2022 at 2:38 PM Finn Thain <fthain@linux-m68k.org> wrote:
>>>>>> On Thu, 27 Jan 2022, trix@redhat.com wrote:
>>>>>>
>>>>>>> From: Tom Rix <trix@redhat.com>
>>>>>>>
>>>>>>> checkpatch reports several hundred formatting errors. Run these files
>>>>>>> through clang-format and knock off some of them.
>>>>>>>
>>>>>> That method seems like a good recipe for endless churn unless checkpatch
>>>>>> and clang-format really agree about these style rules.
>>>>>>
>>>>>> Why use checkpatch to assess code style, if we could simply diff the
>>>>>> existing source with the output from clang-format... but it seems that
>>>>>> clang-format harms readability, makes indentation errors and uses
>>>>>> inconsistent style rules. Some examples:
>>>> Problems with clang-format should be fixed, I'll take a look.
>>>>
>>>> I was reviewing this file for another isseue and could not get past how
>>>> horredously bad it was and really did not want to manually fix the 400+
>>>> formatting errors.  I will drop this patch and use the use these files
>>>> to verify the .clang-format .
>>> I think this is more an issue with clang-format than with checkpatch.
>>>
>>> If you have specific issues with what checkpatch reports for this
>>> file (or any other file), let me know.
>> Yes, I agree. Its a clang-format problem.
>>
>> I will be looking to minimize the .clang-format settings to only those
>> that agree with checkpatch.
>>
>> Then add settings back in later if their problems can be worked out.
> Another option would be to use:
>
> 	./scripts/checkpatch.pl -f --fix[-inplace] [--types=<list>] <files>
>
> where types is an optional list of specific things to change
>
> see:
> 	./scripts/checkpatch.pl --list-types --verbose
>
> to show the possible types.
>
> Only some of these types can be changed with --fix or --fix-inplace
>
> If using checkpatch to change formatting, it sometimes can be useful
> to run checkpatch --fix multiple times on the same file as a
> checkpatch --fix can create a change than checkpatch will suggest
> should itself be fixed.
>
> Of course another option is to do nothing as many will complain,
> sometimes senselessly, about 'churn'.

A testsuite for the fixers may help with churn

Any interest or thought on organization ?

I can take stab at one.

Tom

>
>
>

