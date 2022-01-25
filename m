Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3EA49B457
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457563AbiAYMwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:52:25 -0500
Received: from azure-sdnproxy.icoremail.net ([52.237.72.81]:47427 "HELO
        azure-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1457418AbiAYMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:49:47 -0500
X-Greylist: delayed 9084 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 07:49:46 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=5DkymplUnV
        DC1/piM6/QMhUWW1mHUHUppZ58TGWb3dg=; b=bnrHS/FKJAFTn75dCaC+LA5d8J
        FNJ6UnDnZK6X9/o3TESX2usNuPAQNJNvsP+iqPsvBYADkhMo1EjgL2Qc67QA9Xzx
        iKMz+5VGecpvjkT1DIElhUkV9ffVa2TeSOLYlhq4QiqymunF2VRVtX2DhQIdPBo0
        3Upir0cb/Sk72ODe4=
Received: from localhost.localdomain (unknown [111.192.165.103])
        by app2 (Coremail) with SMTP id XQUFCgC3v_cr7u9hhAZlAA--.2538S4;
        Tue, 25 Jan 2022 20:34:00 +0800 (CST)
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] mtd: rawnand: atmel: fix refcount leaks in atmel_nand_controller_init
Date:   Tue, 25 Jan 2022 20:31:56 +0800
Message-Id: <20220125123155.36891-1-xiongx18@fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XQUFCgC3v_cr7u9hhAZlAA--.2538S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47ZF4xJrW3Xw4xCFWxJFb_yoW8ury5pF
        WUt3y3Zw4UtFsxZF9FgayxuFyFva4kJFyUJ39Iqa4kZ3ZxX3WUK345tr10qFyUCFWfuF13
        ZF47t3W8CF45AFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUepB-DUUUU
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/1tbiAg4REFKp2ii5hwABs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference counting issue happens in several error handling paths
on a refcounted object "nc->dmac". In these paths, the function simply
returns the error code, forgetting to balance the reference count
increased earlier by dma_request_channel(), which may cause refcount
leaks. What's more, the "nc->mck" object also needs to be handled
correctly.

Fix it by adding specific error handling code in those error paths.

Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 22 +++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index f3276ee9e..b3801ebd2 100644
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
+		goto out_put_clk;
 	}
 
 	nc->smc = syscon_node_to_regmap(np);
@@ -2074,10 +2076,24 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 	if (IS_ERR(nc->smc)) {
 		ret = PTR_ERR(nc->smc);
 		dev_err(dev, "Could not get SMC regmap (err = %d)\n", ret);
-		return ret;
+		goto out_put_clk;
 	}
 
 	return 0;
+
+out_put_clk:
+	clk_put(nc->mck);
+	nc->mck = NULL;
+
+out_release_dma:
+	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
+		if (!IS_ERR_OR_NULL(nc->dmac)) {
+			dma_release_channel(nc->dmac);
+			nc->dmac = NULL;
+		}
+	}
+
+	return ret;
 }
 
 static int
-- 
2.25.1

