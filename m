Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481074C5182
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbiBYW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiBYW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:27:43 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AFB210443
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:27:10 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so8427408ooi.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/s03k0JRj2Hv4j2AKAsYfs0BBDQNjuiLF4Fr8g0nRc=;
        b=BffcmKIbgoGIed35TW+fYLtAriHV/47WBC4+PB0zdqSOUZ6KPBKGLlrgOjGwR9iEHF
         ekSUJQNRf97bM0ESf6ZR6i6mVK/E47Lpa6x2lC5lfIONTr8VVTV0DyMqtE52eiRAi8Vd
         lHe4GBN4kZglA2s3egGPjVPnAx878+7tVhYilzobXN+2oD8yFCbO66i6Am3AX+9rOA4n
         dkTeghAi4j1sGiZd3VkmS6TcsWnDt93dChUJuIBrhQKasPfyMyNYRlTGsoVzFlqV5Rou
         7FMxmGWUP+TzZSdDX+XtntiH70oCEvK+6kzqdOMY3tAo1Elf26a7eTv/HlX8xJp6E8XD
         2Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/s03k0JRj2Hv4j2AKAsYfs0BBDQNjuiLF4Fr8g0nRc=;
        b=Sz96u1yuy9uWsxaod2RZHu59ugbe7pKPIFwx5NuVQ7PshWb6hvbrzwgKWSxsM2D9t+
         ubvf9TmHJ24KVE/n4DQwV3aAKjOTrTeS8xSE5HUXp0QQUaG2sFy2uIFCPuOCRZ6f38OY
         d3Ax/CNHtuqcizweN+n9nruZbool1cVTTqn9lL1tW14RrnNB5QiPPd4Rs8q63/+M5ny8
         QncL0PYV5/ub2HG7OVctaSdgCCEvtSiqUyiz1tQm6L6NsXWihnSEOdHMm6/6mq0yCalE
         D2C15MEhgPMZiHX40Bznh+C4ZDCerwyl6fmmQxginP+mH3HpzPTTDjPWUmCwcHRADHqu
         /QCw==
X-Gm-Message-State: AOAM530Somj8AYroq1K5DfeW7a9vamuhtvzvECD3JtvI310vTaY4i79W
        CUykt/frE1TKYjEqZicmkCtDpDXCcxWpEYfiCXGkBw==
X-Google-Smtp-Source: ABdhPJyzEggs0p/6UpO52Lt4Qb/IvgvjdkOygSTvusYNKlp7hN+yataDsQD4LcDnomXSpOXH/IX8bi2laDooHffeLGg=
X-Received: by 2002:a05:6870:6490:b0:d6:d161:6dbb with SMTP id
 cz16-20020a056870649000b000d6d1616dbbmr2311289oab.129.1645828029587; Fri, 25
 Feb 2022 14:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20211118130320.95997-1-likexu@tencent.com> <CALMp9eTONaviuz-NnPUP2=MEOb8ZBkZ7u_ZQBWBUne-i6cRUkA@mail.gmail.com>
 <dc14c98c-e35a-95c0-83dd-13b5f7cffc03@gmail.com>
In-Reply-To: <dc14c98c-e35a-95c0-83dd-13b5f7cffc03@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 25 Feb 2022 14:26:58 -0800
Message-ID: <CALMp9eSWJevnn3vs5==9ay5vRL_djfq28bawUEP3KzBft3FOrg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Fix reserved bits for AMD PerfEvtSeln register
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     David Dunn <daviddunn@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lotus Fenn <lotusf@google.com>
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

On Tue, Feb 15, 2022 at 11:47 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> On 12/2/2022 4:39 pm, Jim Mattson wrote:
> >> -       pmu->reserved_bits = 0xffffffff00200000ull;
> >> +       pmu->reserved_bits = 0xfffffff000280000ull;
> > Bits 40 and 41 are guest mode and host mode. They cannot be reserved
> > if the guest supports nested SVM.
> >
>
> Indeed, we need (some hands) to do more pmu tests on nested SVM.

Actually, it's not just nested SVM.

When we enable vPMU for an Ubuntu guest that is incapable of nested
SVM, we see errors like the following:

root@Ubuntu1804:~# perf stat -e r26 -a sleep 1

 Performance counter stats for 'system wide':

                 0      r26


       1.001070977 seconds time elapsed

Feb 23 03:59:58 Ubuntu1804 kernel: [  405.379957] unchecked MSR access
error: WRMSR to 0xc0010200 (tried to write 0x0000020000130026) at rIP:
0xffffffff9b276a28 (native_write_msr+0x8/0x30)
Feb 23 03:59:58 Ubuntu1804 kernel: [  405.379958] Call Trace:
Feb 23 03:59:58 Ubuntu1804 kernel: [  405.379963]
amd_pmu_disable_event+0x27/0x90

If the standard Linux perf tool sets "exclude_guest" by default, even
when EFER.SVME is clear, then amd_core_hw_config() in the guest kernel
will set bit 41 (again, without checking EFER.SVME). This WRMSR should
not raise #GP.

Current AMD hardware doesn't raise #GP for any value written to a
PerfEvtSeln MSR. I don't think KVM should ever synthesize a #GP
either. Perhaps we should just mask off the bits that you have
indicated as reserved, above.
