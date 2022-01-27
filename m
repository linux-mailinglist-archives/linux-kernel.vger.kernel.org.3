Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46FB49E279
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbiA0MkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:40:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52376 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241186AbiA0MkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:40:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47B0AB82228
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0858EC340E4;
        Thu, 27 Jan 2022 12:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643287206;
        bh=JnlBSQS1AFrenlZcFKIvZzSqaAGifybnUZXObr1eoag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/v/gSJJHYSymievjsJE2D9V15USSFVUI1g2oB3UR1s4BPya1TcsGj7M4TdbrG3xv
         ztjXQHi3pp8UBwrUZ8obIw0pM8fLI6sx99gHlhSF8jq8AwOKZ53La9gk20/WPxKiiG
         IcbjS+SYB/2tekd19VNeX55R2V4hsxNw2ANt8VuorrTtfXJ1DJHRh3L0wffyPuenxY
         TdbY651ULXJ+kvXGbwb/vuEFuiNsuq6ZbPg4d5zSfykjBTP1LPifQqMygm8es8nGm1
         AHqDuJqYU1npqy3VT3HZXloMaKr3WgFqb1JYUc08m7GAW5TVhH5SqmW+HBmApGHVr0
         twLvNlaYwDx3g==
Date:   Thu, 27 Jan 2022 14:39:59 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [RFC V1 02/31] mm/mmap: Clarify protection_map[] indices
Message-ID: <YfKSn6u3YsErB/Ky@kernel.org>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:26:39PM +0530, Anshuman Khandual wrote:
> protection_map[] maps vm_flags access combinations into page protection
> value as defined by the platform via __PXXX and __SXXX macros. The array
> indices in protection_map[], represents vm_flags access combinations but
> it's not very intuitive to derive. This makes it clear and explicit.

The protection_map is going to be removed in one of the next patches, why
bother with this patch at all?
 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  mm/mmap.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1e8fdb0b51ed..254d716220df 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -102,8 +102,22 @@ static void unmap_region(struct mm_struct *mm,
>   *								x: (yes) yes
>   */
>  pgprot_t protection_map[16] __ro_after_init = {
> -	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
> -	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
> +	[VM_NONE]				= __P000,
> +	[VM_READ]				= __P001,
> +	[VM_WRITE]				= __P010,
> +	[VM_READ|VM_WRITE]			= __P011,
> +	[VM_EXEC]				= __P100,
> +	[VM_EXEC|VM_READ]			= __P101,
> +	[VM_EXEC|VM_WRITE]			= __P110,
> +	[VM_EXEC|VM_READ|VM_WRITE]		= __P111,
> +	[VM_SHARED]				= __S000,
> +	[VM_SHARED|VM_READ]			= __S001,
> +	[VM_SHARED|VM_WRITE]			= __S010,
> +	[VM_SHARED|VM_READ|VM_WRITE]		= __S011,
> +	[VM_SHARED|VM_EXEC]			= __S100,
> +	[VM_SHARED|VM_READ|VM_EXEC]		= __S101,
> +	[VM_SHARED|VM_WRITE|VM_EXEC]		= __S110,
> +	[VM_SHARED|VM_READ|VM_WRITE|VM_EXEC]	= __S111
>  };
>  
>  #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
