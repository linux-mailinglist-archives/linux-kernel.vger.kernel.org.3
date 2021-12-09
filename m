Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6146E699
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhLIKdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhLIKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D00C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:29:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 75352CE1FC8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 10:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0745EC004DD;
        Thu,  9 Dec 2021 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639045769;
        bh=/QmpjCuL6s7njp6n+riNneGXXg+eNgJnvQsS9FTssPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kg0OeLHSNtdKhMVXmUzK4SbKdfW/VPLENXZuwCaVbwkm3WO4VU8H9W5Tis5BKW2/1
         hwLrw/mYRHZXzd3PuTFvKdF6WA4nzlv+icBWWczLcuscBt3cIajskOgByQRmpV+JI8
         ddtFZja/LVZRt7kzrq2fVnqLfl7KTKBDw7GhZfsDLSfsV0FeGSA5xQZBEb3xhl11uB
         mUEl5zf/Ehn3amARhmC8KMYAC8b92UbnjJBS1cNqb7BpI1CwDDaUPZPuZxJtLAR8TU
         ICRbqfkcKDcZjU2UPInYyCCz2OfMr/bCQNJoqNRwi5lBSJ0Qevao1eN9lEBRiQXRhB
         8QJb5R4CJQJOQ==
Date:   Thu, 9 Dec 2021 10:29:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 03/15] KVM: arm64: Refcount hyp stage-1 pgtable pages
Message-ID: <20211209102924.GC1833@willie-the-truck>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-4-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201170411.1561936-4-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:03:57PM +0000, Quentin Perret wrote:
> To prepare the ground for allowing hyp stage-1 mappings to be removed at
> run-time, update the KVM page-table code to maintain a correct refcount
> using the ->{get,put}_page() function callbacks.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index f8ceebe4982e..768a58835153 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -408,8 +408,10 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>  		return false;
>  
>  	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> -	if (hyp_pte_needs_update(old, new))
> +	if (hyp_pte_needs_update(old, new)) {
>  		smp_store_release(ptep, new);
> +		data->mm_ops->get_page(ptep);

In the case where we're just updating software bits for a valid pte, doesn't
this result in us taking a spurious reference to the page?

> @@ -482,8 +485,16 @@ static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>  			   enum kvm_pgtable_walk_flags flag, void * const arg)
>  {
>  	struct kvm_pgtable_mm_ops *mm_ops = arg;
> +	kvm_pte_t pte = *ptep;
> +
> +	if (!kvm_pte_valid(pte))
> +		return 0;
> +
> +	mm_ops->put_page(ptep);
> +
> +	if (kvm_pte_table(pte, level))
> +		mm_ops->put_page(kvm_pte_follow(pte, mm_ops));
>  
> -	mm_ops->put_page((void *)kvm_pte_follow(*ptep, mm_ops));
>  	return 0;

This looks pretty similar to the stage-2 walker now, but given how small the
functions are, I'm not sure we'd really gain much by abstracting the "pte
counted" check.

Will
