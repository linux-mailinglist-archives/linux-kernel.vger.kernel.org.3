Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5624CA60A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiCBNbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiCBNbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:31:41 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 90AC9BA76B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=iMaVXwk3iG
        rh60WLRmIvGc+VdwFYNW0mHH3SCrZ7WO8=; b=v/G8PjMjWUihvkpKtwrOY3Yq7k
        Xmd9dva8SrKjgb4bH0MCUdvRzJ2tbak1EKdW0fWs3sFcGiiKaOOc5H7g4Zq+hL2y
        3AJv2Lg+QdwDSwIZ/ofJzc9MZdAi41RDdS7heG60XJKxoDs0mc9NBDeCDQOas7Cq
        sRWTbqtBXQNju7Ce4=
Received: from localhost.localdomain (unknown [10.102.225.84])
        by app1 (Coremail) with SMTP id XAUFCgCnvMBWcR9iqJhcCg--.35820S4;
        Wed, 02 Mar 2022 21:30:03 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH v3] mtd: rawnand: atmel: fix refcount issue in atmel_nand_controller_init
Date:   Wed,  2 Mar 2022 21:27:59 +0800
Message-Id: <20220302132758.3820-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XAUFCgCnvMBWcR9iqJhcCg--.35820S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47ZF4DGrW7uF4rZw47urg_yoW8trykpF
        WUJFW3ZFWUtFs3ZF12kayxuF1rZ3WkJFyUG3yqqa4xZ3ZxXa4jkryYqr10vFyUCFyfuF17
        ZF47t3W8CF1UGFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOrcfUUUUU
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiAQ4NEFKp48tIbgAAsn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference counting issue happens in several error handling paths
on a refcounted object "nc->dmac". In these paths, the function simply
returns the error code, forgetting to balance the reference count of
"nc->dmac", increased earlier by dma_request_channel(), which may
cause refcount leaks.

Fix it by decrementing the refcount of specific object in those error
paths.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Co-developed-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Co-developed-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
---
V2 -> V3: Removed redundant lines
V1 -> V2: Rewrited the error handling block
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index f3276ee9e4fe..3dc4a4bacde5 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2060,13 +2060,15 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 	nc->mck = of_clk_get(dev->parent->of_node, 0);
 	if (IS_ERR(nc->mck)) {
 		dev_err(dev, "Failed to retrieve MCK clk\n");
-		return PTR_ERR(nc->mck);
+		ret = PTR_ERR(nc->mck);
+		goto out_release_dma;
 	}
 
 	np = of_parse_phandle(dev->parent->of_node, "atmel,smc", 0);
 	if (!np) {
 		dev_err(dev, "Missing or invalid atmel,smc property\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_release_dma;
 	}
 
 	nc->smc = syscon_node_to_regmap(np);
@@ -2074,10 +2076,16 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 	if (IS_ERR(nc->smc)) {
 		ret = PTR_ERR(nc->smc);
 		dev_err(dev, "Could not get SMC regmap (err = %d)\n", ret);
-		return ret;
+		goto out_release_dma;
 	}
 
 	return 0;
+
+out_release_dma:
+	if (nc->caps->has_dma && !atmel_nand_avoid_dma && nc->dmac)
+		dma_release_channel(nc->dmac);
+
+	return ret;
 }
 
 static int
-- 
2.25.1

