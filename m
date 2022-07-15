Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C127E576704
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiGOS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGOS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:59:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232B32DAE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:59:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d16so7950570wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xf9uJYF5ACsf3N9sE+T/kH049bkqtRicxBRlf5NJwzI=;
        b=CwN6uSeDs3O6jb0UR1KCay3zWYnCy1FWwTJlKFngHztY9sNyPN5f1zEX61h9EZdjb4
         dTXPuppnKtCXSLsv8TfJ2cWllhpWOtP37ho6NxTHnSFZua9Mkpwk2Rh+w1jqiSQM8YzC
         Ll+jsq1uyvtkUSys6wG3b25DEeLp5lFXK/j+FUm05PHSEQOsyAi4yimwDL1agUcCylob
         T+GI8kY2O7r37cUXMy/SegHE2ly06SC904HLIaPgNAHCjGiK/Krpv8Xxwo8WPRRNpQ3q
         XmPXzvA9PyhyW+4TkF7BraGa1D0erEaWumlwupgbrUKerkG22PokP+YTBHu6J+kaUDXD
         A7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xf9uJYF5ACsf3N9sE+T/kH049bkqtRicxBRlf5NJwzI=;
        b=e+ocec8YiNP6jlZrhonuoVRUl2ZuI6ghoeDHAwfI0CuSYF0XM622oE1vTjBwsuPn30
         XedZ2ma7OGKnFMcBufU84C92GvG1rfJ9YEiEv/LU7Rt4t+wyH0/oUQPwC7k/gD+vJLcT
         gzwNjQVXsKj9X7NiTdyPPsKjTzzi+bqGO/j/kf4yGSBvjb+zTjRtuawCc5pQ85V7DTUZ
         7AbPTc19Ade5WfaJE4o/NOMwIFVsdB0nsZ2Ff4SxPevv4h69R90zDzAx/5wYW7PQCoz5
         KdrWYPL2/hVrWpF9wg49Wk+Bfx7P2OsMvm7rg++wZ5OKR6zJTjrC54mVE2EgGwr9lcUj
         RfqA==
X-Gm-Message-State: AJIora9rRTHNCzc2OgrBs/wHIsL9+RpkcKEUrVAgK134ZrFogmDnM5UC
        mPPENAiPjOdLLSBxVLXwkhp5KV4F3q66Rtl074dfeQ==
X-Google-Smtp-Source: AGRyM1v9zeCKDv2BzQwNi4ntgkA9iowWv3yPGQHa7sWbWYm3w4VEw/n5eMbY6X8cUNvySc25Uhd4xLv8zo162/Z6cvY=
X-Received: by 2002:a05:6000:508:b0:21d:4105:caf9 with SMTP id
 a8-20020a056000050800b0021d4105caf9mr14181145wrf.699.1657911547888; Fri, 15
 Jul 2022 11:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <CA+EHjTzPu9hticW4sPbVsxp43swRGOv4ou843S=Q5q=oQ6ii=g@mail.gmail.com>
In-Reply-To: <CA+EHjTzPu9hticW4sPbVsxp43swRGOv4ou843S=Q5q=oQ6ii=g@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 15 Jul 2022 11:58:56 -0700
Message-ID: <CAC_TJveK_nfaD1=DyQ4oAvRpuWkC_qbBhoEEqWgtcOo1TOvAag@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] KVM nVHE Hypervisor stack unwinder
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
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, Masami Hiramatsu <mhiramat@kernel.org>,
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

