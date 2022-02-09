Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CA04B0085
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiBIWng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:43:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiBIWnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:43:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF8E04FF1C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:43:11 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k17so261769plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=noMkqdTonhMUp9fT8zd3GJsejZVy8dW1w0VkTntk/8Y=;
        b=bHNRLw+OXy+JodwNMwa69BC1zFb8359yF6+/aSWs/bwszNylIZ0siC6/EmVOeJglKh
         H3o/LrFlf8t3pk9303gznetfLGDEFh2lz/MgmHk5/NIi8AckRL2EYEWWCFzWMeJTSMCz
         +eyK9gIuqwgyMjhkDNYgP66k4dyvVwD2ruIOxsnTD/nCrkhLvekAFoTm5k2tMVf8N++w
         jGCZqjJMsAmdtP1RTj71TkUx78nyb3BcpfVLkTOTfNOwOhEVAI29JWyRtPqix7+LEzMz
         Wo+ntyiWbg9YA84BAysTyhZJCXWYjm8vHq8WSpYY7j08PR0iK9ixJiw85MO7ZXIG+J9C
         aRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=noMkqdTonhMUp9fT8zd3GJsejZVy8dW1w0VkTntk/8Y=;
        b=eFtz4fbbFq6SeOxv6auVEV+yJ6XRXIEPMtQfRDaDXT95mL74YFVL3WhKWyI13QPyP9
         nVyzVj8AjIXv9aAcnAm/f2rRKTF7HpxzFAuRArcF29oFTaWR4AvwFwPkSr3n++w8MmZ3
         /P4eKrK5Z9W7SZjhjSj4C7gpeJ4lZeM5OZLQD/09b3LOxtROpuTTe8ujRVXJEXvjMzi/
         hmv+U8yfitwmhr2LpmAySNTniUTC/OSs4gkGp6hV1OEMit9mxdP/qOMjP0N+UK+bB6ZZ
         RDRm5ajpFhmV/FWX1hZucVDsZOqLnchBHwA1h+1LsUeGtjciADjhieMusiGTOMrPqmCu
         byww==
X-Gm-Message-State: AOAM530/Vx2DxfAlhpiGTwlgsMPU4s3fIaGD52bTnnH6fZH0WqxQfj+r
        lAhiLCYMNrB5UAUrHHyq/Jey5Q==
X-Google-Smtp-Source: ABdhPJw7V1tbuSaIRjHHEsNYjQudgK7dt21qZMZDxlNK9KY1aeYFg0uYMJ7CI4qoGq0jmiaHVuJ0Ww==
X-Received: by 2002:a17:902:7ecf:: with SMTP id p15mr4523948plb.112.1644446590881;
        Wed, 09 Feb 2022 14:43:10 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p16sm14695437pgj.79.2022.02.09.14.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:43:10 -0800 (PST)
Date:   Wed, 9 Feb 2022 22:43:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, vkuznets@redhat.com
Subject: Re: [PATCH 02/23] KVM: MMU: nested EPT cannot be used in SMM
Message-ID: <YgRDenzMI49hcss1@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-3-pbonzini@redhat.com>
 <Yf1tY8kNzZDRtH3e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf1tY8kNzZDRtH3e@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022, David Matlack wrote:
> On Fri, Feb 04, 2022 at 06:56:57AM -0500, Paolo Bonzini wrote:
> > The role.base.smm flag is always zero, do not bother copying it over
> > from vcpu->arch.root_mmu.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> 
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 9424ae90f1ef..b0065ae3cea8 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4881,9 +4881,6 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
> >  {
> >  	union kvm_mmu_role role = {0};
> >  
> > -	/* SMM flag is inherited from root_mmu */
> > -	role.base.smm = vcpu->arch.root_mmu.mmu_role.base.smm;
> 
> nit: Retaining a comment here and/or warning here would be useful.
> 
> 	/* EPT is not allowed in SMM */

EPT _is_ allowed in SMM, KVM just doesn't support it.  Specifically, KVM doesn't
emulate Parallel SMM, a.k.a. Dual-Monitor Treatment of SMIs.  Probably worth
calling that out in the changelog.  If there's a WARN, then we don't really need
a comment as blame will get someone to the "why" if they're really curious, and
most people probably would only be confused about parallel SMM comments.

> 	WARN_ONCE_ONCE(vcpu->arch.root_mmu.mmu_role.base.smm);

+1 to a WARN, if only to provide a paper trail for git blame.  Finding when
something is purely deleted is painful.

> 
> (Although I imagine it would just get removed later in the series.)
> 
> > -
> >  	role.base.level = level;
> >  	role.base.has_4_byte_gpte = false;
> >  	role.base.direct = false;
> > -- 
> > 2.31.1
> > 
> > 
