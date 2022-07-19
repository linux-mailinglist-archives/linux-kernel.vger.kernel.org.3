Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE7D57AA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiGSX0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGSX0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:26:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D884C61E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:26:11 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bf13so14847904pgb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PM1UIW/9p/KUWefznS8I/Vq/Z9Bej0JfhvLfrVgUsW8=;
        b=kDZo7JSCmfah4JxNQpJKDMOKar26uH83fxvBnE7IY4ORxp6fMz6/61Kr7FPDqEozmj
         sx4iGnYTk8B9T5tAbrEqjS7e3zg/SVABzZBk2gjhJILlwhTZCHtdaEf5YLdNfOxW6nCJ
         cCByboTNBYvcR4S+UzcIgkZJ7A26oQV5y6ixW2zE48inV1z6r8hZYHiN7qlDUYUWFG1T
         xycin1HJE6FhlALSuyfUPt5tVvHXhho9N17Hl1bi2ZQARyDpgSk66yiWjNHrhQ0tUgwI
         laWDfSlBFBduN3e4JjihS6/+wmXthMTTc+tQKPgDfZABWdnWyptqekT37iMs/t7fUvED
         HNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PM1UIW/9p/KUWefznS8I/Vq/Z9Bej0JfhvLfrVgUsW8=;
        b=vDYVJtCtPqWT4eWwG/dN+y6ONES/h6SEN5h//qjBSRTJ2inMITu7+brxdrJDDVlMfE
         7yaPp3IRreluxFm4S0B/UTi8uxi3iB3uaHcpOUpUSjsdztlNJL8wFVmnelY36UwshiXK
         GaH2QfOV/ZFvyd4+yGp7rElezH0DH9mJhpJbY2tksyFzctEFri/PopEiq0hjGNNqlVyZ
         FR/U8HKoZgP7FwWXmO7vomA+Mxp4Cp+8JomymauaeQGCxL2V4W7zfJWB4m2jx7XZNzeH
         rA3+lI5zQWxJGR4TpB3AyBvxqHo8wcsAEJu3ZQuGhJ6nmsLLv01T1RWPWYdru9yHUxZF
         /JGg==
X-Gm-Message-State: AJIora+kRIGGpGJFL3gxx6bil2ChtnsVK6TfYpCTJHf/MeYoBwLR/KA+
        clsZFuiopNMJAtjhhVwLLaTyXQ==
X-Google-Smtp-Source: AGRyM1ucHijIu37DL/MH9UJmtOsA3/neF6OFfejOM0jONFSxXqH0qt9+o2M9YhwPtQcambswVMkM1w==
X-Received: by 2002:a05:6a00:15d2:b0:52b:8dc:6cd4 with SMTP id o18-20020a056a0015d200b0052b08dc6cd4mr36444238pfu.68.1658273171197;
        Tue, 19 Jul 2022 16:26:11 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id a4-20020aa79704000000b00529cbfc8b38sm12085292pfg.191.2022.07.19.16.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:26:10 -0700 (PDT)
Date:   Tue, 19 Jul 2022 23:26:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH V3 11/12] KVM: X86/MMU: Don't use mmu->pae_root when
 shadowing PAE NPT in 64-bit host
Message-ID: <Ytc9j/ayzTfm6Rti@google.com>
References: <20220521131700.3661-1-jiangshanlai@gmail.com>
 <20220521131700.3661-12-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521131700.3661-12-jiangshanlai@gmail.com>
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

On Sat, May 21, 2022, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Allocate the tables when allocating the local shadow page.

This absolutely needs a much more verbose changelog.

> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 63c2b2c6122c..73e6a8e1e1a9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1809,10 +1809,12 @@ static bool using_local_root_page(struct kvm_mmu *mmu)
>   * 2 or 3 levels of local shadow pages on top of non-local shadow pages.
>   *
>   * Local shadow pages are locally allocated.  If the local shadow page's level
> - * is PT32E_ROOT_LEVEL, it will use the preallocated mmu->pae_root for its
> - * sp->spt.  Because sp->spt may need to be put in the 32 bits CR3 (even in
> - * x86_64) or decrypted.  Using the preallocated one to handle these
> - * requirements makes the allocation simpler.
> + * is PT32E_ROOT_LEVEL, and it is not shadowing nested NPT for 32-bit L1 in
> + * 64-bit L0 (or said when the shadow pagetable's level is PT32E_ROOT_LEVEL),
> + * it will use the preallocated mmu->pae_root for its sp->spt.  Because sp->spt
> + * need to be put in the 32-bit CR3 (even in 64-bit host) or decrypted.  Using
> + * the preallocated one to handle these requirements makes the allocation
> + * simpler.
>   *
>   * Local shadow pages are only visible to local VCPU except through
>   * sp->parent_ptes rmap from their children, so they are not in the
> @@ -1852,13 +1854,12 @@ kvm_mmu_alloc_local_shadow_page(struct kvm_vcpu *vcpu, union kvm_mmu_page_role r
>  	sp->gfn = 0;
>  	sp->role = role;
>  	/*
> -	 * Use the preallocated mmu->pae_root when the shadow page's
> -	 * level is PT32E_ROOT_LEVEL which may need to be put in the 32 bits
> +	 * Use the preallocated mmu->pae_root when the shadow pagetable's
> +	 * level is PT32E_ROOT_LEVEL which need to be put in the 32 bits
>  	 * CR3 (even in x86_64) or decrypted.  The preallocated one is prepared
>  	 * for the requirements.
>  	 */
> -	if (role.level == PT32E_ROOT_LEVEL &&
> -	    !WARN_ON_ONCE(!vcpu->arch.mmu->pae_root))

Why remove this WARN_ON_ONCE()?  And shouldn't this also interact with 

   KVM: X86/MMU: Allocate mmu->pae_root for PAE paging on-demand

Actually, I think the series is buggy.  That patch, which precedes this one, does

	if (vcpu->arch.mmu->root_role.level != PT32E_ROOT_LEVEL)
		return 0;

i.e. does NOT allocate pae_root for a 64-bit host, which means that running KVM
against the on-demand patch would result in the WARN firing and bad things happening.

> +	if (vcpu->arch.mmu->root_role.level == PT32E_ROOT_LEVEL)
>  		sp->spt = vcpu->arch.mmu->pae_root;
>  	else
>  		sp->spt = kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache);
> -- 
> 2.19.1.6.gb485710b
> 
