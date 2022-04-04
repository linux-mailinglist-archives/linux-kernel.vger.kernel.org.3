Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1C24F1E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379041AbiDDVqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379979AbiDDSbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:31:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040562124F;
        Mon,  4 Apr 2022 11:29:50 -0700 (PDT)
Date:   Mon, 04 Apr 2022 18:29:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649096988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9EfMuuRqtyS8P2Al6pBaSFlQtqnpeScM1f+WbcKzbs=;
        b=xIpDlXA8iQhMDtdQ0BssdtIAhyFRpoHdLK81scXP+zYDrs2rB2iIMC7JhKmnqV4Ci6tfan
        dcjpBHmayGZwKR7R9i1WOHdaA8qJRs0E+0MEElzBs0vXm5pckOlXmZlbFcgRlxgZd+LJ+8
        LVvig5vReZC3ocyNEZ0tCMfQHGmQ2EgKCKCpvTQ977e6Bg/S5/p6pt/YTea2atH7J7JCRZ
        F5gL8RAIDrDtSstIw1UttgBKO+X/yhGKiVORojSrz/fy/B9jmlhtQqlEF6Flqs5YwyM8vv
        lUxMXZUzx/BD3IuvdaSChvOOPSH+89ZLsK8aUDEgCQX8coD843PIoSYkoLPD4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649096988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9EfMuuRqtyS8P2Al6pBaSFlQtqnpeScM1f+WbcKzbs=;
        b=yCBR+tgPbz4EcaGWRNpwYhdv4H4skG+PQrWJ6D44gEo446AH3Bl6hxssjJNk8YfE0rEg4N
        QgMrU4wrovrpT3Dw==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Cast an argument to the proper address space
 in prefetch()
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220201144055.5670-1-lukas.bulwahn@gmail.com>
References: <20220201144055.5670-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <164909698735.389.10476346049745259502.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     944fad4583bc8a6d7dd80fbe39db50141da95793
Gitweb:        https://git.kernel.org/tip/944fad4583bc8a6d7dd80fbe39db50141da95793
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Tue, 01 Feb 2022 15:40:55 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 20:08:26 +02:00

x86/fault: Cast an argument to the proper address space in prefetch()

Commit in Fixes uses accessors based on the access mode, i.e., it
distinguishes its access if instr carries a user address or a kernel
address.

Since that commit, sparse complains about passing an argument without
__user annotation to get_user(), which expects a pointer of the __user
address space:

  arch/x86/mm/fault.c:152:29: warning: incorrect type in argument 1 (different address spaces)
  arch/x86/mm/fault.c:152:29:    expected void const volatile [noderef] __user *ptr
  arch/x86/mm/fault.c:152:29:    got unsigned char *[assigned] instr

Cast instr to __user when accessing user memory.

No functional change. No change in the generated object code.

  [ bp: Simplify commit message. ]

Fixes: 35f1c89b0cce ("x86/fault: Fix AMD erratum #91 errata fixup for user code")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220201144055.5670-1-lukas.bulwahn@gmail.com
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d0074c6..fad8faa 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -149,7 +149,7 @@ is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
 		unsigned char opcode;
 
 		if (user_mode(regs)) {
-			if (get_user(opcode, instr))
+			if (get_user(opcode, (unsigned char __user *) instr))
 				break;
 		} else {
 			if (get_kernel_nofault(opcode, instr))
