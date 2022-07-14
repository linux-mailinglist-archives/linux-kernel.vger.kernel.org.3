Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F17574B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbiGNLIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiGNLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:08:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7597E3AE;
        Thu, 14 Jul 2022 04:08:34 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:08:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657796912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxX5sW+cuNZzG69+cBPf9V0vtrlfTlK6c63AmDLg2Ac=;
        b=zF26pg5msQNMNO6qOGcYDXNsZXUrjPA9Lgssul1fhwculLD7n5jbt9vkCYVAd3DI6bWgtO
        P7ppd13ww7dvU/NfNtBmg9RBxG4e4NeGH59hHvFzDdy5lJvwctRvJPutyUhFpv+F8W8MwZ
        uOBLJ1d5xiwtbvHih3b/8lDFpH5keuzRIof99yNqBIMetfwAkC9BuGe6x2aHcUEyIX5yj6
        bi6xXMse8Yx+iVSDIP2nhSG81xPMXQzUrXeccg4GfxeEMxkzxjxdJD+DbDNzMI2YHg8bTX
        AhFb3IOs07Mm6kVcW48vOpjNMvYshFCe9BR85Scl0FaOll9RhYG/+K3lRSMUeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657796912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxX5sW+cuNZzG69+cBPf9V0vtrlfTlK6c63AmDLg2Ac=;
        b=FsAWEZeldOfvL7V8JqmEQ+JkAlmcI0VZU3KBBa/RxAvV8FSM/SZejZ2W+veq0fhkI2KwnJ
        Izf6IGZClNxmiRBw==
From:   "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Remove UNTRAIN_RET from native_irq_return_ldt
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <35b0d50f-12d1-10c3-f5e8-d6c140486d4a@oracle.com>
References: <35b0d50f-12d1-10c3-f5e8-d6c140486d4a@oracle.com>
MIME-Version: 1.0
Message-ID: <165779691151.15455.14072147760711822581.tip-bot2@tip-bot2>
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

Commit-ID:     d16e0b26672066035439b2f49887f6576c4a3689
Gitweb:        https://git.kernel.org/tip/d16e0b26672066035439b2f49887f6576c4a3689
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Wed, 13 Jul 2022 21:58:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Jul 2022 09:45:12 +02:00

x86/entry: Remove UNTRAIN_RET from native_irq_return_ldt

UNTRAIN_RET is not needed in native_irq_return_ldt because RET
untraining has already been done at this point.

In addition, when the RETBleed mitigation is IBPB, UNTRAIN_RET clobbers
several registers (AX, CX, DX) so here it trashes user values which are
in these registers.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/35b0d50f-12d1-10c3-f5e8-d6c140486d4a@oracle.com
---
 arch/x86/entry/entry_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 285e043..9953d96 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -727,7 +727,6 @@ native_irq_return_ldt:
 	pushq	%rdi				/* Stash user RDI */
 	swapgs					/* to kernel GS */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi	/* to kernel CR3 */
-	UNTRAIN_RET
 
 	movq	PER_CPU_VAR(espfix_waddr), %rdi
 	movq	%rax, (0*8)(%rdi)		/* user RAX */
