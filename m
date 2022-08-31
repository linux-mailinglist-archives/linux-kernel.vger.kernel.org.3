Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E765A8586
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiHaS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiHaSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF83F2D55
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA9C61CE7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9830BC4314F;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=2xQ5ecRyKfR7ptHCLyMP99aehKiar5JnTBnRAnso19o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+q/JbhAYVX+CsSD2e5YBXtKSE8T/MmpXUOG78n9m2juOQohoMZ3bvWE+le5pPMbq
         xl4DX5AjyCW2YXcg6o8QaWBkoNMKiW7ejLALPrD6bPcnkpBh62aQRYKGqx5KGpwX0q
         5JHqiubOx0U9bUrSVPo2OUxauLWT40HqThmgOS0f365wSZ69ACJM5depZke8jv3z+P
         6GsFFpbJ5hLaQXtWOIyHBgwOisa4YmAacvnxKq0f9f7IwrtLEeiGM5U17NRHu/kbRg
         aqradmgQlJppWarSVjNcTM1cxI4a5Qe8dXxfb66W9QmljOSEBXUbAsC/HNXo6ii6Hy
         uaVSUsSJBLnOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E93815C0DA6; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 13/18] selftests/nolibc: add a "kernel" target to build the kernel with the initramfs
Date:   Wed, 31 Aug 2022 11:21:43 -0700
Message-Id: <20220831182148.2698489-15-paulmck@kernel.org>
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

The "kernel" target rebuilds the kernel with the current config for the
selected arch, with an initramfs containing the nolibc-test utility.

Since image names depend on the architecture, the currently supported
ones are referenced and resolved based on the architecture.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index fd0a670823340..4a2ab0e73ce2e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -12,6 +12,16 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+# kernel image names by architecture
+IMAGE_i386    = arch/x86/boot/bzImage
+IMAGE_x86     = arch/x86/boot/bzImage
+IMAGE_arm64   = arch/arm64/boot/Image
+IMAGE_arm     = arch/arm/boot/zImage
+IMAGE_mips    = vmlinuz
+IMAGE_riscv   = arch/riscv/boot/Image
+IMAGE         = $(IMAGE_$(ARCH))
+IMAGE_NAME    = $(notdir $(IMAGE))
+
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
@@ -36,6 +46,9 @@ initramfs: nolibc-test
 	$(call QUIET_INSTALL, initramfs/init)
 	$(Q)cp nolibc-test initramfs/init
 
+kernel: initramfs
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+
 clean:
 	$(call QUIET_CLEAN, nolibc-test)
 	$(Q)rm -f nolibc-test
-- 
2.31.1.189.g2e36527f23

