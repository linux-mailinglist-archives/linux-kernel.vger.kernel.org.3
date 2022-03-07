Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D44D0A26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiCGVn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiCGVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:42:32 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90DEB1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:39:24 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 12so16756921oix.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 13:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhSYw4NmArzisFqWEXKxm1GyZhRwR/YO2qh43jj+yRw=;
        b=d9KzZupXoDXPX0VMzbCr0+FY+MPPRnmIBFMkyDtUpTyR9ykBAgAHn9Lwe8m6pMv4aC
         nXATzYNe0bmf8vhjN/Tb5LtQfUHwwgotlZywUxSvs2qFKGuKQZ1MVDsINbkvXXyWf7e1
         /WYXq5ZQelny0kTLkkdc11bpc2wBdHbOnK0KUWvvfOEqJjKQVq3MEpPC/VX2d/dj8H6H
         MZmPpDlwYjjdEZtRdxeRVmxOTj4iZueAe+Mu1U15Lq9x2fJhXwUQ79FzUJI/Qc6tAHbc
         +UDR1wsJhoo/Be2oenpUPfudMENweSOFf5LzyYjTj26UyONlvrkuAfLLZqJ2aP8GTw/F
         8r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhSYw4NmArzisFqWEXKxm1GyZhRwR/YO2qh43jj+yRw=;
        b=c4nNBji9AxCCkJyTvMkXGpEU6VHhIyhS1pMG3asBQgkpF+tk1j9aBrToraZnn99Gju
         2tiHjVR0M9hk1b8/UlNu8dtEBmcGQY4yerfHWorLVe3IgL4AZL4VlR6lXRvOir9x1qjs
         3t9KhGeoxilD1w36lFU/sQZjIl8In9BjzQw5GjZJHQ0ETaIv4n5vRXCE8/XyBY70OA/c
         K1ABqhTdE8Gg6xjSRqjPG61GSvyQoZuQCFvTl0gtRoh49gGrXgtVcQjisN9ck3cCNhsF
         gqcxMrBv9V2DueiSjop4xONz5AMmsA57GoKBL4bB94YVcyngi9wHVGtEz4VFqZikEdEJ
         sJSA==
X-Gm-Message-State: AOAM530JNvNxbcIKJ/eykpblBO77zg6W6+v9yf+RramWdA+Byu3AdA/T
        w7XPdtkOKvC7D03+DkHAE1vhzOhZ4HRa/OaHDvaq6g==
X-Google-Smtp-Source: ABdhPJzYlrEg4xvWZAY47FhUP8E1GimC3kgW3oQM5hTtcL+RgeypqcLNDtdd0PjAMd48I+vq92jJ6Eh56zWzHmWOjyI=
X-Received: by 2002:a05:6808:1446:b0:2d5:281f:9cda with SMTP id
 x6-20020a056808144600b002d5281f9cdamr687506oiv.13.1646689161173; Mon, 07 Mar
 2022 13:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20220307063805.65030-1-likexu@tencent.com>
In-Reply-To: <20220307063805.65030-1-likexu@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 7 Mar 2022 13:39:10 -0800
Message-ID: <CALMp9eSCWxM5-_-S6SK_0o-aTCWGzyut-L2qsqnaeR_dJc6n3g@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Isolate TSX specific perf_event_attr.attr
 logic for AMD
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
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

On Sun, Mar 6, 2022 at 10:38 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> HSW_IN_TX* bits are used in generic code which are not supported on
> AMD. Worse, these bits overlap with AMD EventSelect[11:8] and hence
> using HSW_IN_TX* bits unconditionally in generic code is resulting in
> unintentional pmu behavior on AMD. For example, if EventSelect[11:8]
> is 0x2, pmc_reprogram_counter() wrongly assumes that
> HSW_IN_TX_CHECKPOINTED is set and thus forces sampling period to be 0.
>
> Opportunistically remove two TSX specific incoming parameters for
> the generic interface reprogram_counter().
>
> Fixes: 103af0a98788 ("perf, kvm: Support the in_tx/in_tx_cp modifiers in KVM arch perfmon emulation v5")
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
> Note: this patch is based on [1] which is considered to be a necessary cornerstone.
> [1] https://lore.kernel.org/kvm/20220302111334.12689-1-likexu@tencent.com/
>
>  arch/x86/kvm/pmu.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 17c61c990282..d0f9515c37dd 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -99,8 +99,7 @@ static void kvm_perf_overflow(struct perf_event *perf_event,
>
>  static void pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type,
>                                   u64 config, bool exclude_user,
> -                                 bool exclude_kernel, bool intr,
> -                                 bool in_tx, bool in_tx_cp)
> +                                 bool exclude_kernel, bool intr)
>  {
>         struct perf_event *event;
>         struct perf_event_attr attr = {
> @@ -116,16 +115,18 @@ static void pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type,
>
>         attr.sample_period = get_sample_period(pmc, pmc->counter);
>
> -       if (in_tx)
> -               attr.config |= HSW_IN_TX;
> -       if (in_tx_cp) {
> -               /*
> -                * HSW_IN_TX_CHECKPOINTED is not supported with nonzero
> -                * period. Just clear the sample period so at least
> -                * allocating the counter doesn't fail.
> -                */
> -               attr.sample_period = 0;
> -               attr.config |= HSW_IN_TX_CHECKPOINTED;
> +       if (guest_cpuid_is_intel(pmc->vcpu)) {

This is not the right condition to check. Per the SDM, both bits 32
and 33 "may only be set if the processor supports HLE or RTM." On
other Intel processors, this bit is reserved and any attempts to set
them result in a #GP.

> +               if (pmc->eventsel & HSW_IN_TX)
> +                       attr.config |= HSW_IN_TX;

This statement does nothing. If HSW_IN_TX is set in pmc->eventsel, it
is set in attr.config already.

> +               if (pmc->eventsel & HSW_IN_TX_CHECKPOINTED) {
> +                       /*
> +                        * HSW_IN_TX_CHECKPOINTED is not supported with nonzero
> +                        * period. Just clear the sample period so at least
> +                        * allocating the counter doesn't fail.
> +                        */
> +                       attr.sample_period = 0;
> +                       attr.config |= HSW_IN_TX_CHECKPOINTED;

As above, this statement does nothing. We should just set
attr.sample_period to 0. Note, however, that the SDM documents an
additional constraint which is ignored here: "This bit may only be set
for IA32_PERFEVTSEL2." I have confirmed that a #GP is raised for an
attempt to set bit 33 in any PerfEvtSeln other than PerfEvtSel2 on a
Broadwell Xeon E5.

> +               }
>         }
>
>         event = perf_event_create_kernel_counter(&attr, -1, current,
> @@ -268,9 +269,7 @@ void reprogram_counter(struct kvm_pmc *pmc)
>                         (eventsel & AMD64_RAW_EVENT_MASK),
>                         !(eventsel & ARCH_PERFMON_EVENTSEL_USR),
>                         !(eventsel & ARCH_PERFMON_EVENTSEL_OS),
> -                       eventsel & ARCH_PERFMON_EVENTSEL_INT,
> -                       (eventsel & HSW_IN_TX),
> -                       (eventsel & HSW_IN_TX_CHECKPOINTED));
> +                       eventsel & ARCH_PERFMON_EVENTSEL_INT);
>  }
>  EXPORT_SYMBOL_GPL(reprogram_counter);
>
> --
> 2.35.1
>
