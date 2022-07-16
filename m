Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D837C5770E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiGPSwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiGPSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:52:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A05205FD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:52:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q13-20020a17090a304d00b001f1af9a18a2so411086pjl.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/zm5921PIdLyylEWb3UJ2bmy8roH475LevweYH2b69k=;
        b=Y22f83yk8rH+VEbiyo9v6Q1Wy5rno55x07ohaDQqtddX95MFd6xqeOCzYudMoMzzXo
         S2SLZtWwQrEMWuq5AiuIaobMGr6LVWq0MwTNEDd8JC+vbZGVx/WINQUXUIVMQ9ujaZK/
         2xY/PVo2Q/APVp0BpsUAMTeFqH7MqqFf8HUkY1nCGFcCCdbxcZLuVpJLSAu6KGDOXJd3
         Mgvx1Sr3YdklXapWoowk++OENMPR2XCXLaPOpjFFvnXTngDd/vMDH4f1rF1206IA8A48
         ZKebQtdOJsXJotApPuPjw4Ai/SFG8+Otf8+tDgLiI4z1hYOzSGH+vXqkNIMWwlpEtRZf
         xl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/zm5921PIdLyylEWb3UJ2bmy8roH475LevweYH2b69k=;
        b=LrU9pWIKGeDk9nKy5fSpPRm+tgKNNX4boitq+M4etfws/6IErqYdfbv+7Tr6DR0MHe
         LQYQ0So24Ip122rg2XCFo0A8/haT6Z61f6GOWv8qVXAl01V3ClITcA4pjM745bN64824
         zTjZOQDvF42laupDTAcJWANtgCy2ROPUMo2B1mdyTiQzaK3qKDLe7vJYZz8CB3wjRbHB
         otKa2tWFNdJQfn6oFI/qklIKydwF/vCdJ0+pFWdBNHv7k8nLFkeN/xUnnaLrOqRUqz8Y
         fQPPplVDuI2c0G3NVp/qJsUkhycoXgRHZpz1Y0DHR/CX+6rAQl3+rUDeqgBF9osi+aaR
         1+ZA==
X-Gm-Message-State: AJIora/Ow9OAoRbE7RUuc9BUO4cZlAskTuRu+JHNzOeLkefG19UI3d4Q
        yzNzQmjN8DLUR+6sc7EcZXA4SQ==
X-Google-Smtp-Source: AGRyM1t2YcDwu5/4sbq81CNCE8l9/E1XPe/ag7gaSPwza2dhFXd/Dq6+THLo1SLwjOEypCQUotnN5A==
X-Received: by 2002:a17:902:8602:b0:16c:dfae:9afb with SMTP id f2-20020a170902860200b0016cdfae9afbmr3055479plo.35.1657997522166;
        Sat, 16 Jul 2022 11:52:02 -0700 (PDT)
Received: from google.com (59.39.145.34.bc.googleusercontent.com. [34.145.39.59])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090300c100b0016c4fb6e0b2sm5865429plc.55.2022.07.16.11.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 11:52:01 -0700 (PDT)
Date:   Sat, 16 Jul 2022 18:51:58 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Document the "rules" for using
 host_pfn_mapping_level()
Message-ID: <YtMIvgfsgIPWMgGM@google.com>
References: <20220715232107.3775620-1-seanjc@google.com>
 <20220715232107.3775620-3-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715232107.3775620-3-seanjc@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022, Sean Christopherson wrote:
> Add a comment to document how host_pfn_mapping_level() can be used safely,
> as the line between safe and dangerous is quite thin.  E.g. if KVM were
> to ever support in-place promotion to create huge pages, consuming the
> level is safe if the caller holds mmu_lock and checks that there's an
> existing _leaf_ SPTE, but unsafe if the caller only checks that there's a
> non-leaf SPTE.
> 
> Opportunistically tweak the existing comments to explicitly document why
> KVM needs to use READ_ONCE().
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index bebff1d5acd4..d5b644f3e003 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2919,6 +2919,31 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
>  	__direct_pte_prefetch(vcpu, sp, sptep);
>  }
>  
> +/*
> + * Lookup the mapping level for @gfn in the current mm.
> + *
> + * WARNING!  Use of host_pfn_mapping_level() requires the caller and the end
> + * consumer to be tied into KVM's handlers for MMU notifier events!
Since calling this function won't cause kernel crash now, I guess we can
remove the warning sign here, but keep the remaining statement since it
is necessary.
> + *
> + * There are several ways to safely use this helper:
> + *
> + * - Check mmu_notifier_retry_hva() after grabbing the mapping level, before
> + *   consuming it.  In this case, mmu_lock doesn't need to be held during the
> + *   lookup, but it does need to be held while checking the MMU notifier.

but it does need to be held while checking the MMU notifier and
consuming the result.
> + *
> + * - Hold mmu_lock AND ensure there is no in-progress MMU notifier invalidation
> + *   event for the hva.  This can be done by explicit checking the MMU notifier
> + *   or by ensuring that KVM already has a valid mapping that covers the hva.

Yes, more specifically, "mmu notifier sequence counter".
> + *
> + * - Do not use the result to install new mappings, e.g. use the host mapping
> + *   level only to decide whether or not to zap an entry.  In this case, it's
> + *   not required to hold mmu_lock (though it's highly likely the caller will
> + *   want to hold mmu_lock anyways, e.g. to modify SPTEs).
> + *
> + * Note!  The lookup can still race with modifications to host page tables, but
> + * the above "rules" ensure KVM will not _consume_ the result of the walk if a
> + * race with the primary MMU occurs.
> + */
>  static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
>  				  const struct kvm_memory_slot *slot)
>  {
> @@ -2941,16 +2966,19 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
>  	hva = __gfn_to_hva_memslot(slot, gfn);
>  
>  	/*
> -	 * Lookup the mapping level in the current mm.  The information
> -	 * may become stale soon, but it is safe to use as long as
> -	 * 1) mmu_notifier_retry was checked after taking mmu_lock, and
> -	 * 2) mmu_lock is taken now.
> -	 *
> -	 * We still need to disable IRQs to prevent concurrent tear down
> -	 * of page tables.
> +	 * Disable IRQs to prevent concurrent tear down of host page tables,
> +	 * e.g. if the primary MMU promotes a P*D to a huge page and then frees
> +	 * the original page table.
>  	 */
>  	local_irq_save(flags);
>  
> +	/*
> +	 * Read each entry once.  As above, a non-leaf entry can be promoted to
> +	 * a huge page _during_ this walk.  Re-reading the entry could send the
> +	 * walk into the weeks, e.g. p*d_large() returns false (sees the old
> +	 * value) and then p*d_offset() walks into the target huge page instead
> +	 * of the old page table (sees the new value).
> +	 */
>  	pgd = READ_ONCE(*pgd_offset(kvm->mm, hva));
>  	if (pgd_none(pgd))
>  		goto out;
> -- 
> 2.37.0.170.g444d1eabd0-goog
> 
