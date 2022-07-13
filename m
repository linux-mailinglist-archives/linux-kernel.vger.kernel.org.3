Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C3A572B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiGMCOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiGMCO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:14:26 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABEC14F659
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ikHA2
        7jOWrf1Qm3cFev3aWzpCFTLu3KuD8nMhC9QKso=; b=dhfVW77WPi/zA9iuSew0M
        jWT1+ue2JcM4dFd0/rmTdVZTql2IZ2L3OLwmptdJMavqTru2yPc0wbsrA6u7ZqjQ
        reVSeGjejtOh502m7w970L2WyKAcpZK3eZxDmdPKjVwfUr7DmRXdYQcvOZATF27H
        4v7WbDGvXPMwenl6HdYQKM=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp13 (Coremail) with SMTP id EcCowADXQZ9AKs5iAfn3NA--.40687S2;
        Wed, 13 Jul 2022 10:13:22 +0800 (CST)
From:   huhai <15815827059@163.com>
To:     linux@armlinux.org.uk, dietmar.eggemann@arm.com, mingo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huhai <huhai@kylinos.cn>
Subject: [PATCH] ARM, sched/topology: fix possible memory allocation failure
Date:   Wed, 13 Jul 2022 10:11:29 +0800
Message-Id: <20220713021129.103155-1-15815827059@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADXQZ9AKs5iAfn3NA--.40687S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1rAFyUXw1DZF1rur13twb_yoW8ZrW3pw
        40krW7tw4fWFZ7J397Xw1xZrykKr9rXw17GayUJ3y5J3W3Ar1xGFZav3yaqry7uryFqr1f
        tr4Uta4DWFZ2v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzuWdUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/1tbiqwM9hVUMemdMkQAAsJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huhai <huhai@kylinos.cn>

When kcalloc in parse_dt_topology() fails and it will lead to a null
pointer access.

Considering update_cpu_capacity() also uses __cpu_capacity, and refer to
the implementation of parse_dt_topology() in drivers/base/arch_topology.c,
use global variables to store capacity in this patch.

Signed-off-by: huhai <huhai@kylinos.cn>
---
 arch/arm/kernel/topology.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..383eaac1dbd2 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -68,8 +68,7 @@ static const struct cpu_efficiency table_efficiency[] = {
 	{NULL, },
 };
 
-static unsigned long *__cpu_capacity;
-#define cpu_capacity(cpu)	__cpu_capacity[cpu]
+static unsigned long cpu_capacity[NR_CPUS];
 
 static unsigned long middle_capacity = 1;
 static bool cap_from_dt = true;
@@ -91,9 +90,6 @@ static void __init parse_dt_topology(void)
 	unsigned long capacity = 0;
 	int cpu = 0;
 
-	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
-				 GFP_NOWAIT);
-
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
 		int len;
@@ -135,7 +131,7 @@ static void __init parse_dt_topology(void)
 		if (capacity > max_capacity)
 			max_capacity = capacity;
 
-		cpu_capacity(cpu) = capacity;
+		cpu_capacity[cpu] = capacity;
 	}
 
 	/* If min and max capacities are equals, we bypass the update of the
@@ -163,10 +159,10 @@ static void __init parse_dt_topology(void)
  */
 static void update_cpu_capacity(unsigned int cpu)
 {
-	if (!cpu_capacity(cpu) || cap_from_dt)
+	if (!cpu_capacity[cpu] || cap_from_dt)
 		return;
 
-	topology_set_cpu_scale(cpu, cpu_capacity(cpu) / middle_capacity);
+	topology_set_cpu_scale(cpu, cpu_capacity[cpu] / middle_capacity);
 
 	pr_info("CPU%u: update cpu_capacity %lu\n",
 		cpu, topology_get_cpu_scale(cpu));
-- 
2.27.0

