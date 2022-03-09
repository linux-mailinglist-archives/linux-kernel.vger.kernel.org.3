Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1E4D2A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiCIH6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiCIH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA2B1662ED;
        Tue,  8 Mar 2022 23:55:13 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812512;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoNhBeMj6djwwHh2Lg+aGVN+NobF+DUPxFJhJfDKEo8=;
        b=27FTnWoBEnC5pVGL9GFuvJ5qYQYuuyxLa6QhxmXRgtOvRAITjadFDDEF2m7x5aOGpPqzwi
        1YPJfL90NphRjxS/1iRhwpESkCUiaiOWwtokcCr9TZKgr5x8g87jbwl2ngLvTf7HIVuFgP
        lbJHpx0a4JQe+Qjsapsw+uEVcc0ZbxUNrwOoKiMvjV1TSxItTBl9pEx0S7x3uKVDXlSqxB
        vi96O6qQ0aN4pMfDZgE2ezx5mE61qthlCs51M1sLIAR2GGSqenbXQGMVzYNSDTfPRRWcMm
        YBVQ1MFl9dbVuY+ewJqfAPIaUvUcF38+aRITr3vhRbMTfoGY3x9knmwuPPYuxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812512;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoNhBeMj6djwwHh2Lg+aGVN+NobF+DUPxFJhJfDKEo8=;
        b=BTdHxakF2cGA6hCOQIZV4KCDReBEKqQkyl7b5MgyKcnT8O8/ZgPUzxAXyd1Jl3+5EHCl1l
        ipyXFIZALBPI3+BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/text-patching: Make text_gen_insn() play nice
 with ANNOTATE_NOENDBR
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.638561109@infradead.org>
References: <20220308154317.638561109@infradead.org>
MIME-Version: 1.0
Message-ID: <164681251100.16921.13372816898823421538.tip-bot2@tip-bot2>
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

Commit-ID:     dbf45ea73312b99208809c3b7a4831d6bb4e6ed8
Gitweb:        https://git.kernel.org/tip/dbf45ea73312b99208809c3b7a4831d6bb4e6ed8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:28 +01:00

x86/text-patching: Make text_gen_insn() play nice with ANNOTATE_NOENDBR

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.638561109@infradead.org
---
 arch/x86/include/asm/text-patching.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index b742178..1c4cfb1 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -101,13 +101,21 @@ void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
 	static union text_poke_insn insn; /* per instance */
 	int size = text_opcode_size(opcode);
 
+	/*
+	 * Hide the addresses to avoid the compiler folding in constants when
+	 * referencing code, these can mess up annotations like
+	 * ANNOTATE_NOENDBR.
+	 */
+	OPTIMIZER_HIDE_VAR(addr);
+	OPTIMIZER_HIDE_VAR(dest);
+
 	insn.opcode = opcode;
 
 	if (size > 1) {
 		insn.disp = (long)dest - (long)(addr + size);
 		if (size == 2) {
 			/*
-			 * Ensure that for JMP9 the displacement
+			 * Ensure that for JMP8 the displacement
 			 * actually fits the signed byte.
 			 */
 			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
