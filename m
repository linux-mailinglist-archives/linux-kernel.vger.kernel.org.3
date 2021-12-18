Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444D44798FF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 06:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhLRFjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 00:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhLRFjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 00:39:11 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5FDC061574;
        Fri, 17 Dec 2021 21:39:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E09AA41E96;
        Sat, 18 Dec 2021 05:39:06 +0000 (UTC)
Subject: Re: [PATCH 5/6] irqchip/apple-aic: Support multiple dies
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211209043249.65474-1-marcan@marcan.st>
 <20211209043249.65474-6-marcan@marcan.st> <87mtl4jxjt.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <d9f96032-c20c-beb0-feba-a66a9b17af0c@marcan.st>
Date:   Sat, 18 Dec 2021 14:39:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87mtl4jxjt.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 01.10, Marc Zyngier wrote:
>>  	switch (fwspec->param[0]) {
>>  	case AIC_IRQ:
>> -		if (fwspec->param[1] >= ic->nr_irq)
>> +		if (die >= ic->nr_die)
>> +			return -EINVAL;
>> +		if (args[0] >= ic->nr_irq)
>>  			return -EINVAL;
>> -		*hwirq = (FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_HW) |
>> -			  FIELD_PREP(AIC_EVENT_NUM, fwspec->param[1]));
>> +		*hwirq = AIC_IRQ_HWIRQ(die, args[0]);
>>  		break;
> 
> A side issue with this is that it breaks MSIs, due to the way we
> construct the intspec (I did hit that when upgrading the M1 intspec to
> 4 cells for the PMU). I have the following hack locally:
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index b090924b41fe..f7b4a67b13cf 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -218,7 +218,7 @@ static int apple_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	if (hwirq < 0)
>  		return -ENOSPC;
>  
> -	fwspec.param[1] += hwirq;
> +	fwspec.param[1 + (fwspec.param_count == 4)] += hwirq;
>  
>  	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &fwspec);
>  	if (ret)
> 

Heh, I never noticed; probably because I guess the SD card reader on the
machine I've been testing this on doesn't use MSIs, and I haven't tried
WiFi yet.

Perhaps (fwspec.param_count - 2)? It's probably a safer long-term
assumption that the last two cells will always be leaf IRQ number and type.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
