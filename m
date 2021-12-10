Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0463470815
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245128AbhLJSJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245121AbhLJSJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:09:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41DBC061746;
        Fri, 10 Dec 2021 10:05:47 -0800 (PST)
Date:   Fri, 10 Dec 2021 18:05:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639159545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D52i6rffDxAdGwjJno0zBuqr5+c3xe4+2s1Z9pitFv8=;
        b=YyXU1gyNjCwrp+zXmCIVrggmoYjiFfJ2ot1qlbM4TrADgK9HZQvPPAlbw9YRTHpfb7kHAF
        8ZmQp0AVzeBSbsHETptSBh4c1d6xtH5VARg5pcsJMbsbPWYv97AThrqPuQ2RNDGwVFS1I4
        oMLPviiNsLAQrYkEW1G1/R2xgdZfyjsTkbfrqHKeaUjO8VXmv0RsBL6HuPMR601GPXbAJx
        1N7V5cPw4kJCiejd5QiSBrWS7FLlW2JJ3tQ/qW10ORfs9ZAa8iIsYbeUQRnJHZHQoHDNtK
        ca73KbpsGRKgftEVhyuzEqaboIvFQ6fEysqXwisj2HWPMChdIv0gdUIfT3GgsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639159545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D52i6rffDxAdGwjJno0zBuqr5+c3xe4+2s1Z9pitFv8=;
        b=zXA3ir2nX1fa3iEp/GPsvgfSXMYFapiRL/TkdjAFp1EkulRUKOAbul0eyuBY0QgCLYiNwK
        rgP5O2Y6npx0JdBw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/uaccess: Move variable into switch case statement
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209043456.1377875-1-keescook@chromium.org>
References: <20211209043456.1377875-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <163915954424.23020.11562895071789645475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7fde7c0d4b5d125b6e6cbb1b22fabed883c7331e
Gitweb:        https://git.kernel.org/tip/7fde7c0d4b5d125b6e6cbb1b22fabed883c7331e
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Wed, 08 Dec 2021 20:34:56 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 10 Dec 2021 18:04:12 +01:00

x86/uaccess: Move variable into switch case statement

When building with automatic stack variable initialization, GCC 12
complains about variables defined outside of switch case statements.
Move the variable into the case that uses it, which silences the warning:

./arch/x86/include/asm/uaccess.h:317:23: warning: statement will never be executed [-Wswitch-unreachable]
  317 |         unsigned char x_u8__; \
      |                       ^~~~~~

Fixes: 865c50e1d279 ("x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20211209043456.1377875-1-keescook@chromium.org
---
 arch/x86/include/asm/uaccess.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 33a6840..8ab9e79 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -314,11 +314,12 @@ do {									\
 do {									\
 	__chk_user_ptr(ptr);						\
 	switch (size) {							\
-	unsigned char x_u8__;						\
-	case 1:								\
+	case 1:	{							\
+		unsigned char x_u8__;					\
 		__get_user_asm(x_u8__, ptr, "b", "=q", label);		\
 		(x) = x_u8__;						\
 		break;							\
+	}								\
 	case 2:								\
 		__get_user_asm(x, ptr, "w", "=r", label);		\
 		break;							\
