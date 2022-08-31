Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E175A8589
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiHaS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiHaSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EF8F2432
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA3ED61CEF
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1489C433D6;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=CU73QDisjs/PRWOCwR+T0+q/eTYkk9fwbgXWId7CwWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJy2tq89mR9IEZe4QbPiaq4VvQd3El7aXE3ZTo3k1+dysYtdAIum9IC4SxUqBpIqk
         OqXiCDCM4wZPy6cNRhEKBR2pL4odJdqww8giyHt4ujJkEFsyRVDcuGMI231R352BI0
         lJA2XFbROC1NtwEvbOEMaOte2DqxSB69oKAiuuK3R5c4HGAJlMV9NOGLdDcLYHktsQ
         ZSfQ7ZRerfcM0eFUsj8O7zdrOj0FDYnMkAAuG8MM9xoBUgJ6knZpOsYB9oBHi3eSHW
         TPXuZ8PjUKwUBHaJsAP84tofhNHNnwtaicL1ryWD/YLhbbxQYCHnkNnmhVtFPx4Rt5
         tgLBg3NGnr0TQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE91F5C0E4D; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 16/18] selftests/nolibc: "sysroot" target installs a local copy of the sysroot
Date:   Wed, 31 Aug 2022 11:21:46 -0700
Message-Id: <20220831182148.2698489-18-paulmck@kernel.org>
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

It's not convenient to rely on a sysroot built in another directory,
especially when running cross-compilation tests, where one has to
switch back and forth between directories.

Let's make it possible to install the sysroot directly in the test
directory. It's not big and even benefits from being copied by arch
so that it's easier to switch between archs if needed. The new
"sysroot" target does this, it just calls "headers_standalone" from
nolibc to install the sysroot right here.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 7c1f5360f454e..210f5369fdfc4 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -67,9 +67,16 @@ LDFLAGS := -s
 
 all: nolibc-test
 
-nolibc-test: nolibc-test.c
+sysroot: sysroot/$(ARCH)/include
+
+sysroot/$(ARCH)/include:
+	$(QUIET_MKDIR)mkdir -p sysroot
+	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
+	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
+
+nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -static -include ../../../include/nolibc/nolibc.h $^ -lgcc
+	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
 
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
@@ -93,6 +100,8 @@ rerun:
 	$(Q)grep -w FAIL "$(CURDIR)/run.out" && echo "See all results in $(CURDIR)/run.out" || echo "$$(grep -c ^[0-9].*OK $(CURDIR)/run.out) test(s) passed."
 
 clean:
+	$(call QUIET_CLEAN, sysroot)
+	$(Q)rm -rf sysroot
 	$(call QUIET_CLEAN, nolibc-test)
 	$(Q)rm -f nolibc-test
 	$(call QUIET_CLEAN, initramfs)
-- 
2.31.1.189.g2e36527f23

