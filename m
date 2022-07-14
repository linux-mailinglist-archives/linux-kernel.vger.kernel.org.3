Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA6E574F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbiGNNgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiGNNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:36:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4BC52882;
        Thu, 14 Jul 2022 06:36:49 -0700 (PDT)
Date:   Thu, 14 Jul 2022 13:36:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657805808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bh6wJ/vQveCsuTOTw1wDNrgRDi3COVOkgR8x2VC+BI4=;
        b=VSv0M/3SeyVeSggHW1zD/MRok3Cnn79uxaglDRFGpfNtgOdLhPjnxlEH4NNivzwjuDtE23
        /20g3d2xu7hHrA4fxFdUfhtP7MJLiV+4ArEo2aROEHL3dWawOQjavhWCMsM/h1L1xrKU51
        E1GZlNuX0iqWpSBaWQHoIuDqBlpTfDPlU23kJNKjAiYmdyhYRJNQhwNH142YkayroZHscU
        qyudapXi2g/FWpePKry8V3gfZeOTVLGma5bngJ3OVwt1FClc0GIPnHohhdyI4OVRr0nLTb
        aSCTT+JVM/2JQvAnu5AB4fPtlEJ+15gZCvImtwydEi9J+Pu0rF4Dncoe2dACuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657805808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bh6wJ/vQveCsuTOTw1wDNrgRDi3COVOkgR8x2VC+BI4=;
        b=VE+V0NNs/MgGFTL5MKT0ZMPaNn4ZIXHqbaxFBkXZNi+jXx4oqTGGJ2a4UIImxKgf6LlibK
        saFsjFop2FDStPDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] um: Add missing apply_returns()
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        ")"@tip-bot2.tec.linutronix.de,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Ys%2Ft45l%2FgarIrD0u@worktop.programming.kicks-ass.net>
References: <Ys%2Ft45l%2FgarIrD0u@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165780580734.15455.10164218033628596695.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     564d998106397394b6aad260f219b882b3347e62
Gitweb:        https://git.kernel.org/tip/564d998106397394b6aad260f219b882b3347e62
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 14 Jul 2022 12:20:19 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Jul 2022 13:40:21 +02:00

um: Add missing apply_returns()

Implement apply_returns() stub for UM, just like all the other patching
routines.

Fixes: 15e67227c49a ("x86: Undo return-thunk damage")
Reported-by: Randy Dunlap <rdunlap@infradead.org)
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/Ys%2Ft45l%2FgarIrD0u@worktop.programming.kicks-ass.net
---
 arch/um/kernel/um_arch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0760e24..9838967 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -432,6 +432,10 @@ void apply_retpolines(s32 *start, s32 *end)
 {
 }
 
+void apply_returns(s32 *start, s32 *end)
+{
+}
+
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
