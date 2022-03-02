Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C24CAF14
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiCBTwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbiCBTw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:52:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B893D95E1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:51:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z2so2485816plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K9X7JrhsxNcS6upS7mNhAwW5h+M5okT8FoWI5/raP6I=;
        b=sS3kE8+PStEGIXHDPWwCcXaFdEQhEIzd9oj0L9waQDDookmKz6rjd8d6Vu5NBSuNj4
         nqCMAfhxTsJSS5wE+scTdZznIvWkvkwDUEnyfIJaUTCpy6gXZl4J8PcNpTqohsjMhuFf
         6vjSo1DGJqIWbOtLrL1lPLs2QqQg4xrl+q8hwIV05nAGEVsOLxDAbSLrkwMD8O3Ddh9X
         mLRB5TuAb+VVk8elJE0i1/xtKirCP4v86NnisaGDLN5/JUEmoC6E1J4xos7OwXt5tIW/
         dXzwcxa6VsFzjVF0oKY5oy++wV2V9Au//9o8qjhqvKiKajawoMrL6PXiEHizGYgloNNB
         88UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K9X7JrhsxNcS6upS7mNhAwW5h+M5okT8FoWI5/raP6I=;
        b=1JPkd73ncjDZZSgsfE0BfD37hESHmVuL/VgE8Jbs4y44nhEjPqBAqu8MBdNV/9y5+U
         u3sbGgwaOaPENbd2Y3ETQcc+79+UruaqPqj7T+q9iBCDzBSJp67rs56DjgFGOyKWR/nG
         tzPjzgGLm5rvpXV2u39zjSOiP3ta4JRZGlWaeqgw2PA9vBLDbYGVJ+MFfk5MnCMvUjWQ
         ++ygbE3f6293Ppxys3HBT5sQyXdEagEenhZZq8wnCHs3YgqpqFMAAIA29ambW77lszes
         b6Ec1r6bNAS1TjgUVq6Mpf/btfY/ImX2mgogtA+1ffslF3IqUR1GXlR5Uqvggk33BKis
         i7IA==
X-Gm-Message-State: AOAM530EfXtbjdk2bxsPB5UVaXYJIPs8nCV8sBfxKgANBGxeQczZfkA6
        rH80vSkrFI2V9qKZSchMnRIUiQ==
X-Google-Smtp-Source: ABdhPJx5Y9g4hxadedkvi+PWPXPzmugUGe/3dvfWJiSI56tdTwxtwePEn9v3CEPqzDuVEA3gqmW9jA==
X-Received: by 2002:a17:90a:5917:b0:1be:d200:2501 with SMTP id k23-20020a17090a591700b001bed2002501mr1473742pji.15.1646250704687;
        Wed, 02 Mar 2022 11:51:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g17-20020a62e311000000b004def1931fbcsm13903028pfh.63.2022.03.02.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:51:44 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:51:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
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
Message-ID: <Yh/KzDqsQSGm1CvK@google.com>
References: <20220226001546.360188-1-seanjc@google.com>
 <20220226001546.360188-2-seanjc@google.com>
 <Yh/Al8wGUOEgRmih@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/Al8wGUOEgRmih@google.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022, Mingwei Zhang wrote:
> On Sat, Feb 26, 2022, Sean Christopherson wrote:
> > Now that tdp_mmu_next_root() can process both valid and invalid roots,
> > extend it to be able to process _only_ invalid roots, add yet another
> > iterator macro for walking invalid roots, and use the new macro in
> > kvm_tdp_mmu_zap_invalidated_roots().
> > 
> > No functional change intended.
> > 
> > Reviewed-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/tdp_mmu.c | 74 ++++++++++++++------------------------
> >  1 file changed, 26 insertions(+), 48 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index debf08212f12..25148e8b711d 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -98,6 +98,12 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
> >  	call_rcu(&root->rcu_head, tdp_mmu_free_sp_rcu_callback);
> >  }
> >  
> > +enum tdp_mmu_roots_iter_type {
> > +	ALL_ROOTS = -1,
> > +	VALID_ROOTS = 0,
> > +	INVALID_ROOTS = 1,
> > +};
> 
> I am wondering what the trick is to start from -1?

-1 is arbitrary, any non-zero value would work.  More below.

> >  /*
> >   * Returns the next root after @prev_root (or the first root if @prev_root is
> >   * NULL).  A reference to the returned root is acquired, and the reference to
> > @@ -110,10 +116,16 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
> >   */
> >  static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
> >  					      struct kvm_mmu_page *prev_root,
> > -					      bool shared, bool only_valid)
> > +					      bool shared,
> > +					      enum tdp_mmu_roots_iter_type type)
> >  {
> >  	struct kvm_mmu_page *next_root;
> >  
> > +	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
> > +
> > +	/* Ensure correctness for the below comparison against role.invalid. */
> > +	BUILD_BUG_ON(!!VALID_ROOTS || !INVALID_ROOTS);
> > +
> >  	rcu_read_lock();
> >  
> >  	if (prev_root)
> > @@ -125,7 +137,7 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
> >  						   typeof(*next_root), link);
> >  
> >  	while (next_root) {
> > -		if ((!only_valid || !next_root->role.invalid) &&
> > +		if ((type == ALL_ROOTS || (type == !!next_root->role.invalid)) &&

This is the code that deals with the enums.  It's making the type a tri-state,
where the values of VALID_ROOTS and INVALID_ROOTS align with converting role.invalid
to a boolean (always '0' or '1') so that they can be directly compared as above.

Any value for ALL_ROOTS (other than '0' or '1' obviously) would work since the
above logic requires ALL_ROOTS to be explicitly checked first.

> >  		    kvm_tdp_mmu_get_root(next_root))
> >  			break;
> >  
