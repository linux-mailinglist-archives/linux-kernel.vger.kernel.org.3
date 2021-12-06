Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32E746A132
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376963AbhLFQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:27:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51680 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356635AbhLFQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:26:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6821261373
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F51EC341C1;
        Mon,  6 Dec 2021 16:23:23 +0000 (UTC)
Date:   Mon, 6 Dec 2021 16:23:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     will@kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wuxu.wu@huawei.com, Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] arm64: mm: Use asid2idx() and asid feature macro for
 cleanup
Message-ID: <Ya44+GAmeGBFVAad@arm.com>
References: <4aaabf1b-00c3-3365-e371-9d97dc0c06ab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aaabf1b-00c3-3365-e371-9d97dc0c06ab@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 08:27:23PM +0800, Yunfeng Ye wrote:
> Use asid2idx() and asid feature macro for cleanup.
> 
> No functional change.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  arch/arm64/mm/context.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index cd72576ae2b7..076f14a75bd5 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -50,10 +50,10 @@ static u32 get_cpu_asid_bits(void)
>  		pr_warn("CPU%d: Unknown ASID size (%d); assuming 8-bit\n",
>  					smp_processor_id(),  fld);
>  		fallthrough;
> -	case 0:
> +	case ID_AA64MMFR0_ASID_8:
>  		asid = 8;
>  		break;
> -	case 2:
> +	case ID_AA64MMFR0_ASID_16:
>  		asid = 16;
>  	}

I think this change is fine.

> @@ -162,7 +162,7 @@ static u64 new_context(struct mm_struct *mm)
>  	u64 generation = atomic64_read(&asid_generation);
> 
>  	if (asid != 0) {
> -		u64 newasid = generation | (asid & ~ASID_MASK);
> +		u64 newasid = generation | asid2idx(asid);
> 
>  		/*
>  		 * If our current ASID was active during a rollover, we
> @@ -306,7 +306,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
>  out_unlock:
>  	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> 
> -	asid &= ~ASID_MASK;
> +	asid = asid2idx(asid);

While functionally the code is the same, I don't think this was the
intention of asid2idx(). It's meant to provide an index into asid_map,
while the ASID_MASK lines isolate the asid number and add a new
generation to it.

-- 
Catalin
