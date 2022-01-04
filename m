Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4753F4845F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiADQ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:27:30 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:32966 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233569AbiADQ12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:27:28 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowABHTVlTddRhwvQaBQ--.14235S2;
        Wed, 05 Jan 2022 00:26:59 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     miquel.raynal@bootlin.com
Cc:     kyungmin.park@samsung.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v3] mtd: onenand: Check for error irq
Date:   Wed,  5 Jan 2022 00:26:58 +0800
Message-Id: <20220104162658.1988142-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHTVlTddRhwvQaBQ--.14235S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1DAryDArWrCF4ktw1fWFg_yoW8GryxpF
        s2kay3Crs5Kr1rCFZFyw1qvF15C3WxKrWUtFn0vry8A3s8Jw13ur95JFW2qFWUAFWrJw13
        XF4YqFZ5CF1DuFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
        4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWUMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUeGQDUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the possible failure of the platform_get_irq(), the returned irq
could be error number and will finally cause the failure of the
request_irq().
Consider that platform_get_irq() can now in certain cases return
-EPROBE_DEFER, and the consequences of letting request_irq() effectively
convert that into -EINVAL, even at probe time rather than later on.
So it might be better to check just now.

Fixes: 2c22120fbd01 ("MTD: OneNAND: interrupt based wait support")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
v3: Roll back to v1 commit message and correct the fixes tag.
v2: Change the commit message.
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

