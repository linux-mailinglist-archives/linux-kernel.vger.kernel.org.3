Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF04B186E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbiBJWmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:42:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345087AbiBJWmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:42:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AF526E7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:42:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s133-20020a252c8b000000b0062112290d0bso81353ybs.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=KKogoV3I1Ztwi08cWi/kskl7f13dMqHnW1NYHFKZhQY=;
        b=MSpmQCaLUVfuj+jaf2QClix5p6yRH8yzpyXKVnUK70zmSq5C6/qdwILNdwUhcYMF8c
         u2hO+qWimnqb+XJXum2CyHU9kaCpP4gkRh47JMce1cQUyDNmevlnXSk/v4J+ibagMpdi
         6SyBC+677sSNAQTgfwfnsoK9hG38S7tJZegaoLmq/yU+PY5VBbjSvEWD5BQFkjDn541W
         0JSNQrorMDSfKK5rlmgt+EWI1MHti2dN4PrYJBbrILg+UvVfff878dBp5MtI/4qmAOqW
         Nc7XlL61zC/1JLJf8Tf3E1Keb7HV2kSiSgcuaOFlOR7BDfv+pCD6q+wH9wLq+bDThuMT
         cAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=KKogoV3I1Ztwi08cWi/kskl7f13dMqHnW1NYHFKZhQY=;
        b=TF3POIXn3OhwxXKU3ZKuWyCuvTloq12oS0BvIX9eet3e/1ObhpjY6i8IL8hyjYOMCN
         FB7DorqHDd7wih3WVBtkc9LlO8cjfBlk4xQjwMJE+yjbxWW6r+FyjyZbpQJO+Ck/GgHg
         hsG2rgZE1KU1kZQpaHC/KPabVLns+9QzZST+Z9el21kAZYgGvaNe5tBqsp6S9z995kF2
         myb01YdsScZVnoBMElQgKBbTx7Yembs1uPZqEl3TCtidJJSW2uSYuHP4NvXOdYSQBx+v
         7UyX5viXF9WL8J2aYvdrR9edqFaQR9XvvvhZfs5t5ve/xzfB1pgaP4dmNSfQbVJY2lLT
         AilA==
X-Gm-Message-State: AOAM532TUBqRrHkQOidmexlZJw0CMKt8L8O/z/pgPwA2sAg1U2qDFVfC
        QdywK7rVs/G/hv8XHG5Fh98CKWPP7wbMd5EweQ==
X-Google-Smtp-Source: ABdhPJyp/KdgRlhbqVTv9Y4bfoAHsHmpgIk8uWR57nT9DX2u71VlcwaE1ajfiRh3Ozy8DknZf9zAjVroiBACXQvDfw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:8f02:232:ad86:2ab2])
 (user=kaleshsingh job=sendgmr) by 2002:a25:5802:: with SMTP id
 m2mr9400424ybb.681.1644532964348; Thu, 10 Feb 2022 14:42:44 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:41:41 -0800
Message-Id: <20220210224220.4076151-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 0/7] KVM: arm64: Hypervisor stack enhancements
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
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

This series is based on v5.17-rc3 and adds the following stack features to
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


Kalesh Singh (3):
  KVM: arm64: Add Hyp overflow stack
  KVM: arm64: Unwind and dump nVHE HYP stacktrace
  KVM: arm64: Symbolize the nVHE HYP backtrace

Quentin Perret (4):
  KVM: arm64: Map the stack pages in the 'private' range
  KVM: arm64: Factor out private range VA allocation
  arm64: asm: Introduce test_sp_overflow macro
  KVM: arm64: Allocate guard pages near hyp stacks

 arch/arm64/include/asm/assembler.h   |  11 +
 arch/arm64/include/asm/kvm_asm.h     |  17 ++
 arch/arm64/kernel/entry.S            |   9 +-
 arch/arm64/kvm/Makefile              |   1 +
 arch/arm64/kvm/arm.c                 |   2 +-
 arch/arm64/kvm/handle_exit.c         |  14 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h |   1 +
 arch/arm64/kvm/hyp/nvhe/host.S       |  21 ++
 arch/arm64/kvm/hyp/nvhe/mm.c         |  28 ++-
 arch/arm64/kvm/hyp/nvhe/setup.c      |  63 +++++-
 arch/arm64/kvm/hyp/nvhe/switch.c     |  22 ++
 arch/arm64/kvm/stacktrace.c          | 290 +++++++++++++++++++++++++++
 arch/arm64/kvm/stacktrace.h          |  17 ++
 scripts/kallsyms.c                   |   2 +-
 14 files changed, 468 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/kvm/stacktrace.c
 create mode 100644 arch/arm64/kvm/stacktrace.h


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.35.1.265.g69c8d7142f-goog

