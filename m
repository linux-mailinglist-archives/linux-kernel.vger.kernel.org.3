Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80F34768BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhLPDgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:36:13 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:47973 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229905AbhLPDgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:36:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jkchen@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V-mPlDd_1639625769;
Received: from 30.225.24.96(mailfrom:jkchen@linux.alibaba.com fp:SMTPD_---0V-mPlDd_1639625769)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Dec 2021 11:36:10 +0800
Message-ID: <ad1ebcc9-dc2f-fda7-ae7a-88725a2d4ebb@linux.alibaba.com>
Date:   Thu, 16 Dec 2021 11:36:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [RFC PATCH] irqchip/gic-v4.1:fix the kdump GIC ITS RAS error for
 ITS BASER2
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        zhangliguang@linux.alibaba.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20211214064716.21407-1-jkchen@linux.alibaba.com>
 <87h7bbk05r.wl-maz@kernel.org>
From:   Jiankang Chen <jkchen@linux.alibaba.com>
In-Reply-To: <87h7bbk05r.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

     we get a ras error in our new arm platform:


INFO:    err_gst:8000000
INFO:      - Found: Uncorrected software error in ITS
INFO:    RAS reg:
INFO:      fr = a1
INFO:      status = 64300101
INFO:        V = 1
INFO:        UE = 1
INFO:        MV = 1
INFO:        UET(Uncorrected Error Type) = 3
INFO:        IERR = 1
INFO:        SERR = 1
INFO:      addr = 0
INFO:      misc0 = 12051
INFO:      misc1 = 0
CPU RAS mm handler: EventId=C4000049
ERROR:   sdei_dispatch_event(327) ret:-1


在 2021/12/14 17:26, Marc Zyngier 写道:
> [+ Lorenzo, just in case...]
>
> Hi Jay,
>
> Thanks for this.
>
> On Tue, 14 Dec 2021 06:47:16 +0000,
> Jay Chen <jkchen@linux.alibaba.com> wrote:
>> We encounter a GIC RAS Error in below flow:
>> (1) Configure ITS related register (including
>> 	GITS_BASER2, GITS_BASER2.valid = 1'b1)
>> (2) Configure GICR related register (including
>> 	GICR_VPROPBASER, GICR_VPROPBASER.valid = 1'b1)
>> The common settings in above 2 register are the same
>> and currently everything is OK
>> (3) Kernel panic and os start the kdump flow.And then os
>> reconfigure ITS related register (including GITS_BASER2,
>> GITS_BASER2.valid = 1'b1). But at this time, gicr_vpropbaser
>> is not initialized, so it is still an old value. At this point,
>> the new value of its_baser2 and the old value of gicr_vpropbaser is
>> different, resulting in its RAS error.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=215327
> I'm sorry, but I don't have any access to this. Please add all the
> relevant details to the commit message and drop the link.
>
> Could you please detail what HW this is on? The architecture
> specification for GICv4.1 doesn't make any mention of RAS error
> conditions, so this must be implementation specific. A reference to
> the TRM of the IP would certainly help.
>
> Now, I think you have identified something interesting, but I'm not
> convinced by the implementation, see below.
>
>> Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index eb0882d15366..c340bbf4427b 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2623,6 +2623,12 @@ static int its_alloc_tables(struct its_node *its)
>>   			return err;
>>   		}
>>   
>> +		if ((i == 2) && is_kdump_kernel() && is_v4_1(its)) {
>> +			val = its_read_baser(its, baser);
>> +			val &= ~GITS_BASER_VALID;
>> +			its_write_baser(its, baser, val);
>> +		}
> This looks like a very odd way to address the issue. You are silently
> disabling the Base Register containing the VPE table, and carry on as
> if nothing happened. What happen if someone starts a guest using
> direct injection at this point? A kdump kernel still is a full fledged
> kernel, and I don't expect it to behave differently.
>
> If we are to make this work, we need to either disable the v4.1
> extension altogether or sanitise the offending registers so that we
> don't leave things in a bad state. My preference is of course the
> latter.
>
> Could you please give this patch a go and let me know if it helps?
>
> Thanks,
>
> 	M.
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index daec3309b014..cb339ace5046 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -920,6 +920,15 @@ static int __gic_update_rdist_properties(struct redist_region *region,
>   {
>   	u64 typer = gic_read_typer(ptr + GICR_TYPER);
>   
> +	/* Boot-time cleanup */
> +	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
> +		u64 val;
> +
> +		val = gicr_read_vpropbaser(ptr + SZ_128K + GICR_VPROPBASER);
> +		val &= ~GICR_VPROPBASER_4_1_VALID;
> +		gicr_write_vpropbaser(val, ptr + SZ_128K + GICR_VPROPBASER);
> +	}
> +

     Thank you for your solution, this approach looks better. Through 
our actual tests, this approach can solve the problem.

     Judging from the GIC code, modifying vpropbaser or baser2 can solve 
the problem, but obviously your modification method is better, thank you;


>   	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
>   
>   	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
>
Tks

Jay


