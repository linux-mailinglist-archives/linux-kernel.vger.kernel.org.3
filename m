Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0241254D8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349626AbiFPDcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiFPDcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:32:10 -0400
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 20:32:08 PDT
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BA2D5930C;
        Wed, 15 Jun 2022 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CyCwT
        NVUp2aw6tPR5VloYtflIPPfgirxy7R55hi2yiI=; b=LKZ1Y15zBbGwx6OYcQBTm
        dtx5kwrdLXoalwG7oCjv4m8OQqNn+x08VBR2K7tqyMd/B53JDyWb+XoY4/03ANCF
        DrLdFYtjJy0s9MtLxbMkpQr0YUHsAA+1xvP98SnAJBKNk41dIV09nsaWmRWb2GU/
        h2Wz0FiHJdRzovM/hAa3m8=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgBHlGgnpKpiJDH8Eg--.22565S2;
        Thu, 16 Jun 2022 11:31:51 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH v2] clk: tegra: (clk-tegra124) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 11:31:50 +0800
Message-Id: <20220616033150.3975316-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgBHlGgnpKpiJDH8Eg--.22565S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyrKF4xGw1xZw1xCF15Arb_yoW3urb_XF
        15Xry7Zw15CwsayFZxur43ZryIyryfWrs0qFWSya17Gw18Zr4UWrs0vrn2k3srWa9rWFW5
        Ja4ktw4Fy3s0vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRibAwDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgciF18RPTV5+AAAs7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tegra124_132_clock_init_pre, of_find_matching_node() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: use real name
 v1: fix missing bug

 drivers/clk/tegra/clk-tegra124.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.25.1