On Fri, Jul 15, 2022 at 6:55 AM 'Fuad Tabba' via kernel-team
<kernel-team@android.com> wrote:
>
> Hi Kalesh,
>
> On Fri, Jul 15, 2022 at 7:10 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Hi all,
> >
> > This is v4 of the series adding support for nVHE hypervisor stacktraces;
> > and is based on arm64 for-next/stacktrace.
> >
> > Thanks all for your feedback on previous revisions. Mark Brown, I
> > appreciate your Reviewed-by on the v3, I have dropped the tags in this
> > new verision since I think the series has changed quite a bit.
> >
> > The previous versions were posted at:
> > v3: https://lore.kernel.org/r/20220607165105.639716-1-kaleshsingh@google.com/
> > v2: https://lore.kernel.org/r/20220502191222.4192768-1-kaleshsingh@google.com/
> > v1: https://lore.kernel.org/r/20220427184716.1949239-1-kaleshsingh@google.com/
> >
> > The main updates in this version are to address concerens from Marc on the
> > memory usage and reusing the common code by refactoring into a shared header.
> >
> > Thanks,
> > Kalesh
>
> I tested an earlier version of this patch series, and it worked fine,
> with symbolization. However, testing it now, both with nvhe and with
> pkvm the symbolization isn't working for me. e.g.
>
> [   32.986706] kvm [251]: Protected nVHE HYP call trace:
> [   32.986796] kvm [251]:  [<ffff800008f8b0e0>] 0xffff800008f8b0e0
> [   32.987391] kvm [251]:  [<ffff800008f8b388>] 0xffff800008f8b388
> [   32.987493] kvm [251]:  [<ffff800008f8d230>] 0xffff800008f8d230
> [   32.987591] kvm [251]:  [<ffff800008f8d51c>] 0xffff800008f8d51c
> [   32.987695] kvm [251]:  [<ffff800008f8c064>] 0xffff800008f8c064
> [   32.987803] kvm [251]: ---- End of Protected nVHE HYP call trace ----
>
> CONFIG_PROTECTED_NVHE_STACKTRACE CONFIG_NVHE_EL2_DEBUG and
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT are all enabled. Generating
> a backtrace in the host I get proper symbolisation.
>
> Is there anything else you'd like to know about my setup that would
> help get to the bottom of this?

Hi Fuad,

Thanks for reviewing it. Can you attach the .config when you have a
chance please? I will try reproducing it on my end.

--Kalesh

>
> Thanks,
> /fuad
>
>
>
>
> >
> > ============
> >
> > KVM nVHE Stack unwinding.
> > ===
> >
> > nVHE has two modes of operation: protected (pKVM) and unprotected
> > (conventional nVHE). Depending on the mode, a slightly different approach
> > is used to dump the hyperviosr stacktrace but the core unwinding logic
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
> >        hyperviosr are needed.
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
> >
> > Kalesh Singh (18):
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
> >   KVM: arm64: Dump nVHE hypervisor stack on panic
> >
> >  arch/arm64/include/asm/kvm_asm.h           |  16 ++
> >  arch/arm64/include/asm/memory.h            |   7 +
> >  arch/arm64/include/asm/stacktrace.h        |  92 ++++---
> >  arch/arm64/include/asm/stacktrace/common.h | 224 ++++++++++++++++
> >  arch/arm64/include/asm/stacktrace/nvhe.h   | 291 +++++++++++++++++++++
> >  arch/arm64/kernel/stacktrace.c             | 157 -----------
> >  arch/arm64/kvm/Kconfig                     |  15 ++
> >  arch/arm64/kvm/arm.c                       |   2 +-
> >  arch/arm64/kvm/handle_exit.c               |   4 +
> >  arch/arm64/kvm/hyp/nvhe/Makefile           |   2 +-
> >  arch/arm64/kvm/hyp/nvhe/host.S             |   9 +-
> >  arch/arm64/kvm/hyp/nvhe/stacktrace.c       | 108 ++++++++
> >  arch/arm64/kvm/hyp/nvhe/switch.c           |   5 +
> >  13 files changed, 727 insertions(+), 205 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/stacktrace/common.h
> >  create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h
> >  create mode 100644 arch/arm64/kvm/hyp/nvhe/stacktrace.c
> >
> >
> > base-commit: 82a592c13b0aeff94d84d54183dae0b26384c95f
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
