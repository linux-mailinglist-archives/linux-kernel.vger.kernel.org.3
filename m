Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2285A718D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiH3XRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiH3XQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:16:26 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3497B63F25
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h12-20020a170902f54c00b0016f8858ce9bso8739265plf.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc;
        bh=aNB2G1p8JImzNc5dEIuevaxhalyBC2/QTMyVxE1BAdY=;
        b=hJgGAmgESogRYu+UWbKk7fHxmYr9CBdASi28qnn5M0EDhTZxCRlIfvMiFqk5avr43Q
         pENea1qTrbV4QvXcupPWb9P8F//UDRonsrQop2jiLcGiPg4/L2ghVIIDd4yVMUSx2Psz
         e2FB6PLYBPas49WrBn9exoDdSYKTsYQOeUqtJbSDs5Hmb/gS6L/geIyyZVdcXQAznoeC
         2SFwIBJaOi2jtuqDo9UYGw/0u19IOzrD1X7RBuW0t/W1JlEBmERGDXUIK3US363toZkQ
         nOnBkwUhzdi0TxHs1ObOUu6+e+v/0NHrUMp2t37pLVmkaXx4Zn6ZF5gfBvBGMhmu18UK
         HpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc;
        bh=aNB2G1p8JImzNc5dEIuevaxhalyBC2/QTMyVxE1BAdY=;
        b=17kEAiWrthBZfRoLUS1SNTbXKBhLlYEBgCY7LZlavgr7tZ82TkfyKsLoXm9yG8kAOg
         5Qkoutn5qHWGQL0BeebfzqtxF1T3yr+vg+jJR0s/eGxP2cqox9RiWzApgLlOZE4LW7u4
         ba0Z/dZDjspaqVQaFS/N5yirKmsFh6q0Bf8pTd0fTaFAlhRSqlz+ReoXWlBqS+70yRX4
         uDiwEkt/+pqTrr+uvPBmP4opTt/sGjq2tgpjJ7Inkg1qYR0KFmgzDfJ9ZMyR7EZh51Fu
         6CC2VMSp//1twcpn/bhn95o+ZGPWF4u3LKt/UNEPmhN86ZtVsEsTpAA89mWnrgo/wbtT
         Dh3Q==
X-Gm-Message-State: ACgBeo1bmEXfmqs3ZOevEsSvYdah32oFZSouQJMlE4VoPs0om6675mde
        1Q0WEcVn1M42iKZp1Sv4+W6xsRlzaYE=
X-Google-Smtp-Source: AA6agR5zS66OMb6RhJSr2dTa/+b2KoJlzTAKdbwoEn6stlpf8zfsVvD5MgFba1xtnkLXL7VXCK+wp8FpG24=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:238c:b0:537:d491:4cec with SMTP id
 f12-20020a056a00238c00b00537d4914cecmr21243345pfc.8.1661901377259; Tue, 30
 Aug 2022 16:16:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:15:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830231614.3580124-1-seanjc@google.com>
Subject: [PATCH v5 00/27] KVM: x86: Event/exception fixes and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo and others, please take a look at the proposed changes to
force_emulation_prefix, especially the last patch which makes it writable
while KVM is running.  I'm pretty confident that's safe, but definitely
want confirmation that I'm not overlooking something.

The main goal of this series is to fix KVM's longstanding bug of not
honoring L1's exception intercepts wants when handling an exception that
occurs during delivery of a different exception.  E.g. if L0 and L1 are
using shadow paging, and L2 hits a #PF, and then hits another #PF while
vectoring the first #PF due to _L1_ not having a shadow page for the IDT,
KVM needs to check L1's intercepts before morphing the #PF => #PF => #DF
so that the #PF is routed to L1, not injected into L2 as a #DF.

nVMX has hacked around the bug for years by overriding the #PF injector
for shadow paging to go straight to VM-Exit, and nSVM has started doing
the same.  The hacks mostly work, but they're incomplete, confusing, and
lead to other hacky code, e.g. bailing from the emulator because #PF
injection forced a VM-Exit and suddenly KVM is back in L1.

