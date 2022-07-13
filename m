Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7311957400D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiGMX2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiGMX2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:28:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90B115E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:28:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so6288617pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ak4pD1sAGbJtouTYh24ktcQT5ElV0uX7d0TTbsmyB58=;
        b=pqa6ldT5NaD86r8Y1W0Wofi29CJt2zdiWEh6vBWatwROIEnPY27k0T3HvgqPWuVp0R
         kG6u3AJmLULZsV+9U9kruwRiGIu17wlwVq/p0MTU0xFBzuCAKPInpWr4cKxKn2sgSl8Y
         K80+Lk+EMaIeLmlZXi1/sFSDA4Yyd8SImO746ASrs/EcBPW5ls0c0BLMBm59ocB8BSrC
         vdImrW5lh6ldNflGBfdUiKiMhkE/vqlCTPPTSjSRDq+rdaMcksBd9Gr3MdH5XQ7NrzQj
         o0GWuXSyzFZr4UuW7ILbC8/qHfrWzEB5KMOgxbKQHgM3M/Gos02gPueJpdRccRbff6E4
         FluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ak4pD1sAGbJtouTYh24ktcQT5ElV0uX7d0TTbsmyB58=;
        b=omoadw+s05zf4WRAx0jrwrGVHlhPTgMX6aSEeIeqEL4SZGHHFQmJhAGrDk4QeE6BuL
         LMY2nHMGefyTUIfZjRgAH6+miSW7iKucMbJtqd4mOpyiGF2ZKLoBH2qp4ltBgNH69SzV
         mZPv7KfUKZ7CB6FXdVLBXTOCYcJGkHxYI2YmCPvoDZRSCf55xkdrszDqp0EsGwEYISU/
         l5CdycNaqYVXOHxSAcUngkEZSVH7vUZdfCkuaB/apIAtI+URdNVZ7pi2i7tjHfZ3iw/7
         MmFFIj4HRq7mc7mGEPaGu7LPd+sGs0IRlTfw6CD0/Xb5F7pswAYBy24Q1P3u0UttPeNs
         rdPA==
X-Gm-Message-State: AJIora9H8TYA2GpRKBRxtlTH0o+tBBbXE/ieYWPU00BnuqezDUI6lF7A
        IdgO0IRqoF/6Fya9uAqk620=
X-Google-Smtp-Source: AGRyM1ujrgEttQKAJ20SLXjXBkhFc0OlcYTMW+Yr85LgtCZmvPqmTdhr3O9uyXL0UewXMGxxkaAo8Q==
X-Received: by 2002:a17:90b:4f81:b0:1f0:1c35:6ae1 with SMTP id qe1-20020a17090b4f8100b001f01c356ae1mr12930742pjb.2.1657754922295;
        Wed, 13 Jul 2022 16:28:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id lp2-20020a17090b4a8200b001e87bd6f6c2sm2028899pjb.50.2022.07.13.16.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 16:28:41 -0700 (PDT)
Message-ID: <33f4adff-03b0-3726-c4ba-98971ed46b85@gmail.com>
Date:   Wed, 13 Jul 2022 16:28:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] ARM: Fix MAX_DMA_ADDRESS overflow
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        open list <linux-kernel@vger.kernel.org>, ssantosh@kernel.org,
        ardb@kernel.org, linus.walleij@linaro.org, geert+renesas@glider.be
References: <20220706203353.247633-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220706203353.247633-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/22 13:33, Florian Fainelli wrote:
> Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> added a check to determine whether arm_dma_zone_size is exceeding the
> amount of kernel virtual address space available between the upper 4GB
> virtual address limit and PAGE_OFFSET in order to provide a suitable
> definition of MAX_DMA_ADDRESS that should fit within the 32-bit virtual
> address space. The quantity used for comparison was off by a missing
> trailing 0, leading to MAX_DMA_ADDRESS to be overflowing a 32-bit
> quantity.
> 
> This was caught thanks to CONFIG_DEBUG_VIRTUAL on the bcm2711 platform
> where we define a dma_zone_size of 1GB and we have a PAGE_OFFSET value
> of 0xc000_0000 (CONFIG_VMSPLIT_3G) leading to MAX_DMA_ADDRESS being
> 0x1_0000_0000 which overflows the unsigned long type used throughout
> __pa() and then __virt_addr_valid(). Because the virtual address passed
> to __virt_addr_valid() would now be 0, the function would loudly warn
> and flood the kernel log, thus making the platform unable to boot
> properly.
> 
> Fixes: 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Shall I send this to RMK's patch system?
-- 
Florian
