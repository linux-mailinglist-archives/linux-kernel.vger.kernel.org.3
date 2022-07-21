Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5118A57C849
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiGUJ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiGUJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:56:35 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60E820C0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:56:27 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10d6e8990b9so1677053fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Djk/jm7V8sFeYdQrLHONw4DkWXKTytMwj6eErIiZNOs=;
        b=qMiUkSZcO/DQxY+syybKie3CPgbmEjK2DEV21K7J4sMy+54BjKyfp7DaOJGpM8a8+2
         PPyk7kTzM5UFRlNQ8mX1TsorG2D1KH/yKX07JstO2Y13p2UBslSQWKXatntFbOVqKXqT
         hkP7CYspr/NisT91hlX1kbFTvvw5XWFzgPrgbACKOlafYw77HaJV43PvJbrjQ6xtPzrw
         Dwne7EIbjlXnb7pX/MUQDL6fSzHlsAy+c9ZJZ8D+/HPYSVhQ/23b3RAIt/tUasEYIf3v
         N9TCcqUExWrF2PPTLdezAJhwdroy50MitwwwMa0avmje2FEcbpx2ORKoFRL89OaQY9EG
         zyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Djk/jm7V8sFeYdQrLHONw4DkWXKTytMwj6eErIiZNOs=;
        b=dfx/n0XB8K5BzBLZfmWPypFUwgLRWA62dreI1suDtiYfwet8cpIU9qeeeN4PmaEuIu
         aEgF4QniO/5g7MEk03DS2SCtn72mq4qeb03HvO3CBhPMVXJpR/hUT7+wSjNWimYURs16
         UdH0/uSfUC7kDDAK9kTgsoEdq7rp1VHKi/FCzZAHka6eNdjZWW/0I41PNsyVPOIzcD8V
         QCuUufmie/n+gZsWnL0Ef0VCLdd9J6e+twpUUbDnuC/wY2HR0HLAiNYMs5N3XT+fgPSm
         awRSidXufulNLn9N6oDbny5Ucsh04r2Tmifcl+Q/27vlvttURr1NtekV1cEN6HZNwaAa
         csiA==
X-Gm-Message-State: AJIora8rXg5mzZGGUlY13Zq/9E8o88mHAPwSyOOx9XgZQ0sp5j0aZcJX
        QFkrUeeJFNkxlqa2sWfK0x8TUruAEwhVPfDpAoIFkg==
X-Google-Smtp-Source: AGRyM1tyBHLJ09SZL8UQv3xKzcbUkRuko/W6HxJGr3DYAtz2BFdHpnZYuO+E6hr7wAh4war2obJ4NuExeleTG9buoNU=
X-Received: by 2002:a05:6870:2303:b0:10c:2ed1:6326 with SMTP id
 w3-20020a056870230300b0010c2ed16326mr4419714oao.146.1658397386806; Thu, 21
 Jul 2022 02:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:55:50 +0100
Message-ID: <CA+EHjTzGJknPWSdzU0-G35KgzRyGhQzb6+gkANOYcjZqLuzaJw@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] KVM nVHE Hypervisor stack unwinder
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
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

Hi Kalesh,


On Thu, Jul 21, 2022 at 6:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Hi all,
>
> This is v5 of nVHE hypervisor stacktraces support. The series is based on
> arm64 for-next/stacktrace.
>
> The previous versions were posted at:
> v4: https://lore.kernel.org/r/20220715061027.1612149-1-kaleshsingh@google.com/
> v3: https://lore.kernel.org/r/20220607165105.639716-1-kaleshsingh@google.com/
> v2: https://lore.kernel.org/r/20220502191222.4192768-1-kaleshsingh@google.com/
> v1: https://lore.kernel.org/r/20220427184716.1949239-1-kaleshsingh@google.com/
>
> The main updates in this version are some refactoring to move stuff out of
> stacktrace/nvhe.h (leaving only the unwinder implementation in the header);
> and fixing the symbolization of the hyp stacktrace when KASLR is enabled;
> along with the addressing the other minor comments.
>
> Patch 18 (KVM: arm64: Dump nVHE hypervisor stack on panic) was also squashed
> into earlier patches.
>
> The previous cover letter is copied below for convenience.
>
> Thanks all for your feedback.

Thank you for this. This will be very helpful.

