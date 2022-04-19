Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157CE50615F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbiDSAtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiDSApT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6742AE23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE4B61449
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F699C341D8;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=fnzmowWPyVpYvNDdxtz21Tjcvak4c1q1WQbcre2NwSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTkdW1I1oXG5x54JnwnRgMNIj9v1IrjLxQwl2q1V9Junaiy7ukjFJXzBbuJAZ9YTi
         EMofyyjq0ZW1Kf305yfPuxufVNeOH2YiivYwG0eeuCz2tPqJnOQ24tx5IffhGS7Xvd
         lONS1eCfRPH/UD+us0LDYTD51nkTFDx4svrd0MRjnk9RiPaiLhZ9UYbOVxZsrcm8W7
         f80wKqspbz5yNXmA4H9IdH97yoF71ahAx5ZqIakg4f36dJGbribBaQ+JvbKD2YJACt
         fBIPt7WCXU55OKKO1Wuvj78j+aTf5xsYGxgkB5fFbclKOdVw5bmGa+aoSp34tvv0wi
         BjqyHK+76Kx0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6CA605C3240; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 55/61] tools/nolibc: Remove .global _start from the entry point code
Date:   Mon, 18 Apr 2022 17:42:19 -0700
Message-Id: <20220419004225.3952530-55-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

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
Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

