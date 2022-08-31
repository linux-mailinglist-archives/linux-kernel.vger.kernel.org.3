Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CA5A8587
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiHaS1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiHaSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C7BEE68C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C52F261CEE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BF3C4315A;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=hpw3dacwnLzPWl5y8Cq3vm7W0XF8HCMlGL9rQUzjRhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwG15xQ84Pqok3dWN53SvRS0c71ccK6xdN94X/s2EA9txx3fA5/W7v7pN8PJH3aAp
         1jqCLk313zaNhCtJ5i5jUc4jB6AyWc51fLis87H4MplTHfBYxUrOqx5UQN3IfRfBBa
         2yzxgPHU4oLYatGUzpsQ9HYmeItCN/Q327hjKX2ZlgNLHYjSlVFLmkn0grHGc8Vhdh
         vIWB5TGlrPLOrEw98BxzKHcyBZrt3jvPigYqYgCcG8lhUCspnmZJERmvBCeUYLc8n2
         4/PSAhnzqe3Bh3+BWBRjIqS4NvXD/YXEzyA7gNJn+GOaO0MHAcDF+2Pwd7JRtOokIU
         BLfpC2Bs7+8mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F046B5C0E68; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 17/18] selftests/nolibc: add a "help" target
Date:   Wed, 31 Aug 2022 11:21:47 -0700
Message-Id: <20220831182148.2698489-19-paulmck@kernel.org>
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

It presents the supported targets, and becomes the default target to
save the user from having to read the makefile. The "all" target was
placed after it and now points to "run" to do everything since it's
no longer the default one.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 27 ++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 210f5369fdfc4..69ea659caca98 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -65,7 +65,32 @@ endif
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables
 LDFLAGS := -s
 
-all: nolibc-test
+help:
+	@echo "Supported targets under selftests/nolibc:"
+	@echo "  all          call the \"run\" target below"
+	@echo "  help         this help"
+	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
+	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
+	@echo "  initramfs    prepare the initramfs with nolibc-test"
+	@echo "  defconfig    create a fresh new default config (uses \$$ARCH)"
+	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$ARCH)"
+	@echo "  run          runs the kernel in QEMU after building it (uses \$$ARCH, \$$TEST)"
+	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$ARCH, \$$TEST)"
+	@echo "  clean        clean the sysroot, initramfs, build and output files"
+	@echo ""
+	@echo "The output file is \"run.out\". Test ranges may be passed using \$$TEST."
+	@echo ""
+	@echo "Currently using the following variables:"
+	@echo "  ARCH          = $(ARCH)"
+	@echo "  CROSS_COMPILE = $(CROSS_COMPILE)"
+	@echo "  CC            = $(CC)"
+	@echo "  OUTPUT        = $(OUTPUT)"
+	@echo "  TEST          = $(TEST)"
+	@echo "  QEMU_ARCH     = $(if $(QEMU_ARCH),$(QEMU_ARCH),UNKNOWN_ARCH) [determined from \$$ARCH]"
+	@echo "  IMAGE_NAME    = $(if $(IMAGE_NAME),$(IMAGE_NAME),UNKNOWN_ARCH) [determined from \$$ARCH]"
+	@echo ""
+
+all: run
 
 sysroot: sysroot/$(ARCH)/include
 
-- 
2.31.1.189.g2e36527f23

