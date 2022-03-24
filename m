Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2A4E5F70
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348601AbiCXHca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348592AbiCXHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:32:28 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2889968C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:30:57 -0700 (PDT)
Received: from integral2.. (unknown [182.2.71.236])
        by gnuweeb.org (Postfix) with ESMTPSA id 188617E34D;
        Thu, 24 Mar 2022 07:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648107056;
        bh=a+O1drB15t84OmkUYg4z9+zSx3IJSCUKgljXpPaqSZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bulhIg/uFYat7Try1jIFooNAj4bXgrRqhNagzDCKi4HF6fPG2hIHzt7noGWV2XGkJ
         9ZS8NIYLfvLQnv6ReDZjC7iX8qCYQAaq5fGRoTCC085kIaeXF5ppd4Bq1c+siNHx0o
         rzLHilzy6OdVyjAbJpCSoqnaYYi5ZXUZzON9Shm+FACVEdVED2cQEIHxCt0fG4ueaT
         kNpuV3FX83Czf3TwWsIysqqdERoTPB7Bi8Hi6DLOzA2XA9WNXj45/gK8PNTG5liKw4
         8u2K7s92+sZuxd9a0p19dlMx0eOvMyu23TRiSDxMLRFJtVQ3m2KfXOn9Jr/2VUlbnJ
         IfK7+xka9E6yQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v1 02/11] tools/nolibc: Remove .global _start from the entry point code
Date:   Thu, 24 Mar 2022 14:30:30 +0700
Message-Id: <20220324073039.140946-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
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
---

@@ Changelog:

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
index 87d9e434820c..2dbd80d633cb 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -184,7 +184,6 @@ struct sys_stat_struct {
 /* startup code */
 asm(".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
     "ldr x0, [sp]\n"              // argc (x0) was in the stack
     "add x1, sp, 8\n"             // argv (x1) = sp
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 001a3c8c9ad5..1191395b5acd 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -177,7 +177,6 @@ struct sys_stat_struct {
 /* startup code */
 asm(".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
 #if defined(__THUMBEB__) || defined(__THUMBEL__)
     /* We enter here in 32-bit mode but if some previous functions were in
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index d7e4d53325a3..125a691fc631 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -176,7 +176,6 @@ struct sys_stat_struct {
  */
 asm(".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
     "pop %eax\n"                // argc   (first arg, %eax)
     "mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index c9a6aac87c6d..1a124790c99f 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -192,7 +192,6 @@ struct sys_stat_struct {
 asm(".section .text\n"
     ".weak __start\n"
     ".set nomips16\n"
-    ".global __start\n"
     ".set    noreorder\n"
     ".option pic0\n"
     ".ent __start\n"
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index bc10b7b5706d..511d67fc534e 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -185,7 +185,6 @@ struct sys_stat_struct {
 /* startup code */
 asm(".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
     ".option push\n"
     ".option norelax\n"
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index a7b70ea51b68..84c174181425 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -199,7 +199,6 @@ struct sys_stat_struct {
  */
 asm(".section .text\n"
     ".weak _start\n"
-    ".global _start\n"
     "_start:\n"
     "pop %rdi\n"                // argc   (first arg, %rdi)
     "mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
-- 
Ammar Faizi

