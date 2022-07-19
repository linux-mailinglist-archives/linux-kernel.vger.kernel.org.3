Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31A857A437
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiGSQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiGSQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:34:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55067140C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:34:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c3so13137815pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cIwE//DveooqAU0HMFrAfCwz4yvvn2jMSO+PRCV5uAA=;
        b=PEwwMlNHInRzb+NzGQmTE4e7J/kqq0HpeIQIUdH383exk0CVF0HIVS/iQWNXAGu33I
         /2RG6U0OUqvJ5w/e532j31W+IsZkdKwPRvWboeRnkNXISiUDa+z6g32ZAt+u2ijPkgQR
         H+1kgE+JoFwKxkNOVHSwI0FtAypjUuxpFv/Cq10knjZ7jdEGgh0Iy0YWEMMclANFFpy+
         mwmMmNT9UBGLEpQl+JR/ZWG1AFzQq/PjWq/AzvOGqkhlEVhvojHSHbhTuFF89Op1fx+j
         PVYPSXcSif8v+mbbt6m5A8qS1kxZYzm4IHfop4UlJOyhm0rnFY22h8znBemtqPJUP8OX
         pTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cIwE//DveooqAU0HMFrAfCwz4yvvn2jMSO+PRCV5uAA=;
        b=EQx71ZfEC9izRmtr/MSoJrzalrnOOrmZ17igXfCUXtbKarDlw1b8pZydu5egkxfer6
         O8MQI68AYxoMPCgag/G29Ctr3IsjE5V31+4fnnhjx5pkJuOwshlYyTxcfGprwoQXQwUl
         1iugctS+rNKOQgxljgt7jG/xZdJRcDIXxi9OxUPHuWtdM+lJUQ0+5Cig7hQk9fCnyl8X
         DBzPmh2KqShbFx76GaH55wHqWZEW0PXvCYgkAyAUiEXLHYLze4IC1ERIVhD/vk20d+HQ
         3yrGZrgNKpnkczbmJA1YnqGpWpPiuaDEws4pp/rO7+eHR8MKG1E/g4J5B5slA6lqmlJx
         rnTg==
X-Gm-Message-State: AJIora/KeDt+P7G+WP4wmL+6zTjznMZSaFpIovJ0ntc/HluDv1IE+yaQ
        V18XHf836snp2r/nY9PROmA=
X-Google-Smtp-Source: AGRyM1tebxPaL0J4Nx/2nevaQrq4b9OIxPMmRHcxvHSpxjYym9JauqywI7IHlgZa4Yw2oD1S6t6pXQ==
X-Received: by 2002:a63:5302:0:b0:412:219:928f with SMTP id h2-20020a635302000000b004120219928fmr29334650pgb.425.1658248453758;
        Tue, 19 Jul 2022 09:34:13 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id c190-20020a621cc7000000b005289fbef7c4sm12022759pfc.140.2022.07.19.09.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 09:34:13 -0700 (PDT)
Message-ID: <58ca1f97-2bc2-7391-ffeb-514ee053bea9@gmail.com>
Date:   Tue, 19 Jul 2022 09:34:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v3] ARM: Fix MAX_DMA_ADDRESS overflow
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        open list <linux-kernel@vger.kernel.org>, ssantosh@kernel.org,
        ardb@kernel.org, geert+renesas@glider.be
References: <20220706203353.247633-1-f.fainelli@gmail.com>
 <33f4adff-03b0-3726-c4ba-98971ed46b85@gmail.com>
 <CACRpkdYBwi9biXA7efSLonQM36RALeUqj3p+Rv0EFEfVDC=N5w@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CACRpkdYBwi9biXA7efSLonQM36RALeUqj3p+Rv0EFEfVDC=N5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2022 5:53 AM, Linus Walleij wrote:
> On Thu, Jul 14, 2022 at 1:28 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 7/6/22 13:33, Florian Fainelli wrote:
>>> Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
>>> added a check to determine whether arm_dma_zone_size is exceeding the
>>> amount of kernel virtual address space available between the upper 4GB
>>> virtual address limit and PAGE_OFFSET in order to provide a suitable
>>> definition of MAX_DMA_ADDRESS that should fit within the 32-bit virtual
>>> address space. The quantity used for comparison was off by a missing
>>> trailing 0, leading to MAX_DMA_ADDRESS to be overflowing a 32-bit
>>> quantity.
>>>
>>> This was caught thanks to CONFIG_DEBUG_VIRTUAL on the bcm2711 platform
>>> where we define a dma_zone_size of 1GB and we have a PAGE_OFFSET value
>>> of 0xc000_0000 (CONFIG_VMSPLIT_3G) leading to MAX_DMA_ADDRESS being
>>> 0x1_0000_0000 which overflows the unsigned long type used throughout
>>> __pa() and then __virt_addr_valid(). Because the virtual address passed
>>> to __virt_addr_valid() would now be 0, the function would loudly warn
>>> and flood the kernel log, thus making the platform unable to boot
>>> properly.
>>>
>>> Fixes: 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>
>> Shall I send this to RMK's patch system?
> 
> I think so!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9216/1
-- 
Florian
