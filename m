Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0225A57A730
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiGSTX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiGSTX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:23:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D3545F9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:23:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e16so14474969pfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MTnX2TeXpHP7v1pQxn3jS/+EWjEsPRUgfU3phyOX21s=;
        b=AVYzqlSpLLX+2Dh2JJv/wP4Ov9MEYgY3fi0PRUL7nSg3XVbabk8dvbL2NdBEwLmCyi
         mlVYk6VbJIjFad4GBo9iwP4A0HvfVJy+x95dh1iz+tr1KLKSOg96SU4e4bBmNOYHQqMn
         iD7upg/MAIcOg7fRaddKNxPBOYxU60iqvJankRN8WAXhDo3SgHITdGG85DEfJsz81NUo
         vGPBeDydYt/J1BKbFCc54iJaKo8lCh6oK3XNLNEIR5TetdUnJqH1dyWShevXuDDcenBA
         zea/ahSlzqaT1zVqmJPBa7WzyDYVBKAS46wqnZRJCeiwN8JqLzc1eQ9KMNKEFDn3WTng
         xxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MTnX2TeXpHP7v1pQxn3jS/+EWjEsPRUgfU3phyOX21s=;
        b=EQz49Qz40euGyBrj4ZCjSlbfexeN9IaXf6JU8tSRqMkxr5K5DwJ2QOxJjmO34HXley
         HMOwkBL9N+tv1YwTUmpj5YAdeo6mLkNawPilbVD4wfRyPEANQsjYgs2Xkoj1WJ+STGvr
         5ZRi/bdwfM8SULQm/dk9Lp6iH1wKRoTEplInLkyCWZaOnczxShQ6iaytjHM7o0BEDvKU
         mLYLarO3Gt/sVvbATSkUIDU9QSt9VdyGh+YQ9pJ3c6kRwQt2yB4ldJ6Ftso5u/rhu1RT
         T34de0XUl7I7u4GVKw3RvR1Rsz8T5VA0kzQKtT3g5JnSeSGDhX/J0jTLT+MmlRam9gxJ
         eoVg==
X-Gm-Message-State: AJIora9uxY95Oo9FDGt5n1+ogGRzfy/+MN/24s9IuMFaw4iBlmbiA2xj
        IlJwq2CB1MSkiwCtZBlstTQ97Q==
X-Google-Smtp-Source: AGRyM1tdTRACG72ok5+gvUICVuap9dPfxWpcLRXvvt7dtpUivNWDJzFklYwXVDWM4t7qR09jo914hw==
X-Received: by 2002:a05:6a00:1781:b0:528:c839:9886 with SMTP id s1-20020a056a00178100b00528c8399886mr35174494pfg.71.1658258605007;
        Tue, 19 Jul 2022 12:23:25 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id n5-20020a17090a394500b001f1694dafb1sm8292616pjf.44.2022.07.19.12.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 12:23:24 -0700 (PDT)
Date:   Tue, 19 Jul 2022 19:23:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Sagi Shahar <sagis@google.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>
Subject: Re: [RFC PATCH v6 090/104] KVM: TDX: Handle TDX PV CPUID hypercall
Message-ID: <YtcEqMtjAHQ61ZR9@google.com>
References: <cover.1651774250.git.isaku.yamahata@intel.com>
 <98939c0ec83a109c8f49045e82096d6cdd5dafa3.1651774251.git.isaku.yamahata@intel.com>
 <CAAhR5DHPk2no0PVFX6P1NnZdwtVccjmdn4RLg4wKSmfpjD6Qkg@mail.gmail.com>
 <20220629101356.GA882746@ls.amr.corp.intel.com>
 <CAAhR5DF82HO4yEmOjywXXR-_wcXT7hctib2yfRaS-nb6sGPsLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhR5DF82HO4yEmOjywXXR-_wcXT7hctib2yfRaS-nb6sGPsLw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022, Sagi Shahar wrote:
> On Wed, Jun 29, 2022 at 3:14 AM Isaku Yamahata <isaku.yamahata@gmail.com> wrote:
> >
> > On Tue, Jun 14, 2022 at 11:15:00AM -0700,
> > Sagi Shahar <sagis@google.com> wrote:
> >
> > > On Thu, May 5, 2022 at 11:16 AM <isaku.yamahata@intel.com> wrote:
> > > >
> > > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > >
> > > > Wire up TDX PV CPUID hypercall to the KVM backend function.
> > > >
> > > > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > ---
> > > >  arch/x86/kvm/vmx/tdx.c | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >
> > > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > > > index 9c712f661a7c..c7cdfee397ec 100644
> > > > --- a/arch/x86/kvm/vmx/tdx.c
> > > > +++ b/arch/x86/kvm/vmx/tdx.c
> > > > @@ -946,12 +946,34 @@ static int tdx_emulate_vmcall(struct kvm_vcpu *vcpu)
> > > >         return 1;
> > > >  }
> > > >
> > > > +static int tdx_emulate_cpuid(struct kvm_vcpu *vcpu)
> > > > +{
> > > > +       u32 eax, ebx, ecx, edx;
> > > > +
> > > > +       /* EAX and ECX for cpuid is stored in R12 and R13. */
> > > > +       eax = tdvmcall_a0_read(vcpu);
> > > > +       ecx = tdvmcall_a1_read(vcpu);
> > > > +
> > > > +       kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx, true);
> > >
> > > According to the GHCI spec section 3.6
> > > (TDG.VP.VMCALL<Instruction.CPUID>) we should return
> > > VMCALL_INVALID_OPERAND if an invalid CPUID is requested.
> > >
> > > kvm_cpuid already returns false in this case so we should use that
> > > return value to set the tdvmcall return code in case of invalid leaf.
> >
> > Based on CPUID instruction, cpuid results in #UD when lock prefix is used or
> > earlier CPU that doesn't support cpuid instruction.
> > So I'm not sure what CPUID input result in INVALID_OPERAND error.
> > Does the following make sense for you?
> >
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -1347,7 +1347,7 @@ static int tdx_emulate_cpuid(struct kvm_vcpu *vcpu)
> >         eax = tdvmcall_a0_read(vcpu);
> >         ecx = tdvmcall_a1_read(vcpu);
> >
> > -       kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx, true);
> > +       kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx, false);

Barring new verbiage in the GHCI, this change is correct.  CPUID behavior is
different for AMD vs. Intel, but the behavior is architectural and well-defined
for each vendor.  KVM handles this by emulating the AMD vs. Intel behavior based
on the configured vCPU model.

Forcing an exact match would make TDX follow AMD behavior, not Intel behavior.

> >         tdvmcall_a0_write(vcpu, eax);
> >         tdvmcall_a1_write(vcpu, ebx);
> >
> > thanks,
> 
> If any CPUID request is considered valid, then perhaps the spec itself
> needs to be updated.

Agreed.  Documenting that "Invalid CPUID requested" is a legal return value implies
that TDX is creating a _third_ variant of CPUID behavior.  Dropping the error return
seems like the simplest approach, unless it was added for a specific reason?
