Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33B150611E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiDSAsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521272DA88
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B332C6143D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48117C340EC;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=zlEwoSJGl9lOz3BHLKNNT2oKRiWb3/1DVwxpQdPd5eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lsm0TZoJ5KRjHZvlQKIGxubXi5wJfHK+bKx12mFT+DmaJ6rC+GDRo+NWkMIgskdmx
         87TxD5baUCK6kE5IDbxo/m8h0itxcKgYdh53Ov2R46hU+rTQRMmQnU5/9lCRSwfGzi
         abCTjT3XweZMnVZ6VvIQqIEVYMJ0vw8OxVJ8/Rqqr+LC8BCM2fNXZDwgOe8/b+AmJp
         sahEp2nzhsdzNidr6Uw3J3DeM6JgjjvCUIoKBQuVrUO2Ue281Sab+WEAN6t9qm9t+q
         kw06Ehttuz1kliSCJFyDwpb9AnWpfkNOehDIdylf73Qsv9ptQvR44rELKDXY0M3hs/
         C5dl0WEMuZeWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4327F5C3112; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 33/61] tools/nolibc/arch: mark the _start symbol as weak
Date:   Mon, 18 Apr 2022 17:41:57 -0700
Message-Id: <20220419004225.3952530-33-paulmck@kernel.org>
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

From: Willy Tarreau <w@1wt.eu>

By doing so we can link together multiple C files that have been compiled
with nolibc and which each have a _start symbol.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

