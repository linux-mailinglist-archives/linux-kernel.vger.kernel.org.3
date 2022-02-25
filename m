Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835564C3CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbiBYD7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiBYD7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:59:47 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB21235307
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:59:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i20so939897wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=tA/ZSMp3IJuiKY/7Y5ZTiqONzRTKyArYwt1620XaDiA=;
        b=sXDDJLdAAfXghdOOJT1NTFmyMgF4A1MxnC0N/zJlHVfaF4UVezKfvquQ3pwgrQREGW
         2xRnNrTpFW8KoCYoygN3JMMdc58so0KA/Fl/Hf8NDSFk/pTUofSBNyXj6tGOIrEcFC10
         zhYBqS2ZKH/nZTCBVx54UL4sfRFBVski8OH8vpu2PhcYijOD7CwRymud+rkMRSLKjofw
         cv9EcoElc4Wvx0snfN+JSxifzyuywGXJHL0Ocj1YAKkGAKnx3/jeiAKKVnnf4p8qYmYz
         mPgFw6+NIEZdemZu06JpfXDZSsJykMpnd5v0SwsfCORA4aUJcDnS3VcQL7YCbeEh9PjS
         Dbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=tA/ZSMp3IJuiKY/7Y5ZTiqONzRTKyArYwt1620XaDiA=;
        b=6CCB0idthD7V7pKvghbJeGkYo37xJvzghoXWIXaXBIfQhUFaSTCMsUIQXHiADobOOn
         pWjKTX2xJVkms5+OVQmnY5nk1WNJFYT8fqdI+z1XNzGm2B/H5JS5UiWUYRInrt74n2S3
         SRosGzK+uhuih4V+j9/Ug1Ejz1D1AqNd2peyR0B2iUhtNErDfK7wX5TsCWgR5N5XgRwG
         zHtzFmCfwXHMh1OscAqBtEZwHNtVb529bKeVJ4Bw69E0zpqFmUDSUW5euku2CDrAN+1n
         fCFsyxjKqQDlTpN3UTHm/HMwL1QBmZf+Xy6iQP9nCxY0SLKrb9wpeJDM2c3+viKCKZMY
         LuSA==
X-Gm-Message-State: AOAM531IXtg4NqGRXgymzlyHrD7N9Uz0JO6ng5WcDplgSK65PO8pSNtf
        YQmsDO7aQ+KBphxM1I6zkMs2+T7Zc2cCzUYA3C/x6w==
X-Received: by 2002:a05:600c:218d:b0:37f:a920:9705 with SMTP id
 e13-20020a05600c218d00b0037fa9209705mt419056wme.86.1645761554185; Thu, 24 Feb
 2022 19:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com>
In-Reply-To: <20220224051439.640768-1-kaleshsingh@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 24 Feb 2022 19:59:03 -0800
Message-ID: <CAC_TJvfjGHN95UaVK92s_BovJWb0HyfXKD8r=7fkzcG5avuU-A@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] KVM: arm64: Hypervisor stack enhancements
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 9:15 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Hi all,
>
> This is v3 of the nVHE hypervisor stack enhancements.

Please find the latest version v4, posted at:
https://lore.kernel.org/r/20220225033548.1912117-1-kaleshsingh@google.com/

Thanks,
Kalesh

