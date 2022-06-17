Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730D254EF06
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379458AbiFQB7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379390AbiFQB7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:59:37 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DBC960AAA;
        Thu, 16 Jun 2022 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vsEwa
        4Q3Nuw5b/RYwlym5mojsapn/Da3u7pPStla0+8=; b=H7Q4Bi/nV43shYU2Z7wWb
        NfWjklqmXs6CxrNTv1J0+t5733VEAfO9IftKHMgz9K/nbrw5zj2BFzCw9H9OZ9vR
        m9CEmPBok+H3+jiZIdITixg1AGHTDv+sJEuRaOYUZZ9spPysKSWHM2KjwKVQK3E2
        HmXLyTfRf/eaCz/7hkMScI=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowABnNfH236ticEIdDg--.10993S2;
        Fri, 17 Jun 2022 09:59:20 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liang He <windhl@126.com>
Subject: [PATCH v4] clk: tegra: Add missing of_node_put()
Date:   Fri, 17 Jun 2022 09:59:18 +0800
Message-Id: <20220617015918.4001865-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowABnNfH236ticEIdDg--.10993S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyrXw4fZF47uw1xCFykXwb_yoW8Xr1rpr
        yUXry5ArykXFs2gF1IvFWUZF98C3W3WrWjq34fC3WkZr4DGa48Jr40qa4jkFs0yrZYy393
        Ar1kKr4kGa1Fva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pM_M3fUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3A8jF1pEDvJlTgABsv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tegra124_132_clock_init_pre() and tegra30_clock_init(),
of_find_matching_node() will return a node pointer with
refcount incremented. We should use of_node_put() when it
is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:
 
 v4: split v3 into nomadik and tegra
 v3: merge clk 'missing of_node_put()' patches into one commit.
 v2: use Liang He as real name for S-o-b.
 v1: fix the missing of_node_put().

 drivers/clk/tegra/clk-tegra124.c | 1 +
 drivers/clk/tegra/clk-tegra30.c  | 1 +
 2 files changed, 2 insertions(+)

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

