Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8364AC644
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382314AbiBGQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390609AbiBGQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:14 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DA84C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:13 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOfFi014417;
        Mon, 7 Feb 2022 17:24:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 33/42] tools/nolibc/arch: mark the _start symbol as weak
Date:   Mon,  7 Feb 2022 17:23:45 +0100
Message-Id: <20220207162354.14293-34-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By doing so we can link together multiple C files that have been compiled
with nolibc and which each have a _start symbol.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-aarch64.h | 1 +
 tools/include/nolibc/arch-arm.h     | 1 +
 tools/include/nolibc/arch-i386.h    | 1 +
 tools/include/nolibc/arch-mips.h    | 1 +
 tools/include/nolibc/arch-riscv.h   | 1 +
 tools/include/nolibc/arch-x86_64.h  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 443de5fb7f54..87d9e434820c 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -183,6 +183,7 @@ struct sys_stat_struct {
 
 /* startup code */
 asm(".section .text\n"
+    ".weak _start\n"
     ".global _start\n"
     "_start:\n"
     "ldr x0, [sp]\n"              // argc (x0) was in the stack
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 66f687ad987f..001a3c8c9ad5 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -176,6 +176,7 @@ struct sys_stat_struct {
 
 /* startup code */
 asm(".section .text\n"
+    ".weak _start\n"
     ".global _start\n"
     "_start:\n"
 #if defined(__THUMBEB__) || defined(__THUMBEL__)
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 32f42e2cee26..d7e4d53325a3 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -175,6 +175,7 @@ struct sys_stat_struct {
  *
  */
 asm(".section .text\n"
+    ".weak _start\n"
     ".global _start\n"
     "_start:\n"
     "pop %eax\n"                // argc   (first arg, %eax)
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index e330201dde6a..c9a6aac87c6d 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -190,6 +190,7 @@ struct sys_stat_struct {
 
 /* startup code, note that it's called __start on MIPS */
 asm(".section .text\n"
+    ".weak __start\n"
     ".set nomips16\n"
     ".global __start\n"
     ".set    noreorder\n"
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 9d5ff78f606b..bc10b7b5706d 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -184,6 +184,7 @@ struct sys_stat_struct {
 
 /* startup code */
 asm(".section .text\n"
+    ".weak _start\n"
     ".global _start\n"
     "_start:\n"
     ".option push\n"
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 83c4b458ada7..fe517c16cd4d 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -198,6 +198,7 @@ struct sys_stat_struct {
  *
  */
 asm(".section .text\n"
+    ".weak _start\n"
     ".global _start\n"
     "_start:\n"
     "pop %rdi\n"                // argc   (first arg, %rdi)
-- 
2.35.1

