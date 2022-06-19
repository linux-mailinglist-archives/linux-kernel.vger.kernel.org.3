Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC65508E0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 08:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiFSGSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 02:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiFSGSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 02:18:32 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F134B65E5;
        Sat, 18 Jun 2022 23:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xsRsM
        A2hyPmpGI1vPcsRVjN5gYfeUJLQC69BnESVN58=; b=LL8f2cnDGNEq4St8cNOjZ
        RKz/CBE0BPUj9QwHSAMWHO7a3DIYxNqX+6lq7vTVXiSnUJlJcUkxQnDAkkCnh47w
        4rMfb/oy3kpehKKqkL77dY81l+zYW+9q7GW7fiqBrqK1biFK3PTddini1U954mb5
        o5D/gEPoqK+o5UJ55q5ygk=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBnb3Owv65i9CbYFw--.65288S2;
        Sun, 19 Jun 2022 14:18:25 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net, windhl@126.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: kernel: Fix refcount bug in irq_64.c
Date:   Sun, 19 Jun 2022 14:18:23 +0800
Message-Id: <20220619061823.4066040-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBnb3Owv65i9CbYFw--.65288S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy8Wr4kJw4kWF4DGr4Uurg_yoWfKrX_Ww
        1SqFyDGry09wnaqw4DWw4fXry7Aw1IgFWrKw10ya95J3W8Jr45urZxJF1kZayDZ395AFs3
        Cas0vFWjkr1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKrWF7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RElF1pEAOuKUwAAsi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In map_prom_timers(), of_find_node_by_path() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/sparc/kernel/irq_64.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index c8848bb681a1..84abfe584a08 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -909,12 +909,13 @@ static u64 prom_limit0, prom_limit1;
 
 static void map_prom_timers(void)
 {
-	struct device_node *dp;
+	struct device_node *dp, *tp;
 	const unsigned int *addr;
 
 	/* PROM timer node hangs out in the top level of device siblings... */
-	dp = of_find_node_by_path("/");
-	dp = dp->child;
+	tp = of_find_node_by_path("/");
+	dp = tp->child;
+	of_node_put(tp);
 	while (dp) {
 		if (of_node_name_eq(dp, "counter-timer"))
 			break;
-- 
2.25.1

