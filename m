Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210014F51F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849015AbiDFCco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388343AbiDEVyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:54:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D064114FEF;
        Tue,  5 Apr 2022 13:50:18 -0700 (PDT)
Date:   Tue, 05 Apr 2022 20:50:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649191816;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9NEylB5TuZS1uQcuZiivIHTEA7/w5XCamuX+Zjn7SA=;
        b=r69UORCsb3ybinH4tqd+de10IlVJYWVTvHqN0t6ctCOa2mLgLkRGMhNSQY8R5BEb3C+20R
        8jMiVS8Mh6BFFvqhluXavjV/05wOc5p+fmRag6lqn07kULKxr5mh0x7/WC1ogdzl3FGWVn
        MW4z9gE7FceO8Q1ZMP7ge1oh/DEmkm+g17t7EZYV7YHDcjpVrY02vH4G6VIBl3jTFLjkP0
        8IO/hLjNdGfLs8/icta3QzFC1eWw7kzj1j2zl+rE+MI/6Yz/jOPlJU62qSdvuTE4UzyKFY
        +NOpRO3ETOgVUofAw1MnZLkREF0MtrGwNrxhs7teD8K2hfx/Xm3nRu7Cqi2FGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649191816;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9NEylB5TuZS1uQcuZiivIHTEA7/w5XCamuX+Zjn7SA=;
        b=YRNXRje8iO7luFN9DfbfZW4izUXf+1bdcXyGI6jZkp3BcZL0mDjfqy/2anoWe1ILcbxMFR
        PPPK5u7LeJMMGVCQ==
From:   "tip-bot2 for Ammar Faizi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/delay: Fix the wrong asm constraint in delay_loop()
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220329104705.65256-2-ammarfaizi2@gnuweeb.org>
References: <20220329104705.65256-2-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Message-ID: <164919181468.389.4278489978925909227.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     b86eb74098a92afd789da02699b4b0dd3f73b889
Gitweb:        https://git.kernel.org/tip/b86eb74098a92afd789da02699b4b0dd3f73b889
Author:        Ammar Faizi <ammarfaizi2@gnuweeb.org>
AuthorDate:    Tue, 29 Mar 2022 17:47:04 +07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Apr 2022 21:21:57 +02:00

x86/delay: Fix the wrong asm constraint in delay_loop()

The asm constraint does not reflect the fact that the asm statement can
modify the value of the local variable loops. Which it does.

Specifying the wrong constraint may lead to undefined behavior, it may
clobber random stuff (e.g. local variable, important temporary value in
regs, etc.). This is especially dangerous when the compiler decides to
inline the function and since it doesn't know that the value gets
modified, it might decide to use it from a register directly without
reloading it.

Change the constraint to "+a" to denote that the first argument is an
input and an output argument.

  [ bp: Fix typo, massage commit message. ]

Fixes: e01b70ef3eb3 ("x86: fix bug in arch/i386/lib/delay.c file, delay_loop function")
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220329104705.65256-2-ammarfaizi2@gnuweeb.org
---
 arch/x86/lib/delay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 65d15df..0e65d00 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -54,8 +54,8 @@ static void delay_loop(u64 __loops)
 		"	jnz 2b		\n"
 		"3:	dec %0		\n"
 
-		: /* we don't need output */
-		:"a" (loops)
+		: "+a" (loops)
+		:
 	);
 }
 
