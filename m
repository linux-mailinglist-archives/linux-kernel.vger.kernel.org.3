Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEBD4FE0F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354653AbiDLMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355778AbiDLMsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:48:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444883B012;
        Tue, 12 Apr 2022 05:19:34 -0700 (PDT)
Date:   Tue, 12 Apr 2022 12:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649765972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5q536+xcLUMFhu65pWhMxgwQyw8MpnlpovYWdiwIs4=;
        b=O9sgWJeuAG1KRxoZfkbBTlfdx2Zx298bIlvL1O9mBUhj0YSV8Vo6gqDks4gUJ67Njz83QN
        oJzsHim//DguVLy+lPhXuRvzL5fTwvqwfZrItSY7HKMfuHVbbN4uZSACXuQGosOszw5vGL
        QsXvRTj/TJ0AEC5TyM4OCzaLgP3c7efVKVtjrVEp+HbbNBPSAcJYN5X2Qe8FfxW/NfNxfS
        tGe6hYhE0Pv394aQiBrNAFLXcCA8f4nuxl+ug8t6cebfn7GW/2slxVw4N0EZFVFoM5LBOF
        NU46xBKLqOTY3diBrdY/fsY6uLIjal+1ZmVay761f89ugiNXv1K73MUbRhu7mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649765972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5q536+xcLUMFhu65pWhMxgwQyw8MpnlpovYWdiwIs4=;
        b=k96QegTOyLboiY8TQdGL/we1vM55u8S51MOHM4pvkMsaGxqCTDldmLPuD6r3Pzu7Ik3Biq
        Lm4AQzRYfzuqmMCg==
From:   "tip-bot2 for Boris Ostrovsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/xen: Allow to retry if cpu_initialize_context() failed.
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220209080214.1439408-2-bigeasy@linutronix.de>
References: <20220209080214.1439408-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164976597110.4207.17740112682185994045.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     e8a69f12f01f487c6a0e704eb14ccf2dd015277d
Gitweb:        https://git.kernel.org/tip/e8a69f12f01f487c6a0e704eb14ccf2dd015277d
Author:        Boris Ostrovsky <boris.ostrovsky@oracle.com>
AuthorDate:    Wed, 09 Feb 2022 09:02:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Apr 2022 14:13:01 +02:00

x86/xen: Allow to retry if cpu_initialize_context() failed.

If memory allocation in cpu_initialize_context() fails then it will
bring up the VCPU and leave with the corresponding CPU bit set in
xen_cpu_initialized_map.

The following (presumably successful) CPU bring up will BUG in
xen_pv_cpu_up() because nothing for that VCPU would be initialized.

Clear the CPU bits, that were set in cpu_initialize_context() in case
the memory allocation fails.

[ bigeasy: Creating a patch from Boris' email. ]

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220209080214.1439408-2-bigeasy@linutronix.de

---
 arch/x86/xen/smp_pv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 688aa8b..ba7af2e 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -260,8 +260,11 @@ cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
 		return 0;
 
 	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
-	if (ctxt == NULL)
+	if (ctxt == NULL) {
+		cpumask_clear_cpu(cpu, xen_cpu_initialized_map);
+		cpumask_clear_cpu(cpu, cpu_callout_mask);
 		return -ENOMEM;
+	}
 
 	gdt = get_cpu_gdt_rw(cpu);
 
