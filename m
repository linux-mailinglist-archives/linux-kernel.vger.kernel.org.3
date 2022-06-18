Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCAD550359
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiFRHPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 03:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiFRHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 03:14:58 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24929E032
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yUGvi
        HoDuaYWc3NS2cFfqUOpZuOBhcDVFg5fEUfO50k=; b=Z8hMvxqr2n6DWaX01Dqgs
        N8xvqKxQPOHDuees4IkR4vaAqWNlFZHhfH4V3tdtGjQlP+7sHnSqd4u1RITTh65j
        3WoGSBbPMFGDBaU70sqqfPHMHAqOy4YKHgAgoGfZzYpTm5k3HRivJp+FrSDPSnKz
        iFXdhpW6rMK8iBoKm/Lbxo=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowAD3Ovoxe61i4dmmDg--.41080S2;
        Sat, 18 Jun 2022 15:13:54 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: perf: Fix refcount leak bug in imc-pmu.c
Date:   Sat, 18 Jun 2022 15:13:53 +0800
Message-Id: <20220618071353.4059000-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowAD3Ovoxe61i4dmmDg--.41080S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4UXry5Xw4xKrW3uF4fuFg_yoW8WFy5pr
        WkCayFgr48tw1xu34SqFsFvrZ5t340gr4qqrW7W39FvFnrZr1ktF48Ar1rZryFyFyfJa4x
        Xw4Yqw47Ka4akaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziZYF_UUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgokF1-HZUrvjAABs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In update_events_in_group(), of_find_node_by_phandle() will return
a node pointer with refcount incremented. We should use of_node_put()
in fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/perf/imc-pmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index d7976ab40d38..d517aba94d1b 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -240,8 +240,10 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	ct = of_get_child_count(pmu_events);
 
 	/* Get the event prefix */
-	if (of_property_read_string(node, "events-prefix", &prefix))
+	if (of_property_read_string(node, "events-prefix", &prefix)) {
+		of_node_put(pmu_events);
 		return 0;
+	}
 
 	/* Get a global unit and scale data if available */
 	if (of_property_read_string(node, "scale", &g_scale))
@@ -255,8 +257,10 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 
 	/* Allocate memory for the events */
 	pmu->events = kcalloc(ct, sizeof(struct imc_events), GFP_KERNEL);
-	if (!pmu->events)
+	if (!pmu->events) {
+		of_node_put(pmu_events);
 		return -ENOMEM;
+	}
 
 	ct = 0;
 	/* Parse the events and update the struct */
@@ -266,6 +270,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 			ct++;
 	}
 
+	of_node_put(pmu_events);
+
 	/* Allocate memory for attribute group */
 	attr_group = kzalloc(sizeof(*attr_group), GFP_KERNEL);
 	if (!attr_group) {
-- 
2.25.1

