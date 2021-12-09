Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF2C46E75F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhLILTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236469AbhLILTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:19:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750F1C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:16:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39F7DB8243C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AFBC004DD;
        Thu,  9 Dec 2021 11:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639048574;
        bh=kDyOftpkmsDk75GoXEVgUx9K1nNqGrcK4DZF+4URS5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQI0P+RkXeUhXDPkrrzoj0GrFMX0eSD1FfDHxzzxFQRopG2Py5EnZHqNLeCygCmlt
         w1TdvhgRi0nUtZ9TguyZMIAAUCZ0TDfoY403LndDgHvFry24vHaduocWwNXIVfiBvC
         EAETbyV52qtYoYXPvmDBxyYuQtFNTrV/kyXglI4xo8bcZ0Q/930S+O8QRY1PTmvh5o
         8+e7JuaNuWMDBSnWME6y7c0y7iKZf58t3+cSsdGU8qRvDyEErXTWUzPMbiARc2s1wo
         E3ILJdQCqfxXka+VRXzLw+ZOyPXKyVirn1diPqca9ArQVFo4mvpFYxq267tCi0aIut
         0BW/N+otnTuJw==
Date:   Thu, 9 Dec 2021 11:16:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 08/15] KVM: arm64: pkvm: Refcount the pages shared
 with EL2
Message-ID: <20211209111609.GC1912@willie-the-truck>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-9-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201170411.1561936-9-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:04:02PM +0000, Quentin Perret wrote:
> In order to simplify the page tracking infrastructure at EL2 in nVHE
> protected mode, move the responsibility of refcounting pages that are
> shared multiple times on the host. In order to do so, let's create a
> red-black tree tracking all the PFNs that have been shared, along with
> a refcount.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/mmu.c | 78 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 68 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index fd868fb9d922..d72566896755 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -284,23 +284,72 @@ static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
>  	}
>  }
>  
> -static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
> +struct hyp_shared_pfn {
> +	u64 pfn;
> +	int count;
> +	struct rb_node node;
> +};
> +
> +static DEFINE_MUTEX(hyp_shared_pfns_lock);
> +static struct rb_root hyp_shared_pfns = RB_ROOT;
> +
> +static struct hyp_shared_pfn *find_shared_pfn(u64 pfn, struct rb_node ***node,
> +					      struct rb_node **parent)
>  {
> -	phys_addr_t addr;
> -	int ret;
> +	struct hyp_shared_pfn *this;
> +
> +	*node = &hyp_shared_pfns.rb_node;
> +	*parent = NULL;
> +	while (**node) {
> +		this = container_of(**node, struct hyp_shared_pfn, node);
> +		*parent = **node;
> +		if (this->pfn < pfn)
> +			*node = &((**node)->rb_left);
> +		else if (this->pfn > pfn)
> +			*node = &((**node)->rb_right);
> +		else
> +			return this;
> +	}
>  
> -	for (addr = ALIGN_DOWN(start, PAGE_SIZE); addr < end; addr += PAGE_SIZE) {
> -		ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
> -					__phys_to_pfn(addr));
> -		if (ret)
> -			return ret;
> +	return NULL;
> +}
> +
> +static int share_pfn_hyp(u64 pfn)
> +{
> +	struct rb_node **node, *parent;
> +	struct hyp_shared_pfn *this;
> +	int ret = 0;
> +
> +	mutex_lock(&hyp_shared_pfns_lock);
> +	this = find_shared_pfn(pfn, &node, &parent);

I don't think this is a fast-path at the moment, but in the future we might
consider using RCU to do the lookup outside of the mutex.

But as-is:

Acked-by: Will Deacon <will@kernel.org>

Will
