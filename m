Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168574702E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242184AbhLJOh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbhLJOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:37:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9A0C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 06:34:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u17so15280488wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 06:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2GRxg5k+GfsTEG/HHuVw87NAnSnT8iO/e9MJjPT+e+o=;
        b=L1Ulimte4Z0H1umx57noMXuSMT9z2pNYcjaEcRkOmHyohqLlZ+Jry54jxw02IUiQ6b
         hZIeoWT+jE63R1PqJaesjr0s292gCWiojZhiGY8yrz8EvqzDidcmdx/BscgF2d0Gsw/c
         z+BcffbPwxmOIHinccz2yA5mfDkPrGDPikdswIP0JX2bHiTzy136GaNEbksFDzmHWkjA
         mM/uKKrvrs0+ilM7xZ5243GOYfYAZCPRIWdDiVy71XqKOxGNran1gLigBpqsktzZZZJL
         NTFLY8vXktAMnsiiuZwJXRS+33761Fln7pNz4LY9Gq37455yUWc28PC2BiTuyxFi8OeG
         LAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2GRxg5k+GfsTEG/HHuVw87NAnSnT8iO/e9MJjPT+e+o=;
        b=y62dCwyW9wM8C7H3Kxwt3cd8cfsKQD9yVH1LbOworJymO7vSm/dtb9HZrPe0SmV+Dz
         xjE68D1ZBGu6z9FDoDfpuQUf8XLdJz8dxDtvq1lQU/dUQ6aNvMOOglho+i9xUWoPXWLp
         jbSeoJ+PZNOuKDVyou8cZQiBQRSsEF5EHdkTIszkyDBlsCmZ6GBPK8ETGb7gM+UQGaXX
         ReF0RNuhD7pkgpxzIKgKzwticE+cTDLjEUorKBcn9SjHvXpREqGGOXCld858FFp/jxHv
         uRDGONcekJe5u4xSIkTJ0qDuZn4RF3YLxegKUhdkQcocv3UYMwxKZoxRwx/MDhX3avYY
         LNng==
X-Gm-Message-State: AOAM53058dHL/kcwSxytvOJ8ENJ1zulpkFBp5p8yl4yMdZbD3xBNqr0K
        KKutgslbuQzPaE6nJ2yhEB7lCQ==
X-Google-Smtp-Source: ABdhPJxiJpf2C0a+T3mNrYtnyB6jDvTMU3ozNfVS8W1q01Qvfry0eiftJK86AH/NRJNix5u8rcTx0A==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr14460951wrt.321.1639146860456;
        Fri, 10 Dec 2021 06:34:20 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:76c1:fb36:1e22:8677])
        by smtp.gmail.com with ESMTPSA id z8sm2918950wrh.54.2021.12.10.06.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:34:20 -0800 (PST)
Date:   Fri, 10 Dec 2021 14:34:16 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 03/15] KVM: arm64: Refcount hyp stage-1 pgtable pages
Message-ID: <YbNlaIczPLXwSCcZ@google.com>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-4-qperret@google.com>
 <20211209102924.GC1833@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209102924.GC1833@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 Dec 2021 at 10:29:24 (+0000), Will Deacon wrote:
> On Wed, Dec 01, 2021 at 05:03:57PM +0000, Quentin Perret wrote:
> > To prepare the ground for allowing hyp stage-1 mappings to be removed at
> > run-time, update the KVM page-table code to maintain a correct refcount
> > using the ->{get,put}_page() function callbacks.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/pgtable.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index f8ceebe4982e..768a58835153 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -408,8 +408,10 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> >  		return false;
> >  
> >  	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> > -	if (hyp_pte_needs_update(old, new))
> > +	if (hyp_pte_needs_update(old, new)) {
> >  		smp_store_release(ptep, new);
> > +		data->mm_ops->get_page(ptep);
> 
> In the case where we're just updating software bits for a valid pte, doesn't
> this result in us taking a spurious reference to the page?

Ahem, yes, that is the case. I ended up with the below diff to fix it,
which I intend to fold in the next version:

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 6ad4cb2d6947..e2047d3f05a2 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -383,21 +383,6 @@ enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte)
        return prot;
 }

-static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
-{
-       /*
-        * Tolerate KVM recreating the exact same mapping, or changing software
-        * bits if the existing mapping was valid.
-        */
-       if (old == new)
-               return false;
-
-       if (!kvm_pte_valid(old))
-               return true;
-
-       return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW);
-}
-
 static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
                                    kvm_pte_t *ptep, struct hyp_map_data *data)
 {
@@ -407,13 +392,16 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
        if (!kvm_block_mapping_supported(addr, end, phys, level))
                return false;

+       data->phys += granule;
        new = kvm_init_valid_leaf_pte(phys, data->attr, level);
-       if (hyp_pte_needs_update(old, new)) {
-               smp_store_release(ptep, new);
+       if (old == new)
+               return true;
+       else if (!kvm_pte_valid(old))
                data->mm_ops->get_page(ptep);
-       }
+       else if (WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW))
+               return false;

-       data->phys += granule;
+       smp_store_release(ptep, new);
        return true;
 }
