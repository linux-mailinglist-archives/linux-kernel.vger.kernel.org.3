Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CFF4EAB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiC2KTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiC2KTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:19:40 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDB323F380
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:17:57 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id 0B6817E732;
        Tue, 29 Mar 2022 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549076;
        bh=+Y1H++Cm4dLdDCCVAJkzYBwn8t5y6DjxZNCzIJywHNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESPsCv9RkCAopVivFlHhPa+6kkDoCW4kGs7/lGKz5Td1K1oDFvvsRSH53apN9Z0DD
         Jsh0Y3pwyFGMk2sg0nfime+ReU/u1mKfp386Ql30k1lopMbHWowP6darrnIcps5VjW
         vrQuMhVC5+rJdXv1CDTEj21FVdl//wccJA/4qBZbQhWKhghG2ksmRrrEokS5Fd05gK
         dn9dVgI6WqZcUyVxoNSdH9YA4UVAbygEmuR7Q9/exf+n0cMqV/tHLvCkhz3TSWYrsk
         dKmqx6I//1KgK5aTon+riBHLmMlzurBIfiiEKk4VUKuo6Nq75ziouCrFbbp4NzVuPZ
         JtPOdOR06MeEw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 3/9] tools/nolibc: Remove .global _start from the entry point code
Date:   Tue, 29 Mar 2022 17:17:31 +0700
Message-Id: <20220329101737.58985-4-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
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

Building with clang yields the following error:
```
  <inline asm>:3:1: error: _start changed binding to STB_GLOBAL
  .global _start
  ^
  1 error generated.
```
Make sure only specify one between `.global _start` and `.weak _start`.
Remove `.global _start`.

Cc: llvm@lists.linux.dev
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
===

@@ Changelog:

   Link v1: https://lore.gnuweeb.org/gwml/20220324073039.140946-3-ammarfaizi2@gnuweeb.org
   v1 -> v2:
    - Switch the order with the patch that replaces `asm` with `__asm__`.

   Link RFC v2: https://lore.kernel.org/llvm/20220322102115.186179-3-ammarfaizi2@gnuweeb.org
   RFC v2 -> v1:
    - Append Reviewed-by tag from Nick.
    - s/Removing/remove/

   Link RFC v1: https://lore.kernel.org/llvm/20220320093750.159991-3-ammarfaizi2@gnuweeb.org
   RFC v1 -> RFC v2:
    - Remove all `.global _start` for all build (GCC and Clang) instead of
      removing all `.weak _start` for clang build (Comment from Willy).
---
 tools/include/nolibc/arch-aarch64.h | 1 -
 tools/include/nolibc/arch-arm.h     | 1 -
 tools/include/nolibc/arch-i386.h    | 1 -
 tools/include/nolibc/arch-mips.h    | 1 -
 tools/include/nolibc/arch-riscv.h   | 1 -
 tools/include/nolibc/arch-x86_64.h  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index b68443f63980..f68baf8f395f 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -184,7 +184,6 @@ struct sys_stat_struct {
 /* startup code */
 __asm__ (".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
     "ldr x0, [sp]\n"              // argc (x0) was in the stack
     "add x1, sp, 8\n"             // argv (x1) = sp
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 55fd9439b2e2..f31be8e967d6 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -177,7 +177,6 @@ struct sys_stat_struct {
 /* startup code */
 __asm__ (".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
 #if defined(__THUMBEB__) || defined(__THUMBEL__)
     /* We enter here in 32-bit mode but if some previous functions were in
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 136d5739e456..10aada40680d 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -176,7 +176,6 @@ struct sys_stat_struct {
  */
 __asm__ (".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
     "pop %eax\n"                // argc   (first arg, %eax)
     "mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index cd587e539d7d..5fc5b8029bff 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -192,7 +192,6 @@ struct sys_stat_struct {
 __asm__ (".section .text\n"
     ".weak __start\n"
     ".set nomips16\n"
-    ".global __start\n"
     ".set    noreorder\n"
     ".option pic0\n"
     ".ent __start\n"
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 8ec4c05fa69b..95e2b7924925 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -185,7 +185,6 @@ struct sys_stat_struct {
 /* startup code */
 __asm__ (".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
     ".option push\n"
     ".option norelax\n"
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 490530429ac9..0e1e9eb8545d 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -199,7 +199,6 @@ struct sys_stat_struct {
  */
 __asm__ (".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
     "pop %rdi\n"                // argc   (first arg, %rdi)
     "mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
-- 
Ammar Faizi

