Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880684BFF52
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiBVQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiBVQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:53:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA463298D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:52:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s22-20020a252d56000000b00624652ac3e1so9299709ybe.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=FUZhxNiWpTBuv/yo6aC9br7WFC740z5ipvXijUNB1uM=;
        b=rl7DGr9SKCJXXULyQIrNMfWNqV8X0uSCbZhx5bKPP42G9Onx9lq+GQAIBvFAcYM0KR
         Yud0tbtBDX9beTd1+sjFvWoFwk5t88qg3J8PAorzHjj5DCnaTGLU11aui2kWTwEwa6xW
         99/fFQPBB69uHXZRrLMnY8mskRUSa+VgfrimpGhCICIeOSjegQMfKYPl8tb+QwDyI4ED
         lb2YHKrWGQYam0vicFHUYcE7//ShpkJZAnf2Z1mqkqoEvEPITOq8clnVfeWptecNU6Za
         DrkwL6jDl0jULxJGn0RHx0MH8eTOkdkY0DSoUVak546uIUpSPco/QgZ6eFu6kAr1RrKr
         S/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=FUZhxNiWpTBuv/yo6aC9br7WFC740z5ipvXijUNB1uM=;
        b=zmJekwB5H5QD569ItL8xppZkhDff5SMUKgUXVAFsEsEYhAuwgCpiRkCabib69lfQNZ
         jnKfIK//C240VZHpfczKDxlXe4P4VhbbzUPzOrG+HAyXyagTs6T7/1svALB116bNmOV2
         bBv9oA7ay3JgB20hZnPs5JtsqhSrbyOzCqgiCllfCJF+X6oRI7DVkT1d/myeLJSasfcj
         IBLhW7msxM1W3Rdti4M6LB96+u0aRgsh+d3HlqzQtDKefuXCaR22tw4v384xjfKaNw8L
         LG4jif5Qm73dLhtVGmwLHnLkkbCZYNdC5hqc5CACBDg6/1DQGIZfnFJuX7AEocKFaySk
         5lEw==
X-Gm-Message-State: AOAM533QRiVqLK+eam8Wtr9TrmmuRvF1Ky4g0WSOQRLxRgydiW0g5Or8
        fKLx4nNqXSJtvRksiZvQ0GxbEvPzT0ux6uUGXQ==
X-Google-Smtp-Source: ABdhPJyDNYxSumcySMKx9aBNsuewfhPBBIWRyZkgKwWzEZsy+dn6LQiZfsn1zFM7NhoOIoZ+FkhSFT8MYUoWd1pNFw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a81:4bcd:0:b0:2d0:a61f:6b5a with SMTP
 id y196-20020a814bcd000000b002d0a61f6b5amr23695338ywa.477.1645548763067; Tue,
 22 Feb 2022 08:52:43 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:51:01 -0800
Message-Id: <20220222165212.2005066-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 0/9] KVM: arm64: Hypervisor stack enhancements
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
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

This is v2 of the nVHE hypervisor stack enhancements. v1 can be found at:
https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/

This version has been updated to work for 'classic' KVM in nVHE mode in
addition to pKVM, per Marc; and rebased on 5.17-rc5.

The cover letter has been copied below for convenience.

Thanks,
Kalesh

-----

This series adds the following stack features to the KVM nVHE hypervisor:

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
before panicking the host; as shown below:

kvm [408]: nVHE hyp panic at: \
           [<ffffffc01161460c>] __kvm_nvhe_overflow_stack+0x10/0x34!
kvm [408]: nVHE HYP call trace:
kvm [408]: [<ffffffc011614974>] __kvm_nvhe_hyp_panic_bad_stack+0xc/0x10
kvm [408]: [<ffffffc01160fa48>] __kvm_nvhe___kvm_hyp_host_vector+0x248/0x794
kvm [408]: [<ffffffc01161461c>] __kvm_nvhe_overflow_stack+0x20/0x34
. . .
kvm [408]: [<ffffffc01161461c>] __kvm_nvhe_overflow_stack+0x20/0x34
kvm [408]: [<ffffffc01161421c>] __kvm_nvhe___kvm_vcpu_run+0x2c/0x40c
kvm [408]: [<ffffffc011615e14>] __kvm_nvhe_handle___kvm_vcpu_run+0x1c8/0x36c
kvm [408]: [<ffffffc0116157c4>] __kvm_nvhe_handle_trap+0xa4/0x124
kvm [408]: [<ffffffc01160f060>] __kvm_nvhe___host_exit+0x60/0x64
kvm [408]: ---- end of nVHE HYP call trace ----


Kalesh Singh (8):
  KVM: arm64: Introduce hyp_alloc_private_va_range()
  KVM: arm64: Introduce pkvm_alloc_private_va_range()
  KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
  KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack
  KVM: arm64: Detect and handle hypervisor stack overflows
  KVM: arm64: Add hypervisor overflow stack
  KVM: arm64: Unwind and dump nVHE HYP stacktrace
  KVM: arm64: Symbolize the nVHE HYP backtrace

Quentin Perret (1):
  arm64: asm: Introduce test_sp_overflow macro

 arch/arm64/include/asm/assembler.h   |  11 +
 arch/arm64/include/asm/kvm_asm.h     |  18 ++
 arch/arm64/include/asm/kvm_mmu.h     |   4 +
 arch/arm64/kernel/entry.S            |   7 +-
 arch/arm64/kvm/Kconfig               |   5 +-
 arch/arm64/kvm/Makefile              |   1 +
 arch/arm64/kvm/arm.c                 |  34 +++-
 arch/arm64/kvm/handle_exit.c         |  16 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h |   3 +-
 arch/arm64/kvm/hyp/nvhe/host.S       |  21 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   |   5 +-
 arch/arm64/kvm/hyp/nvhe/mm.c         |  49 +++--
 arch/arm64/kvm/hyp/nvhe/setup.c      |  25 ++-
 arch/arm64/kvm/hyp/nvhe/switch.c     |  29 +++
 arch/arm64/kvm/mmu.c                 |  61 ++++--
 arch/arm64/kvm/stacktrace.c          | 290 +++++++++++++++++++++++++++
 arch/arm64/kvm/stacktrace.h          |  17 ++
 scripts/kallsyms.c                   |   2 +-
 18 files changed, 533 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm64/kvm/stacktrace.c
 create mode 100644 arch/arm64/kvm/stacktrace.h


base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.35.1.473.g83b2b277ed-goog

