Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124B84D1CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348183AbiCHQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiCHQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:10:36 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D87A4FC7A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:09:39 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id j83so8645210oih.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4bG9ceNDXZVVDENiolsCGhpylb9dUhIx0aVVVy9Bke4=;
        b=HQ0DyEWKpny5lxdCG2aCDyQ7Balh4hyLGaA20bc+yEU55VOW2NWcYOA3XRqVcrPhc2
         3yqXu54hPjELKwKFbhISE5ffAvubeegWVOf2mBDeA5UotkqQIqT/lvBtLIsIl3EgI4ys
         HKL2jFWnT3Ft5Vo64glxv7T7AQUN/uwTpsl+cZ2Oj5P8rv0YCzNf9bQi5jkzWaJiUh0v
         SgwWKqegWKhcK6Fnq6LlRZGOttQ4BYbnyqFXuwyan3tkp+YWr0SErC5ugY7+wqZpbfPF
         dCXJO8uZd9O7/Cw+oKtytfqdf5SMKyxrD3hXUDIw1UCBMnk8I2zCm1fv+uITuVSE/xlt
         ftcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4bG9ceNDXZVVDENiolsCGhpylb9dUhIx0aVVVy9Bke4=;
        b=u3YI2+KAoFEcu4gQl30a4Tq+l9iqpdniTshXhQScOsd08+Wlvbc6x3d8M/E6J5cecM
         E1hX+P5LQZJROA0ps8umoQgMTkxUd4SQmLfhgdUXHbauJC1cy5Q0C4/OM9OE8YZOOb8A
         yB+PpMag56wDxdppruF8m2ZbUrEskPQ3r6W3SAhQ8SegN2PC7gdsuWkQx1UnSl4pvEzu
         nu7psU8Mel7meLs4r41sPJaFpRVoE/AI0I9sVywaWjlKnXrrghEOBaFDfavnV4CYBaVJ
         RvAxvzcOblEOGxDotWran9YnPgn8wErpUNtbOBWqLT0fx3mQi/ytpXsY+OgmB1B+ixsx
         FWKw==
X-Gm-Message-State: AOAM533DRusccb+yq0bPAhN6c82l5nNg3yje/7wWkXDVeRa6/7oCysRw
        YAyPNkp14y1qLcE69xqiVj7mI+ggN2gnBJ4G6zR08A==
X-Google-Smtp-Source: ABdhPJx41Ac3Fm6O2cmDT23l61/ZBODg0dY8O8XqOO87o5j59Bah/88xxjGoqFa2f4t+5iGybo7Qt1hLdbHTl4SMMs8=
X-Received: by 2002:a05:6808:118d:b0:2d9:a01a:48c2 with SMTP id
 j13-20020a056808118d00b002d9a01a48c2mr2986270oil.269.1646755778269; Tue, 08
 Mar 2022 08:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20220307063805.65030-1-likexu@tencent.com> <CALMp9eSCWxM5-_-S6SK_0o-aTCWGzyut-L2qsqnaeR_dJc6n3g@mail.gmail.com>
 <f1f846f6-a544-d38c-beef-611bf70c4fcc@gmail.com>
In-Reply-To: <f1f846f6-a544-d38c-beef-611bf70c4fcc@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 8 Mar 2022 08:09:27 -0800
Message-ID: <CALMp9eRN47AJL7MPPUdFN7Q8HmuJ_PjNWk=TyWQ6NcMS5ffn6w@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Isolate TSX specific perf_event_attr.attr
 logic for AMD
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 8, 2022 at 3:59 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> On 8/3/2022 5:39 am, Jim Mattson wrote:
> > On Sun, Mar 6, 2022 at 10:38 PM Like Xu <like.xu.linux@gmail.com> wrote=
:
> >>
> >> From: Like Xu <likexu@tencent.com>
> >>
> >> HSW_IN_TX* bits are used in generic code which are not supported on
> >> AMD. Worse, these bits overlap with AMD EventSelect[11:8] and hence
> >> using HSW_IN_TX* bits unconditionally in generic code is resulting in
> >> unintentional pmu behavior on AMD. For example, if EventSelect[11:8]
> >> is 0x2, pmc_reprogram_counter() wrongly assumes that
> >> HSW_IN_TX_CHECKPOINTED is set and thus forces sampling period to be 0.
> >>
> >> Opportunistically remove two TSX specific incoming parameters for
> >> the generic interface reprogram_counter().
> >>
> >> Fixes: 103af0a98788 ("perf, kvm: Support the in_tx/in_tx_cp modifiers =
in KVM arch perfmon emulation v5")
> >> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >> Signed-off-by: Like Xu <likexu@tencent.com>
> >> ---
> >> Note: this patch is based on [1] which is considered to be a necessary=
 cornerstone.
> >> [1] https://lore.kernel.org/kvm/20220302111334.12689-1-likexu@tencent.=
com/
> >>
> >>   arch/x86/kvm/pmu.c | 29 ++++++++++++++---------------
> >>   1 file changed, 14 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> >> index 17c61c990282..d0f9515c37dd 100644
> >> --- a/arch/x86/kvm/pmu.c
> >> +++ b/arch/x86/kvm/pmu.c
> >> @@ -99,8 +99,7 @@ static void kvm_perf_overflow(struct perf_event *per=
f_event,
> >>
> >>   static void pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type,
> >>                                    u64 config, bool exclude_user,
> >> -                                 bool exclude_kernel, bool intr,
> >> -                                 bool in_tx, bool in_tx_cp)
> >> +                                 bool exclude_kernel, bool intr)
> >>   {
> >>          struct perf_event *event;
> >>          struct perf_event_attr attr =3D {
> >> @@ -116,16 +115,18 @@ static void pmc_reprogram_counter(struct kvm_pmc=
 *pmc, u32 type,
> >>
> >>          attr.sample_period =3D get_sample_period(pmc, pmc->counter);
> >>
> >> -       if (in_tx)
> >> -               attr.config |=3D HSW_IN_TX;
> >> -       if (in_tx_cp) {
> >> -               /*
> >> -                * HSW_IN_TX_CHECKPOINTED is not supported with nonzer=
o
> >> -                * period. Just clear the sample period so at least
> >> -                * allocating the counter doesn't fail.
> >> -                */
> >> -               attr.sample_period =3D 0;
> >> -               attr.config |=3D HSW_IN_TX_CHECKPOINTED;
> >> +       if (guest_cpuid_is_intel(pmc->vcpu)) {
> >
> > This is not the right condition to check. Per the SDM, both bits 32
> > and 33 "may only be set if the processor supports HLE or RTM." On
> > other Intel processors, this bit is reserved and any attempts to set
> > them result in a #GP.
>
> We already have this part of the code:
>
>         entry =3D kvm_find_cpuid_entry(vcpu, 7, 0);
>         if (entry &&
>             (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RT=
M)) &&
>             (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM)))
>                 pmu->reserved_bits ^=3D HSW_IN_TX|HSW_IN_TX_CHECKPOINTED;

I stand corrected.

> > additional constraint which is ignored here: "This bit may only be set
> > for IA32_PERFEVTSEL2." I have confirmed that a #GP is raised for an
> > attempt to set bit 33 in any PerfEvtSeln other than PerfEvtSel2 on a
> > Broadwell Xeon E5.
>
> Yes, "19.3.6.5 Performance Monitoring and Intel=C2=AE TSX".
>
> I'm not sure if the host perf scheduler indicate this restriction.

Whether it does or it doesn't, it's KVM's responsibility to synthesize
the #GP if IN_TXCP is set for any PerfEvtSeln other than PerfEvtSel2.
