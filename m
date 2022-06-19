Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FE255090F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiFSHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiFSHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:00:47 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E6ACDFC7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xEvCU
        fDCDVBkY6E6w4t7hfvJ26KTGyPP8KXafpD2R6A=; b=FV1Gk31Y6tUlQFnR3s2QD
        3jTGbZeq54u0Lev8/fBq57KTM92sO6MwVxjuonsGH2JISRaiuf8P8idCTkRrGZ4E
        3L+m3yOyOenQoxEim39UEJsOY6kgjK1XKWDzbFJtQDMgD8e1wmB4Yjlrwfk88Y26
        F6uBOCwNfG1XLEPiYxf/TU=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowACnDPldya5izSCMDg--.28541S2;
        Sun, 19 Jun 2022 14:59:42 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        linus.walleij@linaro.org, arnd@arndb.de, rostedt@goodmis.org,
        ebiederm@xmission.com
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm/kernel: Fix refcount leak bugs
Date:   Sun, 19 Jun 2022 14:59:41 +0800
Message-Id: <20220619065941.4066920-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowACnDPldya5izSCMDg--.28541S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWkZrW7ur15Gw13ZFy7KFg_yoW8Xr4Up3
        4jkr9xtF4Yka9rJ3yFy3s5ur4Yy3Wvgw4Sg3yj93yfArs0yry8XrsY9asI9ry7XF4Fgw4F
        ga10kF4Sq3W8WaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUPEhUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgclF1-HZVICbQAAsv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arm_dt_init_cpu_maps() and init_machine_late(), we need of_node_put()
to keep refcount balance.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/kernel/devtree.c | 4 ++++
 arch/arm/kernel/setup.c   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 02839d8b6202..d4dbc9eb382d 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -94,6 +94,7 @@ void __init arm_dt_init_cpu_maps(void)
 		 */
 		if (hwid & ~MPIDR_HWID_BITMASK) {
 			of_node_put(cpu);
+			of_node_put(cpus);
 			return;
 		}
 
@@ -108,6 +109,7 @@ void __init arm_dt_init_cpu_maps(void)
 			if (WARN(tmp_map[j] == hwid,
 				 "Duplicate /cpu reg properties in the DT\n")) {
 				of_node_put(cpu);
+				of_node_put(cpus);
 				return;
 			}
 
@@ -148,6 +150,8 @@ void __init arm_dt_init_cpu_maps(void)
 	if (!found_method)
 		set_smp_ops_by_method(cpus);
 
+	of_node_put(cpus);
+
 	if (!bootcpu_valid) {
 		pr_warn("DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map\n");
 		return;
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1e8a50a97edf..43ec8d78c219 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -960,6 +960,7 @@ static int __init init_machine_late(void)
 	if (root) {
 		ret = of_property_read_string(root, "serial-number",
 					      &system_serial);
+		of_node_put(root);
 		if (ret)
 			system_serial = NULL;
 	}
-- 
2.25.1

