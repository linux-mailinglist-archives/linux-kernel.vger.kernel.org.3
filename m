Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B335A6335
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiH3MWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiH3MV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:21:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76151E9921
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:21:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 825E41063;
        Tue, 30 Aug 2022 05:21:50 -0700 (PDT)
Received: from [10.57.13.45] (unknown [10.57.13.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DC623F71A;
        Tue, 30 Aug 2022 05:21:42 -0700 (PDT)
Message-ID: <15a6c200-8683-37f4-1e8e-5c6010e90b07@arm.com>
Date:   Tue, 30 Aug 2022 13:21:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 5/4] ARM: footbridge: remove custom DMA address
 handling
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
References: <20220821055326.GA25950@lst.de>
 <20220825201544.1931658-1-arnd@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220825201544.1931658-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-25 21:15, Arnd Bergmann wrote:
[...]
> diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
> index 372600bc15c8..f8920d0010de 100644
> --- a/arch/arm/mach-footbridge/dc21285.c
> +++ b/arch/arm/mach-footbridge/dc21285.c
> @@ -5,6 +5,7 @@
>    *  Copyright (C) 1998-2001 Russell King
>    *  Copyright (C) 1998-2000 Phil Blundell
>    */
> +#include <linux/dma-map-ops.h>
>   #include <linux/kernel.h>
>   #include <linux/pci.h>
>   #include <linux/interrupt.h>
> @@ -241,6 +242,22 @@ static irqreturn_t dc21285_parity_irq(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> +static int dc21285_pci_bus_notifier(struct notifier_block *nb,
> +				    unsigned long action,
> +				    void *data)
> +{
> +	if (action != BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_DONE;
> +
> +	dma_direct_set_offset(data, PHYS_OFFSET, BUS_OFFSET, SZ_256M);

FWIW I've always had it in mind that for this kind of special case the 
platform could just statically allocate the dma_range_map and assign it 
to all devices. However in practice that needs some kfree_const() tweaks 
in the driver core, which I'm sure are out-of-scope for this series, so 
I'm mostly flagging this up to help myself remember that it might be 
worth doing a dma_direct_set_offset() cleanup sweep soon.

As-is the patch at least makes things a lot clearer, and presumably 
there aren't likely to be enough PCI devices for the extra allocations 
to have noticeable impact in the meantime.

Cheers,
Robin.
