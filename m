Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B04D9964
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347766AbiCOKsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347439AbiCOKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:46:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F8517EB;
        Tue, 15 Mar 2022 03:44:20 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZC3/kc1HTY+XXoQPROWdI9AV7DgxswUrZQiDvHRmSQ=;
        b=wkP6R//JdhXK+fS9vM2rUcstzrQqroC6LZR2GQiK5FMghlmIztCfJaEJrJWFK4VigmrLv9
        glsOHbL2kA9oCafyLbJJ/9sSUTaLQREDZVdL3LrbPeayoHYW1UoIxbYt8vjlRlwtN6G2fX
        9NUduiowRx+KLuS5btXI8bSizZPCM1/h7/jZdRDv0EX06nANCtMdzBSjNpvh0ElqgMiEUw
        bGdzWy7Z3pwPlHOjpsN+8cn3NeDuhVcUbD1ku2Pg/C3CI2NKKtStDWNZOPOGNa1GglcEeS
        j0/E5GCfN337MAMTA2doevGTPpMzcQypPjzkii7w6h4jamPOcNU809m1Sj5Rww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZC3/kc1HTY+XXoQPROWdI9AV7DgxswUrZQiDvHRmSQ=;
        b=cHduqrcOx1GMlJBKhGL49kGdpyGFthsZb1S+ZUnIuaC89/I3LhjuNAF0I3+QPUWwt/pWm7
        7CvQdXlgPwRxjLCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] static_call: Avoid building empty .static_call_sites
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.223798256@infradead.org>
References: <20220308154317.223798256@infradead.org>
MIME-Version: 1.0
Message-ID: <164734105718.16921.7882247983946373837.tip-bot2@tip-bot2>
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

Commit-ID:     b44544fe0298ee2224960a31f795e317029e2a60
Gitweb:        https://git.kernel.org/tip/b44544fe0298ee2224960a31f795e317029e2a60
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:31 +01:00

static_call: Avoid building empty .static_call_sites

Without CONFIG_HAVE_STATIC_CALL_INLINE there's no point in creating
the .static_call_sites section and it's related symbols.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.223798256@infradead.org
---
 include/asm-generic/vmlinux.lds.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 42f3866..a41e623 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -404,6 +404,7 @@
 	KEEP(*(__jump_table))						\
 	__stop___jump_table = .;
 
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 #define STATIC_CALL_DATA						\
 	. = ALIGN(8);							\
 	__start_static_call_sites = .;					\
@@ -412,6 +413,9 @@
 	__start_static_call_tramp_key = .;				\
 	KEEP(*(.static_call_tramp_key))					\
 	__stop_static_call_tramp_key = .;
+#else
+#define STATIC_CALL_DATA
+#endif
 
 /*
  * Allow architectures to handle ro_after_init data on their
