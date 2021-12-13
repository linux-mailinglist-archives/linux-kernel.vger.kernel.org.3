Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C7472CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhLMMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhLMMxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:53:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25C5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47951CE0FF7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0DBC34603;
        Mon, 13 Dec 2021 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639399986;
        bh=BxpFYEalQW7I1obrELsCap0ySUis6eH6NC+wPVvjF5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPDlGBfx6aounopVqMoIeB7/Km5GVGb4un4MmsPLF0z0Jow4ee3Fin+xyvotkZjna
         +HQXYWO7CVHglWL2uH85pacYkVxzgCsNEujYRYb+xUotOZNeh96hUsw/dX3Q1hzUWi
         pC6IuPHdDHrPdzrR7328EnFsoMBrOXRp+hh58MtW3YqFfbpbcPd81QytVcW9CWaBES
         eKK4CoflTQnLfuj64O5Q3A/GKtzVNbPDmTNkc+jtIS88Uj/d2vVJlCiLaKWHFFcyNg
         MqX5q4kkMxxyLMcQ1jVzCd6De2QF2xGEZNuyuA3F4XDYPiIKO2IMar+abiCrki7yfK
         3/rSlp8TN4z6g==
Date:   Mon, 13 Dec 2021 12:53:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 03/15] KVM: arm64: Refcount hyp stage-1 pgtable pages
Message-ID: <20211213125300.GA10915@willie-the-truck>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-4-qperret@google.com>
 <20211209102924.GC1833@willie-the-truck>
 <YbNlaIczPLXwSCcZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbNlaIczPLXwSCcZ@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:34:16PM +0000, Quentin Perret wrote:
> On Thursday 09 Dec 2021 at 10:29:24 (+0000), Will Deacon wrote:
> > On Wed, Dec 01, 2021 at 05:03:57PM +0000, Quentin Perret wrote:
> > > To prepare the ground for allowing hyp stage-1 mappings to be removed at
> > > run-time, update the KVM page-table code to maintain a correct refcount
> > > using the ->{get,put}_page() function callbacks.
> > > 
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/pgtable.c | 17 ++++++++++++++---
> > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > > index f8ceebe4982e..768a58835153 100644
> > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > @@ -408,8 +408,10 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> > >  		return false;
> > >  
> > >  	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> > > -	if (hyp_pte_needs_update(old, new))
> > > +	if (hyp_pte_needs_update(old, new)) {
> > >  		smp_store_release(ptep, new);
> > > +		data->mm_ops->get_page(ptep);
> > 
> > In the case where we're just updating software bits for a valid pte, doesn't
> > this result in us taking a spurious reference to the page?
> 
> Ahem, yes, that is the case. I ended up with the below diff to fix it,
> which I intend to fold in the next version:
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 6ad4cb2d6947..e2047d3f05a2 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -383,21 +383,6 @@ enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte)
>         return prot;
>  }
> 
> -static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
> -{
> -       /*
> -        * Tolerate KVM recreating the exact same mapping, or changing software
> -        * bits if the existing mapping was valid.
> -        */
> -       if (old == new)
> -               return false;
> -
> -       if (!kvm_pte_valid(old))
> -               return true;
> -
> -       return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW);
> -}
> -
>  static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>                                     kvm_pte_t *ptep, struct hyp_map_data *data)
>  {
> @@ -407,13 +392,16 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>         if (!kvm_block_mapping_supported(addr, end, phys, level))
>                 return false;
> 
> +       data->phys += granule;
>         new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> -       if (hyp_pte_needs_update(old, new)) {
> -               smp_store_release(ptep, new);
> +       if (old == new)
> +               return true;
> +       else if (!kvm_pte_valid(old))

(nit: clearer to drop the 'else' part here)

>                 data->mm_ops->get_page(ptep);

Ok, so this works because new is always valid.

LGTM.

Will