For the whole series:
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>
> --Kalesh
>
> ============
>
> KVM nVHE Stack unwinding.
> ===
>
> nVHE has two modes of operation: protected (pKVM) and unprotected
> (conventional nVHE). Depending on the mode, a slightly different approach
> is used to dump the hypervisor stacktrace but the core unwinding logic
> remains the same.
>
> Protected nVHE (pKVM) stacktraces
> ====
>
> In protected nVHE mode, the host cannot directly access hypervisor memory.
>
> The hypervisor stack unwinding happens in EL2 and is made accessible to
> the host via a shared buffer. Symbolizing and printing the stacktrace
> addresses is delegated to the host and happens in EL1.
>
> Non-protected (Conventional) nVHE stacktraces
> ====
>
> In non-protected mode, the host is able to directly access the hypervisor
> stack pages.
>
> The hypervisor stack unwinding and dumping of the stacktrace is performed
> by the host in EL1, as this avoids the memory overhead of setting up
> shared buffers between the host and hypervisor.
>
> Resuing the Core Unwinding Logic
> ====
>
> Since the hypervisor cannot link against the kernel code in proteced mode.
> The common stack unwinding code is moved to a shared header to allow reuse
> in the nVHE hypervisor.
>
> Reducing the memory footprint
> ====
>
> In this version the below steps were taken to reduce the memory usage of
> nVHE stack unwinding:
>
>     1) The nVHE overflow stack is reduced from PAGE_SIZE to 4KB; benificial
>        for configurations with non 4KB pages (16KB or 64KB pages).
>     2) In protected nVHE mode (pKVM), the shared stacktrace buffers with the
>        host are reduced from PAGE_SIZE to the minimum size required.
>     3) In systems other than Android, conventional nVHE makes up the vast
>        majority of use case. So the pKVM stack tracing is disabled by default
>        (!CONFIG_PROTECTED_NVHE_STACKTRACE), which avoid the memory usage for
>        setting up shared buffers.
>     4) In non-protected nVHE mode (conventional nVHE), the stack unwinding
>        is done directly in EL1 by the host and no shared buffers with the
>        hypervisor are needed.
>
> Sample Output
> ====
>
> The below shows an example output from a simple stack overflow test:
>
> [  126.862960] kvm [371]: nVHE hyp panic at: [<ffff8000090a51d0>] __kvm_nvhe_recursive_death+0x10/0x34!
> [  126.869920] kvm [371]: Protected nVHE HYP call trace:
> [  126.870528] kvm [371]:  [<ffff8000090a5570>] __kvm_nvhe_hyp_panic+0xac/0xf8
> [  126.871342] kvm [371]:  [<ffff8000090a55cc>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
> [  126.872174] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> [  126.872971] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
>    . . .
>
> [  126.927314] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> [  126.927727] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> [  126.928137] kvm [371]:  [<ffff8000090a4de4>] __kvm_nvhe___kvm_vcpu_run+0x30/0x40c
> [  126.928561] kvm [371]:  [<ffff8000090a7b64>] __kvm_nvhe_handle___kvm_vcpu_run+0x30/0x48
> [  126.928984] kvm [371]:  [<ffff8000090a78b8>] __kvm_nvhe_handle_trap+0xc4/0x128
> [  126.929385] kvm [371]:  [<ffff8000090a6864>] __kvm_nvhe___host_exit+0x64/0x64
> [  126.929804] kvm [371]: ---- End of Protected nVHE HYP call trace ----
>
> ============
>
> Kalesh Singh (17):
>   arm64: stacktrace: Add shared header for common stack unwinding code
>   arm64: stacktrace: Factor out on_accessible_stack_common()
>   arm64: stacktrace: Factor out unwind_next_common()
>   arm64: stacktrace: Handle frame pointer from different address spaces
>   arm64: stacktrace: Factor out common unwind()
>   arm64: stacktrace: Add description of stacktrace/common.h
>   KVM: arm64: On stack overflow switch to hyp overflow_stack
>   KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
>   KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
>   KVM: arm64: Stub implementation of pKVM HYP stack unwinder
>   KVM: arm64: Stub implementation of non-protected nVHE HYP stack
>     unwinder
>   KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
>   KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
>   KVM: arm64: Implement protected nVHE hyp stack unwinder
>   KVM: arm64: Implement non-protected nVHE hyp stack unwinder
>   KVM: arm64: Introduce pkvm_dump_backtrace()
>   KVM: arm64: Introduce hyp_dump_backtrace()
>
>  arch/arm64/include/asm/kvm_asm.h           |  16 ++
>  arch/arm64/include/asm/memory.h            |   8 +
>  arch/arm64/include/asm/stacktrace.h        |  92 +++++----
>  arch/arm64/include/asm/stacktrace/common.h | 230 +++++++++++++++++++++
>  arch/arm64/include/asm/stacktrace/nvhe.h   | 199 ++++++++++++++++++
>  arch/arm64/kernel/stacktrace.c             | 157 --------------
>  arch/arm64/kvm/Kconfig                     |  15 ++
>  arch/arm64/kvm/arm.c                       |   2 +-
>  arch/arm64/kvm/handle_exit.c               | 101 +++++++++
>  arch/arm64/kvm/hyp/nvhe/Makefile           |   2 +-
>  arch/arm64/kvm/hyp/nvhe/host.S             |   9 +-
>  arch/arm64/kvm/hyp/nvhe/stacktrace.c       | 116 +++++++++++
>  arch/arm64/kvm/hyp/nvhe/switch.c           |   6 +
>  13 files changed, 749 insertions(+), 204 deletions(-)
>  create mode 100644 arch/arm64/include/asm/stacktrace/common.h
>  create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/stacktrace.c
>
>
> base-commit: 82a592c13b0aeff94d84d54183dae0b26384c95f
> --
> 2.37.0.170.g444d1eabd0-goog
>
