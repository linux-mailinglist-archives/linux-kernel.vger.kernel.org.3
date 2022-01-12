Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96C648BF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbiALHm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:42:56 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52374
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236960AbiALHmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:42:55 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9607C3F198
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 07:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641973374;
        bh=epu2LRZE4ho4WW6edxeyHFTEV0S/nG4S9x7fJoxh1S0=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=FzRkzwXJ0mxEFiJZcC56k4YPZtoeQbUsY6dETKVc5aUwEkJSIcE4tW4qduNGpPVvT
         8GVZbIXyEKuUyDia04hnt+pKc7CQfZu3cKhSDjARA8TGTJOSTzn8p006AQtWfHd5bE
         soZxKYn4TmIRgSTDp0FBXY741KVtuaYuXumW4J+sETk0xfQ/yUoE8U+mQpxDGING0B
         ovpRazThHRKFKy00Z4LhP5plFh5juKp8V3lrLwgZPn5ln3cBeiK7GkWIiJf45iDdfF
         1TBprjbucgOCoEm0X3E9X1YemxBClz+50JrL7NBfPbUylH4nZAoP3zl8UjzhMoJcYC
         XbGGs3LKOeOtA==
Received: by mail-ed1-f71.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so1521505edz.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 23:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=epu2LRZE4ho4WW6edxeyHFTEV0S/nG4S9x7fJoxh1S0=;
        b=RdIQMsN1K2gIQ74ZcwQZrhHKZiuOWXWH1qdbDlzCS/0lhs0xLGZYpKWyAYlrJh8bxJ
         jM1+QumjGSk0k0o7wTc5p6V+g0uPrXSL4iHe7AaBIfBWVUDqGRJw/UOXC0KVmgTNeZ8p
         mK9SsF3R5KwLLIwe75QYpbJo5ugXKjq+mg6/EybstrAYRXcUaSn6/t0Q5Iiq4QSvzoIB
         wG/lSK7sL1PFZqD4sI2w91OTpKfaFRG2oj+rQ3elNHbGc3snaYF1pHi5oND7Z13QCqp/
         79oQvN09HMiRX1X2sYTfd9FkZsPEad1bE5U8KoFM9j8Ttz3ExX/wRE0g0a/dFWl6uWu4
         +5gQ==
X-Gm-Message-State: AOAM532VH0+5YcbQiWbhegYpyKSfKVjPbmol2Ethnj6Z9/fd8X3otZrS
        fOPaDIJ8DVVPJwWfaaQyDc/WzLNm0slnu3m/LPevrwNkeKPSIsKTa675FvOhls4nhBWDVLja+xb
        df1tkmRnL0ZXlmyDYgf1FIrEl9FBJVFicoNG0rswpWA==
X-Received: by 2002:aa7:df13:: with SMTP id c19mr7689773edy.233.1641973374240;
        Tue, 11 Jan 2022 23:42:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0NbbWSBowvR9ILzXQnO9GdhgSKLG97/LSzMoBz0Gaauz3kd508ZNjLoLgXl9i652kC+N/dw==
X-Received: by 2002:aa7:df13:: with SMTP id c19mr7689756edy.233.1641973374107;
        Tue, 11 Jan 2022 23:42:54 -0800 (PST)
Received: from [192.168.0.26] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id hq29sm4265184ejc.141.2022.01.11.23.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 23:42:53 -0800 (PST)
Message-ID: <783a67ad-ee7e-c75a-a52c-672cd355bd37@canonical.com>
Date:   Wed, 12 Jan 2022 08:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: common: fix unit address in
 max77693 example
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
 <20220111175430.224421-4-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111175430.224421-4-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 18:54, Krzysztof Kozlowski wrote:
> The max77693 LED device node should not take an unit address, because it
> is instantiated from a max77693 I2C parent device node.  This also
> splits all examples to separate DTS examples because they are actually
> independent.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

This should be part of my max77693 patchset:
https://lore.kernel.org/lkml/20220111175017.223966-1-krzysztof.kozlowski@canonical.com/

Nothing actually depends on this patch. It just fixes a warning which
will be brought to eyes with mentioned max77693 patchset.

Pavel, feel free to take it separately via leds tree. Other way is to
take it with other max77693 patches (probably via MFD tree).

Best regards,
Krzysztof
