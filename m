Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8768846DA52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhLHRtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhLHRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:49:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED810C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:46:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A603FB82200
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9759FC341C8;
        Wed,  8 Dec 2021 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638985558;
        bh=Jx3EOS//BNcop0ND7pQzMMlMr2gVDNuw8TQ5ywrclRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmNzrKQ3OnYmFnZ2a4Jomabp/a9q/yYrr0HjxsL29TK/HKq9JbbwZ3ySIjYUnI/Rf
         9O1tlLVZmTmyMHxOO88CIxcuz8XvMCTo0yCShgw/35w7i7O3ws/48jZJefRhAgwz1d
         2ZQUnXOH0H+xQstckdT5qaf83wv9Yg8QFtNbdzYH3jalwUGAn/tS+eLDhVSgG/lv3j
         JeAlClg3O55KUtlt74R5f607wI7FCCW02YiBl3GRebbX9Hvdd+zodgSzOV26+fDADx
         1jPUJ2W4SSRHLld+gDMtUlGqszKEh/60YvQ+/SDYjprSMVmzV2bcXHjgH44C9sZ/sR
         rRB2DSjDB6ggg==
Date:   Wed, 8 Dec 2021 17:45:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 4/6] KVM: arm64: Make __io_map_base static
Message-ID: <20211208174552.GD820@willie-the-truck>
References: <20211208152300.2478542-1-qperret@google.com>
 <20211208152300.2478542-5-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208152300.2478542-5-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 03:22:57PM +0000, Quentin Perret wrote:
> The __io_map_base variable is used at EL2 to track the end of the
> hypervisor's "private" VA range in nVHE protected mode. However it
> doesn't need to be used outside of mm.c, so let's make it static to keep
> all the hyp VA allocation logic in one place.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mm.h | 1 -
>  arch/arm64/kvm/hyp/nvhe/mm.c         | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index 3f60d6cc5368..2d08510c6cc1 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -12,7 +12,6 @@
>  
>  extern struct kvm_pgtable pkvm_pgtable;
>  extern hyp_spinlock_t pkvm_pgd_lock;
> -extern u64 __io_map_base;
>  
>  int hyp_create_idmap(u32 hyp_va_bits);
>  int hyp_map_vectors(void);
> diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> index 9e0ff5a700dd..526a7d6fa86f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> @@ -19,11 +19,12 @@
>  
>  struct kvm_pgtable pkvm_pgtable;
>  hyp_spinlock_t pkvm_pgd_lock;
> -u64 __io_map_base;
>  
>  struct memblock_region hyp_memory[HYP_MEMBLOCK_REGIONS];
>  unsigned int hyp_memblock_nr;
>  
> +static u64 __io_map_base;
> +
>  static int __pkvm_create_mappings(unsigned long start, unsigned long size,
>  				  unsigned long phys, enum kvm_pgtable_prot prot)

Acked-by: Will Deacon <will@kernel.org>

Will
