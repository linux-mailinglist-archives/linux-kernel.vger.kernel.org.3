Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8E4787C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhLQJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:35:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48990
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231778AbhLQJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:35:14 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E1893FFD6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639733712;
        bh=z2ulb+DVZsgqJd2LDgGlq8D+/PB9tFXsgdrZEe6FKTw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=dGr7HKPDvmMNTlGHP350Rq2sxz2mYrR04S0Mb2aUqxNrrYQHJpOd19+199fdLsNRM
         oIkCexFFiGFG5hojPV+UYl40F2UTTh1G7EHQXoV0u86Ri4P24pynJ2LSzazIHTpiVQ
         xCL5nRzSqPgQhZIAKYCtY5of+LHpx1dkCDLRnbe5zSblblqhg8U1nX3VgE2Ew2e2zx
         3i6XBjG+d1OXSCgNO1w6EHu5mcltPiyZHhCKwxNW9iOi0oLticnd95aW+sVbYki2cu
         nbagT4IvpyTfaipv2uTncbyI2WdEIhfS2mpM9/bLxI3bh9Os95Lmr2h1IKV5NQ7SGg
         x4w9a/fkK66ow==
Received: by mail-lf1-f70.google.com with SMTP id h7-20020ac24da7000000b0042521f16f1fso760583lfe.21
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z2ulb+DVZsgqJd2LDgGlq8D+/PB9tFXsgdrZEe6FKTw=;
        b=XKG/bi7bjL92sA+PbNY2Ern0x0enGf37qw22G4czUZTgCwt2+XFr+oflmFN/dIT6ET
         d7dVp3P/LNMZIUrzMWZ/OCnf6wW1fT9itwEGe+SlU5wM34PI2Qp7tn//lBmMs+/evxtB
         UdME1Spk0nCP9B3Jg4INZLE69JN/2GDqLWjmR1Bbjv4BcxxQRMX8u8RHEh2MkP/TsiOc
         sYzRdXTwzX7kUxH/fdu3x4sLCuiVsl6KHWptaIb4REvMIkTmpsvUhb9f6UrfxWZKeYhK
         WFyYTX5GnqthVswIT5rj2LsC7ukXtFxufUAxEC2DVzf3k5K7jYkzrQ1itKYZDKr7OOzv
         wT+g==
X-Gm-Message-State: AOAM531lYh5t/ZfjLa44msskRLe+pUbAPlT6TnXnt3B11nLWsr/B3J9d
        sBQFKJKBdS6JeEQjnK4vhZO+5Rhns3lDHjjg9qh+G5WTU/sd3FkN6JMVIpuVty7pUijjnTiPesP
        Pd01rmaL7AqQtQKwkkipAG55u3XjLYHQldpR0YlJUSg==
X-Received: by 2002:a05:6512:261b:: with SMTP id bt27mr2134395lfb.68.1639733711849;
        Fri, 17 Dec 2021 01:35:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3vfcxbokbMTir1a2F1ktl93PTYnZK69spGTwWf5wxnVgnRpbKDs2qjbIy8UtGLc3PLoeRVA==
X-Received: by 2002:a05:6512:261b:: with SMTP id bt27mr2134385lfb.68.1639733711553;
        Fri, 17 Dec 2021 01:35:11 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id w15sm1300450lfe.245.2021.12.17.01.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 01:35:10 -0800 (PST)
Message-ID: <4e0ab991-1149-5e40-2109-d0a2405dd7de@canonical.com>
Date:   Fri, 17 Dec 2021 10:35:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] watchdog: s3c2410: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20211216214747.10454-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211216214747.10454-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2021 22:47, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Dropped goto and directly returned on error
> ---
>  drivers/watchdog/s3c2410_wdt.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
