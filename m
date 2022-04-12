Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605944FE514
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357296AbiDLPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350957AbiDLPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:49:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE9D5FF29
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:46:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so3487104pja.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=js3tHDr4eOmEThgm8BUw/oQwvmml9LueqFtgZ1mVLag=;
        b=g7Tpd/SDnjWeFBxtNwLp0z0M9X5xMPs6WTBHb9BWKpfmauaI8enp2SS2e019oT1jiZ
         Ct3/55zRMiwurWkKgnpI6VlRoVIrcb+k7aStwuAyg6C280VfkuzF7pq2IMjN3MUA+bzx
         E8ucYdFUUYzI1KuyaBFDCAU0a4SkzvyI2GiJBCmpKMedqW1Rt40bD+B8O3YiqqV4PDrj
         5wg9BexJ6eve+GtECxtukuW6aolxYDu3Q8X7BAUz2qbTVHdT4moZlD1458TPdBQB16B4
         FAdjswkHtsyTHDPocXzTO83vDX53hmRfew0hZuLKimHimZ/SuYTL1IFu6p8s6AJ0Z0PJ
         wLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=js3tHDr4eOmEThgm8BUw/oQwvmml9LueqFtgZ1mVLag=;
        b=deY24itl2Gm6m8bCEkQtVVdfJUebW6toZqB/UyJ0ZsvsRJPdZt11CquBfy+9z8NVPJ
         85M+tbSSM5z/7mh16MpMTD+atBOtImiXdq3RWK/xwxnnYlKl+jjS0GGCPn7uKIfY8R11
         llUD/3NKtpXVs3f/gQ1J6eF0aFaCdd6+Hie+4z+FIAJwd0JSeNQSxdzhMkUR92rOanvu
         a2EpfjMXBv3dqGKPWrMnYNm3084M6Hx+mP2SOrmbx4fF5i6mSMBIIYeso2XI8m765oNk
         Ix5Muj+tAeHXihCUpQjsAWxfsXTrBRNpNkYoDN09ApLn6lRiMMZP2yvh47ryEjltXXo3
         rjjw==
X-Gm-Message-State: AOAM533sDBJ/A7R/t4gdkU9kMY5I+L4CP594VB6OxG98mC6u3eGD0c9h
        OwxWPfziIfZRO2FcXSIELkUFkA==
X-Google-Smtp-Source: ABdhPJzWh088TkrTlX2julOJDlWp7vqoK+Ge8A9SWU59r2SdzQzPnnZKLDM2tyUj29HwS007VXKOuA==
X-Received: by 2002:a17:90b:380c:b0:1cb:a43d:4c29 with SMTP id mq12-20020a17090b380c00b001cba43d4c29mr5591787pjb.240.1649778413563;
        Tue, 12 Apr 2022 08:46:53 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id bd11-20020a656e0b000000b0039da213aa72sm1645826pgb.5.2022.04.12.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:46:52 -0700 (PDT)
Date:   Tue, 12 Apr 2022 15:46:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v2 5/9] KVM: x86/mmu: Factor out the meat of
 reset_tdp_shadow_zero_bits_mask
Message-ID: <YlWe6bwQX9V4Oc5S@google.com>
References: <20220321224358.1305530-1-bgardon@google.com>
 <20220321224358.1305530-6-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321224358.1305530-6-bgardon@google.com>
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

On Mon, Mar 21, 2022, Ben Gardon wrote:
> Factor out the implementation of reset_tdp_shadow_zero_bits_mask to a
> helper function which does not require a vCPU pointer. The only element
> of the struct kvm_mmu context used by the function is the shadow root
> level, so pass that in too instead of the mmu context.
> 
> No functional change intended.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3b8da8b0745e..6f98111f8f8b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4487,16 +4487,14 @@ static inline bool boot_cpu_is_amd(void)
>   * possible, however, kvm currently does not do execution-protection.
>   */
>  static void

Strongly prefer the newline here get dropped (see below).

> -reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
> +build_tdp_shadow_zero_bits_mask(struct rsvd_bits_validate *shadow_zero_check,

Kind of a nit, but KVM uses "calc" for this sort of thing.  There are no other
instances of "build_" to describe this behavior.

Am I alone in think that shadow_zero_check is an awful, awful name?  E.g. the EPT
memtype case has legal non-zero values.  Anyone object to opportunistically
renaming the function and the local shadow_zero_check to "rsvd_bits" to shorten
line lengths and move KVM one step closer to consistent naming?

> +				int shadow_root_level)
>  {
> -	struct rsvd_bits_validate *shadow_zero_check;
>  	int i;
>  
> -	shadow_zero_check = &context->shadow_zero_check;
> -
>  	if (boot_cpu_is_amd())
>  		__reset_rsvds_bits_mask(shadow_zero_check, reserved_hpa_bits(),
> -					context->shadow_root_level, false,
> +					shadow_root_level, false,
>  					boot_cpu_has(X86_FEATURE_GBPAGES),
>  					false, true);
>  	else
> @@ -4507,12 +4505,19 @@ reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
>  	if (!shadow_me_mask)
>  		return;
>  
> -	for (i = context->shadow_root_level; --i >= 0;) {
> +	for (i = shadow_root_level; --i >= 0;) {
>  		shadow_zero_check->rsvd_bits_mask[0][i] &= ~shadow_me_mask;
>  		shadow_zero_check->rsvd_bits_mask[1][i] &= ~shadow_me_mask;
>  	}
>  }
>  
> +static void
> +reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)

One line!  Aside from being against the One True Style[*], there is zero reason
for a newline here.

And I vote to drop the "mask", because (a) it's not a singular mask and (b) it's
not even a mask in all cases.

And while I'm on a naming consistency rant, s/context/mmu.

I.e. end up with:

static void calc_tdp_shadow_rsvd_bits(struct rsvd_bits_validate *rsvd_bits,
				      int shadow_root_level)

static void reset_tdp_shadow_rsvd_bits(struct kvm_mmu *mmu)

[*] https://lore.kernel.org/mm-commits/CAHk-=wjS-Jg7sGMwUPpDsjv392nDOOs0CtUtVkp=S6Q7JzFJRw@mail.gmail.com

> +{
> +	build_tdp_shadow_zero_bits_mask(&context->shadow_zero_check,
> +					context->shadow_root_level);
> +}
> +
>  /*
>   * as the comments in reset_shadow_zero_bits_mask() except it
>   * is the shadow page table for intel nested guest.
> -- 
> 2.35.1.894.gb6a874cedc-goog
> 
