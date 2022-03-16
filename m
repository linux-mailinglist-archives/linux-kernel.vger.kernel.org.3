Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9DF4DAE20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355100AbiCPKSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiCPKSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:18:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2BC652E4;
        Wed, 16 Mar 2022 03:16:50 -0700 (PDT)
Date:   Wed, 16 Mar 2022 10:16:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647425808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uhOLMazwC5SQwWzyqg971VyuPTFYQGWqUb9R9iSPZc=;
        b=PgvlCi2YH1ObraubcB+gzHmMv0A88Q2PDrfOu1unEXr0sTRVFkILv3iA5qcTX1oBnCNr5c
        PQGOJzIzuInonfsBBWvLZEruC7wDKJl33pzVVTZnjEVU80rUQPLIXO/Z/LmRIKSr21O+te
        JgFG4KoeW0dwoEzBMXrgl/D68EqYzG/ut6KiIjiY8lzST31csA/JgAVRG7Gghpeot3OFW5
        1M5DPdfnF/JW3GYK/46eoUKnOm4rjzQ4R6Vfbw3DnxuXXYCgmPge0mzfKXQ5npMzSRkErf
        icQjHS28e7l5ovz80W4lBb1LVblRa/EKChpNdcs3caUJl1Pf6uHGeUu/HETmVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647425808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uhOLMazwC5SQwWzyqg971VyuPTFYQGWqUb9R9iSPZc=;
        b=5zKPehMD0hQLzKP3bAxpYufgZKutXX1gHVdiFuVHJs2e8oCOOtO+L5kFfpmeZyxQGJjShp
        pPCMkI8P4vfxk7Dw==
From:   "tip-bot2 for Jiri Kosina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/nmi: Remove the 'strange power saving mode'
 hint from unknown NMI handler
Cc:     Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <nycvar.YFH.7.76.2203140924120.24795@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2203140924120.24795@cbobk.fhfr.pm>
MIME-Version: 1.0
Message-ID: <164742580521.16921.12855276450839401894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d4c9df20a37d128f6acb3c6286db7e694554a51b
Gitweb:        https://git.kernel.org/tip/d4c9df20a37d128f6acb3c6286db7e694554a51b
Author:        Jiri Kosina <jkosina@suse.cz>
AuthorDate:    Mon, 14 Mar 2022 09:25:18 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 16 Mar 2022 11:02:41 +01:00

x86/nmi: Remove the 'strange power saving mode' hint from unknown NMI handler

The

  Do you have a strange power saving mode enabled?

hint when unknown NMI happens dates back to i386 stone age, and isn't
currently really helpful.

Unknown NMIs are coming for many different reasons (broken firmware,
faulty hardware, ...) and rarely have anything to do with 'strange power
saving mode' (whatever that even is).

Just remove it as it's largerly misleading.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/nycvar.YFH.7.76.2203140924120.24795@cbobk.fhfr.pm
---
 arch/x86/kernel/nmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4bce802..e73f7df 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -292,7 +292,6 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 	pr_emerg("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
 		 reason, smp_processor_id());
 
-	pr_emerg("Do you have a strange power saving mode enabled?\n");
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
 		nmi_panic(regs, "NMI: Not continuing");
 
