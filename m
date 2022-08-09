Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B2E58DACA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244792AbiHIPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244826AbiHIPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:05:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCCE1EC54
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:05:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so1375690pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=lV0oW6sp8HtXcmxj4/hAp/SUG2DXsDXcAzBIhIgQ+uo=;
        b=j0A8pnYN9V/OZQ4fgcEgf+kg9R2CNjxcy4LCRZ4wiSocF6MjLaj/hlw1jAnH9pAnc5
         jxXQimoN+eCLFIUZfxmMk+9537VUhMyh9eWcrQxPixJ3oPtcJo3g4U1sTWqqM7xKPETS
         S2XfWiULtHnanXg8VQ9+ouD1ayRkcn4A9heqOW9szY8JXaPlHYT00emawPtc4/wqwk4O
         7BAogeY5sqB9aXkN8nRMsEFJ89W5eP5O7jIAhQNfY03sOwDYAVSjFYZgizR8mvGPNobQ
         +mbnxX1+c/ILPCzQT44dMsXhLmXM3pH206Uof5dBdpGbqFtWvVk5LG3KEse7klhRDodl
         EaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lV0oW6sp8HtXcmxj4/hAp/SUG2DXsDXcAzBIhIgQ+uo=;
        b=0V1fjx5szZnf4vFcOKdAN5r8BxlpInI9QrgI44Hi9VP8syQ8XD1YqMIzCEwAsZ0j1y
         XIcFnO2mPrQYxu/an2btWUVWuWuPw69ql9xNhp6ucw930+8sqGFhzwK2kiS7zLBp/ze3
         BI+luaytLLwj+bAzspFC+eAdXO2hSZSk0xEUMJ8PxQSZ6uwfJ2do2GyFAUkLnhcqyChW
         G0yQ2Nc5mi1DmY/XvaH4aQ8NuH5K/wbr2ukz14AZTubfYUS74QhMa4S8KBjqawpjh44o
         D4zPIlpIH5CP66gajy5BOOVLo8k5XadQID525V0PCAYO8D2xjmqR0B6cRJoOnexwXXFY
         LGsw==
X-Gm-Message-State: ACgBeo0osqIAGiV/LYF+UQ8QmM/jh6FnjkACDHCD/A3tqGqstwhATiqw
        JazL0/It9+bnO0rMISj6SLMLxQ==
X-Google-Smtp-Source: AA6agR4wIiEFKbpHoDDn9bv6dVm6d6U+WX0V3ZA/tX8Np9CYn6Vg/83IrDzrs6eGxJuIkZFIUkKMSA==
X-Received: by 2002:a17:903:110c:b0:16c:cfae:e492 with SMTP id n12-20020a170903110c00b0016ccfaee492mr23921575plh.162.1660057509354;
        Tue, 09 Aug 2022 08:05:09 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ik30-20020a170902ab1e00b0016c1a1c1405sm10798867plb.222.2022.08.09.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:05:08 -0700 (PDT)
Date:   Tue, 9 Aug 2022 15:05:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v3 5/8] KVM: x86/mmu: Set disallowed_nx_huge_page in TDP
 MMU before setting SPTE
Message-ID: <YvJ3oOSMr37AciAT@google.com>
References: <20220805230513.148869-1-seanjc@google.com>
 <20220805230513.148869-6-seanjc@google.com>
 <YvHT0dA0BGgCQ8L+@yzhao56-desk.sh.intel.com>
 <331dc774-c662-9475-1175-725cb2382bb2@redhat.com>
 <YvJyw96QZdf6YPAX@google.com>
 <c976a6e6-963e-d076-053b-15e381c3800a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c976a6e6-963e-d076-053b-15e381c3800a@redhat.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022, Paolo Bonzini wrote:
> On 8/9/22 16:44, Sean Christopherson wrote:
> > On Tue, Aug 09, 2022, Paolo Bonzini wrote:
> > > and (4) is definitely ordered after (1) thanks to the READ_ONCE hidden
> > > within (3) and the data dependency from old_spte to sp.
> > 
> > Yes, I think that's correct.  Callers must verify the SPTE is present before getting
> > the associated child shadow page.  KVM does have instances where a shadow page is
> > retrieved from the SPTE _pointer_, but that's the parent shadow page, i.e. isn't
> > guarded by the SPTE being present.
> > 
> > 	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
> > 
> > Something like this is as a separate patch?
> 
> Would you resubmit without the memory barriers then?

Ya.

> > diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
> > index f0af385c56e0..9d982ccf4567 100644
> > --- a/arch/x86/kvm/mmu/tdp_iter.h
> > +++ b/arch/x86/kvm/mmu/tdp_iter.h
> > @@ -13,6 +13,12 @@
> >    * to be zapped while holding mmu_lock for read, and to allow TLB flushes to be
> >    * batched without having to collect the list of zapped SPs.  Flows that can
> >    * remove SPs must service pending TLB flushes prior to dropping RCU protection.
> > + *
> > + * The READ_ONCE() ensures that, if the SPTE points at a child shadow page, all
> > + * fields in struct kvm_mmu_page will be read after the caller observes the
> > + * present SPTE (KVM must check that the SPTE is present before following the
> > + * SPTE's pfn to its associated shadow page).  Pairs with the implicit memory
> 
> I guess you mean both the shadow page table itself and the struct
> kvm_mmu_page?

Yes.  It's a bug if KVM ever consumes a SPTE's pfn (read the next level of SPTEs
or pfn_to_page() to get kvm_mmu_page) without first checking that the SPTE is
MMU-present.  

> Or do you think to_shadow_page() should have a smp_rmb()?

I believe we're ok.  If any SP fields are toggled after the SP is marked present,
then we'd need separate barriers, e.g. similar to is_unsync_root() +
mmu_try_to_unsync_pages() (ignoring that we've since added a spinlock in the "try
to unsync" path).
