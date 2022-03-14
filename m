Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2614D8DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbiCNUDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbiCNUDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:03:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2773EA8B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:02:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dc1ce31261so140806677b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=xEuR5NAbPKTc90nTUG2UpVDsPT4/g7gJ4EIuKy2M61Y=;
        b=ry7DrS+DzmCoBuS+N3t8KJPneqxZpyjWKhm0hi4UrJVtWocUiLGratH7dA7vGH64X7
         Qg/sE6ZP+ZQuX6cKWQqNcZW6E9FfL8kpyZVAoWnG+B5DO6fQiwivmN8fNnXVY0N6Ixvf
         bMOIdm00KmvyWI9+z3twtaJ6QG9adpXzf7D7r2LWmUXxnDLf73lL12Lok43SuXanyQop
         KBwSkd7sD4mFizm5xQ53F43xhYn9dXjcZk0+drkMZbmDDYN3Y4hmCBytmO7wv8ywRXdB
         b8p8OtiKMvR67lAOiIZx034Nf/fJoa1ZehmUA2wp5KusaqdbU77O+LKpVeykEIpNS6GY
         fuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=xEuR5NAbPKTc90nTUG2UpVDsPT4/g7gJ4EIuKy2M61Y=;
        b=MQ40vQq4dAjabs25QcUVjaBpMwEGpvrBG6u39qZz0aI3EwUEmgh91IWLQZtbcwjw8F
         lvf9Grj4gsnUyo7dwfTK2+g1YPXStY523V/zEWa+RLfyqROxFjuuIzDBBLBgPrYXqxgY
         SXeS5uDwdRem+sCgurXxC/8S7ZBm7dF2arsU5fNuPLxlYu3VlWfRN1h1sXBVzA/lYLas
         qHBgicwzOcnzqWyOxRZaBRWH4N7ycQ8J72YOpYXApjo7cn3d2f+8c+Exfzei9cJOkiFZ
         3dKSckmVWj6qewCXjZ+sFv56jtz6Yl2jlojbotu9mqwS/rgnqLp+v00jEwLzz9eF8KH4
         mVMw==
X-Gm-Message-State: AOAM532Bz2CCZhYNxADhVtpfPJ+EHYhT5fDn5JQtdp3hNl9WQZVpEEkf
        N2PfgDr5L5lNgJFccWA3ygskVxpywyOLFXBuDw==
X-Google-Smtp-Source: ABdhPJxifXiV2IwBShgAldnOtAN44f4qB6zmnPyH/IJw/7BkXZPOJKxYCtAxbJk4yN0V7cgS+dlxUhTFe/JmaJ6gOg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:500a:9ac2:e73e:69e3])
 (user=kaleshsingh job=sendgmr) by 2002:a25:7b85:0:b0:628:beb3:d877 with SMTP
 id w127-20020a257b85000000b00628beb3d877mr19510073ybc.8.1647288122059; Mon,
 14 Mar 2022 13:02:02 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:01:09 -0700
Message-Id: <20220314200148.2695206-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 0/8] KVM: arm64: Hypervisor stack enhancements
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Scull <ascull@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v6 of the nVHE hypervisor stack enhancements. Addresses some
refactoring/cleanup and documentation improvments from Stephen,
and rebased on 5.17-rc8.

Previous versions can be found at:
v5: https://lore.kernel.org/r/20220307184935.1704614-1-kaleshsingh@google.com/
v4: https://lore.kernel.org/r/20220225033548.1912117-1-kaleshsingh@google.com/
v3: https://lore.kernel.org/r/20220224051439.640768-1-kaleshsingh@google.com/
v2: https://lore.kernel.org/r/20220222165212.2005066-1-kaleshsingh@google.com/
v1: https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/

The previous cover letter has been copied below for convenience.

Thanks,
Kalesh

-----

This series is based on 5.17-rc8 and adds the following stack features to
the KVM nVHE hypervisor:

== Hyp Stack Guard Pages ==

