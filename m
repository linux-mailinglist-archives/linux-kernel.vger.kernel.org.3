Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5189346C1FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhLGRqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbhLGRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:46:05 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6569CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:42:34 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso19054880otr.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZyOSLRD+OOns9+yyRtcdOOhQIxKcBFv5MAHI5qU57h8=;
        b=kI6zf53RuzrPprRdot2VD1lXiadsOrPCq3R7Y+R+e3Hnszjo8W/y248q9/MbDGTWPk
         FE+3aCmxmwzYPfl64a3shrWHXn/Fw26u5gAnRKHQ1ynkXZdxIIbB7TY92ghtO83wMBRT
         1f78bu534VolDVq/oibdoEjcIVSptazGW8Tr0VV6v4V+BopvbNe+1G4xhHVnk49xvLoq
         5mwsi+sbo3tqWnTRx3O2ZgbJ4DGKSXuYSypCiUEGk0VMPTWcu0VLGTikqox/wFySGx8j
         2LxprfiwiaH9gr61x7XQ3KPc+Xg96xeAXvqZJhpZga1hulxqhvV3Fs9CFm4x3DksOoUS
         jj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZyOSLRD+OOns9+yyRtcdOOhQIxKcBFv5MAHI5qU57h8=;
        b=AHfXCJ0VtlFu/dxiq5MoGUK6e3fJChsVCwMNktRVlpnPUjlN70w+PzoaTITjKDncnH
         dSpu/lvxrcn5P1KSPP5WRExrCh/aFGzNC/OypJEHIwLJS19VB+0uPQ+hXaLoxNG+e14a
         44CSV1js0xuKXpeiLtXZ+OlmMSyu15pmtDnzL0mg7hJLtUPOj3ltRUCuX6zooDQRRtMF
         1PZDElK5KFA+Z712f0bw9H4BTD3UXopDwLvnmEVYc8F7QY4kLSUYRrjNyaHmpBAhSge3
         3J+CJGqUsbDDHVKDmsg31ao0hCQB8KIph2+4VwnzGxjBLnV1mOfSTj27EbLKLgn3Y25S
         2Owg==
X-Gm-Message-State: AOAM533O+/iBWF2s8Rks60bFvuhEW9vOa4fHUURb69GZTa2vdsm9ipXN
        1bzF6YSOOO468s7lUSsxGJ0VSNa5cOlGzYk9Jz332Q==
X-Google-Smtp-Source: ABdhPJwfBTn/IIYq01dVF804dzDnEe9hyh//gCAkH89rt4NSjhn675lKQ68LLKYKu00DJJJKgr2dW8Id55pdchBOwHA=
X-Received: by 2002:a05:6830:601:: with SMTP id w1mr35698440oti.267.1638898953399;
 Tue, 07 Dec 2021 09:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20211130074221.93635-1-likexu@tencent.com> <20211130074221.93635-2-likexu@tencent.com>
 <CALMp9eTq8H_bJOVKwi_7j3Kum9RvW6o-G3zCLUFco1A1cvNrkQ@mail.gmail.com> <7ca8ffcb-eb45-a47c-f91b-6dbd35ea8893@gmail.com>
In-Reply-To: <7ca8ffcb-eb45-a47c-f91b-6dbd35ea8893@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 7 Dec 2021 09:42:21 -0800
Message-ID: <CALMp9eSucAtacT-4pR2Du8b_aHtFeSSLGqsZMMQnOE+XVSgK0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: x86/pmu: Setup pmc->eventsel for fixed PMCs
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 10:08 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> On 7/12/2021 3:50 am, Jim Mattson wrote:
> > On Mon, Nov 29, 2021 at 11:42 PM Like Xu <like.xu.linux@gmail.com> wrote:
> >
> >> From: Like Xu <likexu@tencent.com>
> >>
> >> The current pmc->eventsel for fixed counter is underutilised. The
> >> pmc->eventsel can be setup for all known available fixed counters
> >> since we have mapping between fixed pmc index and
> >> the intel_arch_events array.
> >>
> >> Either gp or fixed counter, it will simplify the later checks for
> >> consistency between eventsel and perf_hw_id.
> >>
> >> Signed-off-by: Like Xu <likexu@tencent.com>
> >> ---
> >>   arch/x86/kvm/vmx/pmu_intel.c | 16 ++++++++++++++++
> >>   1 file changed, 16 insertions(+)
> >>
> >> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> >> index 1b7456b2177b..b7ab5fd03681 100644
> >> --- a/arch/x86/kvm/vmx/pmu_intel.c
> >> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> >> @@ -459,6 +459,21 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu,
> >> struct msr_data *msr_info)
> >>          return 1;
> >>   }
> >>
> >> +static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
> >> +{
> >> +       size_t size = ARRAY_SIZE(fixed_pmc_events);
> >> +       struct kvm_pmc *pmc;
> >> +       u32 event;
> >> +       int i;
> >> +
> >> +       for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> >> +               pmc = &pmu->fixed_counters[i];
> >> +               event = fixed_pmc_events[array_index_nospec(i, size)];
> >>
> >
> > How do we know that i < size? For example, Ice Lake supports 4
> > fixed counters, but fixed_pmc_events only has three entries.
>
> With the help of macro MAX_FIXED_COUNTERS,
> the fourth or more fixed counter is currently not supported in KVM.

Thanks for the hint. I see it now.

> If the user space sets a super set of CPUID supported by KVM,
> any pmu emulation failure is to be expected, right ?

Actually, I would expect a misconfigured VM to elicit an error. I
don't see the advantage of mis-emulating an unsupported configuration.
But maybe that's just me.

> Waiting for more comments from you on this patch set.

I'll try to get to them this week. Thanks for following up while I was
on holiday.

> >
> >
> >> +               pmc->eventsel = (intel_arch_events[event].unit_mask << 8) |
> >> +                       intel_arch_events[event].eventsel;
> >> +       }
> >> +}
> >> +
> >>
> >>
> >>
> >
