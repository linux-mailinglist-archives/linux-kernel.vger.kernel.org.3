Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2184484400
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiADO7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:59:25 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:36374 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231989AbiADO7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:59:25 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowADHz5+vYNRhFHfGBQ--.33414S2;
        Tue, 04 Jan 2022 22:58:55 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     miquel.raynal@bootlin.com
Cc:     kyungmin.park@samsung.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] mtd: onenand: Check for error irq
Date:   Tue,  4 Jan 2022 22:58:54 +0800
Message-Id: <20220104145854.1987853-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHz5+vYNRhFHfGBQ--.33414S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr13tw18Gr4UWrWUGF15urg_yoWkArc_CF
        sa9FyxGrW0yr97u3Zxtw1fAr92kF4DWr1DZa90qrsIq345tFyFq3yDuF15ur17u34UKFy5
        Cry5X3yxAw13JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5XwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUO4E_DUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it is possible that there is no suitable irq, platform_get_irq()
will return error number.
Therefore, it might be better to check it and return error if fails
to guarantee the success of the probe.

Fixes: 26777d37216c ("mtd: Move onenand code base to drivers/mtd/nand/onenand")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2

* Change 1. Change the commit message.
---
 drivers/mtd/nand/onenand/generic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/onenand/generic.c b/drivers/mtd/nand/onenand/generic.c
index 8b6f4da5d720..a4b8b65fe15f 100644
--- a/drivers/mtd/nand/onenand/generic.c
+++ b/drivers/mtd/nand/onenand/generic.c
@@ -53,7 +53,12 @@ static int generic_onenand_probe(struct platform_device *pdev)
 	}
 
 	info->onenand.mmcontrol = pdata ? pdata->mmcontrol : NULL;
-	info->onenand.irq = platform_get_irq(pdev, 0);
+
+	err = platform_get_irq(pdev, 0);
+	if (err < 0)
+		goto out_iounmap;
+
+	info->onenand.irq = err;
 
 	info->mtd.dev.parent = &pdev->dev;
 	info->mtd.priv = &info->onenand;
-- 
2.25.1

