Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F851572627
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiGLTn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiGLTm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:42:59 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66DFF7A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:23:34 -0700 (PDT)
Received: from [192.168.1.101] (abxj14.neoplus.adsl.tpnet.pl [83.9.3.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 163C83F3BC;
        Tue, 12 Jul 2022 21:23:32 +0200 (CEST)
Message-ID: <acd89b38-89e1-f6d6-2f98-01d94d9984bb@somainline.org>
Date:   Tue, 12 Jul 2022 21:23:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220712160919.740878-1-konrad.dybcio@somainline.org>
 <20220712160919.740878-2-konrad.dybcio@somainline.org>
 <87a69e16x1.wl-maz@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <87a69e16x1.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.07.2022 21:12, Marc Zyngier wrote:
> Hi Konrad,
> 
> Please add a cover letter when sending more than a single patch.
> 
> On Tue, 12 Jul 2022 17:09:19 +0100,
> Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>>
>> Add support for A7-A11 SoCs by if-ing out some features only present on
>> A12 & newer (UNCORE2 registers) or M1 & newer (EL2 registers - the
>> older SoCs don't implement EL2).
>>
>> Also, annotate IPI regs support (A11 and newer*) so that the driver can
>> tell whether the SoC supports these (they are written to even if fast
>> IPI is disabled, when the registers are there of course).
>>
>> *A11 is supposed to use this feature, but it is currently not working.
>> That said, it is not yet necessary, especially with only one core up,
>> and it works a-ok using the same featureset as earlier SoCs.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>  drivers/irqchip/irq-apple-aic.c | 54 +++++++++++++++++++++++----------
>>  1 file changed, 38 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
>> index 12dd48727a15..36f4b52addc2 100644
>> --- a/drivers/irqchip/irq-apple-aic.c
>> +++ b/drivers/irqchip/irq-apple-aic.c
>> @@ -245,7 +245,10 @@ struct aic_info {
>>  	u32 die_stride;
>>  
>>  	/* Features */
>> +	bool el2_regs;
>>  	bool fast_ipi;
>> +	bool ipi_regs;
>> +	bool uncore2_regs;
>>  };
>>  
>>  static const struct aic_info aic1_info = {
>> @@ -261,7 +264,10 @@ static const struct aic_info aic1_fipi_info = {
>>  	.event		= AIC_EVENT,
>>  	.target_cpu	= AIC_TARGET_CPU,
>>  
>> +	.el2_regs	= true,
>>  	.fast_ipi	= true,
>> +	.ipi_regs	= true,
>> +	.uncore2_regs	= true,
>>  };
>>  
>>  static const struct aic_info aic2_info = {
>> @@ -269,7 +275,10 @@ static const struct aic_info aic2_info = {
>>  
>>  	.irq_cfg	= AIC2_IRQ_CFG,
>>  
>> +	.el2_regs	= true,
>>  	.fast_ipi	= true,
>> +	.ipi_regs	= true,
>> +	.uncore2_regs	= true,
> 
> So to sum it up, all recent cores have all the cool features, and the
> older ones have none of them. Surely we can do better than adding 3
> fields that have the same value. Turn 'fast_ipi' into something that
> means 'full_fat', and key everything on that.
> 
> And if this is meant to evolve into a more differentiated set of
> features, the usual idiom is to have a set of flags as part of an
> unsigned long instead of a set of booleans.
The latter would be true if a bootrom exploit or any equivalent means
of booting Linux would be found for A12 (M1 is family with A14 for context).

We can think of 4 feature levels, I think:

A7-A10: 'nothing fancy'
A11: fast_ipi (broken currently, need to investigate)
A12: A11 + UNCORE2 regs
M1+: A12 + EL2

We *could* squash the A12-A14 case into M1, but then if a means of booting
Linux appears, this would have to be untangled again..

> 
>>  };
>>  
>>  static const struct of_device_id aic_info_match[] = {
>> @@ -452,6 +461,9 @@ static unsigned long aic_fiq_get_idx(struct irq_data *d)
>>  
>>  static void aic_fiq_set_mask(struct irq_data *d)
>>  {
>> +	if (!aic_irqc->info.el2_regs)
>> +		return;
> 
> Why? AIC_TMR_EL02_PHYS is defined as the interrupt that fires in the
> context of a guest. There is no guest here (no EL2 either), so what
> you should have as interrupt number is AIC_TMR_EL0_{PHYS,VIRT}, and
> this change becomes irrelevant (nothing to mask). Which is also what
> happens when running an M1 under the m1n1 hypervisor.
This func accesses impl-defined regs that are not present on earlier SoCs.

> 
>> +
>>  	/* Only the guest timers have real mask bits, unfortunately. */
>>  	switch (aic_fiq_get_idx(d)) {
>>  	case AIC_TMR_EL02_PHYS:
>> @@ -469,6 +481,9 @@ static void aic_fiq_set_mask(struct irq_data *d)
>>  
>>  static void aic_fiq_clear_mask(struct irq_data *d)
>>  {
>> +	if (!aic_irqc->info.el2_regs)
>> +		return;
>> +
>>  	switch (aic_fiq_get_idx(d)) {
>>  	case AIC_TMR_EL02_PHYS:
>>  		sysreg_clear_set_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2, 0, VM_TMR_FIQ_ENABLE_P);
>> @@ -524,12 +539,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>>  	 * we check for everything here, even things we don't support yet.
>>  	 */
>>  
>> -	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>> -		if (static_branch_likely(&use_fast_ipi)) {
>> -			aic_handle_ipi(regs);
>> -		} else {
>> -			pr_err_ratelimited("Fast IPI fired. Acking.\n");
>> -			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>> +	if (aic_irqc->info.ipi_regs) {
> 
> This is probably the hottest path in the whole kernel. Do we want an
> extra read here? Absolutely not. At the very least, this should be a
> static key.
Yeah, makes sense..


> 
>> +		if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>> +			if (static_branch_likely(&use_fast_ipi)) {
>> +				aic_handle_ipi(regs);
>> +			} else {
>> +				pr_err_ratelimited("Fast IPI fired. Acking.\n");
>> +				write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>> +			}
>>  		}
>>  	}
>>  
>> @@ -566,12 +583,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>>  					  AIC_FIQ_HWIRQ(irq));
>>  	}
>>  
>> -	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
>> -			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>> -		/* Same story with uncore PMCs */
>> -		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
>> -		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> -				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>> +	if (aic_irqc->info.uncore2_regs) {
> 
> Same thing.
> 
>> +		if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
>> +				(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>> +			/* Same story with uncore PMCs */
>> +			pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
>> +			sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> +					FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>> +		}
>>  	}
>>  }
>>  
>> @@ -676,7 +695,8 @@ static int aic_irq_domain_translate(struct irq_domain *id,
>>  				break;
>>  			case AIC_TMR_HV_PHYS:
>>  			case AIC_TMR_HV_VIRT:
>> -				return -ENOENT;
>> +				if (aic_irqc->info.el2_regs)
>> +					return -ENOENT;
> 
> See my comment above about the use of these interrupt numbers.
`if (!is_kernel_in_hyp_mode()) {` always evaluates to true, since there's
no EL2. Hence, accessing AIC_TMR_HV_{VIRT,PHYS} makes this return ENOENT,
which means timer can't probe and that's no bueno.


> 
>>  			default:
>>  				break;
>>  			}
>> @@ -944,7 +964,8 @@ static int aic_init_cpu(unsigned int cpu)
>>  	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
>>  
>>  	/* Pending Fast IPI FIQs */
>> -	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>> +	if (aic_irqc->info.ipi_regs)
>> +		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>>  
>>  	/* Timer FIQs */
>>  	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
>> @@ -965,8 +986,9 @@ static int aic_init_cpu(unsigned int cpu)
>>  			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
>>  
>>  	/* Uncore PMC FIQ */
>> -	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> -			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>> +	if (aic_irqc->info.uncore2_regs)
>> +		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> +				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>>  
>>  	/* Commit all of the above */
>>  	isb();
> 
> I must be missing something though. Where is the code that actually
> enables support for the SoCs mentioned in $SUBJECT?
In this peculiar case, enabling support means stripping away the so-called
'features', otherwise the interrupt controller won't budge.

Konrad
> 
> Thanks,
> 
> 	M.
> 
