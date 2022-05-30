Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9824153795C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiE3Kqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiE3Kpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:45:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5057CB25;
        Mon, 30 May 2022 03:45:51 -0700 (PDT)
Date:   Mon, 30 May 2022 10:45:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653907550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oN0BchjI0S/uiKLm500Vkkr8chqe+DNI+Hp7hPtlPf8=;
        b=Py4QG6U/wsFwBrArb8Lod/82iJCJnpOnVvAxgwZc67w8C2W+bGx1NyWetexdvNMa7nTvLz
        UVF1KfbR5l8+xVBfY9qSi11QacB6nY2iKwLQqgLHP9V9ZO19fKJpYlx00RqesD/BtAf+LZ
        iBO/x7NsMFei2kjh26xtu9H1R6kfdQAO3hhXZkYwWM1BJfRVacjh7wyikjC8qS+DNZVEkE
        OJ48NijzKAwh2geGGcpgEQg4QW0Q/PxqT77W/9AQdmkQCqR0gJCyE2CA319CvD1BVIQwu3
        OTJlQH8G9iC5vYKY38Zu8/rumXJxMF/HTLpddgZvJMvxA0xwL0J3WayvpM3TOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653907550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oN0BchjI0S/uiKLm500Vkkr8chqe+DNI+Hp7hPtlPf8=;
        b=bhdLHd+hi6E7ioq31ntS7fvfx8GSdxqIpUdHwpzL5sF+Pb1DwCNPJ4sa9sa1aX9YRXgtxU
        tTQEeg5rz/RmrtCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/autogroup: Fix sysctl move
Cc:     Ivan Kozik <ivan@ludios.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YpR2IqndgsyMzN00@worktop.programming.kicks-ass.net>
References: <YpR2IqndgsyMzN00@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165390754900.4207.11439782656946256684.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     82f586f923e3ac6062bc7867717a7f8afc09e0ff
Gitweb:        https://git.kernel.org/tip/82f586f923e3ac6062bc7867717a7f8afc09e0ff
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 30 May 2022 09:45:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 30 May 2022 12:36:36 +02:00

sched/autogroup: Fix sysctl move

Ivan reported /proc/sys/kernel/sched_autogroup_enabled went walk-about
and using the noautogroup command line parameter would result in a
boot error message.

Turns out the sysctl move placed the init function wrong.

Fixes: c8eaf6ac76f4 ("sched: move autogroup sysctls into its own file")
Reported-by: Ivan Kozik <ivan@ludios.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Ivan Kozik <ivan@ludios.org>
Link: https://lkml.kernel.org/r/YpR2IqndgsyMzN00@worktop.programming.kicks-ass.net
---
 kernel/sched/autogroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 16092b4..4ebaf97 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -36,6 +36,7 @@ void __init autogroup_init(struct task_struct *init_task)
 	kref_init(&autogroup_default.kref);
 	init_rwsem(&autogroup_default.lock);
 	init_task->signal->autogroup = &autogroup_default;
+	sched_autogroup_sysctl_init();
 }
 
 void autogroup_free(struct task_group *tg)
@@ -219,7 +220,6 @@ void sched_autogroup_exit(struct signal_struct *sig)
 static int __init setup_autogroup(char *str)
 {
 	sysctl_sched_autogroup_enabled = 0;
-	sched_autogroup_sysctl_init();
 
 	return 1;
 }
