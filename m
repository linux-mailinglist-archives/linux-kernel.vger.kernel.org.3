Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F41506161
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiDSAuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbiDSApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2CE2AE1F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D49B36143F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4CCC341D5;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=hgtXtp6oDk1Z4mAAuthMNuVpmsGa0EQ5/tDSm1m1OLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9GbkojD5TGG1Rz2fcRovMaEQtrYY6dPf61m5dYvkRDtiMRFY95n/0dr6HT84ysRC
         BnVLtQ/GeRWwyPStzg7GIa1SSgTZo1emgNer2Dk8kKJlvdp4Cxa/K2nQfxBgOnHT/F
         JOr3qIYD8rL1/pHDQOJ1hHQ3GPpmvhN59Bi+51tFUCcAcDtrSUMPDMzTE9pioK8zZG
         kZ3cQKe53+tEdtK+sfqOe+0QdCSYVKOue4xD9tJ475Fxi5LUT/SI4THRD3ru++y2yD
         u02JTZrxoA6ZMSZLtqOYokmOm5n5THEz7ud8sg4+/6JY92ynZvydxtW88c3bU2yGFr
         cbOQCo9HY1eEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6E7AB5C04C6; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, x86@kernel.org,
        llvm@lists.linux.dev, David Laight <David.Laight@ACULAB.COM>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 56/61] tools/nolibc: i386: Implement syscall with 6 arguments
Date:   Mon, 18 Apr 2022 17:42:20 -0700
Message-Id: <20220419004225.3952530-56-paulmck@kernel.org>
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

On i386, the 6th argument of syscall goes in %ebp. However, both Clang
and GCC cannot use %ebp in the clobber list and in the "r" constraint
without using -fomit-frame-pointer. To make it always available for
any kind of compilation, the below workaround is implemented.

  1) Push the 6-th argument.
  2) Push %ebp.
  3) Load the 6-th argument from 4(%esp) to %ebp.
  4) Do the syscall (int $0x80).
  5) Pop %ebp (restore the old value of %ebp).
  6) Add %esp by 4 (undo the stack pointer).

Cc: x86@kernel.org
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/lkml/2e335ac54db44f1d8496583d97f9dab0@AcuMS.aculab.com
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-i386.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 10aada40680d..d7e7212346e2 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -167,6 +167,29 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)	\
+({								\
+	long _eax  = (long)(num);				\
+	long _arg6 = (long)(arg6); /* Always in memory */	\
+	__asm__ volatile (					\
+		"pushl	%[_arg6]\n\t"				\
+		"pushl	%%ebp\n\t"				\
+		"movl	4(%%esp),%%ebp\n\t"			\
+		"int	$0x80\n\t"				\
+		"popl	%%ebp\n\t"				\
+		"addl	$4,%%esp\n\t"				\
+		: "+a"(_eax)		/* %eax */		\
+		: "b"(arg1),		/* %ebx */		\
+		  "c"(arg2),		/* %ecx */		\
+		  "d"(arg3),		/* %edx */		\
+		  "S"(arg4),		/* %esi */		\
+		  "D"(arg5),		/* %edi */		\
+		  [_arg6]"m"(_arg6)	/* memory */		\
+		: "memory", "cc"				\
+	);							\
+	_eax;							\
+})
+
 /* startup code */
 /*
  * i386 System V ABI mandates:
-- 
2.31.1.189.g2e36527f23

