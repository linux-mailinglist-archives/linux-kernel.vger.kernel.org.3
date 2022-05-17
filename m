Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E41E529FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbiEQK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiEQK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:59:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB42B4B41B;
        Tue, 17 May 2022 03:58:53 -0700 (PDT)
Date:   Tue, 17 May 2022 10:58:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652785130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qq22VJKbqTDmP1HhOQj3CkRWDuZ6tAV0hl6p/bOyx3w=;
        b=zZRNLb73NmYEHumOPqdjKTbdLGv4BcCFhaNdfmjLZXXU9Fy6m+r4o4DxaRpEu2xFdaLAwC
        w1KxE0BlKQRCvw1bPW/vUvkSGw+/usor3Npa0MdwVsezfXBd6zFOaE224q/CDyMhM/a0ZU
        5EcJodc9BTO6q2w2ejnCWkjwroYYQJtj/mHQqglicWzYemPtvyKRcxhpVm5le/Br0TyGzB
        FaXfWQwKOlYB/b5Y72QwGYi4CYCiqhDVvDuBfuc44SkSFPoOeFxOe0BKNSvRZgtDEMXEn8
        H0TvvahZW7xjdSQ/HAtelz18lSaEO3xxxQ7XWgyVgFm5M8Q9nzFGHbCjh7QaHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652785130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qq22VJKbqTDmP1HhOQj3CkRWDuZ6tAV0hl6p/bOyx3w=;
        b=uY5vygZkyTTy69Ymlaxx8Mt3duXIZ8G2oNbML+FpIf0i0Ncze44jzHTa7+M+fNM0sRKIy6
        FO4q7w+13CZn+0CA==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Remove duplicated assignment to variable info
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220516184215.51841-1-colin.i.king@gmail.com>
References: <20220516184215.51841-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Message-ID: <165278512876.4207.18026967254271145899.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0621210ab7693e6d50585ca689d95d57df617455
Gitweb:        https://git.kernel.org/tip/0621210ab7693e6d50585ca689d95d57df617455
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Mon, 16 May 2022 19:42:15 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 May 2022 12:52:37 +02:00

x86/sev: Remove duplicated assignment to variable info

Variable info is being assigned the same value twice, remove the
redundant assignment. Also assign variable v in the declaration.

Cleans up clang scan warning:
  warning: Value stored to 'info' during its initialization is never read [deadcode.DeadStores]

No code changed:

  # arch/x86/kernel/sev.o:

   text    data     bss     dec     hex filename
  19878    4487    4112   28477    6f3d sev.o.before
  19878    4487    4112   28477    6f3d sev.o.after

md5:
   bfbaa515af818615fd01fea91e7eba1b  sev.o.before.asm
   bfbaa515af818615fd01fea91e7eba1b  sev.o.after.asm

  [ bp: Running the before/after check on sev.c because sev-shared.c
    gets included into it. ]

Fixes: 597cfe48212a ("x86/boot/compressed/64: Setup a GHCB-based VC Exception handler")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220516184215.51841-1-colin.i.king@gmail.com
---
 arch/x86/kernel/sev-shared.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2b4270d..b478edf 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -201,10 +201,7 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 
 	if (ret == 1) {
 		u64 info = ghcb->save.sw_exit_info_2;
-		unsigned long v;
-
-		info = ghcb->save.sw_exit_info_2;
-		v = info & SVM_EVTINJ_VEC_MASK;
+		unsigned long v = info & SVM_EVTINJ_VEC_MASK;
 
 		/* Check if exception information from hypervisor is sane. */
 		if ((info & SVM_EVTINJ_VALID) &&
