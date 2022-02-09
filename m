Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4C4AFF5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiBIVqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:46:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiBIVqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:46:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 245AFC03BFF4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:46:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2D59ED1;
        Wed,  9 Feb 2022 13:46:05 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1F5E3F73B;
        Wed,  9 Feb 2022 13:46:02 -0800 (PST)
Message-ID: <9d0d5c82-f609-576f-b1ed-d4c2b4f2340e@arm.com>
Date:   Wed, 9 Feb 2022 21:45:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 1/1] perf/smmuv3: Don't cast parameter in bit
 operations
Content-Language: en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>
References: <20220209184758.56578-1-andriy.shevchenko@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220209184758.56578-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-09 18:47, Andy Shevchenko wrote:
> While in this particular case it would not be a (critical) issue,
> the pattern itself is bad and error prone in case somebody blindly
> copies to their code.
> 
> Don't cast parameter to unsigned long pointer in the bit operations.
> Instead copy to a local variable on stack of a proper type and use.

Seems reasonable, in fact in my build it appears to save a spill and 
reload from the stack so the code actually gets a teeny bit better. Not 
sure a cleanup warrants a "Fixes" tag, but either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Note, new compilers might warn on this line for potential outbound access.
> 
> Fixes: 7d839b4b9e00 ("perf/smmuv3: Add arm64 smmuv3 pmu driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index c49108a72865..00d4c45a8017 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -654,6 +654,7 @@ static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>   static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
>   {
>   	struct smmu_pmu *smmu_pmu = data;
> +	DECLARE_BITMAP(ovs, BITS_PER_TYPE(u64));
>   	u64 ovsr;
>   	unsigned int idx;
>   
> @@ -663,7 +664,8 @@ static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
>   
>   	writeq(ovsr, smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
>   
> -	for_each_set_bit(idx, (unsigned long *)&ovsr, smmu_pmu->num_counters) {
> +	bitmap_from_u64(ovs, ovsr);
> +	for_each_set_bit(idx, ovs, smmu_pmu->num_counters) {
>   		struct perf_event *event = smmu_pmu->events[idx];
>   		struct hw_perf_event *hwc;
>   
