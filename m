Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F525568C45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiGFPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiGFPHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:07:43 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137CE2611C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:07:41 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id x31so569443uaf.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zfcy3m2aUEnWeUHn5XfX6u8AAnHVyZsNCC+cc8UeCsE=;
        b=le4jtK2QSjWURfVESc5K7w8QK2lwcPWnZWbLUUO5UuMF9/35xMgYsUlcS8EoJblZfS
         2HLA4JCYWWpa8fawH5oFR/7yHQVoeSVnVWi0ibMvNwlJaTV6k7WPA90fWRuq0LSivG+r
         uuVxQdQ0iuGfT+ao/jFhsgyrxsXM4YBEaOF8/TVlOom9nT9kvIhoJ53MuHloR4dzJ66l
         zsbbvO596XWQF9CUWoehgIJ414gSGLnYzHtIZgrKcz9Fxc648RDB09C/Kb5kjZ4IfskQ
         X1myZp1L6dcOveSxUwxkpOZ0nCqiqKjugJ0E+cqlLCuTQNctl8HNc9MBQjZTUwgEnPR0
         SNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zfcy3m2aUEnWeUHn5XfX6u8AAnHVyZsNCC+cc8UeCsE=;
        b=qC2XMoEDb9v70tQHI0B47ppg2FbfyiD3hV3wUILaRa1P28hFJRrKwKBPGlGVZxXKfN
         HzBd40lbjB8v/nswFv626xEeqXtf18oL7pNv58a8OvviAHTrOMRl3JiNEXQIfKbzj8ph
         geOV65+wbJ++ChV8dJY2CP4T/DQhhvyfhyOxr/m1lJAH3fU5NuaxxTB7oLi/NGhD9X1Z
         gyZiBKsazd88NI8IzHU88XbmPDdt5kElZ+KpeFQF/mxyB6Cxd2hInCMsK11cfzPvSdId
         3alko2hUuUafo4z85pbncfkvel8mqKdB/JYBWs/IRINL54eFwKfHz23qLMeuYF+2puYU
         Y8Zw==
X-Gm-Message-State: AJIora/oWgFi780uul9hXKweP9HcJwaozYiHnhmeM6U26Xd2hPU9Ysw7
        lUOi8FpLOnwdN82QxZWwoOCs5PCRDufyataufzUusQ==
X-Google-Smtp-Source: AGRyM1s48ooDVEVNaeipULKJ2uDLBt3vYCsJKr6Eh7LXVrZLaUsYil8k83ks7YpwaJ30mf1NQKDBiHb0MxOt/ut8QD8=
X-Received: by 2002:a9f:3155:0:b0:382:9191:6c4d with SMTP id
 n21-20020a9f3155000000b0038291916c4dmr8314242uab.98.1657120060698; Wed, 06
 Jul 2022 08:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220701165045.4074471-1-juew@google.com> <20220701165045.4074471-2-juew@google.com>
 <181c484aa33.6db8a9c7835812.4939150843849434525@siddh.me>
In-Reply-To: <181c484aa33.6db8a9c7835812.4939150843849434525@siddh.me>
From:   Jue Wang <juew@google.com>
Date:   Wed, 6 Jul 2022 08:07:29 -0700
Message-ID: <CAPcxDJ51EQwTZzNOzckRGXgE9s6X+rpDWFxvb8JZpAQQVjm1iQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86: Fix access to vcpu->arch.apic when the
 irqchip is not in kernel
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Matlack <dmatlack@google.com>,
        Tony Luck <tony.luck@intel.com>, kvm <kvm@vger.kernel.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Siddh,

Thanks for the note.

I've sent out an updated v2 patch:
https://lore.kernel.org/kvm/20220706145957.32156-2-juew@google.com/T/#u

Thanks,
-Jue


On Sun, Jul 3, 2022 at 7:44 AM Siddh Raman Pant <code@siddh.me> wrote:
>
> On Fri, 01 Jul 2022 22:20:45 +0530  Jue Wang <juew@google.com> wrote
> > Fix an access to vcpu->arch.apic when KVM_X86_SETUP_MCE is called
> > without KVM_CREATE_IRQCHIP called or KVM_CAP_SPLIT_IRQCHIP is
> > enabled.
> >
> > Fixes: 4b903561ec49 ("KVM: x86: Add Corrected Machine Check Interrupt (CMCI) emulation to lapic.")
> > Signed-off-by: Jue Wang <juew@google.com>
> > ---
> >  arch/x86/kvm/x86.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 4322a1365f74..d81020dd0fea 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -4820,8 +4820,9 @@ static int kvm_vcpu_ioctl_x86_setup_mce(struct kvm_vcpu *vcpu,
> >          if (mcg_cap & MCG_CMCI_P)
> >              vcpu->arch.mci_ctl2_banks[bank] = 0;
> >      }
> > -    vcpu->arch.apic->nr_lvt_entries =
> > -        KVM_APIC_MAX_NR_LVT_ENTRIES - !(mcg_cap & MCG_CMCI_P);
> > +    if (vcpu->arch.apic)
> > +        vcpu->arch.apic->nr_lvt_entries =
> > +            KVM_APIC_MAX_NR_LVT_ENTRIES - !(mcg_cap & MCG_CMCI_P);
> >
> >      static_call(kvm_x86_setup_mce)(vcpu);
> >  out:
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
> >
>
> Hello Jue,
>
> There is a syzkaller bug regarding null ptr dereference which is caused by
> vcpu->arch.apic being NULL, first reported on 27th June. You might want to
> add it's reported-by line so that it can be marked as fixed.
>
> Link: https://syzkaller.appspot.com/bug?id=10b9b238e087a6c9bef2cc48bee2375f58fabbfc
>
> I was looking at this bug too and fixed it (i.e. reproducer won't crash)
> using lapic_in_kernel(vcpu) as a condition instead of null ptr check on
> vcpu->arch.apic, as it makes more sense to the code reader (the lapic is
> not there since during kvm_arch_vcpu_create(), it isn't created due to
> irqchip_in_kernel() check being false).
>
> May I suggest that lapic_in_kernel(vcpu) be used instead of the null ptr
> check?
>
> Thanks,
> Siddh
