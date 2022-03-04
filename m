Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1947D4CD8FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbiCDQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbiCDQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:21:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC2160FE8;
        Fri,  4 Mar 2022 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3nx/4EjCT1WRnAbdK5B+QhYx3aB9p2jPUVgIs1XaPe8=; b=Tf4WsORJlbxFmdqRP3ReSVZHBT
        nQlwFzKCRUEzwP7ODV0Acd7wfi5ZFKQSer4AYIl9wZixg+FFp8TQ8ElcRbcbUk+OGWrtjG5T3K33h
        I1am+nyXyXSOmuTPK7/V5D4UypDkAs/n2dymry7to2NQWZIusrsfrHARkH/tM0kZGZaQRg6u+P2CV
        BUAuKP758rcllfU1lMwWB8hOvClN/cXE5YgKzAKji+kuS5a3LSjzkTnosq+4XEZLB7Bij/XDF73lF
        gwGtpUVczrvcSNHFeAsL+VnCvKcehD3t1/NbVUW6SwrqvbsixJsxUBrXKfeLxz9ro62ZCE8vXekI9
        k6SgfAMg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQAf2-00CmEl-QK; Fri, 04 Mar 2022 16:20:09 +0000
Message-ID: <bc6899cb-21c2-17d0-b886-c5d7ae33d2de@infradead.org>
Date:   Fri, 4 Mar 2022 08:20:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] m68k: tweak coldfire/device.c for COMPILE_TEST
Content-Language: en-US
To:     Greg Ungerer <gerg@linux-m68k.org>, linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Angelo Dureghello <angelo@sysam.it>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
References: <20220304033531.28667-1-rdunlap@infradead.org>
 <cbdbb347-b510-131f-e961-09f1545fb891@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cbdbb347-b510-131f-e961-09f1545fb891@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/22 06:45, Greg Ungerer wrote:
> Hi Randy,
> 
> On 4/3/22 13:35, Randy Dunlap wrote:
>> When CONFIG_MCF_EDMA is set (due to COMPILE_TEST, not due to
>> CONFIG_M5441x), coldfire/device.c has compile errors due to
>> missing MCFEDMA_* symbols. In the .config file that was provided,
>> CONFIG_M5206=y, not CONFIG_M5441x, so <asm/m5441xsim.h> is not
>> included in coldfire/device.c.
>>
>> Only build the MCF_EDMA code in coldfire/device.c if both MCF_EDMA
>> and M5441x are enabled.
>>
>> Fixes these build errors:
>>
>> ../arch/m68k/coldfire/device.c:512:35: error: 'MCFEDMA_BASE' undeclared here (not in a function); did you mean 'MCFDMA_BASE1'?
>>    512 |                 .start          = MCFEDMA_BASE,
>> ../arch/m68k/coldfire/device.c:513:50: error: 'MCFEDMA_SIZE' undeclared here (not in a function)
>>    513 |                 .end            = MCFEDMA_BASE + MCFEDMA_SIZE - 1,
>> ../arch/m68k/coldfire/device.c:517:35: error: 'MCFEDMA_IRQ_INTR0' undeclared here (not in a function)
>>    517 |                 .start          = MCFEDMA_IRQ_INTR0,
>> ../arch/m68k/coldfire/device.c:523:35: error: 'MCFEDMA_IRQ_INTR16' undeclared here (not in a function)
>>    523 |                 .start          = MCFEDMA_IRQ_INTR16,
>> ../arch/m68k/coldfire/device.c:529:35: error: 'MCFEDMA_IRQ_INTR56' undeclared here (not in a function)
>>    529 |                 .start          = MCFEDMA_IRQ_INTR56,
>> ../arch/m68k/coldfire/device.c:535:35: error: 'MCFEDMA_IRQ_ERR' undeclared here (not in a function)
>>    535 |                 .start          = MCFEDMA_IRQ_ERR,
>>
>> Fixes: d7e9d01ac292 ("m68k: add ColdFire mcf5441x eDMA platform support")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: lore.kernel.org/r/202203030252.P752DK46-lkp@intel.com
>> Cc: Angelo Dureghello <angelo@sysam.it>
>> Cc: Greg Ungerer <gerg@kernel.org>
>> Cc: Greg Ungerer <gerg@linux-m68k.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: linux-m68k@lists.linux-m68k.org
>> Cc: uclinux-dev@uclinux.org
>> ---
>>   arch/m68k/coldfire/device.c |    6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> --- linux-next-20220303.orig/arch/m68k/coldfire/device.c
>> +++ linux-next-20220303/arch/m68k/coldfire/device.c
>> @@ -480,7 +480,7 @@ static struct platform_device mcf_i2c5 =
>>   #endif /* MCFI2C_BASE5 */
>>   #endif /* IS_ENABLED(CONFIG_I2C_IMX) */
>>   -#if IS_ENABLED(CONFIG_MCF_EDMA)
>> +#if IS_ENABLED(CONFIG_MCF_EDMA) && IS_ENABLED(CONFIG_M5441x)
> 
> I really try to avoid making these ColdFire SoC specific. Freescale has
> a habit of using the same hardware blocks across a number of parts.
> The model so far has been to let the Kconfig select these out as required
> (and so not having to conditionally duplicate that here).
> 
> I would prefer it to be conditional on !COMPILE_TEST if that is what
> is ultimately causing the problem.

What is ultimately causing the problem is drivers/dma/Kconfig:

config MCF_EDMA
	tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
	depends on M5441x || COMPILE_TEST


Would you prefer to just remove that COMPILE_TEST?

Or do like Geert suggested -- see your previous patch:
commit 322c512f476f07e9 ("m68knommu: include SDHC support only when hardware has it")

thanks.

-- 
~Randy
