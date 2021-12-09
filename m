Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7046E754
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhLILQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbhLILQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:16:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D7C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:13:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5972B8240D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A43C004DD;
        Thu,  9 Dec 2021 11:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639048395;
        bh=ANeJvJaglK5z+Q0sms0vKHiAMCpEobKinM29UMmj+kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s60RD7GDYskSr2bUPl4Kx/pLl11WfPwMgkk8Enj3/7qQfiS5iSS2cOqU/NqanNnYn
         G8Vh7m8J0qjIPmUcfZaxLF9DsLMzyCkd38la1HoUSVnsUdid0fiCoxLXb/RWEHQAn5
         AgqXC41G2nSOQELJGmzuIU/1nSMp5Bbj+i7MsVYmm26stg2cJS1ddkE4s61sVIDx6A
         g4MFWt5Fhpg5JT2PIUOosh3uE/uYuWRZFq/x5bWr8FXFehgAmeDJVbEKrjvdA0rNzr
         N1c1O4ENZhx0H/2eJ/2PegJNpHVVZEn2MZPUCRkG+MSVI8AGCuJWuT6p4pqoO30Uzq
         ITK3b+qwVC4kA==
Date:   Thu, 9 Dec 2021 11:13:10 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 07/15] KVM: arm64: Introduce kvm_share_hyp()
Message-ID: <20211209111309.GB1912@willie-the-truck>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-8-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201170411.1561936-8-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:04:01PM +0000, Quentin Perret wrote:
> The create_hyp_mappings() function can currently be called at any point
> in time. However, its behaviour in protected mode changes widely
> depending on when it is being called. Prior to KVM init, it is used to
> create the temporary page-table used to bring-up the hypervisor, and
> later on it is transparently turned into a 'share' hypercall when the
> kernel has lost control over the hypervisor stage-1. In order to prepare
> the ground for also unsharing pages with the hypervisor during guest
> teardown, introduce a kvm_share_hyp() function to make it clear in which
> places a share hypercall should be expected, as we will soon need a
> matching unshare hypercall in all those places.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |  1 +
>  arch/arm64/kvm/arm.c             |  4 ++--
>  arch/arm64/kvm/fpsimd.c          |  2 +-
>  arch/arm64/kvm/mmu.c             | 27 +++++++++++++++++++++------
>  arch/arm64/kvm/reset.c           |  2 +-
>  5 files changed, 26 insertions(+), 10 deletions(-)

[...]

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index f8f1096a297f..fd868fb9d922 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -299,6 +299,25 @@ static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
>  	return 0;
>  }
>  
> +int kvm_share_hyp(void *from, void *to)
> +{
> +	if (is_kernel_in_hyp_mode())
> +		return 0;
> +
> +	/*
> +	 * The share hcall maps things in the 'fixed-offset' region of the hyp
> +	 * VA space, so we can only share physically contiguous data-structures
> +	 * for now.
> +	 */
> +	if (is_vmalloc_addr(from) || is_vmalloc_addr(to))
> +		return -EINVAL;

If we're adding these sanity checks, perhaps is_vmalloc_or_module_addr()
would be worth using instead?

Will
