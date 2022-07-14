Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A9A575407
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiGNR1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbiGNR1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:27:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D975F983
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:27:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o15so3486216pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=utH2IS/VTX5JTS0QLCXRVyshNaT5RNL5Nc+i8BDtLmk=;
        b=rF12YwCEfFYueQbJLNdKUdSIPn3X/JN/wNW9JmI7PR/QSVfskRk9FLorv09enmrJEt
         yere3bNl9k4wIiAy3UIFX0nhGyeL3iiGzOo2xq5kJmAnDswrTOs6XPnVlRD4QWiQVwqr
         K1xBzJ0W/PDTuXHhjpGY7naObopY8/99iO1nXeOpgjmKlZUu05KTMg4j5BpdP5+oKLdN
         sR+Di65OwzZDZGewiMDnB8pr79dCMheqPr7XCMwS5NhOJKExYEDtSjDpfzAxDTWp89BU
         ET586gz+4uGrx4JfHzaZY/s1jVKBQbHZYv6l+rfWTc1+MEX+8vffY7kdUGBXWMUrwTnZ
         WLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=utH2IS/VTX5JTS0QLCXRVyshNaT5RNL5Nc+i8BDtLmk=;
        b=aoeL9NNjFrUUEIohS8B8usIP+9WHuQvyNvpf7Xtvn23HluSlN8nvmek5fjjT4vmTmV
         yTI4ah9vKSRQUuruC/EP3X8sKRIoQcPP2SZACNHctP6oS2zAhKs8ubXouRTNzVv3D/F4
         fbabaBzcoK1ugzI8kwM+CbfuQCW+6hlpXgg8P+jinPEYbi6TUBOgiIPN4sBG55y6g5K+
         ddIBe93xwByFlnxckw0PK2HfEuOL75JQpkOZ3m6SGVbdbBuRYthCbQRziFadJB03dfyD
         wjZDPSXNkmUJevL3zE84TrNdvBhjxVBeyquF03FHpkkmHy/CeeR9Td91dwC1xZ01gI2C
         eqCQ==
X-Gm-Message-State: AJIora/fNa7tNTIIF80dworAD+/gfUaUj2iFeN7wPH1PEELpNUH2Q6u8
        55ccP1fbL4RLCLwGQuwhkwvvEA==
X-Google-Smtp-Source: AGRyM1tZbMvh/IPB79aNcE/pjioSN87QQMJthXMeW7P+2OiAXSUEst9UtSeRYRzH1N/wOQJpKs+fAw==
X-Received: by 2002:a17:903:244d:b0:16c:52f1:ceb with SMTP id l13-20020a170903244d00b0016c52f10cebmr9808645pls.120.1657819651493;
        Thu, 14 Jul 2022 10:27:31 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id ik5-20020a170902ab0500b00168b113f222sm1726733plb.173.2022.07.14.10.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:27:30 -0700 (PDT)
Date:   Thu, 14 Jul 2022 17:27:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: x86: Clean up rmap zap helpers
Message-ID: <YtBR/x3CAEavwzMI@google.com>
References: <20220712015558.1247978-1-seanjc@google.com>
 <bc2c1af3-33ec-d97e-f604-12a991c7cd5e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc2c1af3-33ec-d97e-f604-12a991c7cd5e@redhat.com>
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

On Thu, Jul 14, 2022, Paolo Bonzini wrote:
> On 7/12/22 03:55, Sean Christopherson wrote:
> > Clean up the rmap helpers (mostly renames) to yield a more coherent set of
> > APIs, and to purge the irritating and inconsistent "rmapp" (p is for pointer)
> > nomenclature.
> > 
> > Patch 1 is a tangentially related fix for a benign bug.
> > 
> > Sean Christopherson (5):
> >    KVM: x86/mmu: Return a u64 (the old SPTE) from
> >      mmu_spte_clear_track_bits()
> >    KVM: x86/mmu: Rename rmap zap helpers to better show relationships
> >    KVM: x86/mmu: Remove underscores from __pte_list_remove()
> >    KVM: x86/mmu: Use innermost rmap zap helper when recycling rmaps
> >    KVM: x86/mmu: Drop the "p is for pointer" from rmap helpers
> > 
> >   arch/x86/kvm/mmu/mmu.c | 73 +++++++++++++++++++++---------------------
> >   1 file changed, 36 insertions(+), 37 deletions(-)
> > 
> > 
> > base-commit: b9b71f43683ae9d76b0989249607bbe8c9eb6c5c
> 
> I'm not sure I dig the ____, I'll take a closer look tomorrow or next week
> since it's dinner time here.

Yeah, I'm not a fan of it either.  And rereading things, my proposed names also
create an inconsistency; the zap path is the only user of kvm_handle_gfn_range()
that uses a plural "rmaps".

  $ git grep kvm_handle_gfn_range
  arch/x86/kvm/mmu/mmu.c:static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
  arch/x86/kvm/mmu/mmu.c:         flush = kvm_handle_gfn_range(kvm, range, kvm_zap_rmaps);
  arch/x86/kvm/mmu/mmu.c:         flush = kvm_handle_gfn_range(kvm, range, kvm_set_pte_rmap);
  arch/x86/kvm/mmu/mmu.c:         young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
  arch/x86/kvm/mmu/mmu.c:         young = kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);

Make "rmaps" plural is probably a mistake.  The helper zaps multiple SPTEs for a
given rmap list, but from a certain point of view it's just a single "rmap".

What about:

  kvm_zap_rmapp => kvm_zap_rmap    // to align with kvm_handle_gfn_range() usage
  kvm_zap_rmap  => __kvm_zap_rmap  // to pair with kvm_zap_rmap()
  
and

  pte_list_remove  => kvm_zap_one_rmap_spte  
  pte_list_destroy => kvm_zap_all_rmap_sptes

That will yield a better series too, as I can move patch 5 to be patch 2, then
split what was patch 2 (the rename) into separate patches to first align kvm_zap_rmap()
and __kvm_zap_rmap(), and then rename the pte_list_remove/destroy helpers.
