Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7422E4753D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbhLOHgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:36:46 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60524
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236011AbhLOHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:36:41 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 203953F1B0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639553800;
        bh=F6A76TBrmUtFWX3VCIsN07CYhL6FGO84vIVFcKsHMuk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=HBhtqH1ftR+JE8s30I5DsAG0EuWjU+L6cYe5RU3DMx6TTR2l1POXl4JAJfUEU21W6
         j3BSoVnYkjcx9YjGGZccgnSmS5RQFEW1Fr/DdC61vvWnQjehz75pOIghLlyARcWSMB
         33HTuXB4CsxWmFzT+YvsOsVPkQAO8WOdBkU987uEpVShT8eRsXSY05ibMYgKsC6sA5
         lNcKKMBJaHRxD+iQZ8PafGHPCd333khRvEV3x3iGjUDidWJ5013WUPl9fkyuIVL5pI
         jb/yS+DraClm4KTIzSp0DzQal5w27BTJoMtVZOCb+Uu5FUUBq2Iwpekqv8Y64Ko/+N
         oh3GQkpRyU39g==
Received: by mail-lj1-f199.google.com with SMTP id q64-20020a2e2a43000000b00218c94eab9bso6653473ljq.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F6A76TBrmUtFWX3VCIsN07CYhL6FGO84vIVFcKsHMuk=;
        b=T6obXA3sZFwygQXpmvJ8UAms5iLy9tVDBKs/uP3bQjlYHVkzxOu2Eq9yAkqzrz0wqf
         HCTWCUr4mWQgFDCMxDq9VhteF4zMzRoGXBorwpaqTwXuer4Ueyq58srCh9SadY3KVivk
         fLYrUB6FQMLnc/TlsQjVWNFwBd+hxZwwmgVRW68/x4orpue4dYhpByab8tarFrunb+0X
         g9Py96nu8Qv7SNLP80HbCIq8ar7w5hmXNDNOPatT57b74E3JGXgFvyFKtRMxVdGlPThj
         GDTIQ8NhINVcHo20brKm8Sqfo8Gx32nSYRGjNjxWtJ79tz2Xn+CUTljwgUytwDdiqTZs
         +RGQ==
X-Gm-Message-State: AOAM532gDTG76NC40ky0ETYocqdzYQkVpe2xkeuCJN6kCXzfQhD39S/k
        DTG+6zao+WdArePtFUqlCAU7R15Nz+tF3O0BeM4RhkbYc4CWEozZ6aLeyDL0fAv8sFMvlus5JmC
        lBz2NMtG0poEBCdMSLTALr454BezTREZX4FfcvC0nVA==
X-Received: by 2002:a05:6512:4022:: with SMTP id br34mr8848168lfb.530.1639553799646;
        Tue, 14 Dec 2021 23:36:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzPtDMOJasNzOvdacYEtvNk/bKv5BWr0rmdGjWr2pcPixNzBSY/JytR3tWeRLhzvX45bRflw==
X-Received: by 2002:a05:6512:4022:: with SMTP id br34mr8848159lfb.530.1639553799518;
        Tue, 14 Dec 2021 23:36:39 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bp15sm188546lfb.176.2021.12.14.23.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 23:36:39 -0800 (PST)
Message-ID: <27e76745-090c-36c5-78b8-aeda58c91034@canonical.com>
Date:   Wed, 15 Dec 2021 08:36:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] dt-bindings: soc: samsung: Fix I2C clocks order in USI
 binding example
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211214170924.27998-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211214170924.27998-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 18:09, Sam Protsenko wrote:
> Now that HSI2C binding [1] is converted to dt-schema format, it reveals
> incorrect HSI2C clocks order in USI binding example:
> 
>     .../exynos-usi.example.dt.yaml:
>     i2c@13820000: clock-names:0: 'hsi2c' was expected
>     From schema: .../i2c-exynos5.yaml
> 
>     .../exynos-usi.example.dt.yaml:
>     i2c@13820000: clock-names:1: 'hsi2c_pclk' was expected
>     From schema: .../i2c-exynos5.yaml
> 
> Change HSI2C clock order in USI binding example to satisfy HSI2C binding
> requirements and fix above warnings.
> 
> [1] Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> NOTE: If possible, it can be squashed into "dt-bindings: soc: samsung:
>       Add Exynos USI bindings" patch (already applied in Krzysztof tree)
> 

I already merged it between branches, so no squashing.

Best regards,
Krzysztof
