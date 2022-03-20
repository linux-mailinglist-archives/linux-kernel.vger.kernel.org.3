Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438554E1AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbiCTJkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243310AbiCTJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 05:40:13 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724111A20
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 02:38:51 -0700 (PDT)
Received: from integral2.. (unknown [182.2.42.189])
        by gnuweeb.org (Postfix) with ESMTPSA id 1E4AA7E32F;
        Sun, 20 Mar 2022 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647769130;
        bh=BXzzI1AHGnhVngox7MmLibr5gzV+RXSwMy3QZ9xcVDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTXPJDYF2yyWTk2sjoZoOISwOfNp+Dtv5i7SIky2i2yas1T444ZvVGGLkVk3EzOjH
         4/bKKvJ7R4O2R1VLa7LAQgbBO5tSF8Ug2oVkaZt+2MqqM7GpVY6naWZtmcOFVompyt
         MbWyGY7ctisWzmb1UjtNLGPVBsS4h7WuiDP1S7M1Uu8Ae8LTnHkEWbaVTbMWLBnixW
         V2rjfsLBzG7wqKElpn5ykqst5hc47ubw9NVJqDleB9MGj8OzzhHkr5edJDxYBRPePR
         nWZ1jZk3dkoPWz855mUHE/nQshvZqjGbDAWflvxgXx4spVeHXXVCDSOgkXBnogArYw
         ObuL9eGCYEaSg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, llvm@lists.linux.dev
Subject: [RFC PATCH v1 2/6] tools/nolibc: Make the entry point not weak for clang
Date:   Sun, 20 Mar 2022 16:37:46 +0700
Message-Id: <20220320093750.159991-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Budilig with clang yields the following error:
```
  <inline asm>:3:1: error: _start changed binding to STB_GLOBAL
  .global _start
  ^
  1 error generated.
```
Don't make the entry point weak if we're compiling with clang.

Cc: llvm@lists.linux.dev
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-aarch64.h | 2 ++
 tools/include/nolibc/arch-arm.h     | 2 ++
 tools/include/nolibc/arch-i386.h    | 2 ++
 tools/include/nolibc/arch-mips.h    | 2 ++
 tools/include/nolibc/arch-riscv.h   | 2 ++
 tools/include/nolibc/arch-x86_64.h  | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 87d9e434820c..5084cd58b429 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -183,7 +183,9 @@ struct sys_stat_struct {
 
 /* startup code */
 asm(".section .text\n"
+#if !defined(__clang__)
     ".weak _start\n"
+#endif
     ".global _start\n"
     "_start:\n"
     "ldr x0, [sp]\n"              // argc (x0) was in the stack
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 001a3c8c9ad5..b3f135a615a6 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -176,7 +176,9 @@ struct sys_stat_struct {
 
 /* startup code */
 asm(".section .text\n"
+#if !defined(__clang__)
     ".weak _start\n"
+#endif
     ".global _start\n"
     "_start:\n"
 #if defined(__THUMBEB__) || defined(__THUMBEL__)
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index d7e4d53325a3..82bf797849ae 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -175,7 +175,9 @@ struct sys_stat_struct {
  *
  */
 asm(".section .text\n"
+#if !defined(__clang__)
     ".weak _start\n"
+#endif
     ".global _start\n"
     "_start:\n"
     "pop %eax\n"                // argc   (first arg, %eax)
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index c9a6aac87c6d..719d3808614d 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -190,7 +190,9 @@ struct sys_stat_struct {
 
 /* startup code, note that it's called __start on MIPS */
 asm(".section .text\n"
+#if !defined(__clang__)
     ".weak __start\n"
+#endif
     ".set nomips16\n"
     ".global __start\n"
     ".set    noreorder\n"
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index bc10b7b5706d..a9704affd7de 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -184,7 +184,9 @@ struct sys_stat_struct {
 
 /* startup code */
 asm(".section .text\n"
+#if !defined(__clang__)
     ".weak _start\n"
+#endif
     ".global _start\n"
     "_start:\n"
     ".option push\n"
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index a7b70ea51b68..f453f1a05a48 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -198,7 +198,9 @@ struct sys_stat_struct {
  *
  */
 asm(".section .text\n"
+#if !defined(__clang__)
     ".weak _start\n"
+#endif
     ".global _start\n"
     "_start:\n"
     "pop %rdi\n"                // argc   (first arg, %rdi)
-- 
Ammar Faizi

