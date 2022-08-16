Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3516659643F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbiHPVKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHPVKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:10:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A947E013
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:10:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t3so2443992ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3TNHDMK6crAKiQ8dof0O0YciDkj6xbRmAwSNGdrV/YE=;
        b=boYJM7xJiO/wnH7j6dLOPptvSyfRhEgsvkuoBvfH+tM0qFfNdkwASUWa96bH+Jrsfv
         AovCBxjPOLDEpy/pB8PCAwjZZ2T9DSIwSML7y7kyegifKjHSiC4en3bSXqmUoj4eX9t/
         fmMFog27hbKyimdFYrGRXmR3o/r1aCaxGOAiqtqvUnSkMeh1enqk+Ou2goi4Mb+vyWmJ
         iQpdkyicqBZpKn+EJA6Gw+2HO/iXuzk1uKiqzQVBVS80nyd4HzMP4obsBjF8MSJgqBQL
         Bundqoyr7xLOjF1n8+WTMc9y3zG0uv5WVM0Ipfhum1rjqhV4q7EC+NXkjWE+GgH/D++F
         MGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3TNHDMK6crAKiQ8dof0O0YciDkj6xbRmAwSNGdrV/YE=;
        b=nvgUZUMW5XSc6cdnCPDMc1QXi8croiGSslgsBMWOkImY8LLrbMmOR8rZY8ArGfjAFg
         +p9Z4cwbpuOJcH6HGAxE0VjwIg3eKJl2Bem82kC4IoU+QbKUMKJTEo6isRx/LcHMsuCU
         VdUsvs1KUSGtikF7lFzEYZTHQAAXnEHTGC5ayI8SlL0BjyHklVrH/9Sf9td3Jxsy4sn3
         dsMphFVy6nQvGD1GOYAfW+Dh3D8aTPGmcKOWrQC1BbVX0ZAOlaoUvnp4PCOOUkxVb1/u
         UflsGwcf3be8X/yMAJAExbBq0ELM+viXYN21dloOLAFxVGFFQ/rgjCuEq17u3uzxwWw/
         ddJg==
X-Gm-Message-State: ACgBeo0oyamqZDLveDO6n+kI7/xWRex84VM2JNlkVzutqRX8Ttzl3NG/
        eWC++2QMS16jwoFieuT7JFGMPQ==
X-Google-Smtp-Source: AA6agR4OF22Kg1O7WqhFOFstzTRFWcNIrryo56OK9hPQ71EVjtpEzpipCt2qEIejXom6L7e8j9JGog==
X-Received: by 2002:a17:903:11c7:b0:170:cde7:d24a with SMTP id q7-20020a17090311c700b00170cde7d24amr23966559plh.91.1660684202826;
        Tue, 16 Aug 2022 14:10:02 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 189-20020a6204c6000000b0052ce4074fddsm9177050pfe.145.2022.08.16.14.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:10:02 -0700 (PDT)
Date:   Tue, 16 Aug 2022 21:09:58 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v3 3/8] KVM: x86/mmu: Rename NX huge pages
 fields/functions for consistency
Message-ID: <YvwHpjxS9CCEVER7@google.com>
References: <20220805230513.148869-1-seanjc@google.com>
 <20220805230513.148869-4-seanjc@google.com>
 <YvhL6jKfKCj0+74w@google.com>
 <YvrAoyhgNzTcvzkU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvrAoyhgNzTcvzkU@google.com>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022, Sean Christopherson wrote:
> On Sun, Aug 14, 2022, Mingwei Zhang wrote:
> > On Fri, Aug 05, 2022, Sean Christopherson wrote:
> > > Rename most of the variables/functions involved in the NX huge page
> > > mitigation to provide consistency, e.g. lpage vs huge page, and NX huge
> > > vs huge NX, and also to provide clarity, e.g. to make it obvious the flag
> > > applies only to the NX huge page mitigation, not to any condition that
> > > prevents creating a huge page.
> > > 
> > > Leave the nx_lpage_splits stat alone as the name is ABI and thus set in
> > > stone.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h |  8 ++--
> > >  arch/x86/kvm/mmu/mmu.c          | 70 +++++++++++++++++----------------
> > >  arch/x86/kvm/mmu/mmu_internal.h | 22 +++++++----
> > >  arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
> > >  arch/x86/kvm/mmu/tdp_mmu.c      |  8 ++--
> > >  5 files changed, 59 insertions(+), 51 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index e8281d64a431..5634347e5d05 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -1143,7 +1143,7 @@ struct kvm_arch {
> > >  	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
> > >  	struct list_head active_mmu_pages;
> > >  	struct list_head zapped_obsolete_pages;
> > > -	struct list_head lpage_disallowed_mmu_pages;
> > > +	struct list_head possible_nx_huge_pages;
> > 
> > Honestly, I am struggling to understand this one. 'possible_*' indicates
> > that there are other possibilities. But what are those possibilities?
> 
> No, possible is being used as an adjective in this case.  possible_nx_huge_pages
> is the list of shadow pages for which it's possible to replace the shadow page
> with an NX huge page.
> 
> The noun version would yield a name like nx_huge_page_possiblities.

Right, but these shadow pages are not NX huge pages, right? IIUC, they
are pages to be zapped due to NX huge pages, aren't they?

`nx_huge_page_disallowed` is easy to understand because it literally say
'nx_huge_page is not allowed', which is correct.

But this one, it says 'possible nx_huge_pages', but they are not
nx huge pages at all. Instead, they are 'shadow pages that are replaced
with nx_huge_pages'. So that's why updates to this list is done together
with stats nx_plage_splits.

Please correct me if I am wrong. I am still struggling to understand the
meaning of these variables.

>
> > I feel this name is more confusing than the original one. Maybe just keep
> 
> Ignoring lpage => huge_page, the current name is terribly inaccurate.  The list
> doesn't contain all disallowed huge pages, nor does it even contain all disallowed
> NX huge pages, it specifically tracks shadow pages that might be able to be
> replaced with an NX huge page.
> 
> I'm open to other names, but whatever we choose should be paired with
> account_nx_huge_page()'s param that is currently named "nx_huge_page_possible".

How about mmu_pages_replaced_by_nx_huge,
mmu_pages_replaced_by_possible_nx_huge or something starting with
possible_pages_, pages_ instead of possible_nx_huge_pages?

