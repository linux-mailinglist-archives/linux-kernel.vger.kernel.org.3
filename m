Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030504BA8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiBQS4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:56:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbiBQS4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:56:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E839E5F88;
        Thu, 17 Feb 2022 10:56:27 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXjrItAfdtEMlY/0qGw5BYxOY8OMhR7/U55oHzy6wDU=;
        b=zaAFhhSty3f9PLr92+XMqMRqOVVa0ryc24oMGhSQA7FSMVfj7V7t9XMmraWiiqbCdZEfrm
        lvQPO530piKnuUqWFGWDIr39sqIFamRa8bzQk++XJ2JA6hL39iSRQKoWU+cWoAYWlzivgZ
        pt5dFCAsyphUpFSpDJq/qJAmLkOPtL3KvN2Kp05X/Z8EZmT5sZ4ipQa+JnJ40wtIHK5sAF
        l4D+FAAwY4FITdMHMU19K7jrysC8hiPzeBlsPNf+DyWzDKNfjnAblCmLQy8Kq78QMU19u1
        ILjl1YdlJD2EHAVAaex/D+aBg+avWS0CECGld7YW+jd0oT51VI6D7qveM2vySA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXjrItAfdtEMlY/0qGw5BYxOY8OMhR7/U55oHzy6wDU=;
        b=CtOE7ZjsnixJR0cwroa9qB0xIaQNfdqtYYVRh1sTE3gszUTum3OzAtMLiH0OZ//sdYQ12b
        gONcwNITUj5RwvCA==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: Refactor #ifdef of struct static_key
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220213165717.2354046-2-masahiroy@kernel.org>
References: <20220213165717.2354046-2-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <164512418374.16921.7962295675716313147.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cd27ccfc727e99352321c0c75012ab9c5a90321e
Gitweb:        https://git.kernel.org/tip/cd27ccfc727e99352321c0c75012ab9c5a90321e
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 14 Feb 2022 01:57:17 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:58 +01:00

jump_label: Refactor #ifdef of struct static_key

Move #ifdef CONFIG_JUMP_LABEL inside the struct static_key.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220213165717.2354046-2-masahiroy@kernel.org
---
 include/linux/jump_label.h |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 6924e68..107751c 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -82,10 +82,9 @@ extern bool static_key_initialized;
 				    "%s(): static key '%pS' used before call to jump_label_init()", \
 				    __func__, (key))
 
-#ifdef CONFIG_JUMP_LABEL
-
 struct static_key {
 	atomic_t enabled;
+#ifdef CONFIG_JUMP_LABEL
 /*
  * Note:
  *   To make anonymous unions work with old compilers, the static
@@ -104,13 +103,9 @@ struct static_key {
 		struct jump_entry *entries;
 		struct static_key_mod *next;
 	};
+#endif	/* CONFIG_JUMP_LABEL */
 };
 
-#else
-struct static_key {
-	atomic_t enabled;
-};
-#endif	/* CONFIG_JUMP_LABEL */
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_JUMP_LABEL
