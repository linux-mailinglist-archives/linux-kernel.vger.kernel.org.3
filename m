Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C5746A5F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348695AbhLFTvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348091AbhLFTvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:51:04 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C00C061354;
        Mon,  6 Dec 2021 11:47:35 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so14985731oto.13;
        Mon, 06 Dec 2021 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ATT3EvusHd12VybkS1nkDnM9ybrEK3U/h9mE/9ewvkI=;
        b=eFsH5GDdHgWbMo8e43I0HKnDfJwbKNqPKFAl6EHYcC3BnFUEMWqXXqHRITvY8Jql7F
         /7TmJrnGraK9LlFUqEoc2ru8sD4B1it1B1tdOoCIv5jIpJKX+HK/aHbl9UwkhOX7S62N
         Cgzxr31nvwaEi5ZYp7+Nho4qNjsqwXYQr4HeWlKbm//ILBsN6KRsIjJbKkK/G1mV8y0J
         2aivFOPRsNFlNFYJK+mOqJJIkaZXNE9qHxfTAmKQqtk7dVh6BE26TOHmQE7M7w/n6HWu
         9vxEn3Ta5kTR8pamTWz4YKopWlPzLWdCqc4pNLxE4licC/jiXZ4DBrWJurEIkpH4zJKo
         qzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ATT3EvusHd12VybkS1nkDnM9ybrEK3U/h9mE/9ewvkI=;
        b=CmjT1eEn2Zr3PzxFTw+1xmYzVyPsZi7tEDRFpul5C+LJ0LHIYP4eBfOBdWpxmN3unr
         l3fqfJ9mFGJbtSrK7JH6b5JbU/ZYw39yhd21Mq9Hb1l5xYVV4wZ0LWHfcIU/MIhVXhFz
         rbTK5c3Hyw4u0i2+QqGCEh224fzHIK0vfenexvdqm7cd5kAm2NfBkDOxDwboE6L2W1uC
         TbR0adWnsBto3iKN+gHJaMhapDOSNGQ5KCVhR+aKPXqKPi6cMHIfJatbH77oC+6ZWEG7
         JE7gdYZ1XDTQHWKyzmDWBJraonW/DDDP6Exbp7Lbmwi7R6BD5K1JY/+bcs2yupfaAvCZ
         K5lw==
X-Gm-Message-State: AOAM532w4SNiD7U9/Eorip6ogIrpZKM7qioZaI6BE6Z3G9z1dW/R/Xrw
        0B3pqC+AMj7cNFnZJJCSrNI=
X-Google-Smtp-Source: ABdhPJx8oGfX6tBchUQmz9HgJwSbEJVF4WzThI5g+QHF2fI0G/8izJTboMOZ1sqSDEaYd4gBqyb4Sw==
X-Received: by 2002:a9d:7993:: with SMTP id h19mr31994094otm.245.1638820054587;
        Mon, 06 Dec 2021 11:47:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2sm2361341oop.12.2021.12.06.11.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:47:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Dec 2021 11:47:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: atmel: Add missing 'interrupts'
 property
Message-ID: <20211206194732.GB3759192@roeck-us.net>
References: <20211206174045.2294873-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206174045.2294873-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:40:45AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the atmel,sama5d4-wdt
> example has the following warning:
> 
> /home/rob/proj/git/linux-dt/.build-arm64/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.example.dt.yaml: watchdog@fc068640: Unevaluated properties are not allowed ('interrupts' was unexpected)
> 
> Document the missing 'interrupts' property.
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> index 9856cd76c28d..a9635c03761c 100644
> --- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> @@ -22,6 +22,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  interrupts:
> +    maxItems: 1
> +
>    atmel,watchdog-type:
>      $ref: /schemas/types.yaml#/definitions/string
>      description: should be hardware or software.
> -- 
> 2.32.0
> 
