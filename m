Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E44F329C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354268AbiDEKMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7FE167E1;
        Tue,  5 Apr 2022 01:29:00 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:28:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nurDYK5C/TNfM+pI70QrFow1rWlcdmAbhl+BhuPbTI=;
        b=JDaO9YIdkp3LiZ5vkIvWLxakI39d/y9fwKX0B27LuDQ5TGcT7TgsEEsi3zQrTKqXSOvy1Z
        pYU3Vj0OddWHot2+cVznVTza4LW+KxxnKGXTnddRUb5F/m93Mole7PveIWXkn2CVe4HB+u
        bwDdvEKgPbewgnJtBZ306EfjSWAorJhT0MDWyUeN3rH5rSCy1UbQkJ7QkGmIomopUApnQe
        slPzpGQPPO3BEZ0re9vWZAgYOXjPimuagueK5u+sq5euBXfmAo0tjtN5mR1FAWyRAI8d3i
        QlpC4gZkcfs9w2qhdy4dj15wsEq/053nEBS5x7ifAhKAow4uLQCyyt6esLb6+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nurDYK5C/TNfM+pI70QrFow1rWlcdmAbhl+BhuPbTI=;
        b=llOd6f0j5yhcZVRBpl9KFo5wl1oVT7Hxw8jKqCXRg3B3GqSejtp2rphg71XgjklAfCMOjB
        2ezDILUwnyYgrrCQ==
From:   "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Remove __DEFINE_STATIC_CALL macro
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C329074f92d96e3220ebe15da7bbe2779beee31eb=2E16472?=
 =?utf-8?q?53456=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
References: =?utf-8?q?=3C329074f92d96e3220ebe15da7bbe2779beee31eb=2E164725?=
 =?utf-8?q?3456=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
MIME-Version: 1.0
Message-ID: <164914733763.389.2781184707273888130.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     df21c0d7a94db64a4e1a0d070e26fb02e60fefab
Gitweb:        https://git.kernel.org/tip/df21c0d7a94db64a4e1a0d070e26fb02e60fefab
Author:        Christophe Leroy <christophe.leroy@csgroup.eu>
AuthorDate:    Mon, 14 Mar 2022 11:27:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:38 +02:00

static_call: Remove __DEFINE_STATIC_CALL macro

Only DEFINE_STATIC_CALL use __DEFINE_STATIC_CALL macro now when
CONFIG_HAVE_STATIC_CALL is selected.

Only keep __DEFINE_STATIC_CALL() for the generic fallback, and
also use it to implement DEFINE_STATIC_CALL_NULL() in that case.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/329074f92d96e3220ebe15da7bbe2779beee31eb.1647253456.git.christophe.leroy@csgroup.eu
---
 include/linux/static_call.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3c50b0f..df53bed 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -180,13 +180,13 @@ extern int static_call_text_reserved(void *start, void *end);
 
 extern long __static_call_return0(void);
 
-#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
+#define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func_init,					\
+		.func = _func,						\
 		.type = 1,						\
 	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func_init)
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
@@ -225,12 +225,12 @@ extern long __static_call_return0(void);
 
 static inline int static_call_init(void) { return 0; }
 
-#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
+#define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func_init,					\
+		.func = _func,						\
 	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func_init)
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
@@ -292,11 +292,11 @@ static inline long __static_call_return0(void)
 		.func = _func_init,					\
 	}
 
+#define DEFINE_STATIC_CALL(name, _func)					\
+	__DEFINE_STATIC_CALL(name, _func, _func)
+
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
-	DECLARE_STATIC_CALL(name, _func);				\
-	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = NULL,						\
-	}
+	__DEFINE_STATIC_CALL(name, _func, NULL)
 
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
 	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
@@ -341,7 +341,4 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-#define DEFINE_STATIC_CALL(name, _func)					\
-	__DEFINE_STATIC_CALL(name, _func, _func)
-
 #endif /* _LINUX_STATIC_CALL_H */
