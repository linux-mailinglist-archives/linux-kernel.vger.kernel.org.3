Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15484C65F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiB1JrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiB1Jq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:46:57 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A4269CFF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:46:18 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DBD8D3F1DD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646041575;
        bh=kx3KwflhSQCgPfG7GHkNt9DIyHPaoaEcSwFWIFUDpTI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rwdvWQaKfYE0WPA7FVxo1nNoXW7QEg4HBaqb1eTa7MmPwRKXUKzmxQwNIPN/aGHIc
         BVcy++fbcUq9yhspprHBgCK0ctQswXr4mSW9wFdUjU3ptplR+XRPcl5z4pbq61+Rj3
         YrYcB89zF34A4BTALMogn/ZwpDwV2yhGGG/kClG2JMtIlMI7rI7/QLEDyTiNs3aFEp
         0StR5hfsej+fNzTRv3O582QKi4JFhNojP4MFQQsTtjcRNr75IlGwetIR5XWJQNdoaY
         /vavjPAGgc9l3I2DZX8P/nsFhuDoaH7lxzGDhHFhkedkx7XPoOnvqvwvX2BBDrPH/q
         rrkAXOh0poosQ==
Received: by mail-wm1-f72.google.com with SMTP id q17-20020a1ca711000000b0037be98d03a1so6195387wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kx3KwflhSQCgPfG7GHkNt9DIyHPaoaEcSwFWIFUDpTI=;
        b=uVYu4L6WDgVa4OYkllVqOeuNcUrpS2iMmboZBqBHtTRTLTNGyLzk+mKR+XVHcDxBnt
         AYEJrpAabiWJvXKfxcfsem+naG4CW2/IepREcf15CYSKUdXuXz6nbcBVcghvRVsyvyjn
         WjpavBR1j0JYhoSiyaf/YtZiPuE/3gYQ4bVxbVn1/B/OBpXULY9kwLS0k4zx/NINC8VK
         o0NLTvkHDmoO8TMKLRWG+TeM60+LEjsO8EiJkRJOpdF0/XV0OVWyLdiubAsQ5OGiM04z
         E/RCQx6fpE3BFMiD/RKEm1OXnPAVPzOJ+Lj1/jg1ezxbUW5GFON5moDJAW3NlE72D2uO
         4cLw==
X-Gm-Message-State: AOAM533rteX51tPn+4/vSzwuV98HleTwy8QHAGpJo21J8rfOWd7xi7mJ
        J1i8wiViMKnus3gMKViLY5u8j2F3Cy4mZX51yTJZV/tKnxliAGJ11jR/qRi+GkjwuXOHppkm4dK
        p2Ev/PnNw2L53inhDVwlPdBax9aDfJwxlegQMVKRAWQ==
X-Received: by 2002:adf:f00e:0:b0:1ed:e1d2:f10c with SMTP id j14-20020adff00e000000b001ede1d2f10cmr15225302wro.181.1646041575515;
        Mon, 28 Feb 2022 01:46:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwL0JBj8yLIAMajpevQP4oIWnehXfhmFqdOAerH2yff2r6ZgTyrXSY7IhRRUp4jT3ezbYRq9w==
X-Received: by 2002:adf:f00e:0:b0:1ed:e1d2:f10c with SMTP id j14-20020adff00e000000b001ede1d2f10cmr15225292wro.181.1646041575355;
        Mon, 28 Feb 2022 01:46:15 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id n5-20020adffe05000000b001edf8fc0cc3sm9924559wrr.41.2022.02.28.01.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:46:14 -0800 (PST)
Message-ID: <269c748f-e418-8fda-7c50-f15c3e6c604f@canonical.com>
Date:   Mon, 28 Feb 2022 10:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/V2L SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On 27/02/2022 22:23, Lad Prabhakar wrote:
> Document RZ/V2L SDHI bindings. RZ/V2L SDHI is almost identical to one
> found on the R-Car Gen3. No driver changes are required as generic
> compatible string "renesas,rcar-gen3-sdhi" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSi changes have been posted [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227203744.18355-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
