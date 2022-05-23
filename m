Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B9F5314E5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbiEWQYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiEWQXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:23:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE1868328
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:23:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so18017815pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjexXrGS7BxPzeGdf9fCf6kgZQFaox1zpS8kJ4DMpls=;
        b=COW4CzMEUCXsynuc100zu1EoLrCfj0MekuJROwqYmgCFNGXfxSDg+KcKldwTEFn+Sa
         Ua1T4qgyUJoePe96Y5fhHd8+QlrOg6noSDJhJEmtL7sBm04iHJuYZfoS4DTMaKWbQJHF
         9jA4ZCZ6VNAvX29zI2pnOre0FcuXIgOuSPvq+yPNrVG7s9mq/PrGv4I4Fpoe+uCyzGRu
         nNe363HwBbHnmLI+XvTbrNdeqlCytzUorGakLi3iMK3YerH4eRighb5cbRgebA+6LN73
         u7u4cI/KXIZHTO/qZlyKCPRBozCBGlAASkVFfV1dcvEWMZ9/hWg5seRJFQ5O345pi+/n
         QFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjexXrGS7BxPzeGdf9fCf6kgZQFaox1zpS8kJ4DMpls=;
        b=Lh+EcGVU9EXMr2g+on5seki+VzPCX0oRS+FNkR7R3PwwT5Wqk5AnBlMRZJT559wPsH
         uJvjTMr0XFw+ecduADjdU+4lvR8mGjRKugztXbQ6xPXULg7NOmceQq4cT6Iu/JrNEDpL
         BeFHI6ACO0J2FhMuBOds56skqaWvgn/9PCQyqkDIYzrZu+uSQqZi+k8Sq3DNRFWDgFHg
         Zyiv18lbtgEmcIFXjikAun6r31WjEi6OU4VHtUdSbyNlmZaW4JGCF0KXCo1An+qLmlTj
         J40JlEMhOUQtkPrgARyIb8HDvujDkL14VBxMcUh5PMGKyggAOa9+5yJDkGUiJCMbd/ft
         bpJA==
X-Gm-Message-State: AOAM531Jjd/lVpIsPfVc0885s2dOq0AA1HBUHV5DV+B9VYWlrHGnCqo8
        aFB5Z94woGB7AFDnYnz5bWgMDQ==
X-Google-Smtp-Source: ABdhPJxiCIrt0CBgMKNVza4j0yYrc/SsaUFLLrGxTaqpj7e5byzn61qU00FPEv9zqJi+LE8Fzw1LSA==
X-Received: by 2002:a17:902:f708:b0:153:839f:bf2c with SMTP id h8-20020a170902f70800b00153839fbf2cmr23430337plo.113.1653323029921;
        Mon, 23 May 2022 09:23:49 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b005181133ff2dsm7670428pfh.176.2022.05.23.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:23:49 -0700 (PDT)
Date:   Mon, 23 May 2022 16:23:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] KVM: selftests: Add a test to get/set triple
 fault event
Message-ID: <You1Eq6fp8F3YF5Z@google.com>
References: <20220421072958.16375-1-chenyi.qiang@intel.com>
 <20220421072958.16375-3-chenyi.qiang@intel.com>
 <YoVHAIGcFgJit1qp@google.com>
 <5c5a7597-d6e3-7a05-ead8-659c45aea222@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c5a7597-d6e3-7a05-ead8-659c45aea222@intel.com>
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

On Mon, May 23, 2022, Chenyi Qiang wrote:
> 
> 
> On 5/19/2022 3:20 AM, Sean Christopherson wrote:
> > On Thu, Apr 21, 2022, Chenyi Qiang wrote:
> > > +#ifndef __x86_64__
> > > +# error This test is 64-bit only
> > 
> > No need, all of KVM selftests are 64-bit only.
> > 
> > > +#endif
> > > +
> > > +#define VCPU_ID			0
> > > +#define ARBITRARY_IO_PORT	0x2000
> > > +
> > > +/* The virtual machine object. */
> > > +static struct kvm_vm *vm;
> > > +
> > > +static void l2_guest_code(void)
> > > +{
> > > +	/*
> > > +	 * Generate an exit to L0 userspace, i.e. main(), via I/O to an
> > > +	 * arbitrary port.
> > > +	 */
> > 
> > I think we can test a "real" triple fault without too much effort by abusing
> > vcpu->run->request_interrupt_window.  E.g. map the run struct into L2, clear
> > PIN_BASED_EXT_INTR_MASK in vmcs12, and then in l2_guest_code() do:
> > 
> > 	asm volatile("cli");
> > 
> > 	run->request_interrupt_window = true;
> > 
> 
> Maybe, A GUEST_SYNC to main() to change the request_interrupt_window also
> works.

Hmm, yes, that should work too.  Feel free to punt on writing this sub-test.  As
mentioned below, KVM should treat a pending triple fault as a pending "exception",
i.e. userspace shouldn't see KVM_EXIT_IRQ_WINDOW_OPEN with a pending triple fault,
and so the test should actually assert that the triple fault occurs in L2.  But I
can roll that test into the KVM fix if you'd like.

> > 	asm volatile("sti; ud2");
> > 
> 
> How does the "real" triple fault occur here? Through UD2?

Yeah.  IIRC, by default L2 doesn't have a valid IDT, so any fault will escalate to
a triple fault.

> > 	asm volatile("inb %%dx, %%al"
> > 		     : : [port] "d" (ARBITRARY_IO_PORT) : "rax"); 	
> > 
> > The STI shadow will block the IRQ-window VM-Exit until after the ud2, i.e. until
> > after the triple fault is pending.
> > 
> > And then main() can
> > 
> >    1. verify it got KVM_EXIT_IRQ_WINDOW_OPEN with a pending triple fault
> >    2. clear the triple fault and re-enter L1+l2
> >    3. continue with the existing code, e.g. verify it got KVM_EXIT_IO, stuff a
> >       pending triple fault, etc...
> > 
> > That said, typing that out makes me think we should technically handle/prevent this
> > in KVM since triple fault / shutdown is kinda sorta just a special exception.
