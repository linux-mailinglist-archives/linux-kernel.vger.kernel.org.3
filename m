Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81E7575B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiGOGKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOGKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:10:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D23DBD2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:10:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i9-20020a258b09000000b0066efe437da6so3287131ybl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jMvgrncDh19VLIxOJYgbY+8u9WVXCjUHgvxdJwgA1hU=;
        b=AU4WA06a1gryKpQZZscV3xyuTAWuOM+1BMyFI07eCKp6M1rjIHwsijdh49eGEWbah7
         uHNFnCQ7PtLlHHa7gv3uPl1OYjdXyhc9IGjYnrFlQZAgemYxQMFWaXc6DXnpysIHLHnF
         BNElBsasUCUo+8kTSCQA0ALDa5zIRDDAlLDElnNTyquxTRqnHcFGYtMrnaFszs55XXFV
         MkjW7pSfYbJdEHWaclwxNgOAtQWJtW2COwyjhsi1U75l+LUe5PYINtBvRDH2qzumYZcy
         vk9vjH40Xcjc+uTxVi4fEaZX8cH8d4imq5uzvZhshER47yCdsZREZvvX7PAhOWkce+OL
         JhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jMvgrncDh19VLIxOJYgbY+8u9WVXCjUHgvxdJwgA1hU=;
        b=GrxgMum4gHUf0KibFPBw6/ZdfRWb7FVAf+l3nycObpQT5wmk57dLDUGRkM64oUEa5a
         BjDaxghEx3oAYglV8/Bok5GP5T9anSpuemknflTXa4YEZmiwqCWZ3HhbUw4moMVNSlM9
         vj/ib3tko7IwFI92V3VRM1ygEJl7d5CZrU0A/A8SicSt7ng4eD678e1au/U67HX9YLLE
         B5jnY1zP6Gq6E9UrFdGv8MP0DqgjSuV4BnOsSMm4WLvvRfuPlcyoRK2NYPDPONCoL2dW
         vhen2deSBWq9JQ9DqD5Wa/lT5iCmCoyWSilQH3fJM/wsgiLMANF6nC72TkqA9pCFtzk1
         FTFg==
X-Gm-Message-State: AJIora9pCIfkzguNDEMVC1YUXA/LCvdKZNguEn7HWFo6/Q+YsKPaebXA
        iOXX7VnrG7SlHgKb5mX1x1ATGNt7IPaAdTCF5g==
X-Google-Smtp-Source: AGRyM1tElEz+Zdy+T5bPWEvVhzahxJmgjZVoA901DfRk1w0g6Kch4frRfRAQVj/F99KlefyGV3nMDpDuquO5xP0uAA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a81:187:0:b0:31d:eebe:16f0 with SMTP
 id 129-20020a810187000000b0031deebe16f0mr4433403ywb.378.1657865431985; Thu,
 14 Jul 2022 23:10:31 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:09 -0700
Message-Id: <20220715061027.1612149-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 00/18] KVM nVHE Hypervisor stack unwinder
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        kaleshsingh@google.com, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, andreyknvl@gmail.com,
        russell.king@oracle.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
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

Hi all,

This is v4 of the series adding support for nVHE hypervisor stacktraces;
and is based on arm64 for-next/stacktrace.

Thanks all for your feedback on previous revisions. Mark Brown, I
appreciate your Reviewed-by on the v3, I have dropped the tags in this
new verision since I think the series has changed quite a bit.

The previous versions were posted at:
v3: https://lore.kernel.org/r/20220607165105.639716-1-kaleshsingh@google.com/
v2: https://lore.kernel.org/r/20220502191222.4192768-1-kaleshsingh@google.com/
v1: https://lore.kernel.org/r/20220427184716.1949239-1-kaleshsingh@google.com/

The main updates in this version are to address concerens from Marc on the
memory usage and reusing the common code by refactoring into a shared header.

Thanks,
Kalesh

============

KVM nVHE Stack unwinding.
===

nVHE has two modes of operation: protected (pKVM) and unprotected
(conventional nVHE). Depending on the mode, a slightly different approach
is used to dump the hyperviosr stacktrace but the core unwinding logic
remains the same.

Protected nVHE (pKVM) stacktraces
====

In protected nVHE mode, the host cannot directly access hypervisor memory.

The hypervisor stack unwinding happens in EL2 and is made accessible to
the host via a shared buffer. Symbolizing and printing the stacktrace
addresses is delegated to the host and happens in EL1.

Non-protected (Conventional) nVHE stacktraces
====

In non-protected mode, the host is able to directly access the hypervisor
stack pages.

The hypervisor stack unwinding and dumping of the stacktrace is performed
by the host in EL1, as this avoids the memory overhead of setting up
shared buffers between the host and hypervisor.

