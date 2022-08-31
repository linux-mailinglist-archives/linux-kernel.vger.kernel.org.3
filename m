Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD405A858A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiHaS1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiHaSZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AF6F2433
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B222CB82286
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BA0C43159;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=hXeiDn5SObJ18DT8fc6Pa6a9wr3LC/31YgOsnz8spKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esKn2NT7MHuBE6iHrVUjMw3WR/bsaF9URjFUicPeI2JCHLi+3G/ZPIMYfMhYn8eVo
         aHYRw7eRLWDuAUyWyYu7liE9bG66/54Bv2A7CmsVSYRHaPoyaZFZ0rZ9NEZwGv+crE
         F+hd+eBu4PAjsWSBMIk4mtPlAedhyYpg7YKS1hxVNjQ7guOMYEJN/TwEjE4NbWz6k5
         IyQ7horEW3nH6J8l99xrEBygytnoZf8+DBf3rmTTfU3z9nsUsCNG7Oelfx/NlOufhs
         5g2Gg6aC1NKC94bBwbX2O1moSTUOdA+m2rb2qLnwTpNCaFYhp7wdqOIGfZfabFiWPo
         S0zMUnTb0caPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ECCF15C0DF4; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 15/18] selftests/nolibc: add a "run" target to start the kernel in QEMU
Date:   Wed, 31 Aug 2022 11:21:45 -0700
Message-Id: <20220831182148.2698489-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

The "run" target will build the kernel and start it in QEMU. The
"rerun" target will not have the kernel dependency and will just try
to start QEMU. The QEMU architecture used to start the kernel is
derived from the configured ARCH. This might need to be improved
for archs which include different variants under the same name
(mips vs mipsel, +/-64, riscv32 vs riscv64). This could be tested
for i386, x86, arm, arm64, mips and riscv (the later two reporting
issues on some tests).

It is possible to pass a test specification for nolibc-test in the TEST
variable, which will be passed as-is as NOLIBC_TEST.

On success, the number of successful tests is printed. On failure, failed
lines are individually printed.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index c104719eae8b8..7c1f5360f454e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -31,6 +31,27 @@ DEFCONFIG_mips    = malta_defconfig
 DEFCONFIG_riscv   = defconfig
 DEFCONFIG         = $(DEFCONFIG_$(ARCH))
 
+# optional tests to run (default = all)
+TEST =
+
+# QEMU_ARCH: arch names used by qemu
+QEMU_ARCH_i386    = i386
+QEMU_ARCH_x86     = x86_64
+QEMU_ARCH_arm64   = aarch64
+QEMU_ARCH_arm     = arm
+QEMU_ARCH_mips    = mipsel  # works with malta_defconfig
+QEMU_ARCH_riscv   = riscv64
+QEMU_ARCH         = $(QEMU_ARCH_$(ARCH))
+
+# QEMU_ARGS : some arch-specific args to pass to qemu
+QEMU_ARGS_i386    = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_x86     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_arm64   = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_arm     = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mips    = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv   = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS         = $(QEMU_ARGS_$(ARCH))
+
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
@@ -61,8 +82,20 @@ defconfig:
 kernel: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
+# run the tests after building the kernel
+run: kernel
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)grep -w FAIL "$(CURDIR)/run.out" && echo "See all results in $(CURDIR)/run.out" || echo "$$(grep -c ^[0-9].*OK $(CURDIR)/run.out) test(s) passed."
+
+# re-run the tests from an existing kernel
+rerun:
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)grep -w FAIL "$(CURDIR)/run.out" && echo "See all results in $(CURDIR)/run.out" || echo "$$(grep -c ^[0-9].*OK $(CURDIR)/run.out) test(s) passed."
+
 clean:
 	$(call QUIET_CLEAN, nolibc-test)
 	$(Q)rm -f nolibc-test
 	$(call QUIET_CLEAN, initramfs)
 	$(Q)rm -rf initramfs
+	$(call QUIET_CLEAN, run.out)
+	$(Q)rm -rf run.out
-- 
2.31.1.189.g2e36527f23

