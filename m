Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993E149B516
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576865AbiAYN0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:26:33 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44312
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1576441AbiAYNV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:21:57 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 497463F1CC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643116916;
        bh=GqSRGOwqotf00GRrIVq/CrHZH/1UrUmdSDaTt40VOAM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=QkG3WCgxRohfH2+6GrIzN637gMpOwBy5Oi+SmHciXZCrqyqUr1E8vjZ8mgdvMcQ7R
         SzvbEUvQmU20idZp6kFulGfs3WAK79MlJiVrnmplKE5vbBoMuNBawuq/mmko3dFXPp
         91sllNx+Pnzo6uELhlNJbxMwvKrys6gsrTsMjtppaRPvYqtNISat1T5UarrA4HK5yT
         RAF9qS9huANGJPB5ki7YvCjd3eXZN+AG0b3JdYJ8pbvKXYtGpkwvnayCVtTy4jG2Jm
         Y1VQ2dNkcV71gtqTwbx8twM4r0qezjG4BvH+wc3W6eTJKFVsqmHasmWetCADPWkX8M
         4B3i5/9W1gH/w==
Received: by mail-wr1-f72.google.com with SMTP id x4-20020adfbb44000000b001d83e815683so3035805wrg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GqSRGOwqotf00GRrIVq/CrHZH/1UrUmdSDaTt40VOAM=;
        b=YIJthmRmuLxVAy8411aGdDFfavvBnwbJ4LpFCCagch+rcrbR4mIaLc+eiriNndhOm5
         2qhPdkiI4lSYYRJRkFQot5PmUCqLh1d13SA50+8zV0axaU3Ct33Z3gxelVu81Ekf0rgA
         frGmv9AFlU4CmcITx2tCpc9ievntNTyusn3fH7vVFPVbLhaflohivxZpf6MgkNyeJgaM
         5/0ZsbUptradyiN7xpaishYoJcs3c2ealVyv8Q2ImHQpSLRqtO8YWY81HUVJztLzhn4p
         fVJCeTrO+y4fdSMfFQGQU0JUWAgaViRAdnxKG+ubT8qCBSB4tKkEFr2+85Dmmqc2SKK9
         zkXg==
X-Gm-Message-State: AOAM533z8Ii/8juUAVkTxLgwS4t1n/E5jHpCRZvx8phcHN7AvUGKTPWn
        0ibA0vmRtbM4K/aX0zgdPap9b3GZ6+o7c/anvCBjmR1qrtBsFg0f/Kc8RFsGsRe6RLOfhwfNMDr
        vBv+h21NhLPDVv4orYpt7fbqTiFASnnFv3frWzxA1Hw==
X-Received: by 2002:adf:f14a:: with SMTP id y10mr17659172wro.145.1643116915696;
        Tue, 25 Jan 2022 05:21:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQEDd2I8GeJEKiaLo3Ns9QBAcA+Cpew7nwWs/FsWRHpr/3jD2rwboT4OiDAN2ucloeNLoOOg==
X-Received: by 2002:adf:f14a:: with SMTP id y10mr17659159wro.145.1643116915523;
        Tue, 25 Jan 2022 05:21:55 -0800 (PST)
Received: from [192.168.0.59] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t1sm3607494wre.45.2022.01.25.05.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 05:21:54 -0800 (PST)
Message-ID: <d79e19e8-e15d-fe09-6ebc-c1f8aaacfc00@canonical.com>
Date:   Tue, 25 Jan 2022 14:21:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
 <CAPLW+4n-1H5Yu3wQaus-UJ_VW_TjHrNUHaPCGCMURXg8EqxjyA@mail.gmail.com>
 <CAK8P3a1ou-ZdrXN0MHQoJ+gGbvhXT-e2qt96_f9M8VwrdX0pAg@mail.gmail.com>
 <CAOesGMgF3S5_XsWjEqq=-zfYXwOWFpFNA6afL81wceRUA_0FeQ@mail.gmail.com>
 <CAPLW+4k8=ymx56R7bKOt8kMVG_uUgrTsCkVd5wiY_rkYq8dYbQ@mail.gmail.com>
 <72a50afd-df9f-ceb3-898e-070d70dc0221@canonical.com>
 <CAPLW+4=xaHA2a=-F4ikuUPDpoO8Waj7qrrfpgkift1aMi_hU+g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAPLW+4=xaHA2a=-F4ikuUPDpoO8Waj7qrrfpgkift1aMi_hU+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2022 14:50, Sam Protsenko wrote:
> On Sun, 23 Jan 2022 at 21:27, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 22/01/2022 13:38, Sam Protsenko wrote:
>>> On Wed, 19 Jan 2022 at 18:53, Olof Johansson <olof@lixom.net> wrote:
>>>>
>>>> On Wed, Jan 19, 2022 at 8:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>
>>>>> On Wed, Jan 19, 2022 at 4:11 PM Sam Protsenko
>>>>> <semen.protsenko@linaro.org> wrote:
>>>>>> On Mon, 27 Dec 2021 at 13:30, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
>>>>>>
>>>>>> Hi Olof, Arnd,
>>>>>>
>>>>>> Just want to check if it's possible for those patches to be applied in
>>>>>> v5.17? Sorry for the noise, but that's important to me.
>>>>>
>>>>> I can see that Olof merged merged this into the "arm/late" branch in
>>>>> the soc tree,
>>>>> so I assume he still plans to send it in the next few days.
>>>>
>>>> Yep, will be sent up today most likely.
>>>>
>>>
>>> Thanks for detailed answer! Glad to hear it's still a possibility.
>>> Please let me know if you need any actions on my side (like rebasing,
>>> etc).
>>>
>>>>> With the timing over Christmas, I sent out the large bulk of the
>>>>> contents (anything
>>>>> I merged before Dec 23) last year, and Linus already merged it, the rest ended
>>>>> up in the "late" branch.
>>>>>
>>>>> As usual, there is no guarantee that late changes make it in, but I have seen
>>>>> no indication of any problems so far.
>>>>
>>>> Correct. Been sitting on it for a while in case there were fixes
>>>> coming in for the first pieces that got merged, but in traditional
>>>> fashion I'm guessing those will start to show up a few days after the
>>>> late branch gets merged. :)
>>
>> Olof,
>> v5.17-rc1 came earlier, so I see this part did not make into it. Is
>> there a chance for a past-rc1 pull to Linus with it?
>>
>> Sam,
>> Anyway the patches wont' get lost (you mentioned such worry in previous
>> email to me). They might just need to wait. Unfortunately if patch,
>> especially with new feature, is coming in the end of cycle, there is a
>> risk it won't make it. The patches have to wait a few days in my trees
>> before I send them to Arnd/Olof, so if the patch is coming after rc6, I
>> can push it to Arnd/Olof around rc7, you see there is very little time.
>>
> 
> Should I send the patch fixing hard-coded clock numbers though? I
> remember you said I should send it once -rc1 is out. But now that dts
> patches are not merged in mainline, I'm not sure it can still be
> applied?

Yeah, please wait.

We have few patches following that pull-request, so it will be actually
easier not to merge it to soc-tree but resend soon with the follow-ups.


Best regards,
Krzysztof
