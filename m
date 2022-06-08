Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885EE542B86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiFHJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiFHJZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:25:28 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B90FF5BD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:48:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2588mOaN008080;
        Wed, 8 Jun 2022 03:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654678104;
        bh=38zKuLEy+kU1Hx4YD4xQlrtcNMSNGu3IBycOD4u+O9M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=apTS/po4zj63+WbwfTo4KYcotXY/3+TtEnkGd28pPBvAZYhAZB2JH9ybXuR2Pb7g/
         9OeYcG61f1LIhuMKzAGEERWFht5xvKxEGw0QBtUjkWBn3vgOL0PJrwT1y4fMcArCj1
         K8voswFlTiczL52RFfFNoSegpacThXzIivx/KYfs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2588mOe7111425
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jun 2022 03:48:24 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Jun 2022 03:48:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Jun 2022 03:48:24 -0500
Received: from [172.24.145.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2588mLAh084985;
        Wed, 8 Jun 2022 03:48:21 -0500
Message-ID: <0733f59a-497a-351b-0e97-26a2875a5352@ti.com>
Date:   Wed, 8 Jun 2022 14:18:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] irqchip/ti-sci-intr: Add support for system
 suspend/resume PM
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220607061912.12222-1-a-govindraju@ti.com>
 <87sfohyma5.wl-maz@kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <87sfohyma5.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 07/06/22 12:48, Marc Zyngier wrote:
> On Tue, 07 Jun 2022 07:19:12 +0100,
> Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> Add support for system level suspend/resume power management. The
>> interrupt mappings are stored in an array and restored in the system level
>> resume routine. Struct ti_sci_resource_desc can have atmost 2 sets for
>> ranges. Therefore, the mapping array is also formatted such that it can
>> store two sets of ranges.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  drivers/irqchip/irq-ti-sci-intr.c | 108 ++++++++++++++++++++++++++++++
>>  1 file changed, 108 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
>> index fe8fad22bcf9..a8fc6cfb96ca 100644
>> --- a/drivers/irqchip/irq-ti-sci-intr.c
>> +++ b/drivers/irqchip/irq-ti-sci-intr.c
>> @@ -25,6 +25,7 @@
>>   * @dev:	Struct device pointer.
>>   * @ti_sci_id:	TI-SCI device identifier
>>   * @type:	Specifies the trigger type supported by this Interrupt Router
>> + * @mapping:	Pointer to out_irq <-> hwirq mapping table
>>   */
>>  struct ti_sci_intr_irq_domain {
>>  	const struct ti_sci_handle *sci;
>> @@ -32,6 +33,7 @@ struct ti_sci_intr_irq_domain {
>>  	struct device *dev;
>>  	u32 ti_sci_id;
>>  	u32 type;
>> +	u32 *mapping;
>>  };
>>  
>>  static struct irq_chip ti_sci_intr_irq_chip = {
>> @@ -99,6 +101,23 @@ static int ti_sci_intr_xlate_irq(struct ti_sci_intr_irq_domain *intr, u32 irq)
>>  	return -ENOENT;
>>  }
>>  
>> +/**
>> + * ti_sci_intr_free_irq - Free the irq entry in the out_irq <-> hwirq mapping table
>> + * @intr:	IRQ domain corresponding to Interrupt Router
>> + * @out_irq:	Out irq number
>> + */
>> +static void ti_sci_intr_free_irq(struct ti_sci_intr_irq_domain *intr, u16 out_irq)
>> +{
>> +	u16 start = intr->out_irqs->desc->start;
>> +	u16 num = intr->out_irqs->desc->num;
>> +	u16 start_sec = intr->out_irqs->desc->start_sec;
>> +
>> +	if (out_irq < start + num)
>> +		intr->mapping[out_irq - start] = 0xFFFFFFFF;
>> +	else
>> +		intr->mapping[out_irq - start_sec + num] = 0xFFFFFFFF;
>> +}
>> +
>>  /**
>>   * ti_sci_intr_irq_domain_free() - Free the specified IRQs from the domain.
>>   * @domain:	Domain to which the irqs belong
>> @@ -118,11 +137,30 @@ static void ti_sci_intr_irq_domain_free(struct irq_domain *domain,
>>  	intr->sci->ops.rm_irq_ops.free_irq(intr->sci,
>>  					   intr->ti_sci_id, data->hwirq,
>>  					   intr->ti_sci_id, out_irq);
>> +	ti_sci_intr_free_irq(intr, out_irq);
>>  	ti_sci_release_resource(intr->out_irqs, out_irq);
>>  	irq_domain_free_irqs_parent(domain, virq, 1);
>>  	irq_domain_reset_irq_data(data);
>>  }
>>  
>> +/**
>> + * ti_sci_intr_add_irq - Add the irq entry in the out_irq <-> hwirq mapping table
>> + * @intr:	IRQ domain corresponding to Interrupt Router
>> + * @hwirq:	Input irq number
>> + * @out_irq:	Out irq number
>> + */
>> +static void ti_sci_intr_add_irq(struct ti_sci_intr_irq_domain *intr, u32 hwirq, u16 out_irq)
>> +{
>> +	u16 start = intr->out_irqs->desc->start;
>> +	u16 num = intr->out_irqs->desc->num;
>> +	u16 start_sec = intr->out_irqs->desc->start_sec;
>> +
>> +	if (out_irq < start + num)
>> +		intr->mapping[out_irq - start] = hwirq;
>> +	else
>> +		intr->mapping[out_irq - start_sec + num] = hwirq;
>> +}
> 
> I'll bite: you already have a full resource allocator that is used for
> all sort of things. Why isn't this cached by the resource allocator
> itself? Why is this an irqchip specific thing? I expect other users of
> the same API to have the same needs.
> 

As, the resource allocator does not have enough memory to save and
restore all the mappings corresponding various resources, this is being
done on the requester or consumer side.

-- 
Thanks,
Aswath

> 	M.
> 



