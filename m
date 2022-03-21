Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D04E3359
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiCUWzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiCUWys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:54:48 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7D37806A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:38:08 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v130so30621919ybe.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYTd46XXMIR/EBFVjL4wkBggwgjqAKgJIG8foIWgEVU=;
        b=qFwNYGnX+e22tchIGIjV+ocVkIfa8G9W7pb7GhR3piqlo1M6aJsZoF80AetZeF33t+
         qbJcMOfLLkvkiJWn1u+R0LhkbJ2d1jVaLpiv1qETysL+Lpa7AA+Ie/WzQHZgN8abrohh
         lCG5aB5mh5J3MjGse5g2KRTGwV/RX6g31qlMk2decWxmy61hJRWdF2fVUSOv6OhhP90k
         LZWBGL474isIc5KzWCCj0i0KP+hqPOsclgI8XG9smN9dTq9QkoW4Wz4YqxLn0IeaJXgT
         I9iqtEBurdtBHJHpJnTzA8P0N8CqvPoTKrZNXA8v8YJiPAIhlVTdFeYsSV4+78j+yprF
         txog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYTd46XXMIR/EBFVjL4wkBggwgjqAKgJIG8foIWgEVU=;
        b=0UNCqFCy18vjlYP/RzFc2jqAERVnnyH/BPF7JzmqKYg7+L+JHtHC82E272gaJekqvG
         P8qvYkREm6/ta5Nr/G0Fgbt62wUNQ5/TPwSDLZHqMFFoC/WmDZm4pJ4GpVvjhmFMr3WG
         2ARqPprkSctXfHkP9frbZyn8dLJ54Sh0tLvcELR49T27Aa8nQch7U1FIs42hSDPT2BAB
         ZPvNOYT2NVTj7QIOuuvP2Iy6mMKUO2TqVKXLs+s6AaGhwmfvdUyLPCmh/7OC9MujvzWX
         tzGDFfwXwpB5Re87D5XlCJFudQwq3heZUJDs93wYMta6XMgQC+g9TYcz52gu0ttug/Tg
         ZHfg==
X-Gm-Message-State: AOAM530nOYX3kYrjTkA9TCFTLVWJEsXOzT+8bC25q3I1WzSkyvu8xzlL
        qLQwUkB8IbAMX3UmUoYPAZxq7/KKvCoG97BhS6yn4AGC5kC5Wg==
X-Google-Smtp-Source: ABdhPJz83L5u7fcF/6pdKAPYZlCmmDwyFkbR0yvukYMy/bmnO8xACe84WQdxXh8v47Ko37hEaoSD67qkhnDw6a2llBc=
X-Received: by 2002:a9d:6e04:0:b0:5af:6426:6d39 with SMTP id
 e4-20020a9d6e04000000b005af64266d39mr8523074otr.75.1647900004351; Mon, 21 Mar
 2022 15:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220301143650.143749-1-mlevitsk@redhat.com> <20220301143650.143749-5-mlevitsk@redhat.com>
 <CALMp9eRjY6sX0OEBeYw4RsQKSjKvXKWOqRe=GVoQnmjy6D8deg@mail.gmail.com>
 <6a7f13d1-ed00-b4a6-c39b-dd8ba189d639@redhat.com> <CALMp9eRRT6pi6tjZvsFbEhrgS+zsNg827iLD4Hvzsa4PeB6W-Q@mail.gmail.com>
 <abe8584fa3691de1d6ae6c6617b8ea750b30fd1c.camel@redhat.com>
In-Reply-To: <abe8584fa3691de1d6ae6c6617b8ea750b30fd1c.camel@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 21 Mar 2022 14:59:53 -0700
Message-ID: <CALMp9eSUSexhPWMWXE1HpSD+movaYcdge_J95LiLCnJyMEp3WA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] KVM: x86: nSVM: support PAUSE filter threshold and
 count when cpu_pm=on
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>
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

On Mon, Mar 21, 2022 at 2:36 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Wed, 2022-03-09 at 11:07 -0800, Jim Mattson wrote:
> > On Wed, Mar 9, 2022 at 10:47 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > On 3/9/22 19:35, Jim Mattson wrote:
> > > > I didn't think pause filtering was virtualizable, since the value of
> > > > the internal counter isn't exposed on VM-exit.
> > > >
> > > > On bare metal, for instance, assuming the hypervisor doesn't intercept
> > > > CPUID, the following code would quickly trigger a PAUSE #VMEXIT with
> > > > the filter count set to 2.
> > > >
> > > > 1:
> > > > pause
> > > > cpuid
> > > > jmp 1
> > > >
> > > > Since L0 intercepts CPUID, however, L2 will exit to L0 on each loop
> > > > iteration, and when L0 resumes L2, the internal counter will be set to
> > > > 2 again. L1 will never see a PAUSE #VMEXIT.
> > > >
> > > > How do you handle this?
> > > >
> > >
> > > I would expect that the same would happen on an SMI or a host interrupt.
> > >
> > >         1:
> > >         pause
> > >         outl al, 0xb2
> > >         jmp 1
> > >
> > > In general a PAUSE vmexit will mostly benefit the VM that is pausing, so
> > > having a partial implementation would be better than disabling it
> > > altogether.
> >
> > Indeed, the APM does say, "Certain events, including SMI, can cause
> > the internal count to be reloaded from the VMCB." However, expanding
> > that set of events so much that some pause loops will *never* trigger
> > a #VMEXIT seems problematic. If the hypervisor knew that the PAUSE
> > filter may not be triggered, it could always choose to exit on every
> > PAUSE.
> >
> > Having a partial implementation is only better than disabling it
> > altogether if the L2 pause loop doesn't contain a hidden #VMEXIT to
> > L0.
> >
>
> Hi!
>
> You bring up a very valid point, which I didn't think about.
>
> However after thinking about this, I think that in practice,
> this isn't a show stopper problem for exposing this feature to the guest.
>
>
> This is what I am thinking:
>
> First lets assume that the L2 is malicious. In this case no doubt
> it can craft such a loop which will not VMexit on PAUSE.
> But that isn't a problem - instead of this guest could have just used NOP
> which is not possible to intercept anyway - no harm is done.
>
> Now lets assume a non malicious L2:
>
>
> First of all the problem can only happen when a VM exit is intercepted by L0,
> and not by L1. Both above cases usually don't pass this criteria since L1 is highly
> likely to intercept both CPUID and IO port access. It is also highly unlikely
> to allow L2 direct access to L1's mmio ranges.
>
> Overall there are very few cases of deterministic vm exit which is intercepted
> by L0 but not L1. If that happens then L1 will not catch the PAUSE loop,
> which is not different much from not catching it because of not suitable
> thresholds.
>
> Also note that this is an optimization only - due to count and threshold,
> it is not guaranteed to catch all pause loops - in fact hypervisor has
> to guess these values, and update them in attempt to catch as many such
> loops as it can.
>
> I think overall it is OK to expose that feature to the guest
> and it should even improve performance in some cases - currently
> at least nested KVM intercepts every PAUSE otherwise.

Can I at least request that this behavior be documented as a KVM
virtual CPU erratum?

>
> Best regards,
>         Maxim Levitsky
>
>
>
>
