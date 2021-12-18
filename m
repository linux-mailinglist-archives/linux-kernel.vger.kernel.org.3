Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7232E4798F9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 06:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhLRFbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 00:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhLRFbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 00:31:35 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53956C061574;
        Fri, 17 Dec 2021 21:31:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E0A6E41F5F;
        Sat, 18 Dec 2021 05:31:30 +0000 (UTC)
Subject: Re: [PATCH 2/6] irqchip/apple-aic: Add Fast IPI support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211209043249.65474-1-marcan@marcan.st>
 <20211209043249.65474-3-marcan@marcan.st> <87sfuyt3nh.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <83631cf6-46c5-cd87-c3a7-6b619669a943@marcan.st>
Date:   Sat, 18 Dec 2021 14:31:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87sfuyt3nh.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2021 21.21, Marc Zyngier wrote:
>> +/* MPIDR fields */
>> +#define MPIDR_CPU			GENMASK(7, 0)
>> +#define MPIDR_CLUSTER			GENMASK(15, 8)
> 
> This should be defined in terms of MPIDR_AFFINITY_LEVEL() and co.

Yeah, I found out about that macro from your PMU driver... :)

>> +static const struct aic_info aic1_fipi_info = {
>> +	.version	= 1,
>> +
>> +	.fast_ipi	= true,
> 
> Do you anticipate multiple feature flags like this? If so, maybe we
> should consider biting the bullet and making this an unsigned long
> populated with discrete flags.
> 
> Not something we need to decide now though.

Probably not, but who knows! It's easy to change it later, though.

>>  	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>> -		pr_err_ratelimited("Fast IPI fired. Acking.\n");
>> -		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>> +		if (aic_irqc->info.fast_ipi) {
> 
> On the other hand, this is likely to hit on the fast path. Given that
> we know at probe time whether we support SR-based IPIs, we can turn
> this into a static key and save a few fetches on every IPI. It applies
> everywhere you look at this flag at runtime.

Good point, I'll see about refactoring this to use static keys.

>> +static void aic_ipi_send_fast(int cpu)
>> +{
>> +	u64 mpidr = cpu_logical_map(cpu);
>> +	u64 my_mpidr = cpu_logical_map(smp_processor_id());
> 
> This is the equivalent of reading MPIDR_EL1. My gut feeling is that it
> is a bit faster to access the sysreg than a percpu lookup, a function
> call and another memory access.

Yeah, I saw other IRQ drivers doing this, but I wasn't sure it made
sense over just reading MPIDR_EL1... I'll switch to that.

>> +	u64 idx = FIELD_GET(MPIDR_CPU, mpidr);
>> +
>> +	if (FIELD_GET(MPIDR_CLUSTER, my_mpidr) == cluster)
>> +		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
>> +			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
>> +	else
>> +		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx) | FIELD_PREP(IPI_RR_CLUSTER, cluster),
>> +			       SYS_IMP_APL_IPI_RR_GLOBAL_EL1);
> 
> Don't you need an ISB, either here or in the two callers? At the
> moment, I don't see what will force the execution of these writes, and
> they could be arbitrarily delayed.

Is there any requirement for timeliness sending IPIs? They're going to
another CPU after all, they could be arbitrarily delayed because it has
FIQs masked.

>> -	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit)
>> -		aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
>> +	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit) {
>> +		if (ic->info.fast_ipi)
>> +			aic_ipi_send_fast(smp_processor_id());
> 
> nit: if this is common enough, maybe having an aic_ipi_send_self_fast
> could be better. Needs evaluation though.

I'll do some printing to see how common self-IPIs are when running
common workloads, let's see. If it's common enough it's easy enough to add.

>> +	irqc->info = *(struct aic_info *)match->data;
> 
> Why the copy? All the data is const, and isn't going away.

... for now, but later patches then start computing register offsets and
putting them into this structure :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
