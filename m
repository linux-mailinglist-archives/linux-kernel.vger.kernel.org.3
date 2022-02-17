Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EDB4BA8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbiBQS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244699AbiBQS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719445D1B1;
        Thu, 17 Feb 2022 10:56:51 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vg14YJ56VGteBFg5eXdVUE8hpg4SnmX7rQz9Qjf0MIk=;
        b=m3nKigkUAYR+caz/KwmSz/YSlCfwoMJiOl0J75wnKwJRzz3ic8FdvcgS/4tiaP+UY3vbQ3
        35p3x7AOsiD2iPR8QUFZad7VQGziMyLGI4t+vEtBMKQvpxeK/jigFQITF3g4Tx0cCP1ZNs
        S8jYjkMiXe1X3GmBnag+il6VnXC41RjM3hts8mrSwFmy0Ky3P8UHJAldh7xoNR0QateFow
        QQqn0rQ6XJSlw2kAQpZVprkW5Vq+xUOZLXPfzhi5Uzy+AQSAg+kqYZluIS9xWfn04STTz/
        +2x+4WTrYG97PqvMekKVzoADFigqCBIZiOM0AJGZGUTuswHmkh2qoCykK9fZXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vg14YJ56VGteBFg5eXdVUE8hpg4SnmX7rQz9Qjf0MIk=;
        b=JuNwX9c3+PAu9VVby3udGYYPS6P8vPXp5TQ3ZhlvOP6D2Xnbfp2aHSXBO8aoRjpxvX2rFU
        uElNOOm04FSMquAg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] net: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207155910.527133-4-frederic@kernel.org>
References: <20220207155910.527133-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <164512420898.16921.9921602007161018305.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c8fb9f22ae22dbe06a43b77717299e1c3e632d5c
Gitweb:        https://git.kernel.org/tip/c8fb9f22ae22dbe06a43b77717299e1c3e632d5c
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 07 Feb 2022 16:59:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:54 +01:00

net: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch

To prepare for supporting each feature of the housekeeping cpumask
toward cpuset, prepare each of the HK_FLAG_* entries to move to their
own cpumask with enforcing to fetch them individually. The new
constraint is that multiple HK_FLAG_* entries can't be mixed together
anymore in a single call to housekeeping cpumask().

This will later allow, for example, to runtime modify the cpulist passed
through "isolcpus=", "nohz_full=" and "rcu_nocbs=" kernel boot
parameters.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20220207155910.527133-4-frederic@kernel.org
---
 net/core/net-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 53ea262..ed8da7b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -823,7 +823,7 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 {
 	struct rps_map *old_map, *map;
 	cpumask_var_t mask;
-	int err, cpu, i, hk_flags;
+	int err, cpu, i;
 	static DEFINE_MUTEX(rps_map_mutex);
 
 	if (!capable(CAP_NET_ADMIN))
@@ -839,8 +839,8 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 	}
 
 	if (!cpumask_empty(mask)) {
-		hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
-		cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_FLAG_DOMAIN));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_FLAG_WQ));
 		if (cpumask_empty(mask)) {
 			free_cpumask_var(mask);
 			return -EINVAL;
