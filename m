Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A544798FB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 06:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhLRFg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 00:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhLRFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 00:36:26 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B5CC061574;
        Fri, 17 Dec 2021 21:36:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6473C41E96;
        Sat, 18 Dec 2021 05:36:22 +0000 (UTC)
Subject: Re: [PATCH 3/6] irqchip/apple-aic: Switch to irq_domain_create_tree
 and sparse hwirqs
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211209043249.65474-1-marcan@marcan.st>
 <20211209043249.65474-4-marcan@marcan.st> <87r1ahubx5.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <9b2c76bd-5f65-804d-0311-e17513b443f1@marcan.st>
Date:   Sat, 18 Dec 2021 14:36:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87r1ahubx5.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2021 23.37, Marc Zyngier wrote:
>> @@ -75,6 +75,7 @@
>>  #define AIC_EVENT_TYPE		GENMASK(31, 16)
>>  #define AIC_EVENT_NUM		GENMASK(15, 0)
>>  
>> +#define AIC_EVENT_TYPE_FIQ	0 /* Software use */
> 
> What does 'SW use' mean? Are you using the fact that the event
> register never returns 0 in the top bits?

Yeah. Since we're switching to tree IRQs we can use the raw hardware
event as the hwirq, and save some cycles munging fields, but we still
need a place for FIQ hwirq numbers to live. Zero here means "no
IRQ/spurious" to the hardware, so it's a convenient place to stick FIQs.
Note that the top-level IRQ handler function does check this field, so
even if newer hardware starts doing something silly here (which I highly
doubt...) it would never end up forwarded to the IRQ domain code without
further code changes.

>> -	aic_ic_write(ic, AIC_MASK_SET + MASK_REG(irqd_to_hwirq(d)),
>> -		     MASK_BIT(irqd_to_hwirq(d)));
>> +	u32 irq = FIELD_GET(AIC_EVENT_NUM, hwirq);
> 
> This expression is used quite a few times, and could use a helper
> clarifying its purpose (converting the event/hwirq to an index?).
> 'irq' is a bit of a misnomer too, but I struggle to find another
> name...

Ack, I'll add a helper. It's extracting the IRQ number field from the
hwirq number. This is relatively trivial at this point in the patch set
(where the only other field is the constant type = 1), but it makes more
sense once I add the die field later on.

>> @@ -492,13 +497,13 @@ static struct irq_chip fiq_chip = {
>>  static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
>>  			      irq_hw_number_t hw)
>>  {
>> -	struct aic_irq_chip *ic = id->host_data;
>> +	u32 type = FIELD_GET(AIC_EVENT_TYPE, hw);
>>  
>> -	if (hw < ic->nr_hw) {
>> +	if (type == AIC_EVENT_TYPE_HW) {
>>  		irq_domain_set_info(id, irq, hw, &aic_chip, id->host_data,
>>  				    handle_fasteoi_irq, NULL, NULL);
>>  		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
>> -	} else {
>> +	} else if (type == AIC_EVENT_TYPE_FIQ) {
> 
> Do we need to check for FIQ? This should be the case by construction,
> right? If there is a risk that it isn't the case, then we probably
> need a default case (and the whole thing would be better written as a
> switch() statement).

Yes, it should be the case by construction; this can just be an else.
I'll change it.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
