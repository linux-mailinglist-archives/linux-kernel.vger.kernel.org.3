Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B462B5890BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiHCQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiHCQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:45:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11AF1ADB0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:45:35 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f65so15588467pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zvXdeRuA5sLY5zynbWXHtTh6B+8PVsCOPRs6rWFCsCI=;
        b=a4BdvhaGeDTpBJ744nfOprIfMN+VxMz6rcQGh159BErSpIQVDJJ8K5rcpUOiwkJIbq
         ccSLQ1wgw9Ep9j++KSkTPXDXO8/n+JRs7l5XCCIZ2GAm8bzHnkQI0OPS40LNIPmfAsJ/
         irRjfhnjq1cav+2d3lCNenk0kDxX+Ku/+0+0GtHaX2d1tChKTD8jju2INtlYSBOggylg
         te/7q5M3lPuUquNndM2le/pCUfAFV7mv4Ymt/pySn7yd/xEeMb7Q6SUTYYfZOfmuGdb8
         K+KRJjNHk2q55xTTigO8fVlwxsnr74LeBxbLHMgJ0ufrF3+9YIzk0RvatoJfq+gSYkLa
         W1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zvXdeRuA5sLY5zynbWXHtTh6B+8PVsCOPRs6rWFCsCI=;
        b=GzglVd2e8KgiHJgWLZYqYDUTCQT5Py9uBQvNc/kHiOYw5k7JoAE99TLB7VOcSkJ7e/
         1XWMJ+68SK8+CFVat1WT6SSt0XXCkYGybaIaBYvhKlbdwS6qnZNuOFyhAFVJW00rWp2u
         1IHhSIpabDTzunxV+WtoAvuJsqpbJopkiPQVhWMy3mXVqkXnH7NOaBHpT6hLnF94B/Iv
         MNUKFwLWLDtzqNW+nb0ltIRUOViDJubS2zD7q4KCGi1jp6aKsBGFVovTNk8ItTxT/lB9
         +EdpBj3iVZyN1ubNIHfzUjyGzs60oOyo4gU8V3d1lL37QWIWX7NIIRrUfcsYziM78Bre
         myOA==
X-Gm-Message-State: ACgBeo3f8IjbdJozKSpvCQqIoOceeEdymIyT+QXoPhl1b2cRW1zwx3Rl
        gASPkiGnBi5xIYPVxro4QgDIoQ==
X-Google-Smtp-Source: AA6agR6Au7Zfg+OM55tlZl8j7l1vuaz6zzcbeNJcOPK1uMadkFvbbF8MajabNMEfQA8B9JXdsg9kGA==
X-Received: by 2002:a05:6a00:1993:b0:52d:951a:d0ad with SMTP id d19-20020a056a00199300b0052d951ad0admr13205062pfl.47.1659545134954;
        Wed, 03 Aug 2022 09:45:34 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b0016d9d6d05f7sm2245614ple.273.2022.08.03.09.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:45:34 -0700 (PDT)
Date:   Wed, 3 Aug 2022 16:45:30 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 1/5] KVM: x86: Get vmcs12 pages before checking pending
 interrupts
Message-ID: <YuqmKkxEsDwBvayo@google.com>
References: <20220802230718.1891356-1-mizhang@google.com>
 <20220802230718.1891356-2-mizhang@google.com>
 <060419e118445978549f0c7d800f96a9728c157c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060419e118445978549f0c7d800f96a9728c157c.camel@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022, Maxim Levitsky wrote:
> On Tue, 2022-08-02 at 23:07 +0000, Mingwei Zhang wrote:
> > From: Oliver Upton <oupton@google.com>
> > 
> > vmx_guest_apic_has_interrupts implicitly depends on the virtual APIC
> > page being present + mapped into the kernel address space. However, with
> > demand paging we break this dependency, as the KVM_REQ_GET_VMCS12_PAGES
> > event isn't assessed before entering vcpu_block.
> > 
> > Fix this by getting vmcs12 pages before inspecting the guest's APIC
> > page. Note that upstream does not have this issue, as they will directly
> > get the vmcs12 pages on vmlaunch/vmresume instead of relying on the
> > event request mechanism. However, the upstream approach is problematic,
> > as the vmcs12 pages will not be present if a live migration occurred
> > before checking the virtual APIC page.
> 
> Since this patch is intended for upstream, I don't fully understand
> the meaning of the above paragraph.

My apology. Some of the statement needs to be updated, which I should do
before sending. But I think the point here is that there is a missing
get_nested_state_pages() call here within vcpu_block() when there is the
request of KVM_REQ_GET_NESTED_STATE_PAGES.

> 
> 
> > 
> > Signed-off-by: Oliver Upton <oupton@google.com>
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  arch/x86/kvm/x86.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 5366f884e9a7..1d3d8127aaea 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -10599,6 +10599,23 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
> >  {
> >  	bool hv_timer;
> >  
> > +	/*
> > +	 * We must first get the vmcs12 pages before checking for interrupts
> > +	 * that might unblock the guest if L1 is using virtual-interrupt
> > +	 * delivery.
> > +	 */
> > +	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
> > +		/*
> > +		 * If we have to ask user-space to post-copy a page,
> > +		 * then we have to keep trying to get all of the
> > +		 * VMCS12 pages until we succeed.
> > +		 */
> > +		if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
> > +			kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> > +			return 0;
> > +		}
> > +	}
> > +
> >  	if (!kvm_arch_vcpu_runnable(vcpu)) {
> >  		/*
> >  		 * Switch to the software timer before halt-polling/blocking as
> 
> 
> If I understand correctly, you are saying that if apic backing page is migrated in post copy
> then 'get_nested_state_pages' will return false and thus fail?

What I mean is that when the vCPU was halted and then migrated in this
case, KVM did not call get_nested_state_pages() before getting into
kvm_arch_vcpu_runnable(). This function checks the apic backing page and
fails on that check and triggered the warning.
> 
> AFAIK both SVM and VMX versions of 'get_nested_state_pages' assume that this is not the case
> for many things like MSR bitmaps and such - they always uses non atomic versions
> of guest memory access like 'kvm_vcpu_read_guest' and 'kvm_vcpu_map' which
> supposed to block if they attempt to access HVA which is not present, and then
> userfaultd should take over and wake them up.

You are right here.
> 
> If that still fails, nested VM entry is usually failed, and/or the whole VM
> is crashed with 'KVM_EXIT_INTERNAL_ERROR'.
> 
> Anything I missed? 
> 
> Best regards,
> 	Maxim Levitsky
> 
