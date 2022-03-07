Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414D84D06DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243619AbiCGSui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiCGSug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:50:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CED5C852
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:49:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a3-20020a5b0ac3000000b006288f395b25so14283086ybr.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=sfVUTk2MbhVgy0tKug84HjGTAODI0KpG5JNI6LdeG5Q=;
        b=mBD7jDE9tctzEwd05BghFMrXysPRXZH49psJdvMCVo1LFKJuoybPLYv+zm28CPjdAn
         FHmAenInSI30NtCmPkisWjlUYl1Phey3TlDGp11Ea9klFHmkRnvORexyuov/tZ/YAsES
         hhML8NfQLEIQc8mEK1/wQ3Ysoecxd1/NHjlfNnZKK3DpJAiuh2A4Ll9UUt3PonjBaMfZ
         9vIYC/bEKiOtXeNtZ6ktkA+fRw7AXbd/l7Awawerz2ZENW2plzW+EHM3y5NO+kkV+T9P
         ZLxsM1wmsAwhlwsDPVdTzWm373LE7elz/RpRUxHQyeuB3enAKW5BwS3y6YuHQERPfZtj
         YnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=sfVUTk2MbhVgy0tKug84HjGTAODI0KpG5JNI6LdeG5Q=;
        b=BvZChnvYl3BIaZrHxmJyf7ieXbCGnEtbbtDAqyDP5c+4550rnt6Rb1O98nJoQYcd0+
         BkmYzzFAkx4aiyPq3KNb5uLgVpgemXHf+g6zACCwdcHzdVILoLztpeM9vFONCWwZMcsX
         plsnHNumd4snKWMKvewG1BzCun3LolSenfjq3pyTxxhYFbNsC1GVHoahhqSECa7FD8X0
         BeUKZQQtrISLaWagjG5S706Pec2jXskf1Bi1rRZOfTf9w/jU08XNwvU99GfpqbSOXaUA
         z1waJwzIDpMHVcqlm0enYEpfpVbKndLcRxTQ4if4GE7sZnCuMtYMX0qcqDrZJ3PBkFkv
         uI4w==
X-Gm-Message-State: AOAM533Emb8kyflOge2XDgqS0w289ewoiDT9kfXRrCmI8Q6TvURXMby6
        0c9gIfi8aRct519DgbYkDw3pSbvaW5r6k3JMxg==
X-Google-Smtp-Source: ABdhPJwYR1ukUuK1X0gGG2I3YVw+cUKejD8V8+q6qNTMpKaEru/j9GxQIUP2JpqPwd8HWu9c/k22KViOLRx7I/V8ow==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:dd66:1e7d:1858:4587])
 (user=kaleshsingh job=sendgmr) by 2002:a25:e645:0:b0:628:8f2b:ef2 with SMTP
 id d66-20020a25e645000000b006288f2b0ef2mr9304216ybh.475.1646678980575; Mon,
 07 Mar 2022 10:49:40 -0800 (PST)
Date:   Mon,  7 Mar 2022 10:48:58 -0800
Message-Id: <20220307184935.1704614-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 0/8] KVM: arm64: Hypervisor stack enhancements
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

This is v5 of the nVHE hypervisor stack enhancements. The main changes in this
version are:
  - Align private allocations on based the order of their size
  - Allocate single private VA range for both stack and guard page
    (Don't rely on allocator providing separate allocations that are contiguous)
  - Rebase series on 5.17-rc7

Previous versions can be found at:
v4: https://lore.kernel.org/r/20220225033548.1912117-1-kaleshsingh@google.com/
v3: https://lore.kernel.org/r/20220224051439.640768-1-kaleshsingh@google.com/
v2: https://lore.kernel.org/r/20220222165212.2005066-1-kaleshsingh@google.com/
v1: https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/

The previous cover letter has been copied below for convenience.

Thanks,
Kalesh

-----

This series is based on 5.17-rc7 and adds the following stack features to
the KVM nVHE hypervisor:

== Hyp Stack Guard Pages ==

Based on the technique used by arm64 VMAP_STACK to detect overflow.
i.e. the stack is aligned such that the 'stack shift' bit of any valid
SP is 1. The 'stack shift' bit can be tested in the exception entry to
detect overflow without corrupting GPRs.

== Hyp Stack Unwinder ==

Based on the arm64 kernel stack unwinder
(See: arch/arm64/kernel/stacktrace.c)

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
 arch/arm64/kvm/arm.c                 |  42 +++++-
 arch/arm64/kvm/handle_exit.c         |  16 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h |   1 +
 arch/arm64/kvm/hyp/nvhe/host.S       |  29 ++++
 arch/arm64/kvm/hyp/nvhe/mm.c         |  56 ++++---
 arch/arm64/kvm/hyp/nvhe/setup.c      |  31 +++-
 arch/arm64/kvm/hyp/nvhe/switch.c     |  30 +++-
 arch/arm64/kvm/mmu.c                 |  67 ++++++---
 scripts/kallsyms.c                   |   2 +-
 14 files changed, 440 insertions(+), 86 deletions(-)


base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
-- 
2.35.1.616.g0bdcbb4464-goog

