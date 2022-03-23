Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC534E598A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbiCWUHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbiCWUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:07:11 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E1C89CEC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:05:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2db2add4516so30342707b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ltQEm4jkJpPFO26laIPZcGY83DKyfBZ1sw0JUywVss=;
        b=Yuz2n+O88bMGFiLvP9JQxndEu9C7Bjz6BlwPzjdaGBLhQqxtKjxKwgQzPGtuW6RBpA
         fLSqBttEmGFiP58M7lAc+Cbl+gPbR/8iiTR/B8SuFYIXOxo3I11NNt8XN5PqBDwtvUSI
         TBEiBrieiwW1BfhbgQOc+eWIJfqUk6hlDxl+FxNVQjPTFAcqN7aGFtn82h5SOCBwTmyk
         B5EcSifU3q45VDJG0gz7lGIgg9C4z+Wk24+xgjoCChJPqnHmECF8iMbDGmLCKGHN4ty1
         eWXHa5DjNcpfK2fCwYGIA8ioxzhGm33Vz1l4GcXlZz6hpdIwWMeNSxtRD+g1SVfrMQNt
         DTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ltQEm4jkJpPFO26laIPZcGY83DKyfBZ1sw0JUywVss=;
        b=2/6DlPAusMXVGCPFLBGlxTLck7oDcixmDhqSwcv01yrRGCCfCFDBxycDPdOIwbFK7v
         TDGDOoelhg/7UuX7n+zBwWiVquNH+PgPF9HJiYymGnOX9DrLYLH+LnsXeRXldDDjn4sd
         vG/EYlnatxSQLNo3Y4sMRa5g2NjD5wZyw0qylib71uDlHQjDmwgGcaM+scj6gVqLktB/
         /qVe/oJMSSbXEji6XVAPzoNifo1eexjvhtQFgGXy7Pl6jnsGm/FBttganFD1+kSTAG0t
         SzOYnZqwYnxGZd2u+zZ31EYNmUv9EGbqVtpnMNfSQPgpdujjLteWvzNNpZxdsy3XczQT
         I0Ww==
X-Gm-Message-State: AOAM533g11EqwTUW+05gZc7VEDC0/krUswobRwPU2PalAc/es3km+rco
        MgL0i+gLZIH/6Ygjo0H7ChX0AwsOqHwjB7l6Bzry6Q==
X-Google-Smtp-Source: ABdhPJxDiIpzZ7WTx+jmKbHOAdv97rA0H0HYvVB8Owy+/SsU5Pne5Z9Fdnds0uwjTSiQ39wWWyqxQEfiZ+2F2Ldkyt0=
X-Received: by 2002:a0d:e80e:0:b0:2e5:ba68:80bc with SMTP id
 r14-20020a0de80e000000b002e5ba6880bcmr1771295ywe.350.1648065938422; Wed, 23
 Mar 2022 13:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <cedda3dbe8597356374ef64de26ecef0d8cd7a62.1646422845.git.isaku.yamahata@intel.com>
 <CAAYXXYy3QLWyq9QrEnrsOLB3r44QTgKaOW4=HhOozDuw1073Gg@mail.gmail.com> <20220323175552.GG1964605@ls.amr.corp.intel.com>
In-Reply-To: <20220323175552.GG1964605@ls.amr.corp.intel.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Wed, 23 Mar 2022 13:05:27 -0700
Message-ID: <CAAYXXYygcwW-Ai5qAAMpp_GprywV2=x02JYXfJxY2ac_EMKLvw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 064/104] KVM: TDX: Implement TDX vcpu enter/exit path
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Mar 23, 2022 at 10:55 AM Isaku Yamahata
<isaku.yamahata@gmail.com> wrote:
>
> On Tue, Mar 22, 2022 at 10:28:42AM -0700,
> Erdem Aktas <erdemaktas@google.com> wrote:
>
> > On Fri, Mar 4, 2022 at 11:50 AM <isaku.yamahata@intel.com> wrote:
> > > @@ -509,6 +512,37 @@ void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> > >         vcpu->kvm->vm_bugged = true;
> > >  }
> > >
> > > +u64 __tdx_vcpu_run(hpa_t tdvpr, void *regs, u32 regs_mask);
> > > +
> > > +static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
> > > +                                       struct vcpu_tdx *tdx)
> > > +{
> > > +       guest_enter_irqoff();
> > > +       tdx->exit_reason.full = __tdx_vcpu_run(tdx->tdvpr.pa, vcpu->arch.regs, 0);
> > > +       guest_exit_irqoff();
> > > +}
> > > +
> > > +fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu)
> > > +{
> > > +       struct vcpu_tdx *tdx = to_tdx(vcpu);
> > > +
> > > +       if (unlikely(vcpu->kvm->vm_bugged)) {
> > > +               tdx->exit_reason.full = TDX_NON_RECOVERABLE_VCPU;
> > > +               return EXIT_FASTPATH_NONE;
> > > +       }
> > > +
> > > +       trace_kvm_entry(vcpu);
> > > +
> > > +       tdx_vcpu_enter_exit(vcpu, tdx);
> > > +
> > > +       vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
> > > +       trace_kvm_exit(vcpu, KVM_ISA_VMX);
> > > +
> > > +       if (tdx->exit_reason.error || tdx->exit_reason.non_recoverable)
> > > +               return EXIT_FASTPATH_NONE;
> >
> > Looks like the above if statement has no effect. Just checking if this
> > is intentional.
>
> I'm not sure if I get your point.  tdx->exit_reason is updated by the above
> tdx_cpu_enter_exit().  So it makes sense to check .error or .non_recoverable.
> --
> Isaku Yamahata <isaku.yamahata@gmail.com>

What I mean is, if there is an error, it returns EXIT_FASTPATH_NONE
but if there is no error, it still returns EXIT_FASTPATH_NONE.

The code is like below, the if-statement might be there as a
placeholder to check errors but it has no impact on what is returned
from this function.

       if (tdx->exit_reason.error || tdx->exit_reason.non_recoverable)
               return EXIT_FASTPATH_NONE;
       return EXIT_FASTPATH_NONE;
