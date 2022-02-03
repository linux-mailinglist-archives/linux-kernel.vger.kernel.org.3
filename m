Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64B4A7EE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiBCFYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:24:22 -0500
Received: from foss.arm.com ([217.140.110.172]:50426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbiBCFYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:24:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24D841FB;
        Wed,  2 Feb 2022 21:24:19 -0800 (PST)
Received: from [10.163.44.35] (unknown [10.163.44.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAF003F774;
        Wed,  2 Feb 2022 21:24:17 -0800 (PST)
Subject: Re: [RFC V1 31/31] mm/mmap: Define macros for vm_flags access
 permission combinations
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-32-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <53026c47-4bfa-44fe-1cba-f9c78d901a02@arm.com>
Date:   Thu, 3 Feb 2022 10:54:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1643029028-12710-32-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 6:27 PM, Anshuman Khandual wrote:
> These macros will be useful in cleaning up the all those switch statements
> in vm_get_page_prot() across all platforms.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/mm.h | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6c0844b99b3e..b3691eeec500 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2828,6 +2828,45 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
>  	return (vma && vma->vm_start <= start && end <= vma->vm_end);
>  }
>  
> +/*
> + * Access permission related vm_flags combination is used to map into
> + * platform defined page protection flags. This enumeration helps in
> + * abstracting out possible indices after vm_flags is probed for all
> + * access permission i.e  (VM_SHARED | VM_EXEC | VM_READ | VM_WRITE).
> + *
> + * VM_EXEC ---------------------|
> + *                              |
> + * VM_WRITE ---------------|    |
> + *                         |    |
> + * VM_READ -----------|    |    |
> + *                    |    |    |
> + * VM_SHARED ----|    |    |    |
> + *               |    |    |    |
> + *               v    v    v    v
> + * VMFLAGS_IDX_(S|X)(R|X)(W|X)(E|X)
> + *
> + * X - Indicates that the access flag is absent
> + */
> +enum vmflags_idx {
> +	VMFLAGS_IDX_XXXX,	/* (VM_NONE)                                    */
> +	VMFLAGS_IDX_XRXX,	/* (VM_READ)                                    */
> +	VMFLAGS_IDX_XXWX,	/* (VM_WRITE)                                   */
> +	VMFLAGS_IDX_XRWX,	/* (VM_READ | VM_WRITE)                         */
> +	VMFLAGS_IDX_XXXE,	/* (VM_EXEC)                                    */
> +	VMFLAGS_IDX_XRXE,	/* (VM_EXEC | VM_READ)                          */
> +	VMFLAGS_IDX_XXWE,	/* (VM_EXEC | VM_WRITE)                         */
> +	VMFLAGS_IDX_XRWE,	/* (VM_EXEC | VM_READ | VM_WRITE)               */
> +	VMFLAGS_IDX_SXXX,	/* (VM_SHARED | VM_NONE)                        */
> +	VMFLAGS_IDX_SRXX,	/* (VM_SHARED | VM_READ)                        */
> +	VMFLAGS_IDX_SXWX,	/* (VM_SHARED | VM_WRITE)                       */
> +	VMFLAGS_IDX_SRWX,	/* (VM_SHARED | VM_READ | VM_WRITE)             */
> +	VMFLAGS_IDX_SXXE,	/* (VM_SHARED | VM_EXEC)                        */
> +	VMFLAGS_IDX_SRXE,	/* (VM_SHARED | VM_EXEC | VM_READ)              */
> +	VMFLAGS_IDX_SXWE,	/* (VM_SHARED | VM_EXEC | VM_WRITE)             */
> +	VMFLAGS_IDX_SRWE,	/* (VM_SHARED | VM_EXEC | VM_READ | VM_WRITE)   */
> +	VMFLAGS_IDX_MAX
> +};

Defining platform specific vm_get_page_prot() involves a switch statement
with various vm_flags access combinations as cases. Hence I am wondering,
will it help to use these above macros, instead of existing combinations
separated with '|' flags. I can move this patch earlier in the series and
change all platform switch cases. Please do suggest. Thank you.

- Anshuman
