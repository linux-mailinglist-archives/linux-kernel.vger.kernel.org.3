Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3309492094
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbiARHwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:52:37 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40002
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343536AbiARHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:52:36 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E030407F5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642492355;
        bh=aNtiM+Mkd9efU1H0Wh+stfJIqfRGDAuGYHwSDx2cIxk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pUEsfnD4G8rzpPF1W6GCucVZvTUXP6TTMslAC6eB+nKtKLpTmsIBtPdM435v3YobL
         CJ/Rca7bY4fKXDP6LlNt0ipz/hfM2wS9TVqiDyCI/2tY0f0TRFta1XdEPUETKQ8HeV
         nXVme2Ec83QCAVlAO04ADZRvpjFesLr+Yy8AknVRTywmm50MlASnea40Gc9NAtO/l6
         SjoF7a0i2oXG7AtQzQUTqFMYpCFmTts48mcC9IFElg1tmcFGBSZUMsw/0yVZP6EPo3
         TR+vj5cZA8+FIPC4Twcf5KmKpvnv+uqsk2SlDNbjWkLrgZNsFLSl9tYFN01VAg+rD3
         IdbmZ4IigM5HQ==
Received: by mail-ed1-f70.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so16243123edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aNtiM+Mkd9efU1H0Wh+stfJIqfRGDAuGYHwSDx2cIxk=;
        b=DnGth58G0Xh1k5VOD3QmaHsf0E7h8qytNdLgR7pX+WAQ2KP8iAzXMnxYS/MenZyDE3
         daFD8T8zRD5bZ+R6iz2so+ndIpPLrY/S76qAzCEdqw26uDTBnhLuWiPTavqJbRONdT1q
         FZgfHur3amK8ddkDxngbQu2jpQM7GeNX7bKs+pC0y1mT0pCPMH1r+HXrn1atFG2Tnt8V
         QRFmgpqNl4WwGjaod3Nk+aDD8Qu5iXGXSL7m/UcGqrkxSt5YSu7mTe93Di2+MzgCm4ez
         cb3L4qZrB0OjMvvnhEIJxH/R3TPvNiuggSqun49mVRmwFV+HqXwC52SkaAIgFc9pBgOU
         SFew==
X-Gm-Message-State: AOAM532Cn6aH4aZRJP8VeGZjDQ/69Gcrm8rihoVIFqPiKqyMrd3laUJA
        XK1+INhlHkwKfs9wx7+zGvyK3123a2UlcRhsA18BaMIfiDp0ALKYXw/sGdoOkotw14PxD11EWG7
        wW/TaMDyBPhAGM2SNXIkl+4dieszqTQW9Ez9PJOCN8g==
X-Received: by 2002:a17:907:1b0d:: with SMTP id mp13mr19153541ejc.29.1642492354935;
        Mon, 17 Jan 2022 23:52:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBxln2AY6zvpOpDMIrbY3pJ2WqNGAK6xMIm4ZKaNEKJULRafQ8SSXBijKpYwqfIhylcmfhEA==
X-Received: by 2002:a17:907:1b0d:: with SMTP id mp13mr19153526ejc.29.1642492354785;
        Mon, 17 Jan 2022 23:52:34 -0800 (PST)
Received: from [192.168.0.40] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a3sm5071801ejd.34.2022.01.17.23.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 23:52:34 -0800 (PST)
Message-ID: <794f39ed-3436-432c-767d-8fa60779d510@canonical.com>
Date:   Tue, 18 Jan 2022 08:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 24/28] dt-bindings: pinctrl: samsung: convert to
 dtschema
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Rob Herring <robh@kernel.org>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
 <20220111201722.327219-18-krzysztof.kozlowski@canonical.com>
 <CACRpkdYTXSOW+sOX3wVtF4jj6xm0jr-F3HKQPGHOdAVjbasP3A@mail.gmail.com>
 <5047da7c-d3a6-5472-b0ca-7ed3dbe8a5fe@canonical.com>
 <CACRpkdbhmJ91EW395C5F2WYjWJQdJ-SBHaDm7XnQsxMuyoMmLg@mail.gmail.com>
 <77bd8fa4-2b35-352c-da07-ef91fcbed454@canonical.com>
 <CAOesGMg2eH1B94h+etPBDW3B1LMeHBytz0v2e0GfVRDv8gU0YA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAOesGMg2eH1B94h+etPBDW3B1LMeHBytz0v2e0GfVRDv8gU0YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 21:26, Olof Johansson wrote:
> On Sun, Jan 16, 2022 at 11:45 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 16/01/2022 22:38, Linus Walleij wrote:
>>> On Sun, Jan 16, 2022 at 6:10 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@canonical.com> wrote:
>>>
>>>> Anyway DTS and dtschema will have to wait for one release, because they
>>>> depend on samsung pinctrl driver change (patch #2).
>>>
>>> What about I put that (and maybe this schema) on an immutable
>>> branch so you can pull the commit into your for-arm-soc branch and
>>> put the DTS changes on top?
>>
>> That would be a solution if not a policy for arm-soc of keeping DTS
>> separate. Arnd and Olof since some time are not happy when DTS branch
>> receives any driver updates.
>>
>> Arnd, Olof,
>> This is a set of dtschema conversion + DTS alignment with new schema:
>> 1. Driver change necessary to accept new DTS (driver depends on node
>> names and this has to change because of dtschema),
>> 2. DTS commits depending on above, which convert node name to new format,
>> 3. Finally dtschema requiring new naming of the GPIO nodes.
>>
>> If I got correctly, the policy of not mixing drivers and DTS requires
>> that #2 above (DTS changes) will wait for one more release. During the
>> time, if dtschema (#3 above) is applied, there will be new warnings
>> about non-compliant DTS.
>>
>> Do you see any chance of merging driver + DTS + dtschema via same tree
>> in same release?
> 
> Our general guidance to separate DTS and driver changes is to avoid
> large entangled changes between the two, and to discourage a developer
> mentality of "the implementation is the binding".
> 
> I think this is a good example of when it makes sense to bring in what
> is a fairly small and clean driver change to deal with this. So the
> right answer here is to stage such a stable branch and merge into both
> arm-soc and the pinctrl subsystem trees as proposed.

Thanks for clarification, I'll go with this approach.

Best regards,
Krzysztof
