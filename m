Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E676F4C3C76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiBYDi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiBYDi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:38:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A66179A05
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:38:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so1979083ybp.19
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=lRl0HjXhPu6ADawywYnArEMte7rRfDeWFMBvRkbFFjM=;
        b=S7Ke1Qrv/H2gN5bhiIKHyXO5BqKb0hR9jNRoPi0ajEBy8u9aNZorLX7Bo8H1GqHsKz
         fmsU7Ycr3ES37wkC2wy6RB2faGuLjPdcjhP8gh4qvonB2dN744jN9Qd0Y+ewhJBs0Cju
         R+RzRPi6HqMmLq5cgrFtJ/uBW110v4PhK/pKkXGUlNNCRdDA75w96ekaFpOahjt3Xht5
         ZhOZZAaYBlDdZV4/gS2FFVYdvU97vf+K3Q5mKDiKGE/BhIL+5RvDUbw1+8GJK/a1Ybe1
         Pm6mYc8xu4dhRUkcWmUWV83PwwMqz8U2so66u68ZMz4jE5XVbhlD7L5Ux4w/BE8bgAcm
         Kf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=lRl0HjXhPu6ADawywYnArEMte7rRfDeWFMBvRkbFFjM=;
        b=K1bmEWnobBTsfq+3g2cQ9J1aFyZgStqOeQrc5FS0kgMEGYYd5Z0UsGbXZPnEtFRngv
         UtHV+A/RFBxB2O6OoDO2PWZcomjU/h61tRQtR8ScDj6gwilhr1ntRvbg5ClAe4oVryeT
         55AsMyYrP0I+TbDzgeem42aC8PCCodu9IDEQAvjEe3H50QJGMgrGJ8UEQpAbA0mU5CO3
         wDoWncJUojL8vUDCxzWGY1q287NQPYaaR3pjsawKuxZ8hknOVKqExm5uqMCS+AeqcIVJ
         aM8itU3laN+MLXYoKx7aUKhApiGHChdoM2IJXEG8xqdHfWnV0lC8GbfVH8M28kywDb0C
         0UbA==
X-Gm-Message-State: AOAM530D2BVEf0YjN0Ilm4Z5x705Y4hbAalf6R/by62f/g4u/UkJSRUY
        rBNHaqr2/tLKNdJ933xixQigzq48KGXjXr62Rg==
X-Google-Smtp-Source: ABdhPJzT2/dEx2ZlZAx77MFqSXMTepcIZYciKpvBk468Pli5bTlecp6MbBohdSPmg6XJHm7ArsvkwmhXD6EBP+rbvA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:3a50:90b2:e6a2:9060])
 (user=kaleshsingh job=sendgmr) by 2002:a25:4945:0:b0:61d:546d:aedb with SMTP
 id w66-20020a254945000000b0061d546daedbmr5422061yba.147.1645760305379; Thu,
 24 Feb 2022 19:38:25 -0800 (PST)
Date:   Thu, 24 Feb 2022 19:34:45 -0800
Message-Id: <20220225033548.1912117-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 0/8] KVM: arm64: Hypervisor stack enhancements
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
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

This is v4 of the nVHE hypervisor stack enhancements.

Previous versions can be found at:
v3: https://lore.kernel.org/r/20220224051439.640768-1-kaleshsingh@google.com/
v2: https://lore.kernel.org/r/20220222165212.2005066-1-kaleshsingh@google.com/
v1: https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/

The previous cover letter has been copied below for convenience.

Thanks,
Kalesh

-----

This series is based on 5.17-rc5 and adds the following stack features to
the KVM nVHE hypervisor:

== Hyp Stack Guard Pages ==

Based on the technique used by arm64 VMAP_STACK to detect overflow.
i.e. the stack is aligned to twice its size which ensure that the 
'stack shift' bit of any valid SP is 0. The 'stack shift' bit can be
tested in the exception entry to detect overflow without corrupting GPRs.

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
 arch/arm64/kvm/arm.c                 |  34 ++++-
 arch/arm64/kvm/handle_exit.c         |  16 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h |   3 +-
 arch/arm64/kvm/hyp/nvhe/host.S       |  29 ++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   |   5 +-
 arch/arm64/kvm/hyp/nvhe/mm.c         |  60 +++++---
 arch/arm64/kvm/hyp/nvhe/setup.c      |  25 +++-
 arch/arm64/kvm/hyp/nvhe/switch.c     |  30 +++-
 arch/arm64/kvm/mmu.c                 |  65 ++++++---
 scripts/kallsyms.c                   |   2 +-
 15 files changed, 428 insertions(+), 93 deletions(-)


base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.35.1.574.g5d30c73bfb-goog

