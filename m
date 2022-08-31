Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1919E5A8585
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiHaS06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiHaSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BC6E9935
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADC8DB8227B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC71FC43470;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=gnygS7VyDQKpNvDpWmORFPhy85HDq/0vqTL/ck01Zvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ah9tKkXq3vOEXguqAwL9NywK4DxyFHwX9Y9isgx/gbekxdaaxT1y8EjoIMBTS9x6O
         tRhG+mq4iFUbSuLrMU7mJWdRPrNLDlHJeSzpigFd1Kx0KHnX7+jR3np3iC23LqlXuw
         S3dbdP/by+W+QlooP/58luBseHeXe/pY0M+XPOUJmrd9NXi8aIKuEDypYfvsHMd/Li
         Z+zoUFUKZVd0UPcaZSWSWsLLkgFCoCasB837RCobOvjoMqj3YCrGsINIL/YbGi/S0a
         ivg+j87Bm9w5gGwq7GE1SI6bSLLvmLOLHB7Dv1higCQNuaP8Xw5qvl6np4jAKnwR/w
         562c1H1plESFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EAEF85C0DE5; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 14/18] selftests/nolibc: add a "defconfig" target
Date:   Wed, 31 Aug 2022 11:21:44 -0700
Message-Id: <20220831182148.2698489-16-paulmck@kernel.org>
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

While most archs will work fine with "make defconfig", not all will
do, and it's not always easy to remember the most suitable choice to
use for a specific architecture.

This adds a "defconfig" target to the Makefile so that one may easily
run "make -C ... defconfig" and make sure to clean and rebuild a fresh
config. This is *not* used by default because we want to preserve the
user's config by default.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 4a2ab0e73ce2e..c104719eae8b8 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -22,6 +22,15 @@ IMAGE_riscv   = arch/riscv/boot/Image
 IMAGE         = $(IMAGE_$(ARCH))
 IMAGE_NAME    = $(notdir $(IMAGE))
 
+# default kernel configurations that appear to be usable
+DEFCONFIG_i386    = defconfig
+DEFCONFIG_x86     = defconfig
+DEFCONFIG_arm64   = defconfig
+DEFCONFIG_arm     = multi_v7_defconfig
+DEFCONFIG_mips    = malta_defconfig
+DEFCONFIG_riscv   = defconfig
+DEFCONFIG         = $(DEFCONFIG_$(ARCH))
+
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
@@ -46,6 +55,9 @@ initramfs: nolibc-test
 	$(call QUIET_INSTALL, initramfs/init)
 	$(Q)cp nolibc-test initramfs/init
 
+defconfig:
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+
 kernel: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
-- 
2.31.1.189.g2e36527f23