Resuing the Core Unwinding Logic
====

Since the hypervisor cannot link against the kernel code in proteced mode.
The common stack unwinding code is moved to a shared header to allow reuse
in the nVHE hypervisor.

Reducing the memory footprint
====

In this version the below steps were taken to reduce the memory usage of
nVHE stack unwinding:

    1) The nVHE overflow stack is reduced from PAGE_SIZE to 4KB; benificial
       for configurations with non 4KB pages (16KB or 64KB pages).
    2) In protected nVHE mode (pKVM), the shared stacktrace buffers with the
       host are reduced from PAGE_SIZE to the minimum size required.
    3) In systems other than Android, conventional nVHE makes up the vast
       majority of use case. So the pKVM stack tracing is disabled by default
       (!CONFIG_PROTECTED_NVHE_STACKTRACE), which avoid the memory usage for
       setting up shared buffers.
    4) In non-protected nVHE mode (conventional nVHE), the stack unwinding
       is done directly in EL1 by the host and no shared buffers with the
       hyperviosr are needed.

Sample Output
====

The below shows an example output from a simple stack overflow test:

[  126.862960] kvm [371]: nVHE hyp panic at: [<ffff8000090a51d0>] __kvm_nvhe_recursive_death+0x10/0x34!
[  126.869920] kvm [371]: Protected nVHE HYP call trace:
[  126.870528] kvm [371]:  [<ffff8000090a5570>] __kvm_nvhe_hyp_panic+0xac/0xf8
[  126.871342] kvm [371]:  [<ffff8000090a55cc>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
[  126.872174] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  126.872971] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
   . . .

[  126.927314] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  126.927727] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  126.928137] kvm [371]:  [<ffff8000090a4de4>] __kvm_nvhe___kvm_vcpu_run+0x30/0x40c
[  126.928561] kvm [371]:  [<ffff8000090a7b64>] __kvm_nvhe_handle___kvm_vcpu_run+0x30/0x48
[  126.928984] kvm [371]:  [<ffff8000090a78b8>] __kvm_nvhe_handle_trap+0xc4/0x128
[  126.929385] kvm [371]:  [<ffff8000090a6864>] __kvm_nvhe___host_exit+0x64/0x64
[  126.929804] kvm [371]: ---- End of Protected nVHE HYP call trace ----

============


Kalesh Singh (18):
  arm64: stacktrace: Add shared header for common stack unwinding code
  arm64: stacktrace: Factor out on_accessible_stack_common()
  arm64: stacktrace: Factor out unwind_next_common()
  arm64: stacktrace: Handle frame pointer from different address spaces
  arm64: stacktrace: Factor out common unwind()
  arm64: stacktrace: Add description of stacktrace/common.h
  KVM: arm64: On stack overflow switch to hyp overflow_stack
  KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
  KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
  KVM: arm64: Stub implementation of pKVM HYP stack unwinder
  KVM: arm64: Stub implementation of non-protected nVHE HYP stack
    unwinder
  KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
  KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
  KVM: arm64: Implement protected nVHE hyp stack unwinder
  KVM: arm64: Implement non-protected nVHE hyp stack unwinder
  KVM: arm64: Introduce pkvm_dump_backtrace()
  KVM: arm64: Introduce hyp_dump_backtrace()
  KVM: arm64: Dump nVHE hypervisor stack on panic

 arch/arm64/include/asm/kvm_asm.h           |  16 ++
 arch/arm64/include/asm/memory.h            |   7 +
 arch/arm64/include/asm/stacktrace.h        |  92 ++++---
 arch/arm64/include/asm/stacktrace/common.h | 224 ++++++++++++++++
 arch/arm64/include/asm/stacktrace/nvhe.h   | 291 +++++++++++++++++++++
 arch/arm64/kernel/stacktrace.c             | 157 -----------
 arch/arm64/kvm/Kconfig                     |  15 ++
 arch/arm64/kvm/arm.c                       |   2 +-
 arch/arm64/kvm/handle_exit.c               |   4 +
 arch/arm64/kvm/hyp/nvhe/Makefile           |   2 +-
 arch/arm64/kvm/hyp/nvhe/host.S             |   9 +-
 arch/arm64/kvm/hyp/nvhe/stacktrace.c       | 108 ++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c           |   5 +
 13 files changed, 727 insertions(+), 205 deletions(-)
 create mode 100644 arch/arm64/include/asm/stacktrace/common.h
 create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/stacktrace.c


base-commit: 82a592c13b0aeff94d84d54183dae0b26384c95f
-- 
2.37.0.170.g444d1eabd0-goog

