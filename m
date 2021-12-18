Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02934798FD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 06:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhLRFhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 00:37:47 -0500
Received: from marcansoft.com ([212.63.210.85]:36458 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhLRFhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 00:37:47 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 899E741E96;
        Sat, 18 Dec 2021 05:37:42 +0000 (UTC)
Subject: Re: [PATCH 4/6] irqchip/apple-aic: Dynamically compute register
 offsets
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211209043249.65474-1-marcan@marcan.st>
 <20211209043249.65474-5-marcan@marcan.st> <87pmq1u1al.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <392e04a4-f786-f1f9-83a1-b587f0e1d505@marcan.st>
Date:   Sat, 18 Dec 2021 14:37:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87pmq1u1al.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2021 03.26, Marc Zyngier wrote:
> On Thu, 09 Dec 2021 04:32:47 +0000,
> Hector Martin <marcan@marcan.st> wrote:
>>
>> This allows us to support AIC variants with different numbers of IRQs
>> based on capability registers.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>  drivers/irqchip/irq-apple-aic.c | 73 +++++++++++++++++++++++++--------
>>  1 file changed, 56 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
>> index 572d1af175fc..d03caed51d56 100644
>> --- a/drivers/irqchip/irq-apple-aic.c
>> +++ b/drivers/irqchip/irq-apple-aic.c
>> @@ -312,12 +326,15 @@ static int aic_irq_set_affinity(struct irq_data *d,
>>  	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
>>  	int cpu;
>>  
>> +	if (!ic->info.target_cpu)
>> +		return -EINVAL;
> 
> Can this even happen? And if it did, this should scream loudly,
> shouldn't it?

Yeah, it can't happen, so this really should be a BUG_ON. This is mostly
there in case somehow we end up with confusion between AIC versions and
register offsets later, since AIC2 does not use this field but also
shouldn't be setting up an irqchip that calls this function.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
