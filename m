Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4D05775A7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 12:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiGQKNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 06:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiGQKNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 06:13:31 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5304D140AF
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 03:13:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VJXkPQD_1658052805;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VJXkPQD_1658052805)
          by smtp.aliyun-inc.com;
          Sun, 17 Jul 2022 18:13:25 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr, alexandre.ghiti@canonical.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH 0/5] Fixups to work with crash tool
Date:   Sun, 17 Jul 2022 18:13:18 +0800
Message-Id: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ever sent the patch 1,2 in the link:
https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-2-xianting.tian@linux.alibaba.com/
https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
And patch 3,4 in the link:
https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/

This patch series just put these patches together, and with a new patch 5.
these five patches are the fixups for kexec, vmcore and improvements
for vmcoreinfo and memory layout dump.

The main changes in the five patchs as below,
Patch 1: Add a fast call path of crash_kexec() as other Arch(x86, arm64) do.
Patch 2: use __smp_processor_id() instead of smp_processor_id() to cleanup
	 the console prints.
Patch 3: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
	 the development of crash tool as ARM64 already did
	 (arch/arm64/kernel/crash_core.c).
Patch 4: Add modules to virtual kernel memory layout dump.
Patch 5: Fixup to get correct kernel mode PC for vmcore

With these 5 patches(patch 3 is must), crash tool can work well to analyze
a vmcore. The patches for crash tool for RISCV64 is in the link:
https://lore.kernel.org/linux-riscv/20220717042929.370022-1-xianting.tian@linux.alibaba.com/

Xianting Tian (5):
  RISC-V: Fixup fast call of crash_kexec()
  RISC-V: use __smp_processor_id() instead of smp_processor_id()
  RISC-V: Add arch_crash_save_vmcoreinfo support
  riscv: Add modules to virtual kernel memory layout dump
  RISC-V: Fixup getting correct current pc

 arch/riscv/kernel/Makefile          |  1 +
 arch/riscv/kernel/crash_core.c      | 29 +++++++++++++++++++++++++++++
 arch/riscv/kernel/crash_save_regs.S |  2 +-
 arch/riscv/kernel/machine_kexec.c   |  2 +-
 arch/riscv/kernel/traps.c           |  4 ++++
 arch/riscv/mm/init.c                |  4 ++++
 6 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/kernel/crash_core.c

-- 
2.17.1

