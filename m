Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF60572583
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiGLTSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiGLTSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:18:17 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5805EA17D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:55:54 -0700 (PDT)
Received: from [192.168.1.101] (abxj14.neoplus.adsl.tpnet.pl [83.9.3.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C19943F689;
        Tue, 12 Jul 2022 20:55:51 +0200 (CEST)
Message-ID: <dac53c94-f27b-12ba-970f-99c957a578c6@somainline.org>
Date:   Tue, 12 Jul 2022 20:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220712160919.740878-1-konrad.dybcio@somainline.org>
 <20220712160919.740878-2-konrad.dybcio@somainline.org>
 <0ad65aa0-862d-4b5b-aa35-0323a19ba17a@www.fastmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <0ad65aa0-862d-4b5b-aa35-0323a19ba17a@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.07.2022 20:52, Sven Peter wrote:
> marcan probably has to review this in detail but two comments from me:
> 
> On Tue, Jul 12, 2022, at 18:09, Konrad Dybcio wrote:
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
> 
> I don't quite understand the difference between fast_ipi and ipi_regs.
> Don't we always have fast_ipi suppport when those regs are available?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/irqchip/irq-apple-aic.c?h=next-20220712#n532

Both cases invoke accessing IPI regs, and there was a ipi/no-ipi variant
before, so I didn't want to mess with that.


> 
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
>>  };
>>
>>  static const struct of_device_id aic_info_match[] = {
>> @@ -452,6 +461,9 @@ static unsigned long aic_fiq_get_idx(struct irq_data *d)
>>
>>  static void aic_fiq_set_mask(struct irq_data *d)
>>  {
>> +	if (!aic_irqc->info.el2_regs)
>> +		return;
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
>>  		sysreg_clear_set_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2, 0, 
>> VM_TMR_FIQ_ENABLE_P);
>> @@ -524,12 +539,14 @@ static void __exception_irq_entry 
>> aic_handle_fiq(struct pt_regs *regs)
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
>> +		if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>> +			if (static_branch_likely(&use_fast_ipi)) {
>> +				aic_handle_ipi(regs);
>> +			} else {
>> +				pr_err_ratelimited("Fast IPI fired. Acking.\n");
>> +				write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>> +			}
>>  		}
>>  	}
> 
> This is a pretty hot path and the use_fast_ipi check uses the jump label support
> (static_branch_likely, static_branch_enable) to avoid dereferencing memory here.
> We'll probably want the same for the other features.
> 
> For this branch here the else can probably just be removed: I think that's
> a leftover from when this driver just didn't support fastipi at all even
> when the registers were available.
If there's no use for non-fast-ipi paths, perhaps they can just be removed?
That could simplify the fast_ipi/ipi_regs situation.

Konrad
> 
> 
> 
> Sven
>  
