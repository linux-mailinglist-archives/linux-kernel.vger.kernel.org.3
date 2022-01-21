Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D249651E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382146AbiAUSd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:33:56 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56416
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382143AbiAUSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:33:53 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB73840024
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 18:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642790032;
        bh=v1/ZmZoCSfUTZLAD5km6I/vpYxbMEROGRzZoW4u340I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KMPDuy10Yod7oilWVZ5zcFp5bGnvWqOi9A5Ql3hGBr7L6u2Xv589+aGY1EOhbgYvy
         witsPX2OWlSTc5Qigp7vEwG/Rwd4c/R2Gg9HTldLj9fRlOj+qcKyYhe0gj1iKKi5k3
         fnLCmHPRgYgoMLXFwbdGy9Aj16s9DWqJZJsXGhwlYuzSJcv99xgqh+WXrBQ5riLJ7B
         niZaIJC2K2buYfivAaRU/D3mreJoIPoOfzO810H2AxSermwSucKe1cnsAh275ZA+64
         0M8zAa7s9z12IU4dABrKSVViN5TaM9QjuiLSClRmLd5xs3MLaidEZpK320vbKFsvVV
         mFR36Y3MTtTvw==
Received: by mail-ej1-f69.google.com with SMTP id ky6-20020a170907778600b0068e4bd99fd1so409648ejc.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 10:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v1/ZmZoCSfUTZLAD5km6I/vpYxbMEROGRzZoW4u340I=;
        b=7D2VgTTQNbNxBs9meuPJ4A3caw6PuKMaih0RgK9Rq7x8TqwfOBvVLwDWchzqOlLqHf
         etZ9saZQuoabasHRO+8b29Rx4/bFkYsraq4U3L3Lh19InWrEdekOoZBGLkbv2PrWoevd
         Zs2hCFPDfSksHN3uaY4DFejvjhrBJlyEcIgShQy8/ktpt9WI/PC6ckY2esqrpnaod/lV
         VWx/QO96U5ysQxMmNPnhOJbakwsX5yhEob7OOuG8c/vWh6hGmayDKv0fwwvOYBL3N8IU
         6g9ejUtHmBjtLHjoBZh4rQFQzmFLYs3WA6glfjWVRWAbzJ4Bb60Fd12sS2hz7T/ueGPo
         olrA==
X-Gm-Message-State: AOAM532fX2FayDaXb9/79jDkCbaa/W/1RJ0b3kSa+uX07v/KMnMmY9gG
        eCVJAn6S7EYgnp+KzG+J5erjfgOLu7oMb0alzF4A47i7D0eIkZ1HpBLHx6VvwYFxSYEUcg96Ujs
        m6vvijdjP19+EN6lbHd8afQojGq2EpkIKqtw3SQj4Yw==
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr4257063ejc.225.1642790030053;
        Fri, 21 Jan 2022 10:33:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUiLoCSnLbb+feIhIvxBFMattSryvmMTgY5adK0i09eglMEN/QYyW33qlmPPUw6iB1mJV4rA==
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr4257044ejc.225.1642790029899;
        Fri, 21 Jan 2022 10:33:49 -0800 (PST)
Received: from [192.168.0.51] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id lf16sm2220182ejc.25.2022.01.21.10.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 10:33:49 -0800 (PST)
Message-ID: <b11b8507-339b-2125-30e6-a927539d7825@canonical.com>
Date:   Fri, 21 Jan 2022 19:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 2/3] spi: s3c64xx: Add spi port configuration for Tesla
 FSD SoC
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, broonie@kernel.org, andi@etezian.org,
        linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        Aswani Reddy <aswani.reddy@samsung.com>
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
 <CGME20220120193618epcas5p45be1db500363072e647bf179623f8e7a@epcas5p4.samsung.com>
 <20220120192438.25555-3-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120192438.25555-3-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 20:24, Alim Akhtar wrote:
> Adds compatible and port configuration for spi controller
> for Tesla Full Self-Driving SoC.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
