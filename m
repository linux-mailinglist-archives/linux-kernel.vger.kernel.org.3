Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CFE5AFB06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIGEPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIGEPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:15:35 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7EE844E2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:15:33 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1278624b7c4so14951756fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eQ6Yu6xWq0HWJF2rE+heb/FG8puUrwBwpaHndzsXi8s=;
        b=aM8f2yGn70tPngrR97C9af31RRdSIO9ioDrLJO5IFIMZzqALfdSHb6oh/BCLjrNygl
         95BVJQ39uUhseyD5bx6iH9zhiI0IAeKtRL735sd7JqJe6sfeIuzQu6mPXo8L5/zT+LCO
         tdI8nnOLHhs9dj3Tr1g3vDtjIJfKP0K2L1jbPpPLX9SgKcaGgfLGKlx5fPPs9+7YB8h6
         GMNyJtW4l4yZQ+o/6oPjP1yon0IWq6fzAUGYUax6lTJ5fiB3Vf1ZT3mAvAysrh5/cweW
         MTZZxzvFbTa6cvrUzZ9IlpQGDAnioz1fvf/u8Fb5dPCZHe5msZARQ9JZYwH6YEoxcgaa
         FcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eQ6Yu6xWq0HWJF2rE+heb/FG8puUrwBwpaHndzsXi8s=;
        b=xgOD7mo8JKLj718lGm+2fGtJU0wlp7xLAQ42/wOk/gODMUUDYEC78wjIPvt3xhavwQ
         Z6YigrhHBzkO10avA2cjZGDFDqaNPdKcoGJ5QFrbOyXOuAbQDVUpvKmrkdt0DjYCGV5l
         Pwi7PYo8a5sodOTCfHzEs9AH5GYzDSTM1Xf+bGPHrzJoMPRQUJwUXKzSEMFrDQ9hF0Ox
         vWCXbq0wGPKDup5DoAn0LdE2H8SZ8GHESj7VKhD7YCKpAs9qG5DOF4wRW9QUeQXUcbbv
         tn/jaDr5NLPctcTDFaAV/BOBHMc77AOLLMkbEVgQlS9Kdx94pASXy4meZItak07iSdAY
         v7DA==
X-Gm-Message-State: ACgBeo0zH+wNavNz3KtzcyDE+tVm0qIjHZ8pIJVDXQDmfuLSsy0pIBKB
        qSnuoODu3XumZisUYdFYFdmV3XkJlM0YF0i7FKGD3w==
X-Google-Smtp-Source: AA6agR4GlCy17RIcogHAoCj2FwlsDnUVzu9L9JDkWtmof7KMAm5vjCtvjIXzF+MhgodKj4/KNGp82uMmT5VEU2FtpGs=
X-Received: by 2002:a05:6870:41d0:b0:126:5d06:28a5 with SMTP id
 z16-20020a05687041d000b001265d0628a5mr825941oac.181.1662524132990; Tue, 06
 Sep 2022 21:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220905123946.95223-1-likexu@tencent.com> <20220905123946.95223-4-likexu@tencent.com>
 <CALMp9eSBK3xVKoqrk4j2yNqk+Jh0z-Nk-rwCTaTE0Dca5DQoPA@mail.gmail.com>
 <c9b3d50e-ec3d-3fa3-2706-5672100ffe09@gmail.com> <CALMp9eSQ1QkmECM4at9XDPUew0h2nxG5=YUSN=aWnQpZkXy2dw@mail.gmail.com>
 <41834a9f-e8d9-11a2-d391-1ce80758128c@gmail.com>
