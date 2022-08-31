Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3095A8577
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiHaS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiHaSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A81BF327A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5D8861CCE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A7C433D6;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=6XP22WTmc8yL/Ak3Vl83+H3N1Eq7ZOAnCRPlATglroc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FU5A3CG2XmPZTVGIDeITHow4YBhkVZku8EyLz8IYtjfCTd1yEakYzRlDQU4nUhml6
         9v5RUwRNGH0AAx3m3CIfq2x7EgyxoUtSKdEFM+tH/E7HQRUICmAp9FKL9yZpfoPm5i
         GMKp7pGL9deirpDTNBmVpV/fWGgZtaP6svuS67bqvpAbaIL2jhy2EeGLAlMWbpFNsw
         P2xUWLvmlC7kq7dbmbjY/OLX5+oAiWuZ+t7zlqTQBD98BqFUbRnzYtRuPQUVO8J4H+
         K/lnTlQcACZvKzMw5EXX1psV++0UUfm96fmHzJ0gUjRXOUVsphGHJYGke7+Iy6y3DC
         KvW8OIx+qFL7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CF0BC5C015D; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        Pranith Kumar <bobby.prani@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 01/18] tools/nolibc: make argc 32-bit in riscv startup code
Date:   Wed, 31 Aug 2022 11:21:29 -0700
Message-Id: <20220831182148.2698489-1-paulmck@kernel.org>
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

The "ld a0, 0(sp)" instruction doesn't build on RISCV32 because that
would load a 64-bit value into a 32-bit register. But argc 32-bit,
not 64, so we ought to use "lw" here. Tested on both RISCV32 and
RISCV64.

Cc: Pranith Kumar <bobby.prani@gmail.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-riscv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 95e2b79249257..ba04771cb3a34 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -190,7 +190,7 @@ __asm__ (".section .text\n"
     ".option norelax\n"
     "lla   gp, __global_pointer$\n"
     ".option pop\n"
-    "ld    a0, 0(sp)\n"          // argc (a0) was in the stack
+    "lw    a0, 0(sp)\n"          // argc (a0) was in the stack
     "add   a1, sp, "SZREG"\n"    // argv (a1) = sp
     "slli  a2, a0, "PTRLOG"\n"   // envp (a2) = SZREG*argc ...
     "add   a2, a2, "SZREG"\n"    //             + SZREG (skip null)
-- 
2.31.1.189.g2e36527f23