>
> Previous versions can be found at:
> v2: https://lore.kernel.org/r/20220222165212.2005066-1-kaleshsingh@google.com/
> v1: https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/
>
> The main update in this version is that the unwinder now uses the core logic
> from the regular kernel stack unwinder to avoid duplicate code, per Mark; along
> with fixes for the other issues identified in v2.
>
> The previous cover letter (with updated call trace) has been copied below.
>
> Thanks,
> Kalesh
>
> -----
>
> This series is based on 5.17-rc5 and adds the following stack features to
> the KVM nVHE hypervisor:
>
> == Hyp Stack Guard Pages ==
>
> Based on the technique used by arm64 VMAP_STACK to detect overflow.
> i.e. the stack is aligned to twice its size which ensure that the
> 'stack shift' bit of any valid SP is 0. The 'stack shift' bit can be
> tested in the exception entry to detect overflow without corrupting GPRs.
>
> == Hyp Stack Unwinder ==
>
> Based on the arm64 kernel stack unwinder
> (See: arch/arm64/kernel/stacktrace.c)
>
> The unwinding and dumping of the hyp stack is not enabled by default and
> depends on CONFIG_NVHE_EL2_DEBUG to avoid potential information leaks.
>
> When CONFIG_NVHE_EL2_DEBUG is enabled the host stage 2 protection is
> disabled, allowing the host to read the hypervisor stack pages and unwind
> the stack from EL1. This allows us to print the hypervisor stacktrace
> before panicking the host; as shown below.
>
> Example call trace:
>
> [   98.916444][  T426] kvm [426]: nVHE hyp panic at: [<ffffffc0096156fc>] __kvm_nvhe_overflow_stack+0x8/0x34!
> [   98.918360][  T426] nVHE HYP call trace:
> [   98.918692][  T426] kvm [426]: [<ffffffc009615aac>] __kvm_nvhe_cpu_prepare_nvhe_panic_info+0x4c/0x68
> [   98.919545][  T426] kvm [426]: [<ffffffc0096159a4>] __kvm_nvhe_hyp_panic+0x2c/0xe8
> [   98.920107][  T426] kvm [426]: [<ffffffc009615ad8>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
> [   98.920665][  T426] kvm [426]: [<ffffffc009610a4c>] __kvm_nvhe___kvm_hyp_host_vector+0x24c/0x794
> [   98.921292][  T426] kvm [426]: [<ffffffc009615718>] __kvm_nvhe_overflow_stack+0x24/0x34
> . . .
>
> [   98.973382][  T426] kvm [426]: [<ffffffc009615718>] __kvm_nvhe_overflow_stack+0x24/0x34
> [   98.973816][  T426] kvm [426]: [<ffffffc0096152f4>] __kvm_nvhe___kvm_vcpu_run+0x38/0x438
> [   98.974255][  T426] kvm [426]: [<ffffffc009616f80>] __kvm_nvhe_handle___kvm_vcpu_run+0x1c4/0x364
> [   98.974719][  T426] kvm [426]: [<ffffffc009616928>] __kvm_nvhe_handle_trap+0xa8/0x130
> [   98.975152][  T426] kvm [426]: [<ffffffc009610064>] __kvm_nvhe___host_exit+0x64/0x64
> [   98.975588][  T426] ---- end of nVHE HYP call trace ----
>
>
> Kalesh Singh (8):
>   KVM: arm64: Introduce hyp_alloc_private_va_range()
>   KVM: arm64: Introduce pkvm_alloc_private_va_range()
>   KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
>   KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack
>   KVM: arm64: Detect and handle hypervisor stack overflows
>   KVM: arm64: Add hypervisor overflow stack
>   KVM: arm64: Unwind and dump nVHE HYP stacktrace
>   KVM: arm64: Symbolize the nVHE HYP backtrace
>
>  arch/arm64/include/asm/kvm_asm.h     |  20 +++
>  arch/arm64/include/asm/kvm_mmu.h     |   4 +
>  arch/arm64/include/asm/stacktrace.h  |  12 ++
>  arch/arm64/kernel/stacktrace.c       | 210 ++++++++++++++++++++++++---
>  arch/arm64/kvm/Kconfig               |   5 +-
>  arch/arm64/kvm/arm.c                 |  34 ++++-
>  arch/arm64/kvm/handle_exit.c         |  16 +-
>  arch/arm64/kvm/hyp/include/nvhe/mm.h |   3 +-
>  arch/arm64/kvm/hyp/nvhe/host.S       |  29 ++++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c   |   5 +-
>  arch/arm64/kvm/hyp/nvhe/mm.c         |  51 ++++---
>  arch/arm64/kvm/hyp/nvhe/setup.c      |  25 +++-
>  arch/arm64/kvm/hyp/nvhe/switch.c     |  30 +++-
>  arch/arm64/kvm/mmu.c                 |  62 +++++---
>  scripts/kallsyms.c                   |   2 +-
>  15 files changed, 422 insertions(+), 86 deletions(-)
>
>
> base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
> --
> 2.35.1.473.g83b2b277ed-goog
>
