Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C901D470862
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbhLJSWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhLJSWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:22:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA6C061746;
        Fri, 10 Dec 2021 10:18:45 -0800 (PST)
Date:   Fri, 10 Dec 2021 18:18:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639160324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YaA9jnF2hPDn7Hnp5Kf1EWTnCxGCV5pgQLkzb4gRsw=;
        b=EoDbGWkH7l+VxiIDJLQYHle6J7kuRYwxcWgQdHEhr0Vgl4Kt6sj/M2MB5zjGnefezNnnm8
        3GUXCwAyWwfhKFt9kJyhP/3SH/hQXejYrL0B1QBHN39ysZAFchdtaVP34hRv/2qKzeS/kV
        P9HRjeKIixi/f3o1ivJWssNy3SQ9TusbgLktdaQ0CKFIkrnNrC+AvL4Oc6VRrFIieo7pyS
        hlErDp+CPgzWZUKKyWr483QJq28Yzd95AZVjabKyV2vjCWYAtt0I2EneqgAguViXKP5bs5
        p0cceQF7nnfxypta951jCf8CSWILDmkRoRkI6PsVq0clTOK+G8Dxzaelru9QPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639160324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YaA9jnF2hPDn7Hnp5Kf1EWTnCxGCV5pgQLkzb4gRsw=;
        b=oAktX1m8f7AceH3OYIgjk+Lo0veCDtFw7DJ4OFnlj2NObstg3oTQdcGdfw1BmxVb550egP
        neWLrFqs9NFoK3Dg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/uaccess: Move variable into switch case statement
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209043456.1377875-1-keescook@chromium.org>
References: <20211209043456.1377875-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <163916032315.23020.145458656435254901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     61646ca83d3889696f2772edaff122dd96a2935e
Gitweb:        https://git.kernel.org/tip/61646ca83d3889696f2772edaff122dd96a2935e
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Wed, 08 Dec 2021 20:34:56 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 10 Dec 2021 19:13:00 +01:00

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
Signed-off-by: Borislav Petkov <bp@suse.de>
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
