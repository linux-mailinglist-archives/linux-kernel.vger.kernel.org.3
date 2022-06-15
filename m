Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5101654C3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbiFOIhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245226AbiFOIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:37:12 -0400
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 01:37:10 PDT
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9174A23BFA;
        Wed, 15 Jun 2022 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=u6YQg
        HrK1S8KKnarhxByDY6BuIzlDp0AO/shcqnjQyY=; b=ePY+hZkbzAva3Cg41mAP0
        Wj2Ku7jTIbd7N/omPzCMCbZL48b+En0mdGubI1p1H3WPCyD9KzlxaDfHWkxtQQf2
        W7PxuxKXYG2VaE+xKz6Yu+ivdhoJczPgDaFXy2rfipliFXKDw2UyvRDjWLotCEvG
        2YABC5MPr16AiPT3xDZdgI=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowABXXvbtmaliW+ubEQ--.53231S2;
        Wed, 15 Jun 2022 16:35:59 +0800 (CST)
From:   heliang <windhl@126.com>
To:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH] clk: tegra: Add missing of_node_put in clk-tegra124.c
Date:   Wed, 15 Jun 2022 16:35:56 +0800
Message-Id: <20220615083556.3960821-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowABXXvbtmaliW+ubEQ--.53231S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyrKF4xGw1xZw1xCF15Arb_yoW3Wrb_XF
        15XryxXw15Can3AFsxur13ZryIyr1fWrsYqFWSya17Gw18Zr4UWrs0vrn2k3srW39rWFW3
        Ja4kKw40k34YvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREQJ5DUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3A8hF1pEDuVFTgAAsb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tegra124_132_clock_init_pre, of_find_matching_node() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
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

