Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B654B1948
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbiBJXQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:16:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbiBJXQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:16:21 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A105F4E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:16:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id r19so13016386pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U8yAHUx3NK0rKUAij+DjnPG5NstC175VY6VEIELyATY=;
        b=IyNPNiJnwv1DiQnR0zrWU4/CK9fV7cBf452ASGkWgb0WoPhEAQ+RobfZ6ZBoeS7kja
         lL15Qg9fDdFjR30miKaiugM1/3hKUT+Nqs/ZjREWeE7CfnQ1MXR442ec+KrabD4uTH9P
         gkZEy8pwvzx5UzT4FTyvzVN9zZBItkdVsnDTmaxfayzSRLt0pmIzOVWwFm3325ucC95E
         Oup8RAanYZsMTuoUY55OFfPAzUT32OUjR/gRL2Kp7qapzuqrubiA4vtTLQtCOW7woJqD
         PIjJ5vXnMr3qs/FcaRAwf4Isib893ia9l+dBQXjc+GDDo3Yw9ywFTKRqnYHljz3yPmZP
         NEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U8yAHUx3NK0rKUAij+DjnPG5NstC175VY6VEIELyATY=;
        b=NSQF840bGE2pTYlpr8PdSv5Kml+J0K54x06jC+fRxIa6JUamGb8BmANKlUlo1ojoBN
         4HPzEBm7H7hM1IWB+YIm9k9JaLhwmEM1SAI1njcw0aI9mANNy6paXr3DGkSvIjy9AOXi
         DMZcYxOobuiDW6BmZ1vE3IriQZVdjBlWhVEbVYsqu7JaEs1UZMg4kPxmMQY765RI68Iy
         Fh6eDS40VUfUKKjteR13UJ4750o7tM/QQ1P57rjpo7mUDVwGecs7RY4krSCl+mbKgk83
         ud6y7asQXjGr2/83pPuwQVgtiiCK0OTrZ3ua8kHR8XCksLq9YZoX3vbSGiRyNyzobcN6
         4K4Q==
X-Gm-Message-State: AOAM531CuaeR8Iskp8w1fiUkk2KQc9Q1LIipU9rwfJUB/snMA8CtsoDp
        oDBF2Vz3nxrFPpNjJKruzzXkoA==
X-Google-Smtp-Source: ABdhPJz/wIQvMMphnAidsJDKGsOVONIwkZy/0fQZrAN9QPZRK+JABBUQLOF94nKpCjI4m6wDoCOikQ==
X-Received: by 2002:a05:6a00:2355:: with SMTP id j21mr9783791pfj.50.1644534981357;
        Thu, 10 Feb 2022 15:16:21 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 17sm25022106pfl.175.2022.02.10.15.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:16:20 -0800 (PST)
Date:   Thu, 10 Feb 2022 23:16:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
Subject: Re: [PATCH 03/12] KVM: x86: do not deliver asynchronous page faults
 if CR0.PG=0
Message-ID: <YgWcwQYHIFCb2pvH@google.com>
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-4-pbonzini@redhat.com>
 <YgWbgfSrzAhd97LG@google.com>
 <YgWcS/0naKPdAn2E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgWcS/0naKPdAn2E@google.com>
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

On Thu, Feb 10, 2022, Sean Christopherson wrote:
> On Thu, Feb 10, 2022, Sean Christopherson wrote:
> > On Wed, Feb 09, 2022, Paolo Bonzini wrote:
> > > Enabling async page faults is nonsensical if paging is disabled, but
> > > it is allowed because CR0.PG=0 does not clear the async page fault
> > > MSR.  Just ignore them and only use the artificial halt state,
> > > similar to what happens in guest mode if async #PF vmexits are disabled.
> > > 
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  arch/x86/kvm/x86.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 5e1298aef9e2..98aca0f2af12 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -12272,7 +12272,9 @@ static inline bool apf_pageready_slot_free(struct kvm_vcpu *vcpu)
> > >  
> > >  static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
> > >  {
> > > -	if (!vcpu->arch.apf.delivery_as_pf_vmexit && is_guest_mode(vcpu))
> > > +	if (is_guest_mode(vcpu)
> > > +	    ? !vcpu->arch.apf.delivery_as_pf_vmexit
> > > +	    : !is_cr0_pg(vcpu->arch.mmu))
> > 
> > As suggested in the previous patch, is_paging(vcpu).
> > 
> > I find a more tradition if-elif marginally easier to understand the implication
> > that CR0.PG is L2's CR0 and thus irrelevant if is_guest_mode()==true.  Not a big
> > deal though.
> > 
> > 	if (is_guest_mode(vcpu)) {
> > 		if (!vcpu->arch.apf.delivery_as_pf_vmexit)
> > 			return false;
> > 	} else if (!is_paging(vcpu)) {
> > 		return false;
> > 	}
> 
> Alternatively, what about reordering and refactoring to yield:
> 
> 	if (kvm_pv_async_pf_enabled(vcpu))
> 		return false;
> 
> 	if (vcpu->arch.apf.send_user_only &&
> 	    static_call(kvm_x86_get_cpl)(vcpu) == 0)
> 		return false;
> 
> 	/* L1 CR0.PG=1 is guaranteed if the vCPU is in guest mode (L2). */
> 	if (is_guest_mode(vcpu)
> 		return !vcpu->arch.apf.delivery_as_pf_vmexit;
> 
> 	return is_cr0_pg(vcpu->arch.mmu);
> 
> There isn't any need to "batch" the if statements.

Third time's a charm...

	if (kvm_pv_async_pf_enabled(vcpu))
		return false;

	if (vcpu->arch.apf.send_user_only &&
	    static_call(kvm_x86_get_cpl)(vcpu) == 0)
		return false;

	/* L1 CR0.PG=1 is guaranteed if the vCPU is in guest mode (L2). */
	if (is_guest_mode(vcpu))
		return !vcpu->arch.apf.delivery_as_pf_vmexit;

	return is_paging(vcpu);