In-Reply-To: <41834a9f-e8d9-11a2-d391-1ce80758128c@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 6 Sep 2022 21:15:22 -0700
Message-ID: <CALMp9eSaqMf_Ww4yU3O5jaADWATe5ush5fziq-wWo22COyePmQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: x86/svm/pmu: Add AMD PerfMonV2 support
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sandipan Das <sandipan.das@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Sep 6, 2022 at 8:50 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> On 7/9/2022 4:19 am, Jim Mattson wrote:
> > On Tue, Sep 6, 2022 at 5:45 AM Like Xu <like.xu.linux@gmail.com> wrote:
> >>
> >> On 6/9/2022 2:00 am, Jim Mattson wrote:
> >>> On Mon, Sep 5, 2022 at 5:44 AM Like Xu <like.xu.linux@gmail.com> wrote:
> >>>>
> >>>> From: Like Xu <likexu@tencent.com>
> >>>>
> >>>> If AMD Performance Monitoring Version 2 (PerfMonV2) is detected
> >>>> by the guest, it can use a new scheme to manage the Core PMCs using
> >>>> the new global control and status registers.
> >>>>
> >>>> In addition to benefiting from the PerfMonV2 functionality in the same
> >>>> way as the host (higher precision), the guest also can reduce the number
> >>>> of vm-exits by lowering the total number of MSRs accesses.
> >>>>
> >>>> In terms of implementation details, amd_is_valid_msr() is resurrected
> >>>> since three newly added MSRs could not be mapped to one vPMC.
> >>>> The possibility of emulating PerfMonV2 on the mainframe has also
> >>>> been eliminated for reasons of precision.
> >>>>
> >>>> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> >>>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >>>> Signed-off-by: Like Xu <likexu@tencent.com>
> >>>> ---
> >>>>    arch/x86/kvm/pmu.c     |  6 +++++
> >>>>    arch/x86/kvm/svm/pmu.c | 50 +++++++++++++++++++++++++++++++++---------
> >>>>    arch/x86/kvm/x86.c     | 11 ++++++++++
> >>>>    3 files changed, 57 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> >>>> index 7002e1b74108..56b4f898a246 100644
> >>>> --- a/arch/x86/kvm/pmu.c
> >>>> +++ b/arch/x86/kvm/pmu.c
> >>>> @@ -455,12 +455,15 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >>>>
> >>>>           switch (msr) {
> >>>>           case MSR_CORE_PERF_GLOBAL_STATUS:
> >>>> +       case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
> >>>>                   msr_info->data = pmu->global_status;
> >>>>                   return 0;
> >>>>           case MSR_CORE_PERF_GLOBAL_CTRL:
> >>>> +       case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
> >>>>                   msr_info->data = pmu->global_ctrl;
> >>>>                   return 0;
> >>>>           case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> >>>> +       case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
> >>>>                   msr_info->data = 0;
> >>>>                   return 0;
> >>>>           default:
> >>>> @@ -479,12 +482,14 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >>>>
> >>>>           switch (msr) {
> >>>>           case MSR_CORE_PERF_GLOBAL_STATUS:
> >>>> +       case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
> >>>>                   if (msr_info->host_initiated) {
> >>>>                           pmu->global_status = data;
> >>>>                           return 0;
> >>>>                   }
> >>>>                   break; /* RO MSR */
> >>>>           case MSR_CORE_PERF_GLOBAL_CTRL:
> >>>> +       case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
> >>>>                   if (pmu->global_ctrl == data)
> >>>>                           return 0;
> >>>>                   if (kvm_valid_perf_global_ctrl(pmu, data)) {
> >>>> @@ -495,6 +500,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >>>>                   }
> >>>>                   break;
> >>>>           case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> >>>> +       case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
> >>>>                   if (!(data & pmu->global_ovf_ctrl_mask)) {
> >>>>                           if (!msr_info->host_initiated)
> >>>>                                   pmu->global_status &= ~data;
> >>>> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> >>>> index 3a20972e9f1a..4c7d408e3caa 100644
> >>>> --- a/arch/x86/kvm/svm/pmu.c
> >>>> +++ b/arch/x86/kvm/svm/pmu.c
> >>>> @@ -92,12 +92,6 @@ static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
> >>>>           return amd_pmc_idx_to_pmc(vcpu_to_pmu(vcpu), idx & ~(3u << 30));
> >>>>    }
> >>>>
> >>>> -static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
> >>>> -{
> >>>> -       /* All MSRs refer to exactly one PMC, so msr_idx_to_pmc is enough.  */
> >>>> -       return false;
> >>>> -}
> >>>> -
> >>>>    static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
> >>>>    {
> >>>>           struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> >>>> @@ -109,6 +103,29 @@ static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
> >>>>           return pmc;
> >>>>    }
> >>>>
> >>>> +static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
> >>>> +{
> >>>> +       struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> >>>> +
> >>>> +       switch (msr) {
> >>>> +       case MSR_K7_EVNTSEL0 ... MSR_K7_PERFCTR3:
> >>>> +               return pmu->version > 0;
> >>>> +       case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
> >>>> +               return guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE);
> >>>> +       case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
> >>>> +       case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
> >>>> +       case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
> >>>> +               return pmu->version > 1;
> >>>> +       default:
> >>>> +               if (msr > MSR_F15H_PERF_CTR5 &&
> >>>> +                   msr < MSR_F15H_PERF_CTL0 + 2 * KVM_AMD_PMC_MAX_GENERIC)
> >>>> +                       return pmu->version > 1;
> >>>
> >>> Should this be bounded by guest CPUID.80000022H:EBX[NumCorePmc]
> >>> (unless host-initiated)?
> >>
> >> Indeed, how about:
> >>
> >>          default:
> >>                  if (msr > MSR_F15H_PERF_CTR5 &&
> >>                      msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counters)
> >>                          return pmu->version > 1;
> >>
> >> and for host-initiated:
> >>
> >> #define MSR_F15H_PERF_MSR_MAX  \
> >>          (MSR_F15H_PERF_CTR0 + 2 * (KVM_AMD_PMC_MAX_GENERIC - 1))
> >
> > I think there may be an off-by-one error here.
>
> If KVM_AMD_PMC_MAX_GENERIC is 6:
>
> #define MSR_F15H_PERF_CTL               0xc0010200
> #define MSR_F15H_PERF_CTL5              (MSR_F15H_PERF_CTL + 10)
>
> #define MSR_F15H_PERF_CTR               0xc0010201
> #define MSR_F15H_PERF_CTR0              MSR_F15H_PERF_CTR
> #define MSR_F15H_PERF_CTR5              (MSR_F15H_PERF_CTR + 10)
>
> >
> >>
> >> kvm_{set|get}_msr_common()
> >>          case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_MSR_MAX:
>
> the original code is "case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:",
>
> in that case, MSR_F15H_PERF_MSR_MAX make sense, right ?

Right. I was misreading the definition.
