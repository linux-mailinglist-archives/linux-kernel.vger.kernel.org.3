Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1784D9988
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348074AbiCOKsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347377AbiCOKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB750B30;
        Tue, 15 Mar 2022 03:44:09 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0pOWw7heRpRI/kSd9EKxuZgoKqeUnufCahUcADVFbo=;
        b=ndZD3hRxxsHanK1/zUVDftrhgzdFWuQssZzTCZU0tOd6YBYHOgBKnsb2f0oy0YnCTk4tCH
        VI2s8ONBt/HUziZgh4lt+EO+KI/fATXWRohebeCCR8tP+aZ2qkMASbzneULUltKLCvDjZc
        HhSFL+fOYziINuWe53O0ELR7OwC+QW+BL3PVxkgtVEF2n+eW51N+FfUrYcIE/BsPerGJ43
        nGLXQmJ6NrYhgNZ8C6EWBuQ+83v/+0MNiZq3imbnlNZOoktJ9GT4YHH0TUKbMOxzurnGvN
        Ov0dwSfd/mJQSU1c0QFl892dLmS+jGVp6bqZQa0O7YlwZjTMkGnJm79hJraSlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0pOWw7heRpRI/kSd9EKxuZgoKqeUnufCahUcADVFbo=;
        b=Q8sYuV1Bubj0FTp5de6hswC5iUIMhAdIoO0P6wMb/wFHid0Z0WOcsl4O81MU0vyglJrPsi
        dK1wMzOm9FiFJ0Dw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/linkage: Add ENDBR to SYM_FUNC_START*()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.992708941@infradead.org>
References: <20220308154317.992708941@infradead.org>
MIME-Version: 1.0
Message-ID: <164734104652.16921.7577550936306823098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c4691712b546b93707a408368e3c57ae870a2dc4
Gitweb:        https://git.kernel.org/tip/c4691712b546b93707a408368e3c57ae870a2dc4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:36 +01:00

x86/linkage: Add ENDBR to SYM_FUNC_START*()

Ensure the ASM functions have ENDBR on for IBT builds, this follows
the ARM64 example. Unlike ARM64, we'll likely end up overwriting them
with poison.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.992708941@infradead.org
---
 arch/x86/include/asm/linkage.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 0309079..85865f1 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_LINKAGE_H
 
 #include <linux/stringify.h>
+#include <asm/ibt.h>
 
 #undef notrace
 #define notrace __attribute__((no_instrument_function))
@@ -34,5 +35,35 @@
 
 #endif /* __ASSEMBLY__ */
 
+/* SYM_FUNC_START -- use for global functions */
+#define SYM_FUNC_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	ENDBR
+
+/* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
+#define SYM_FUNC_START_NOALIGN(name)			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
+	ENDBR
+
+/* SYM_FUNC_START_LOCAL -- use for local functions */
+#define SYM_FUNC_START_LOCAL(name)			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
+	ENDBR
+
+/* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
+#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
+	ENDBR
+
+/* SYM_FUNC_START_WEAK -- use for weak functions */
+#define SYM_FUNC_START_WEAK(name)			\
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
+	ENDBR
+
+/* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
+#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
+	ENDBR
+
 #endif /* _ASM_X86_LINKAGE_H */
 
