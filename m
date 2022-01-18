Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D5492D68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348109AbiARSfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:35:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43516
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348089AbiARSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:34:57 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 25A963F1E0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642530896;
        bh=el8J3PPct0S+ev5GdXyAPVCnFytQqf1PBg78OHl8Ffc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qkJpGJOQE2H3w73Q3dtLSxheHguD158HyudbvZxNCGWqzsMX36jHPSiXcaSv8lDB9
         yBBr5cjAr2dW23+bFHnSuiRBtbkieeKhRyFL1Y2LuaVv0vukwIGDAtMyGxDre46GyI
         1w116ZAmPh994R/rbtHfeaxz5q1WtW0l8ztecM9LnDAmymh3mDaM9KtOLo/YArmWAa
         EH9DZqYcJ5NL54sdidySMNb3p2rancTtheu4N/DTmLscR3EMqd6CRjXNBNJyJ6wOJQ
         HqNZMbcQwiNsrSN9ItEEUhpnkK21+9YEodqolxcaR0vX0UkMlx0icBOSKoeW5S9Czy
         W9Fr5KdGS2GXA==
Received: by mail-ed1-f71.google.com with SMTP id z6-20020a50eb46000000b00403a7687b5bso2006929edp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=el8J3PPct0S+ev5GdXyAPVCnFytQqf1PBg78OHl8Ffc=;
        b=KvSjY/VJhAxJw4VCC3sG/2feer5+xIgo9l5SjK3Dcmk/9hhG34IwkPaPk2yPovi+Pq
         bHCnGIpXE22nI6bXjX7NlFyYbNVz52cEWQSJZ3m5vMdBBLyFaJYHZTyK/hz/grqocrmJ
         emX7ozsSteN52iBgEXb8gG0H+ndL3Ri9HSUBIxxIdK0aRaHSrxwSlThfhnuYoeLS3c3M
         k5yGyjBmxfB3PWAQ2QS0mCN1MoMkMJdhFWkqSz+sZjiSlxOOdskaBs6L2VVLLsvaweZi
         om5ybvsEM7MZ5fkCHsE86vm+VpnZBAU1AFe8ImpzXJZwfHQllr1GpgrUX0gdKJX/Po/r
         vI0g==
X-Gm-Message-State: AOAM530L+Wi17WC6nXGTAyiamUTtTfaWXnfKqFBx3A0fY6AxoNk+9IYe
        Lp0zgKrfmk3AqVA6vcsxo6W2ZFmwrsMdQsUlVyC6lOCQcTgEvjhBZAifMUrGS5B0/QmpoBbvWRl
        HyPK96JC7S/vPPqBW+bvNbdk/9fd/4mgsYgj9prNt8Q==
X-Received: by 2002:a17:906:26cb:: with SMTP id u11mr22377078ejc.630.1642530895901;
        Tue, 18 Jan 2022 10:34:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhvVGjHzZuQ09wopbadcVRPRuqKkPuSKlwacLl86koXiI0x4vNr1HBDnVEXOEfMu4WgODVng==
X-Received: by 2002:a17:906:26cb:: with SMTP id u11mr22377049ejc.630.1642530895742;
        Tue, 18 Jan 2022 10:34:55 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h11sm194326eja.119.2022.01.18.10.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:34:55 -0800 (PST)
Message-ID: <ea4d5b07-c14c-4558-9ddf-c55e9a6ff657@canonical.com>
Date:   Tue, 18 Jan 2022 19:34:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 07/16] clk: samsung: fsd: Add cmu_fsys1 clock
 information
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Ajay Kumar <ajaykumar.rs@samsung.com>
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150041epcas5p2634381919d0e9f60867d6087162fa134@epcas5p2.samsung.com>
 <20220118144851.69537-8-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-8-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> Adds cmu_fsys1 block clock information which are needed
> for PCIe IPs in block FSYS1.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clk/samsung/clk-fsd.c | 175 ++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
