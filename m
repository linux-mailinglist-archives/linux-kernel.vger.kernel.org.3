Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BE74CB415
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiCCA6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiCCA6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:10 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBD149B82
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:57:25 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h17so3099890plc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 16:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OmYtFMYIIuo00w0TMQnbKGUMCOkErANWVneGk7JdVo8=;
        b=q3QYfl97wM6M9Con2LWthCJR9PN9C1lOfVZrxM/k03pqlgEyqX2KuKnwefx3570qiU
         tNTt9apzqQUXWtqhO8uNcnCF2sb+1WZBuwb60Ere0Xj0bXHMirc1P0Vgq3qtz4xkE7c2
         TiD56Y/UEn5dOi+wbVMMt5V4G4dpqD3mw7hf+61hb3S5o06anr1UJgY/R15JzHOLaHoh
         mL0E7yagjAnBG/QfAOFYyZgYB38PMClPfbg/0dAIVGn//JMTcUO8/pnfb/swtUhmsBJw
         CntV5IfSgS6Jht3l6WeeTO/lCtZtIJ1DvVC3U4xCO7kK0c0Wo5P1Ed47r+VDxRs0rk6Z
         5hOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OmYtFMYIIuo00w0TMQnbKGUMCOkErANWVneGk7JdVo8=;
        b=2ZXoAgw3PWVZaErbKCjCmlE5u4EjP4ZoNLurqqI3S0lpKlMa/zGQRm8Tv3dIKFbfKz
         SZAmYZJEZRrX+Xj8ozUdf1fNDeCl85+pGBe19RocHEBml3MxUyLfbBgbk4TjJ/70rAGn
         RPTZ4S7TWiYTmYTLeZwNXbIgEbnRofxGnVaUJpd5FqMfH2xWJ2/NkPQTloSbtiW6TqmD
         nY8p7WkW8FGfdQCmyUp/RmOHoMGXO8QtV1eI7PlexPDDodINvhoW3ecfjCxmDrYIzten
         frMTwWzT0uPfEQd5xu6LCBtxOnV0vwSozLQ1HfuQ9brLjExR265Sxm0+FIXBnIDiKP9e
         ZtbQ==
X-Gm-Message-State: AOAM533MbdGYqsXGOo7/Mq3MDNYZ0wcI1azYYCwUpZUkKxfyS1ejNRS5
        DP2T0dNgAF3pKrnNWHI9C9tFUQ==
X-Google-Smtp-Source: ABdhPJxAZ7vBeqcealHPEdBlM6OXyXVIwPyvoNL7V4bJypgEmLxPx4UEa3yopNc3PFMRlQP1MFzkqg==
X-Received: by 2002:a17:902:7204:b0:14f:b325:7658 with SMTP id ba4-20020a170902720400b0014fb3257658mr33335598plb.110.1646269044882;
        Wed, 02 Mar 2022 16:57:24 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id on18-20020a17090b1d1200b001b9cfbfbf00sm230589pjb.40.2022.03.02.16.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:57:24 -0800 (PST)
Date:   Thu, 3 Mar 2022 00:57:20 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v3 01/28] KVM: x86/mmu: Use common iterator for walking
 invalid TDP MMU roots
Message-ID: <YiAScLpCt/6O2BjI@google.com>
References: <20220226001546.360188-1-seanjc@google.com>
 <20220226001546.360188-2-seanjc@google.com>
 <Yh/Al8wGUOEgRmih@google.com>
 <Yh/KzDqsQSGm1CvK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/KzDqsQSGm1CvK@google.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022, Sean Christopherson wrote:
> On Wed, Mar 02, 2022, Mingwei Zhang wrote:
> > On Sat, Feb 26, 2022, Sean Christopherson wrote:
> > > Now that tdp_mmu_next_root() can process both valid and invalid roots,
> > > extend it to be able to process _only_ invalid roots, add yet another
> > > iterator macro for walking invalid roots, and use the new macro in
> > > kvm_tdp_mmu_zap_invalidated_roots().
> > > 
> > > No functional change intended.
> > > 
> > > Reviewed-by: David Matlack <dmatlack@google.com>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/mmu/tdp_mmu.c | 74 ++++++++++++++------------------------
> > >  1 file changed, 26 insertions(+), 48 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > > index debf08212f12..25148e8b711d 100644
> > > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > > @@ -98,6 +98,12 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
> > >  	call_rcu(&root->rcu_head, tdp_mmu_free_sp_rcu_callback);
> > >  }
> > >  
> > > +enum tdp_mmu_roots_iter_type {
> > > +	ALL_ROOTS = -1,
> > > +	VALID_ROOTS = 0,
> > > +	INVALID_ROOTS = 1,
> > > +};
> > 
> > I am wondering what the trick is to start from -1?
> 
> -1 is arbitrary, any non-zero value would work.  More below.
> 
> > >  /*
> > >   * Returns the next root after @prev_root (or the first root if @prev_root is
> > >   * NULL).  A reference to the returned root is acquired, and the reference to
> > > @@ -110,10 +116,16 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
> > >   */
> > >  static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
> > >  					      struct kvm_mmu_page *prev_root,
> > > -					      bool shared, bool only_valid)
> > > +					      bool shared,
> > > +					      enum tdp_mmu_roots_iter_type type)
> > >  {
> > >  	struct kvm_mmu_page *next_root;
> > >  
> > > +	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
> > > +
> > > +	/* Ensure correctness for the below comparison against role.invalid. */
> > > +	BUILD_BUG_ON(!!VALID_ROOTS || !INVALID_ROOTS);
> > > +
> > >  	rcu_read_lock();
> > >  
> > >  	if (prev_root)
> > > @@ -125,7 +137,7 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
> > >  						   typeof(*next_root), link);
> > >  
> > >  	while (next_root) {
> > > -		if ((!only_valid || !next_root->role.invalid) &&
> > > +		if ((type == ALL_ROOTS || (type == !!next_root->role.invalid)) &&
> 
> This is the code that deals with the enums.  It's making the type a tri-state,
> where the values of VALID_ROOTS and INVALID_ROOTS align with converting role.invalid
> to a boolean (always '0' or '1') so that they can be directly compared as above.
> 
> Any value for ALL_ROOTS (other than '0' or '1' obviously) would work since the
> above logic requires ALL_ROOTS to be explicitly checked first.
> 
yeah, I see that. The other thing I feel strange is the that VALID_ROOTS
is _0_ while INVALID_ROOTS is _1_. But when I see !!next_root->role.invalid,
that solves my concerns.
> > >  		    kvm_tdp_mmu_get_root(next_root))
> > >  			break;
> > >  
