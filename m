Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDBD57D0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiGUQGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGUQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:06:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913282A97F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:06:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bu1so2922541wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pc0I4yw59jOOvGkA/C+nGbiscopqpoytUjjB6d/I+0w=;
        b=lZURPGzF14j9sNlRgK0JYE0xAdEjjrbkT5z7sM3Stia1hYZlKagfsnRTFUVTxU7HQK
         Z+4YbWji4hQ3wGRC0dQDKjY2DSPgY13RAS4KuzygvfnPpKt8GnkwcO7cdYG+dMzYaxWI
         s4Z7MnglCfrSD0JKJvOUxTuZr1PhjvVvvHSkPAlP0m6VDvfYjY7Iw56mpO/FUdIlEGJB
         Ge18N+XGIs7+bDWY0PrduAM9NtO5945vUVy28vQ5TkFdgekJS2LwUr5z2/lRXJFDg82R
         KI4aO1f400QidOMoqd7evfw+mkZiKW5o+U1oXEvx7gter8t09mHCHMZV1tH50jdGyj7e
         sWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pc0I4yw59jOOvGkA/C+nGbiscopqpoytUjjB6d/I+0w=;
        b=3o9+T6Ysjr5XaHOwH0iJY9d8r7iRKaA3JptobeYmPeSijH4sZpDA71TLCtpqW4Y/nA
         y020lLW/4AZaZtVa1QilU/NR/XwCnDGJnm85fj6VtMn49uMm7sPXbe3z+/CwEU01H7Kn
         erSM1xKy6X1KfnzkUnA1yNR1m0HeeA5sB7Uhz4cO1PF9fACDcpZdzZOsodHlNRS8em9s
         /sL9EBFOPw4PbjSyCTVvkjnWiE8S+P3hrdfhPW3TbQCuyDbJtfUxJXAq2Muum2THlyuL
         3tceFTU6y3V1AhTn1em7TfHmiLGHQl2Ob/wBQhoOi5hry8GsOy7KtSzXrYpiMnE2Vb2u
         qGLA==
X-Gm-Message-State: AJIora+xTKde/qgEwwupTZvM4cPnziQg+lII3s/DVDlveeYt+ahNO5ud
        zDPmSN5k5wYJVBBIKHGJ4W2XIzhPCfTFSqwwc+hKlQ==
X-Google-Smtp-Source: AGRyM1tMKiMRtpHV9YSfuYiFk44eLQKIqdZQ/iYuycWrx2bklYrgWAmV9kHG5RR8KmbUFbcR6TgyoS1YaIwyjhpwAMk=
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id
 bj4-20020a0560001e0400b0021d7ec3fe5amr35846940wrb.116.1658419573778; Thu, 21
 Jul 2022 09:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <CA+EHjTzGJknPWSdzU0-G35KgzRyGhQzb6+gkANOYcjZqLuzaJw@mail.gmail.com>
In-Reply-To: <CA+EHjTzGJknPWSdzU0-G35KgzRyGhQzb6+gkANOYcjZqLuzaJw@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 21 Jul 2022 09:06:02 -0700
Message-ID: <CAC_TJvej+DLYs1u8i4k143WAXdNHzmBQCZV-j-Yd00VMDz5o-g@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] KVM nVHE Hypervisor stack unwinder
To:     Fuad Tabba <tabba@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>, android-mm@google.com,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 2:56 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Kalesh,
>
>
> On Thu, Jul 21, 2022 at 6:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Hi all,
> >
> > This is v5 of nVHE hypervisor stacktraces support. The series is based on
> > arm64 for-next/stacktrace.
> >
> > The previous versions were posted at:
> > v4: https://lore.kernel.org/r/20220715061027.1612149-1-kaleshsingh@google.com/
> > v3: https://lore.kernel.org/r/20220607165105.639716-1-kaleshsingh@google.com/
> > v2: https://lore.kernel.org/r/20220502191222.4192768-1-kaleshsingh@google.com/
> > v1: https://lore.kernel.org/r/20220427184716.1949239-1-kaleshsingh@google.com/
> >
> > The main updates in this version are some refactoring to move stuff out of
> > stacktrace/nvhe.h (leaving only the unwinder implementation in the header);
> > and fixing the symbolization of the hyp stacktrace when KASLR is enabled;
> > along with the addressing the other minor comments.
> >
> > Patch 18 (KVM: arm64: Dump nVHE hypervisor stack on panic) was also squashed
> > into earlier patches.
> >
> > The previous cover letter is copied below for convenience.
> >
> > Thanks all for your feedback.
>
> Thank you for this. This will be very helpful.
>
> For the whole series:
> Tested-by: Fuad Tabba <tabba@google.com>

Thanks for your reviews, Fuad.

--Kalesh

