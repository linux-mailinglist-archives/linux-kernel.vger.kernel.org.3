Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C352C478540
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhLQGmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:42:03 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:49186 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230405AbhLQGmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:42:02 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowABnb58lMbxhlIi_Aw--.37365S2;
        Fri, 17 Dec 2021 14:41:43 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] isoc: mediatek: potential use of error pointer
Date:   Fri, 17 Dec 2021 14:41:40 +0800
Message-Id: <20211217064140.517160-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABnb58lMbxhlIi_Aw--.37365S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4kWrW7XrWxtF1xWFW3Jrb_yoW8WrWfpF
        1ktay2yrWrJrZrWr4vkr4DuF4ag34IyasrK34Y9w1Fy3s8Jrn5XFyrAa4jyFWkAFykK3W3
        tr4jqrWxCF1UZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8AwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjHUDJUUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of devm_clk_get() needs to be checked.
To avoid use of error pointer in case of the failure of alloc.

Fixes: 6078c651947a ("soc: mediatek: Refine scpsys to support multiple platform")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/soc/mediatek/mtk-scpsys.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index ca75b14931ec..778d6ffc42b8 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -411,12 +411,16 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	return ret;
 }
 
-static void init_clks(struct platform_device *pdev, struct clk **clk)
+static int init_clks(struct platform_device *pdev, struct clk **clk)
 {
 	int i;
 
-	for (i = CLK_NONE + 1; i < CLK_MAX; i++)
+	for (i = CLK_NONE + 1; i < CLK_MAX; i++) {
 		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
+		if (!clk[i])
+			return -ENOMEM;
+	}
+	return 0;
 }
 
 static struct scp *init_scp(struct platform_device *pdev,
@@ -426,7 +430,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 {
 	struct genpd_onecell_data *pd_data;
 	struct resource *res;
-	int i, j;
+	int i, j, ret;
 	struct scp *scp;
 	struct clk *clk[CLK_MAX];
 
@@ -481,7 +485,9 @@ static struct scp *init_scp(struct platform_device *pdev,
 
 	pd_data->num_domains = num;
 
-	init_clks(pdev, clk);
+	ret = init_clks(pdev, clk);
+	if (ret)
+		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < num; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
-- 
2.25.1

