Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58054FB014
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbiDJU35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiDJU3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:29:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F93FD91;
        Sun, 10 Apr 2022 13:27:42 -0700 (PDT)
Date:   Sun, 10 Apr 2022 20:27:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649622461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1dSEgq02Yx+z4C2EEpCjyijDIgMlaQGjt5ftk5G6Uk=;
        b=zZRnbUvpLsz2+Zp5PoaxCNPP5v58PvBjOQZiktrgptvjCfoLycMjO69JrK8WOsYeiZwBrs
        h7eVdI+4Im7MvYUrNEpee9Efhqd9lUg6Lp/TX9zrYss7+41krMs6JMnBZ/LyoIAXYMCmEw
        C70b53Nh/3ifVffmJIACqf+SDVzYMa98CaY1Jn2hio9tmage9Yy5y4Rpjr8Y8SR0dHS2Wm
        izXlf5ZZjlRKrmdYhpzQiqKvFBBkhS8lLRKXSdLDMpWAFC3MbNfLjhjg3McTAs/fReVAiM
        NPdFwhGUNsCGhFRqJLxwZ6KpIcTWMvTR5GyVpwrDWtuO7znjGZB/Mfe8oAj0jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649622461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1dSEgq02Yx+z4C2EEpCjyijDIgMlaQGjt5ftk5G6Uk=;
        b=omSQdQJqlcOU5MU8saxs3hnJPsDA0ML6DulScsQ8K/0HgBRl0DeRT3BAAXbJUagbUMyjdz
        i4QPTN1IycjtHtCw==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/affinity: Replace cpumask_weight() with
 cpumask_empty() where appropriate
Cc:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220210224933.379149-22-yury.norov@gmail.com>
References: <20220210224933.379149-22-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <164962245994.4207.10090580398155704963.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     911488de0565f1d53bd36174d20917ebc4b44c0e
Gitweb:        https://git.kernel.org/tip/911488de0565f1d53bd36174d20917ebc4b44c0e
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Thu, 10 Feb 2022 14:49:05 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 22:20:28 +02:00

genirq/affinity: Replace cpumask_weight() with cpumask_empty() where appropriate

__irq_build_affinity_masks() calls cpumask_weight() to check if any bit of
a given cpumask is set.

This can be done more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220210224933.379149-22-yury.norov@gmail.com

---
 kernel/irq/affinity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f7ff891..18740fa 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -258,7 +258,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct node_vectors *node_vectors;
 
-	if (!cpumask_weight(cpu_mask))
+	if (cpumask_empty(cpu_mask))
 		return 0;
 
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
