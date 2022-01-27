Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3987849DBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiA0Hpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:45:38 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35890
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237442AbiA0Hpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:45:36 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9D4823F1D0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643269535;
        bh=A2nKj4Pl+64Ysr4+QSknv7VT4EFI0AF9z9C7GHdP12w=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uOtW3NGdj0gIRpAVE0/UHen6y/HD6qyn2I+E3mmFZcC3pkoC5vkxlszO4wcCEV9un
         xC+M7hAp9O9i2pNuET/m5hfTG2/ujZ9wqfC7hMqTc1J0eWA1YlmnivT7/4kYWghsQ6
         mrK4Piiq68FXhbZloP6RyalTRX/SOABMC82urInh+qxT6rmqRWFDU4OFbasz1iQVnG
         +lQQQcgTw64hZ7cis+m5Md24bxEFJh0Mqs3Fkk0VUM5wG8zIPDd7Pljp4JcFURjSVg
         XQI/idF9ggOimGlEa0Yr3iaQ2Ce6ZTyHlY7BUJcAoKX/ilb5qGLpWdFInUFjtvStae
         JMsw0ai0ehiAA==
Received: by mail-wr1-f72.google.com with SMTP id r27-20020adfb1db000000b001d7567e33baso714655wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A2nKj4Pl+64Ysr4+QSknv7VT4EFI0AF9z9C7GHdP12w=;
        b=YpkkkO3XS1+JGCKy6LnvgRJoLb3WIQsV/blfs/IHvdDAswNrKojNY2z7hU6i7tW9l7
         EvyBuXwx4VEaJnMw5uSmZqm0pT6lMUC+dMjvpF5JaQGcTDYMsUitPmX/mWtwbsaFhLmT
         II4oi3h95Owweg9RvaPUeRZG0uzXzN/sORDZ4YU8bs45ywevZu/CMg8CRVTGnB3CsSuL
         gE+ee/ld954Irb+B+c5o6KsDUJWpNcmAukzq2lf0u1eV5FLV0zzAOVbvycQhk4/x61il
         4J+gEH9uxqayBBe9w9vbkVJd/o2pujXpLeZUyiaCIYU0VcI3LwtMKHiu3sK41OrI/Uf8
         0SHQ==
X-Gm-Message-State: AOAM532lHNhi/oM9g8+AsXXFOTmhagOIEx96q+gzAgUzgVxZAfreZ0oj
        G8xSMkhEv/d0fP6Hde6lMEzcufU0bhg39QibTADCINka/m8ajVWKloAABstZgGe6ECIDik1dWuA
        0Zd+WoLCkv+7YvQBXNQM4Mm2BAvzRk4RyK1cbF/kq2Q==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr1770494wrs.489.1643269535295;
        Wed, 26 Jan 2022 23:45:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7jAoPbLTEGbFOH5NdL0XmAfgEGITHjiDTMGRmPjC05oBjkMk8eXbStMM/Z+R7G7OO6XMvnw==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr1770480wrs.489.1643269535072;
        Wed, 26 Jan 2022 23:45:35 -0800 (PST)
Received: from [192.168.0.62] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m6sm1647098wrw.54.2022.01.26.23.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 23:45:34 -0800 (PST)
Message-ID: <c69d1daf-45c8-3ac5-a0b0-bb853593c54e@canonical.com>
Date:   Thu, 27 Jan 2022 08:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/8] dt-bindings: vendor-prefixes: add LG Electronics
Content-Language: en-US
To:     Petr Vorel <petr.vorel@gmail.com>, Luca Weiss <luca@z3ntu.xyz>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean THOMAS <virgule@jeanthomas.me>
References: <YfHlV13Zi4KV+bNT@pevik>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YfHlV13Zi4KV+bNT@pevik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 01:20, Petr Vorel wrote:
> Hi all,
> 
>>> Hi Krzysztof,
> 
>>> On Montag, 13. September 2021 10:49:43 CEST Krzysztof Kozlowski wrote:
>>>> On 12/09/2021 01:27, Luca Weiss wrote:
>>>>> LG Electronics is a part of the LG Corporation and produces, amongst
>>>>> other things, consumer electronics such as phones and smartwatches.
> 
>>>> Hi,
> 
>>>> Thanks for the patches.
> 
>>>> I think "lge" it's the same prefix as "lg". There is no sense in having
>>>> multiple vendor prefixes just because company splits inside business
>>>> units or subsidiaries. The same as with other conglomerates, e.g.
>>>> Samsung - if we wanted to be specific, there will be 4-5 Samsung
>>>> vendors... Not mentioning that company organisation is not always
>>>> disclosed and can change.
> 
> 
>>> I was mostly following qcom-msm8974-lge-nexus5-hammerhead as it's the other LG
>>> device tree I am aware of so I've picked lge instead of lg. Also worth noting
>>> that Google uses "LGE" in the Android device tree[1] or in the model name in
>>> the LG G Watch R kernel sources ("LGE APQ 8026v2 LENOK rev-1.0")
> 
>> [1] Does not point to kernel tree. Downstream user could be a good
>> argument to switch to lge, but then I would expect correcting other "lg"
>> devices which are in fact made by LGE.
> 
> 
>>> I don't have a strong opinion either way so I'm fine with either.
> 
>>> If we decide to go with "lg" do we want to change the Nexus 5 devicetree
>>> (hammerhead) also, that one has the lge name in at least compatible and
>>> filename (I don't know how much of a breaking change that would be considered
>>> as).
> 
>> We would have to add a new one and mark the old compatible as deprecated.
> 
> Have we sorted this lg- vs. lge- ?
> 
> There are both:
> arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> vs
> arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
> 

Probably renaming/unifying/correcting prefix in existing compatibles is
not worth the effort. This would make a mess and affect other DTS users.

Most of existing usages of "lg" prefix are panels which are coming from
another subsidiary of LG - LG Display. We all use there "lg" prefix, not
"lgd".
Plus mention before Bullhead mobile phone which is coming from LG
Electronics.

If we use generalized "lg" prefix for one subsidiary (LG Display), then
let's do the same for another subsidiary - LG Electronics. Plus entire
branding of LG Electronics products is LG: the website, the logo,
advertisements. Everywhere except legal footer.

I vote for using "lg" for both subsidiaries: LG Display and LG Electronics.


Best regards,
Krzysztof
