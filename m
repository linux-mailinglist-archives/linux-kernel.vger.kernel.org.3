Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACA4C6606
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiB1Jsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiB1Jst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:48:49 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7C1B7A0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:48:11 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF9F33F1D9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646041688;
        bh=jzvznUrdhpJe3ZwPXYWuaaOm/Kyk5u8NdGdjVdeDrjk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YVFdFF8MBmkIYdbu0HFEDJn2xp4fUm/Iqig5ap1tck6H4nDk2bgtry8/fAs4grdI0
         9jqw3PQPG5ZzjmT8wG0l2Zvp6K36gOSSqXGSzyW6z6PIAUM+/G+xBGIGEPQO7LANK5
         00P1suqv416MhF7IZGsptNy77j1pvbsVDqP3wolFCrl0uVWyKZw3VZtEN905ugh6ex
         Qka9sbRwzjiNMW4ZcWfp80EJmD3mxoUk1Tbh8pCfvwptpjm64QY8pyppYZIfxbrq4+
         VifL++zemV0bhUVcusW9LUoPQ1NQVvHDOU3z/m5tq3Yrng5fFjlQM8Qzl/eUFT3Dg6
         OjNgoUija7q0g==
Received: by mail-wm1-f72.google.com with SMTP id m21-20020a7bcf35000000b00380e364b5d2so5834400wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jzvznUrdhpJe3ZwPXYWuaaOm/Kyk5u8NdGdjVdeDrjk=;
        b=mJGlxHnPzQipil1/M26kx16QnWYChE8xylt6nDG4D6zmbHl9XT0LWZsgP2zwvRGZqX
         COWpeyjIhSBjp3H2k/07S4oqXjweEK/n9D38xk3T20zxJzZBtuu59R1IHR6VON+b0fgQ
         d/jqlp4OGD4L0uTSvxgj5dpR5Tjb5l9LUYKv6sF+NmrTZiJxm24uZXcvkDjqcXjqEmof
         NyJ4QVKhOh4SZF2SbboKvbpnaBd6bQ6UyUjdj8Y29lnqpp9va+flot4TiJr3GG7sV2so
         q3OG/rgQgChXHJ5ce0w0gC9o4yjmim9ZV31XhCKU6yJlcYDKOrvI8xkqW1Z68P7EA4Ja
         BuYA==
X-Gm-Message-State: AOAM5320Zgx+X6M+T+w8QKZ90XrUkMmSSjHJFLVfmxt2efW4NJKhcVqR
        BNqe/02ssls6ep0OHrsrNiyBcip9phJDN8WIdnNXT37+lMm3EvLfKcwICpuCe0MNiz99sIed2H4
        uiHZ89WIg1Z2axfrqTwbj04nZXROUoNaFbfYT3A7pUQ==
X-Received: by 2002:a05:600c:1c29:b0:381:7667:ab69 with SMTP id j41-20020a05600c1c2900b003817667ab69mr1410759wms.142.1646041688617;
        Mon, 28 Feb 2022 01:48:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHKdJm6o+V1vsNAGXrWCyYjceYDjJ5C7DvIum25JDoLzfLPUxAf3v0RyZ0xfsac44A1y8uqA==
X-Received: by 2002:a05:600c:1c29:b0:381:7667:ab69 with SMTP id j41-20020a05600c1c2900b003817667ab69mr1410752wms.142.1646041688461;
        Mon, 28 Feb 2022 01:48:08 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id s3-20020adfbc03000000b001e4b0e4a7fdsm10289662wrg.93.2022.02.28.01.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:48:07 -0800 (PST)
Message-ID: <05597fe7-6ee4-6702-03a2-3dbf795889f8@canonical.com>
Date:   Mon, 28 Feb 2022 10:48:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/V2L SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org
References: <20220227225309.28098-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227225309.28098-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2022 23:53, Lad Prabhakar wrote:
> Document RZ/V2L WDT bindings. RZ/V2L WDT is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-wdt" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSI changes have been posted as part of series [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227203744.18355-9-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
