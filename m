Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F354F79B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382192AbiFQMa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382160AbiFQMaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:30:25 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6374C60DB7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xvV3S
        hcwPUAxPUy8RY8/spKuTd4n6cJ6dM39gAWGT9o=; b=hsQtTn/b7QSI/8IR91sFQ
        SefLSW+wFhORPfQpkrQ5/fUEOzTLs8zPNg4fI7t8gtcJi+bBmXa+jRvJs+++CEBD
        b79wAyX7E0tpDxoe3AcOpD/ge0ymFPqul1r7PdWZLM3eeqADH1oLRa4YhV/d3coT
        M/gNLWNyqSDn857BpmUypk=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgAHlYHLc6xiv4JwFw--.38903S2;
        Fri, 17 Jun 2022 20:30:03 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-versatile: Fix refcount leak bug in tc2_pm
Date:   Fri, 17 Jun 2022 20:30:03 +0800
Message-Id: <20220617123003.4048328-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgAHlYHLc6xiv4JwFw--.38903S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy3Aw45CF4xtFy7JrWDArb_yoW8GrW7pr
        10k395Jr10gw1DKa95KFyDZrWFya4q9FW0vr1a93Wak3Z7X3y8AF18tryFyF1DGayrAan5
        Ar15KF17uan8C3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0385UUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gwjF1uwMOUJngAAsL
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tc2_pm_init(), of_find_compatible_node() will return a node pointer
with refcount incremented. We should use of_node_put() in fail path or
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-versatile/tc2_pm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-versatile/tc2_pm.c b/arch/arm/mach-versatile/tc2_pm.c
index 0fe78da0c109..2a7aeab7b3da 100644
--- a/arch/arm/mach-versatile/tc2_pm.c
+++ b/arch/arm/mach-versatile/tc2_pm.c
@@ -212,19 +212,24 @@ static int __init tc2_pm_init(void)
 	np = of_find_compatible_node(NULL, NULL,
 			"arm,vexpress-scc,v2p-ca15_a7");
 	scc = of_iomap(np, 0);
-	if (!scc)
+	if (!scc) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	a15_cluster_id = readl_relaxed(scc + A15_CONF) & 0xf;
 	a7_cluster_id = readl_relaxed(scc + A7_CONF) & 0xf;
-	if (a15_cluster_id >= TC2_CLUSTERS || a7_cluster_id >= TC2_CLUSTERS)
+	if (a15_cluster_id >= TC2_CLUSTERS || a7_cluster_id >= TC2_CLUSTERS) {
+		of_node_put(np);
 		return -EINVAL;
+	}
 
 	sys_info = readl_relaxed(scc + SYS_INFO);
 	tc2_nr_cpus[a15_cluster_id] = (sys_info >> 16) & 0xf;
 	tc2_nr_cpus[a7_cluster_id] = (sys_info >> 20) & 0xf;
 
 	irq = irq_of_parse_and_map(np, 0);
+	of_node_put(np);
 
 	/*
 	 * A subset of the SCC registers is also used to communicate
-- 
2.25.1

