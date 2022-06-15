Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CC254CAD2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356018AbiFOOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356195AbiFOOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:04:00 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61FA814020
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xGjqN
        1CzFGgxxXJufcBxFeGfgDwPCWB316shxSNIbJs=; b=JVHxeNujKk5t7no8ctG1Q
        xSBB2a0rzeK6LpMG1MP7z2IcKj8wzgC8R/tMRRAbUPk14+EZTngtMMnb7ES9AfpX
        ACciMZcwt021YJhkv6pYS/wgRzd3ZxE8wER2KbbNjjPCh36ARQ1eKeoMLewvDNte
        tIV5FyITVMya3u22tGtURU=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgDHFmt45qliXpPJEg--.48216S2;
        Wed, 15 Jun 2022 22:02:33 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] drivers: soc: bcm: brcmstb: Add missing of_node_put() in biuctrl.c
Date:   Wed, 15 Jun 2022 22:02:31 +0800
Message-Id: <20220615140231.3968187-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgDHFmt45qliXpPJEg--.48216S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1rCry8Gw15XFykWr18uFg_yoWkZwcEgF
        93Xr9rXr4UZw48XFyDCw4fZas7uFs8XFs7ZFyIqa43CF92qw1DJrWkZr9xCw4kWrWvkFy7
        Cw4qgrW0vr1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_znQ7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhkhF18RPTF-wQAAsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In brcmstb_biuctrl_init(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
in each fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 2c975d79fe8e..1467bbd59690 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -340,12 +340,12 @@ static int __init brcmstb_biuctrl_init(void)
 
 	ret = setup_hifcpubiuctrl_regs(np);
 	if (ret)
-		return ret;
+		goto out_put;
 
 	ret = mcp_write_pairing_set();
 	if (ret) {
 		pr_err("MCP: Unable to disable write pairing!\n");
-		return ret;
+		goto out_put;
 	}
 
 	a72_b53_rac_enable_all(np);
@@ -353,6 +353,9 @@ static int __init brcmstb_biuctrl_init(void)
 #ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&brcmstb_cpu_credit_syscore_ops);
 #endif
-	return 0;
+	ret = 0;
+out_put:
+	of_node_put(np);
+	return ret;
 }
 early_initcall(brcmstb_biuctrl_init);
-- 
2.25.1

