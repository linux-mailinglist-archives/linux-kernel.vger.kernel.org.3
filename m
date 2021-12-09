Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3299E46E784
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbhLIL0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:26:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57350 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbhLIL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:26:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C02F7B82453
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BDCC004DD;
        Thu,  9 Dec 2021 11:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639048958;
        bh=O1MP/jZT+iP4CkJdmDjsljgxpj4vHoKDEn9+msO/wM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P294UhYKpxbWw0WFvDMWrDL/T6MfhlqNnKVGPQ8P3Z7ZZ+hfspik40BxDTCBh/rxi
         6TQxm2Jejt4fvjCCGXw7y82pDgzM009JJE3pmSHDD9Cxs/7NlxXsBmbhfVIVZPm2bk
         N4Af7QeOraNbUqP31lZtjAn5NzPe+cQ9LegtlzchMORBPTj3NKOGVkQNIkAxI2jfmE
         7u2BVdFlx23AzXUGOVAFmzjBaCCEy/h7GbMYRvH/S6zY5CVRNrIsbjk5Gv+8RK5qY8
         Xc0Eu1kFmCkeF1uwbicAyRRTiFWd3QBgdX7cC11otsI144MXQfin+szwb2ESmP1au5
         /KCjvZDPvPnPA==
Date:   Thu, 9 Dec 2021 11:22:33 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 15/15] KVM: arm64: pkvm: Unshare guest structs during
 teardown
Message-ID: <20211209112233.GD1912@willie-the-truck>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-16-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201170411.1561936-16-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:04:09PM +0000, Quentin Perret wrote:
> Make use of the newly introduced unshare hypercall during guest teardown
> to unmap guest-related data structures from the hyp stage-1.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  2 ++
>  arch/arm64/include/asm/kvm_mmu.h  |  1 +
>  arch/arm64/kvm/arm.c              |  2 ++
>  arch/arm64/kvm/fpsimd.c           | 34 ++++++++++++++++++++++---
>  arch/arm64/kvm/mmu.c              | 42 +++++++++++++++++++++++++++++++
>  arch/arm64/kvm/reset.c            |  8 +++++-
>  6 files changed, 85 insertions(+), 4 deletions(-)

[...]

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index d72566896755..8e506ba8988e 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -344,6 +344,32 @@ static int share_pfn_hyp(u64 pfn)
>  	return ret;
>  }
>  
> +static int unshare_pfn_hyp(u64 pfn)
> +{
> +	struct rb_node **node, *parent;
> +	struct hyp_shared_pfn *this;
> +	int ret = 0;
> +
> +	mutex_lock(&hyp_shared_pfns_lock);
> +	this = find_shared_pfn(pfn, &node, &parent);
> +	if (WARN_ON(!this)) {
> +		ret = -EINVAL;

-ENOENT?

> +		goto unlock;
> +	}
> +
> +	this->count--;
> +	if (this->count)
> +		goto unlock;

Again, if we did an RCU lookup then this could be converted to a refcount_t
to take the mutex only when it hits zero. But for now I think it's fine.

> +
> +	rb_erase(&this->node, &hyp_shared_pfns);
> +	kfree(this);
> +	ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp, pfn, 1);
> +unlock:
> +	mutex_unlock(&hyp_shared_pfns_lock);
> +
> +	return ret;
> +}
> +
>  int kvm_share_hyp(void *from, void *to)
>  {
>  	phys_addr_t start, end, cur;
> @@ -376,6 +402,22 @@ int kvm_share_hyp(void *from, void *to)
>  	return 0;
>  }
>  
> +void kvm_unshare_hyp(void *from, void *to)
> +{
> +	phys_addr_t start, end, cur;
> +	u64 pfn;
> +
> +	if (is_kernel_in_hyp_mode() || kvm_host_owns_hyp_mappings() || !from)

I don't think you need the is_kernel_in_hyp_mode() check any more not that
you've moved that into kvm_host_owns_hyp_mappings().

Will
