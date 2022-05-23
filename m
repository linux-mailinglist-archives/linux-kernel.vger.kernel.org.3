Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE925312EB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiEWQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbiEWQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:17:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E0A66AFB
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:17:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j21so13889245pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eNbcOsis/KpOazxwoapGqmAzQvleW1ZvCZVss5TACNY=;
        b=PvlTBp13muG1TUI68g94aTQ/FiuK9qHmMCLEhGVjZ0ZOVhN6vz5vhhS+wmUP4+Lno7
         7IlNEdS8L46cr3LPygXWejIC2R5nVJHYFz2RQibrrPusEsaLKGvIB9h6v7KfX7A7i0kB
         v+P2h1gE9IKmT0G5rBzwpuio2B55DiAPk8drqySZQ6ng/a9/tF4skaP1vmmzJ5HO8Eae
         PxGQp8Gqh3zX4GFCTSCnZ/kLWXYyzDQ0QstOp7r3CfZjsMSi22A3To/WeaVSCKJ0a/sA
         PopRzqh3tQ/XAtcJTZ/asZNoRcRGEGNwG+tcYnQThEJqQPzA4Ro2opqfmf1ZUxg77Xkw
         zo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eNbcOsis/KpOazxwoapGqmAzQvleW1ZvCZVss5TACNY=;
        b=jZpdC9nHBj4EdHG51MiyT+tDa2K3omtb+Dd+WJLR96VvC/roNcMWX9p0EaLn914n4v
         PwBQQz+G5i3y25ucALvygq8NYqXYZpLfZdmv1rrBKFlsSIbrnit6PLDUs59j0rx2JDaq
         U35vi/lBcdfUB+gOZOjTuVZB2aW4719v/CcQq+1OFejjyxroIEnR/DnBLCvpOTLjH+tY
         AHim8Lcq7qynhdqMIPVNASZjyAstApeF0gRSdccO6T82nO2d/Vn5qMpZUvFEjLDdn5tO
         oG+tawVO0nRuDoT1VpbVl9Yvt42A4t2gKxy+8nLYrjzC0q2PW3+THtvo7TZCqz3qnVSI
         rP2w==
X-Gm-Message-State: AOAM530TfWCsR9HPWRWf5jM7gvZoqv74gmQhdR1z2cDU8ezfQh+2VQfD
        Yu1AzASoht572icoFH2UxeAGmQ==
X-Google-Smtp-Source: ABdhPJxjulk6DvCNQRz3GNKlx5A5+lWZ+jpdQDxApa+oqiYCn513L8CGqWxpc26B7Dlc/KO80E966g==
X-Received: by 2002:a05:6a00:1511:b0:510:30d1:e8fd with SMTP id q17-20020a056a00151100b0051030d1e8fdmr24535196pfu.37.1653322658336;
        Mon, 23 May 2022 09:17:38 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902f11200b00162017529easm5297369plb.167.2022.05.23.09.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:17:37 -0700 (PDT)
Date:   Mon, 23 May 2022 16:17:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     shaoqin.huang@intel.com
Cc:     pbonzini@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Check every prev_roots in
 __kvm_mmu_free_obsolete_roots()
Message-ID: <YouznrVYM7H5IoMK@google.com>
References: <20220523010948.2018342-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220523010948.2018342-1-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> Iterate every prev_roots and only zap obsoleted roots.

Better would be something like:

  When freeing obsolete previous roots, check prev_roots as intended, not
  the current root.

Ugh, my bad.  This escaped into v5.18 :-(

Fixes: 527d5cd7eece ("KVM: x86/mmu: Zap only obsolete roots if a root shadow page is zapped")
Cc: stable@vger.kernel.org

> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 45e1573f8f1d..22803916a609 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5168,7 +5168,7 @@ static void __kvm_mmu_free_obsolete_roots(struct kvm *kvm, struct kvm_mmu *mmu)
>  		roots_to_free |= KVM_MMU_ROOT_CURRENT;
>  
>  	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
> -		if (is_obsolete_root(kvm, mmu->root.hpa))
> +		if (is_obsolete_root(kvm, mmu->prev_roots.hpa))

My version is bad, but at least it compiles ;-)

arch/x86/kvm/mmu/mmu.c: In function ‘__kvm_mmu_free_obsolete_roots’:
arch/x86/kvm/mmu/mmu.c:5182:58: error: ‘(struct kvm_mmu_root_info *)&mmu->prev_roots’ is a pointer; did you mean to use ‘->’?
 5182 |                 if (is_obsolete_root(kvm, mmu->prev_roots.hpa))
      |                                                          ^
      |                                                          ->


		if (is_obsolete_root(kvm, mmu->prev_roots[i].hpa))
		
>  			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
>  	}
>  
> -- 
> 2.30.2
> 
