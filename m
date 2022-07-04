Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C03B565285
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiGDKjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiGDKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:39:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5327CDFF6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:39:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65A3BD6E;
        Mon,  4 Jul 2022 03:39:28 -0700 (PDT)
Received: from [10.57.86.91] (unknown [10.57.86.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA66F3F792;
        Mon,  4 Jul 2022 03:39:25 -0700 (PDT)
Message-ID: <99632b76-3039-34a5-7615-b25e716e2621@arm.com>
Date:   Mon, 4 Jul 2022 11:39:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 3/3] iommu/vt-d: Show region type in
 arch_rmrr_sanity_check()
Content-Language: en-GB
To:     Aaron Tomlin <atomlin@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        joro@8bytes.org, will@kernel.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, hpa@zytor.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        atomlin@atomlin.com
References: <20220611204859.234975-1-atomlin@redhat.com>
 <20220611204859.234975-3-atomlin@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220611204859.234975-3-atomlin@redhat.com>
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

On 2022-06-11 21:48, Aaron Tomlin wrote:
> This patch will attempt to describe the region type in the event
> that a given RMRR entry is not within a reserved region.

Hmm, is this useful information for the user? You'd hope the firmware 
vendor knows the memory map already, but either way, is it particularly 
likely that anyone would be noticing and caring about this warning in a 
context where they couldn't just scroll further up the log and 
cross-reference the full memory map listing? If so, it might be worth 
clarifying what that use-case is, since as it stands there doesn't seem 
to be much justification for the "why" here.

> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>   arch/x86/include/asm/iommu.h | 9 ++++++---
>   arch/x86/kernel/e820.c       | 5 +++--
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index bf1ed2ddc74b..d21366644520 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -17,12 +17,15 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>   {
>   	u64 start = rmrr->base_address;
>   	u64 end = rmrr->end_address + 1;
> +	struct e820_entry *entry;
>   
> -	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
> +	entry = __e820__mapped_all(start, end, 0);
> +
> +	if (entry && entry->type == E820_TYPE_RESERVED)
>   		return 0;
>   
> -	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
> -	       start, end - 1);
> +	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%s: %#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
> +	       e820_type_to_string(entry), start, end - 1);
>   	return -EINVAL;
>   }
>   
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 95b994cf80cd..165e9a444bb9 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1073,7 +1073,7 @@ void __init e820__finish_early_params(void)
>   
>   const char *__init e820_type_to_string(struct e820_entry *entry)
>   {
> -	switch (entry->type) {
> +	switch (entry && entry->type) {

Have you tested this for anything other than E820_TYPE_RAM? I think 
sufficiently up-to-date compilers should warn you here anyway.

Robin.

>   	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
>   	case E820_TYPE_RAM:		return "System RAM";
>   	case E820_TYPE_ACPI:		return "ACPI Tables";
> @@ -1083,8 +1083,9 @@ const char *__init e820_type_to_string(struct e820_entry *entry)
>   	case E820_TYPE_PMEM:		return "Persistent Memory";
>   	case E820_TYPE_RESERVED:	return "Reserved";
>   	case E820_TYPE_SOFT_RESERVED:	return "Soft Reserved";
> -	default:			return "Unknown E820 type";
> +	default:			break;
>   	}
> +	return "Unknown E820 type";
>   }
>   
>   static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
