Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52A94EE07E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiCaSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiCaSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:34:22 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975131C1ED5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:32:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c15so902070ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tvw6taPpgUktbBufV96johk8JlHiJhYBWcWPuBo5rDc=;
        b=gyTvwZKkWvITZ/zBPRstzK2sv3jlV0a0Qv4j6f3+SSTv0Q+DPIDg1CHCfkMvOizNNe
         fcFu/+LVmwvdfBMnWx9eJpH9bXskgTOomTeSXivuJphqNC1UIdx3Wm8AnWje6VCw/0Ws
         bVnVtbYRbbzSqSas2eUdPUXv3oGMaX7cZ0gpccp1XPIrzCtNiYGbLF0QfSJ/iVlMe1cs
         SAV0A2z33vKySiLF0gPFvGh2Brkp9URnuHx7Y0MYyCQW32BDoS1hBgwHysfxKhG+3A8T
         isNoHSIjD0P2uik7tChfWEI02cHLuFxNmBbHCnNA0kJXVhKpd+ty7goKqaGsInhk0JcZ
         aXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tvw6taPpgUktbBufV96johk8JlHiJhYBWcWPuBo5rDc=;
        b=TPI6MOSMECefSNwNMSOERPdiK46wHJv6jGsDkIyhVWumJykSeAxA+j7Mi0O2RhVXAN
         QgLe/YyC39Wuvvmd3AnGiCc0A+EqEbBxURLV+K0TvMAagjsWgu+NiOiyBitBvUuhEMON
         +/npchV2wZ3+SIo/470ccttOnOYeqyUEQg15m54PbI2bre4xBUm8Xz69e6jOlA6EBzZt
         l5c3bkigrSc2jw0AUuLMbLancvsqoh5s++cJLi5M4HPEAAdh8vaGyvTMXyS8lVT+E97f
         Bgei2evo6QL4PjuQVVOOw5cnRjctFS3X5dBW2XWyQo6Rm6G20ItLQ/fkbqiz+gRdtu8H
         LPkQ==
X-Gm-Message-State: AOAM532gf8HNWnzTotDe4DRg8rTmk+UvRt6jApzLBhYYydpmEoQDupYe
        AvdFwRgocKbpiINwifT9F8RqHMNwAQW5otVbbV7ctQ==
X-Google-Smtp-Source: ABdhPJxXnXZtYy6mA03Fv6Rv4cQWDrXySxfwsNF2WvESWs46OgIV2BdHAcwu0EAGIOeigzrCxylDpnc7CUfCL2n+N7Q=
X-Received: by 2002:a2e:3c1a:0:b0:249:88f6:f606 with SMTP id
 j26-20020a2e3c1a000000b0024988f6f606mr11027684lja.132.1648751549725; Thu, 31
 Mar 2022 11:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220308043857.13652-1-nikunj@amd.com> <YkIh8zM7XfhsFN8L@google.com>
 <c4b33753-01d7-684e-23ac-1189bd217761@amd.com> <YkSz1R3YuFszcZrY@google.com> <5567f4ec-bbcf-4caf-16c1-3621b77a1779@amd.com>
In-Reply-To: <5567f4ec-bbcf-4caf-16c1-3621b77a1779@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 31 Mar 2022 12:32:18 -0600
Message-ID: <CAMkAt6px4A0CyuZ8h7zKzTxQUrZMYEkDXbvZ=3v+kphRTRDjNA@mail.gmail.com>
Subject: Re: [PATCH RFC v1 0/9] KVM: SVM: Defer page pinning for SEV guests
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Mingwei Zhang <mizhang@google.com>,
        David Hildenbrand <david@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Mar 30, 2022 at 10:48 PM Nikunj A. Dadhania <nikunj@amd.com> wrote:
>
>
>
> On 3/31/2022 1:17 AM, Sean Christopherson wrote:
> > On Wed, Mar 30, 2022, Nikunj A. Dadhania wrote:
> >> On 3/29/2022 2:30 AM, Sean Christopherson wrote:
> >>> Let me preface this by saying I generally like the idea and especially the
> >>> performance, but...
> >>>
> >>> I think we should abandon this approach in favor of committing all our resources
> >>> to fd-based private memory[*], which (if done right) will provide on-demand pinning
> >>> for "free".
> >>
> >> I will give this a try for SEV, was on my todo list.
> >>
> >>> I would much rather get that support merged sooner than later, and use
> >>> it as a carrot for legacy SEV to get users to move over to its new APIs, with a long
> >>> term goal of deprecating and disallowing SEV/SEV-ES guests without fd-based private
> >>> memory.
> >>
> >>> That would require guest kernel support to communicate private vs. shared,
> >>
> >> Could you explain this in more detail? This is required for punching hole for shared pages?
> >
> > Unlike SEV-SNP, which enumerates private vs. shared in the error code, SEV and SEV-ES
> > don't provide private vs. shared information to the host (KVM) on page fault.  And
> > it's even more fundamental then that, as SEV/SEV-ES won't even fault if the guest
> > accesses the "wrong" GPA variant, they'll silent consume/corrupt data.
> >
> > That means KVM can't support implicit conversions for SEV/SEV-ES, and so an explicit
> > hypercall is mandatory.  SEV doesn't even have a vendor-agnostic guest/host paravirt
> > ABI, and IIRC SEV-ES doesn't provide a conversion/map hypercall in the GHCB spec, so
> > running a SEV/SEV-ES guest under UPM would require the guest firmware+kernel to be
> > properly enlightened beyond what is required architecturally.
> >
>
> So with guest supporting KVM_FEATURE_HC_MAP_GPA_RANGE and host (KVM) supporting
> KVM_HC_MAP_GPA_RANGE hypercall, SEV/SEV-ES guest should communicate private/shared
> pages to the hypervisor, this information can be used to mark page shared/private.

One concern here may be that the VMM doesn't know which guests have
KVM_FEATURE_HC_MAP_GPA_RANGE support and which don't. Only once the
guest boots does the guest tell KVM that it supports
KVM_FEATURE_HC_MAP_GPA_RANGE. If the guest doesn't we need to pin all
the memory before we run the guest to be safe to be safe.
