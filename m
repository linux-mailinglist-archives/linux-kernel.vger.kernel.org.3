Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504C757F5BC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiGXPXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGXPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:23:17 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B28B11C08
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:23:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VKDkjNB_1658676187;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKDkjNB_1658676187)
          by smtp.aliyun-inc.com;
          Sun, 24 Jul 2022 23:23:08 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr, alexandre.ghiti@canonical.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V2 0/5] Fixups to work with crash tool
Date:   Sun, 24 Jul 2022 23:23:00 +0800
Message-Id: <20220724152305.1037212-1-xianting.tian@linux.alibaba.com>
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

I ever sent the patch 1 in the link:
https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
And patch 2,3 in the link:
https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/

This patch series just put these patches together, and with two new patch 4, 5.
these five patches are the fixups for machine_kexec, kernel mode PC for vmcore
and improvements for vmcoreinfo and memory layout dump.

The main changes in the five patchs as below,
Patch 1: use __smp_processor_id() instead of smp_processor_id() to cleanup
	 the console prints.
Patch 2: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
	 the development of crash tool as ARM64 already did
	 (arch/arm64/kernel/crash_core.c).
Patch 3: Add modules to virtual kernel memory layout dump.
Patch 4: Fixup to get correct kernel mode PC for vmcore.
Patch 5: Updates vmcoreinfo.rst.

With these 5 patches(patch 2 is must), crash tool can work well to analyze
a vmcore. The patches for crash tool for RISCV64 is in the link:
https://lore.kernel.org/linux-riscv/20220718025346.411758-1-xianting.tian@linux.alibaba.com/

Changes v1 -> v2:
 1, remove the patch "Add a fast call path of crash_kexec()" from this series
 of patches, as it already applied to riscv git.
 https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
 2, add 'Reviewed-by' based on the comments of v1.  

Xianting Tian (5):
  RISC-V: use __smp_processor_id() instead of smp_processor_id()
  RISC-V: Add arch_crash_save_vmcoreinfo support
  riscv: Add modules to virtual kernel memory layout dump
  RISC-V: Fixup getting correct current pc
  riscv64: crash_core: Export kernel vm layout, phys_ram_base

 .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
 arch/riscv/kernel/crash_save_regs.S           |  2 +-
 arch/riscv/kernel/machine_kexec.c             |  2 +-
 arch/riscv/mm/init.c                          |  4 +++
 6 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/kernel/crash_core.c

-- 
2.17.1