>
> Cheers,
> /fuad
>
>
> >
> > --Kalesh
> >
> > ============
> >
> > KVM nVHE Stack unwinding.
> > ===
> >
> > nVHE has two modes of operation: protected (pKVM) and unprotected
> > (conventional nVHE). Depending on the mode, a slightly different approach
> > is used to dump the hypervisor stacktrace but the core unwinding logic
> > remains the same.
> >
> > Protected nVHE (pKVM) stacktraces
> > ====
> >
> > In protected nVHE mode, the host cannot directly access hypervisor memory.
> >
> > The hypervisor stack unwinding happens in EL2 and is made accessible to
> > the host via a shared buffer. Symbolizing and printing the stacktrace
> > addresses is delegated to the host and happens in EL1.
> >
> > Non-protected (Conventional) nVHE stacktraces
> > ====
> >
> > In non-protected mode, the host is able to directly access the hypervisor
> > stack pages.
> >
> > The hypervisor stack unwinding and dumping of the stacktrace is performed
> > by the host in EL1, as this avoids the memory overhead of setting up
> > shared buffers between the host and hypervisor.
> >
> > Resuing the Core Unwinding Logic
> > ====
> >
> > Since the hypervisor cannot link against the kernel code in proteced mode.
> > The common stack unwinding code is moved to a shared header to allow reuse
> > in the nVHE hypervisor.
> >
> > Reducing the memory footprint
> > ====
> >
> > In this version the below steps were taken to reduce the memory usage of
> > nVHE stack unwinding:
> >
> >     1) The nVHE overflow stack is reduced from PAGE_SIZE to 4KB; benificial
> >        for configurations with non 4KB pages (16KB or 64KB pages).
> >     2) In protected nVHE mode (pKVM), the shared stacktrace buffers with the
> >        host are reduced from PAGE_SIZE to the minimum size required.
> >     3) In systems other than Android, conventional nVHE makes up the vast
> >        majority of use case. So the pKVM stack tracing is disabled by default
> >        (!CONFIG_PROTECTED_NVHE_STACKTRACE), which avoid the memory usage for
> >        setting up shared buffers.
> >     4) In non-protected nVHE mode (conventional nVHE), the stack unwinding
> >        is done directly in EL1 by the host and no shared buffers with the
> >        hypervisor are needed.
> >
> > Sample Output
> > ====
> >
> > The below shows an example output from a simple stack overflow test:
> >
> > [  126.862960] kvm [371]: nVHE hyp panic at: [<ffff8000090a51d0>] __kvm_nvhe_recursive_death+0x10/0x34!
> > [  126.869920] kvm [371]: Protected nVHE HYP call trace:
> > [  126.870528] kvm [371]:  [<ffff8000090a5570>] __kvm_nvhe_hyp_panic+0xac/0xf8
> > [  126.871342] kvm [371]:  [<ffff8000090a55cc>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
> > [  126.872174] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> > [  126.872971] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> >    . . .
> >
> > [  126.927314] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> > [  126.927727] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> > [  126.928137] kvm [371]:  [<ffff8000090a4de4>] __kvm_nvhe___kvm_vcpu_run+0x30/0x40c
> > [  126.928561] kvm [371]:  [<ffff8000090a7b64>] __kvm_nvhe_handle___kvm_vcpu_run+0x30/0x48
> > [  126.928984] kvm [371]:  [<ffff8000090a78b8>] __kvm_nvhe_handle_trap+0xc4/0x128
> > [  126.929385] kvm [371]:  [<ffff8000090a6864>] __kvm_nvhe___host_exit+0x64/0x64
> > [  126.929804] kvm [371]: ---- End of Protected nVHE HYP call trace ----
> >
> > ============
> >
> > Kalesh Singh (17):
> >   arm64: stacktrace: Add shared header for common stack unwinding code
> >   arm64: stacktrace: Factor out on_accessible_stack_common()
> >   arm64: stacktrace: Factor out unwind_next_common()
> >   arm64: stacktrace: Handle frame pointer from different address spaces
> >   arm64: stacktrace: Factor out common unwind()
> >   arm64: stacktrace: Add description of stacktrace/common.h
> >   KVM: arm64: On stack overflow switch to hyp overflow_stack
> >   KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
> >   KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
> >   KVM: arm64: Stub implementation of pKVM HYP stack unwinder
> >   KVM: arm64: Stub implementation of non-protected nVHE HYP stack
> >     unwinder
> >   KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
> >   KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
> >   KVM: arm64: Implement protected nVHE hyp stack unwinder
> >   KVM: arm64: Implement non-protected nVHE hyp stack unwinder
> >   KVM: arm64: Introduce pkvm_dump_backtrace()
> >   KVM: arm64: Introduce hyp_dump_backtrace()
> >
> >  arch/arm64/include/asm/kvm_asm.h           |  16 ++
> >  arch/arm64/include/asm/memory.h            |   8 +
> >  arch/arm64/include/asm/stacktrace.h        |  92 +++++----
> >  arch/arm64/include/asm/stacktrace/common.h | 230 +++++++++++++++++++++
> >  arch/arm64/include/asm/stacktrace/nvhe.h   | 199 ++++++++++++++++++
> >  arch/arm64/kernel/stacktrace.c             | 157 --------------
> >  arch/arm64/kvm/Kconfig                     |  15 ++
> >  arch/arm64/kvm/arm.c                       |   2 +-
> >  arch/arm64/kvm/handle_exit.c               | 101 +++++++++
> >  arch/arm64/kvm/hyp/nvhe/Makefile           |   2 +-
> >  arch/arm64/kvm/hyp/nvhe/host.S             |   9 +-
> >  arch/arm64/kvm/hyp/nvhe/stacktrace.c       | 116 +++++++++++
> >  arch/arm64/kvm/hyp/nvhe/switch.c           |   6 +
> >  13 files changed, 749 insertions(+), 204 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/stacktrace/common.h
> >  create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h
> >  create mode 100644 arch/arm64/kvm/hyp/nvhe/stacktrace.c
> >
> >
> > base-commit: 82a592c13b0aeff94d84d54183dae0b26384c95f
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