Based on the technique used by arm64 VMAP_STACK to detect overflow.
i.e. the stack is aligned such that the 'stack shift' bit of any valid
SP is 1. The 'stack shift' bit can be tested in the exception entry to
detect overflow without corrupting GPRs.

== Hyp Stack Unwinder ==

The unwinding and dumping of the hyp stack is not enabled by default and
depends on CONFIG_NVHE_EL2_DEBUG to avoid potential information leaks.

When CONFIG_NVHE_EL2_DEBUG is enabled the host stage 2 protection is
disabled, allowing the host to read the hypervisor stack pages and unwind
the stack from EL1. This allows us to print the hypervisor stacktrace
before panicking the host; as shown below.

Example call trace:

[   98.916444][  T426] kvm [426]: nVHE hyp panic at: [<ffffffc0096156fc>] __kvm_nvhe_overflow_stack+0x8/0x34!
[   98.918360][  T426] nVHE HYP call trace:
[   98.918692][  T426] kvm [426]: [<ffffffc009615aac>] __kvm_nvhe_cpu_prepare_nvhe_panic_info+0x4c/0x68
[   98.919545][  T426] kvm [426]: [<ffffffc0096159a4>] __kvm_nvhe_hyp_panic+0x2c/0xe8
[   98.920107][  T426] kvm [426]: [<ffffffc009615ad8>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
[   98.920665][  T426] kvm [426]: [<ffffffc009610a4c>] __kvm_nvhe___kvm_hyp_host_vector+0x24c/0x794
[   98.921292][  T426] kvm [426]: [<ffffffc009615718>] __kvm_nvhe_overflow_stack+0x24/0x34
. . .

[   98.973382][  T426] kvm [426]: [<ffffffc009615718>] __kvm_nvhe_overflow_stack+0x24/0x34
[   98.973816][  T426] kvm [426]: [<ffffffc0096152f4>] __kvm_nvhe___kvm_vcpu_run+0x38/0x438
[   98.974255][  T426] kvm [426]: [<ffffffc009616f80>] __kvm_nvhe_handle___kvm_vcpu_run+0x1c4/0x364
[   98.974719][  T426] kvm [426]: [<ffffffc009616928>] __kvm_nvhe_handle_trap+0xa8/0x130
[   98.975152][  T426] kvm [426]: [<ffffffc009610064>] __kvm_nvhe___host_exit+0x64/0x64
[   98.975588][  T426] ---- end of nVHE HYP call trace ----




Kalesh Singh (8):
  KVM: arm64: Introduce hyp_alloc_private_va_range()
  KVM: arm64: Introduce pkvm_alloc_private_va_range()
  KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
  KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack
  KVM: arm64: Detect and handle hypervisor stack overflows
  KVM: arm64: Add hypervisor overflow stack
  KVM: arm64: Unwind and dump nVHE HYP stacktrace
  KVM: arm64: Symbolize the nVHE HYP backtrace

 arch/arm64/include/asm/kvm_asm.h     |  21 +++
 arch/arm64/include/asm/kvm_mmu.h     |   4 +
 arch/arm64/include/asm/stacktrace.h  |  12 ++
 arch/arm64/kernel/stacktrace.c       | 210 ++++++++++++++++++++++++---
 arch/arm64/kvm/Kconfig               |   5 +-
 arch/arm64/kvm/arm.c                 |  41 +++++-
 arch/arm64/kvm/handle_exit.c         |  16 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h |   6 +-
 arch/arm64/kvm/hyp/nvhe/host.S       |  29 ++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  18 ++-
 arch/arm64/kvm/hyp/nvhe/mm.c         |  78 ++++++----
 arch/arm64/kvm/hyp/nvhe/setup.c      |  31 +++-
 arch/arm64/kvm/hyp/nvhe/switch.c     |  30 +++-
 arch/arm64/kvm/mmu.c                 |  70 ++++++---
 scripts/kallsyms.c                   |   2 +-
 15 files changed, 477 insertions(+), 96 deletions(-)


base-commit: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
-- 
2.35.1.723.g4982287a31-goog