v5:
 - Collect reviews. [Maxim]
 - Check code breakpoints on forced emulation (FEP #UD).  Hardware checks
   the RIP of the magic prefix, KVM needs to check the RIP of the insn.
 - Suppress code #DBs on Intel vCPUs if MOV/POP-SS blocking is active.
 - Extend the forced emulation to allow clearing RFLAGS.RF (Intel sets
   it unconditionaly on VM-Exit(#UD), which makes it impossibled to use
   forced emulation to test code #DBs.
 - Allow writing force_emulation_prefix while KVM is running.

v4:
 - https://lore.kernel.org/all/20220723005137.1649592-1-seanjc@google.com
 - Collect reviews. [Maxim]
 - Fix a bug where an intermediate patch dropped the async #PF token
   and used a stale payload. [Maxim]
 - Tweak comments to call out that AMD CPUs generate error codes with
   bits 31:16 != 0. [Maxim]

v3:
 - https://lore.kernel.org/all/20220715204226.3655170-1-seanjc@google.com
 - Collect reviews. [Maxim, Jim]
 - Split a few patches into more consumable chunks. [Maxim]
 - Document that KVM doesn't correctly handle SMI+MTF (or SMI priority). [Maxim]
 - Add comment to document the instruction boundary (event window) aspect
   of block_nested_events. [Maxim]
 - Add a patch to rename inject_pending_events() and add a comment to
   document KVM's not-quite-architecturally-correct handing of instruction
   boundaries and asynchronous events. [Maxim]

v2:
  - https://lore.kernel.org/all/20220614204730.3359543-1-seanjc@google.com
  - Rebased to kvm/queue (commit 8baacf67c76c) + selftests CPUID
    overhaul.
    https://lore.kernel.org/all/20220614200707.3315957-1-seanjc@google.com
  - Treat KVM_REQ_TRIPLE_FAULT as a pending exception.

v1: https://lore.kernel.org/all/20220614204730.3359543-1-seanjc@google.com


Sean Christopherson (27):
  KVM: nVMX: Unconditionally purge queued/injected events on nested
    "exit"
  KVM: VMX: Drop bits 31:16 when shoving exception error code into VMCS
  KVM: x86: Don't check for code breakpoints when emulating on exception
  KVM: x86: Allow clearing RFLAGS.RF on forced emulation to test code
    #DBs
  KVM: x86: Suppress code #DBs on Intel if MOV/POP SS blocking is active
  KVM: nVMX: Treat General Detect #DB (DR7.GD=1) as fault-like
  KVM: nVMX: Prioritize TSS T-flag #DBs over Monitor Trap Flag
  KVM: x86: Treat #DBs from the emulator as fault-like (code and
    DR7.GD=1)
  KVM: x86: Use DR7_GD macro instead of open coding check in emulator
  KVM: nVMX: Ignore SIPI that arrives in L2 when vCPU is not in WFS
  KVM: nVMX: Unconditionally clear mtf_pending on nested VM-Exit
  KVM: VMX: Inject #PF on ENCLS as "emulated" #PF
  KVM: x86: Rename kvm_x86_ops.queue_exception to inject_exception
  KVM: x86: Make kvm_queued_exception a properly named, visible struct
  KVM: x86: Formalize blocking of nested pending exceptions
  KVM: x86: Use kvm_queue_exception_e() to queue #DF
  KVM: x86: Hoist nested event checks above event injection logic
  KVM: x86: Evaluate ability to inject SMI/NMI/IRQ after potential
    VM-Exit
  KVM: nVMX: Add a helper to identify low-priority #DB traps
  KVM: nVMX: Document priority of all known events on Intel CPUs
  KVM: x86: Morph pending exceptions to pending VM-Exits at queue time
  KVM: x86: Treat pending TRIPLE_FAULT requests as pending exceptions
  KVM: VMX: Update MTF and ICEBP comments to document KVM's subtle
    behavior
  KVM: x86: Rename inject_pending_events() to
    kvm_check_and_inject_events()
  KVM: selftests: Use uapi header to get VMX and SVM exit reasons/codes
  KVM: selftests: Add an x86-only test to verify nested exception
    queueing
  KVM: x86: Allow force_emulation_prefix to be written without a reload

 arch/x86/include/asm/kvm-x86-ops.h            |   2 +-
 arch/x86/include/asm/kvm_host.h               |  35 +-
 arch/x86/kvm/emulate.c                        |   3 +-
 arch/x86/kvm/svm/nested.c                     | 110 ++--
 arch/x86/kvm/svm/svm.c                        |  20 +-
 arch/x86/kvm/vmx/nested.c                     | 331 ++++++++----
 arch/x86/kvm/vmx/sgx.c                        |   2 +-
 arch/x86/kvm/vmx/vmx.c                        |  54 +-
 arch/x86/kvm/x86.c                            | 488 ++++++++++++------
 arch/x86/kvm/x86.h                            |  11 +-
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/svm_util.h   |   7 +-
 .../selftests/kvm/include/x86_64/vmx.h        |  51 +-
 .../kvm/x86_64/nested_exceptions_test.c       | 295 +++++++++++
 15 files changed, 987 insertions(+), 424 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c


base-commit: 372d07084593dc7a399bf9bee815711b1fb1bcf2
-- 
2.37.2.672.g94769d06f0-goog

