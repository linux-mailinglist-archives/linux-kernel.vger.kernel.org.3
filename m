Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125C54E124
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiFPMyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiFPMyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:54:36 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5DC839823;
        Thu, 16 Jun 2022 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8tzS2
        e4mBnzb5V406qiQEdwk81OWAt9nUM9IjI52OqY=; b=WKez3PvSC18boMEtLCqZ0
        /ECzCRthgCT7USRyoGkFO8mSZqcVHM4IzHDwyqtAMtdDNRD2DBKfSFCtUjCrS0xW
        0iNmHKn86f3rl1zr+abiMX7e4VGEwQcE99LKqC7kOAgMkmYzeRveWHsPOhgA3fx0
        cP7ngX8nOVPdKSpedYue2I=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowACnhd7xJ6tik_1JEg--.21353S2;
        Thu, 16 Jun 2022 20:54:10 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     windhl@126.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] drivers: clk: Add missing of_node_put()
Date:   Thu, 16 Jun 2022 20:54:09 +0800
Message-Id: <20220616125409.3986745-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowACnhd7xJ6tik_1JEg--.21353S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW5Jw4kur1DJw17Cr4rXwb_yoW8uF1rpr
        y7XrW5AF97XF4xKF1xXFWUZFW5C3W2gFW8K3s3Cw1kZrs8Ca48Jr40qa40kFs8trZ5A3yS
        yr18tr48GF1rXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_HUDUUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhMiF18RPTjkHQAAsa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In these clk-related drivers' xxx_init() funcitons, of_find_matching_node()
will return a node pointer with refcount incremented. We should use
of_node_put() in fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v3: merge clk 'missing of_node_put()' patches into one commit.
 v2: use Liang He as real name for S-o-b.
 v1: fix the missing of_node_put().


 drivers/clk/clk-nomadik.c        | 5 ++++-
 drivers/clk/tegra/clk-tegra124.c | 1 +
 drivers/clk/tegra/clk-tegra30.c  | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index bad2677e11ae..71fbe687fa7b 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -99,7 +99,7 @@ static void __init nomadik_src_init(void)
 	if (!src_base) {
 		pr_err("%s: must have src parent node with REGS (%pOFn)\n",
 		       __func__, np);
-		return;
+		goto out_put;
 	}
 
 	/* Set all timers to use the 2.4 MHz TIMCLK */
@@ -132,6 +132,9 @@ static void __init nomadik_src_init(void)
 	}
 	writel(val, src_base + SRC_XTALCR);
 	register_reboot_notifier(&nomadik_clk_reboot_notifier);
+
+out_put:
+	of_node_put(np);
 }
 
 /**
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 934520aab6e3..a9d4efcef2d4 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1471,6 +1471,7 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
 	}
 
 	pmc_base = of_iomap(node, 0);
+	of_node_put(node);
 	if (!pmc_base) {
 		pr_err("Can't map pmc registers\n");
 		WARN_ON(1);
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 04b496123820..168c07d5a5f2 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1320,6 +1320,7 @@ static void __init tegra30_clock_init(struct device_node *np)
 	}
 
 	pmc_base = of_iomap(node, 0);
+	of_node_put(node);
 	if (!pmc_base) {
 		pr_err("Can't map pmc registers\n");
 		BUG();
-- 
2.25.1

