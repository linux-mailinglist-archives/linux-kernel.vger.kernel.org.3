Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC404ED665
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiCaJDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiCaJCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:02:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33053E5E6;
        Thu, 31 Mar 2022 02:01:03 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:01:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648717262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wR3VjHKbC4KCbwri74FXItqjtDlPNT79+oL5AJuet7A=;
        b=XZuulkPsjIcb632dUWB01NzYw5lRDjrRMOQkI1CBVf6nMa9eF/QxZseWqD9uEgO0gpquQ3
        0w7jUDF0y1tEtMNlz+iycjvCxGYPNMyWxk2YSWdAtwcREFuOJRal2fr9Y13koeq7t6ulpK
        wB2SXd4Ya7QP3Qb7VKvKgdyBpXTazmuvPIAsTToEhkBl5utBO3SI+USQMm0UIe7b/czGd4
        zDF45jRJA4XHz3z5APoRdL2W5PcbsDQt5L8x9MpXz6qm5D495DaXrEw9NPVWTGOrq3gZ4C
        IQu9MJkED+GComtfk/insNBUy4QSBgSPTaQ3WtB0PBvqbqRdQtmSF/IjLkgwmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648717262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wR3VjHKbC4KCbwri74FXItqjtDlPNT79+oL5AJuet7A=;
        b=3tEvSq8SxdeGSYRt+xNGjyYp7TDo/1nbS1++LBGr09sGMUum6SOkf54BMB43tafBEPbXUv
        H+yUcooHJlLW8+CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Remove redundant XCOMP_BV initialization
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220324134623.408932232@linutronix.de>
References: <20220324134623.408932232@linutronix.de>
MIME-Version: 1.0
Message-ID: <164871726137.389.6687530798602523896.tip-bot2@tip-bot2>
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

Commit-ID:     a9f84fb7158fea60cbcadef5c0166fb22b469091
Gitweb:        https://git.kernel.org/tip/a9f84fb7158fea60cbcadef5c0166fb22b469091
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Mar 2022 14:47:08 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 29 Mar 2022 20:57:18 +02:00

x86/fpu: Remove redundant XCOMP_BV initialization

fpu_copy_uabi_to_guest_fpstate() initializes the XCOMP_BV field in the
XSAVE header. That's a leftover from the old KVM FPU buffer handling code.

Since

  d69c1382e1b7 ("x86/kvm: Convert FPU handling to a single swap buffer")

KVM uses the FPU core allocation code, which initializes the XCOMP_BV
field already.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220324134623.408932232@linutronix.de
---
 arch/x86/kernel/fpu/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 19821f0..c049561 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -415,9 +415,6 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
 		xpkru = get_xsave_addr(&kstate->regs.xsave, XFEATURE_PKRU);
 		*vpkru = xpkru->pkru;
 	}
-
-	/* Ensure that XCOMP_BV is set up for XSAVES */
-	xstate_init_xcomp_bv(&kstate->regs.xsave, kstate->xfeatures);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);
