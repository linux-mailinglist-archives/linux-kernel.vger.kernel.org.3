Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE0554C3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbiFOIlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346570AbiFOIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:41:28 -0400
X-Greylist: delayed 255 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 01:41:25 PDT
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04C434A933;
        Wed, 15 Jun 2022 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DmT6U
        58o0/4r961TrAREaDDktMO1YP/6bcDd0RxPXn0=; b=fzvXfURIk/dujjv3CKxa2
        HU4GoGzxVlCyXA+Z0M9zL+UCOcY0U9aTSoh0PxGE5HH3/+XljnQoRG1X7iGX8cx5
        hFhrJscs0gXiEco67561YpeaD/AG7u0sGuD7Hht75+MDkRx8ko7+csBBusP+sXUL
        q52lvNxIno1FpuQi8/c/Ug=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowAAH1fAam6liw9ddDQ--.37360S2;
        Wed, 15 Jun 2022 16:41:07 +0800 (CST)
From:   heliang <windhl@126.com>
To:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH] clk: tegra: Add missing of_node_put in clk-tegra30.c
Date:   Wed, 15 Jun 2022 16:40:56 +0800
Message-Id: <20220615084056.3961029-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowAAH1fAam6liw9ddDQ--.37360S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW3GryrZFW7Aw18uw1kAFb_yoW3GFb_XF
        y5XFyxXw4UKFs5CFs8ur13ZryIvF1rWrnYqFWIyw47G3W0vr4UGrs0vrn7C3s7X39FqFW7
        Gw4kGr48CrZxAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRA2-n7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gMhF1uwMNQCLAAAsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tegra30_clock_init, of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
the node pointer is not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 drivers/clk/tegra/clk-tegra30.c | 1 +
 1 file changed, 1 insertion(+)

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

