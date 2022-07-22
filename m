Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8D757D894
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiGVCZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiGVCZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:25:39 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB7820F40;
        Thu, 21 Jul 2022 19:25:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.12.77.33])
        by mail-app4 (Coremail) with SMTP id cS_KCgDn6Mx_CtpiRg0IAQ--.0S4;
        Fri, 22 Jul 2022 10:25:03 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     dongchun.zhu@mediatek.com, zhengsq@rock-chips.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v0] media: i2c: fix the erroneous pointer initializer
Date:   Fri, 22 Jul 2022 10:24:59 +0800
Message-Id: <20220722022459.5030-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgDn6Mx_CtpiRg0IAQ--.0S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4rtw47GF1UtrykurW8tFb_yoW8ZFy5pF
        ZrX34akryYgr4jqF17J3yUuFyYga1xJFy8KFW3uw15ZFWUCryIvryftF4Yyr1kGrWDKa4I
        qw1rtrW3Aa1xAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are obvious errors for the initializer of ov02a10_i2c_driver,
ov2682_i2c_driver, and ov5695_i2c_driver as the code intended to assign
"address of function pointer" to function pointer. This patch fixes them
by removing redundant & operators.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/media/i2c/ov02a10.c | 4 ++--
 drivers/media/i2c/ov2685.c  | 4 ++--
 drivers/media/i2c/ov5695.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov02a10.c b/drivers/media/i2c/ov02a10.c
index 0f08c05333ea..5d205454ca4e 100644
--- a/drivers/media/i2c/ov02a10.c
+++ b/drivers/media/i2c/ov02a10.c
@@ -1004,8 +1004,8 @@ static struct i2c_driver ov02a10_i2c_driver = {
 		.pm = &ov02a10_pm_ops,
 		.of_match_table = ov02a10_of_match,
 	},
-	.probe_new	= &ov02a10_probe,
-	.remove		= &ov02a10_remove,
+	.probe_new	= ov02a10_probe,
+	.remove		= ov02a10_remove,
 };
 module_i2c_driver(ov02a10_i2c_driver);
 
diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index b6e010ea3249..4b9f4f3a0194 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -832,8 +832,8 @@ static struct i2c_driver ov2685_i2c_driver = {
 		.pm = &ov2685_pm_ops,
 		.of_match_table = of_match_ptr(ov2685_of_match),
 	},
-	.probe		= &ov2685_probe,
-	.remove		= &ov2685_remove,
+	.probe		= ov2685_probe,
+	.remove		= ov2685_remove,
 };
 
 module_i2c_driver(ov2685_i2c_driver);
diff --git a/drivers/media/i2c/ov5695.c b/drivers/media/i2c/ov5695.c
index 910309783885..59da66f4f810 100644
--- a/drivers/media/i2c/ov5695.c
+++ b/drivers/media/i2c/ov5695.c
@@ -1395,8 +1395,8 @@ static struct i2c_driver ov5695_i2c_driver = {
 		.pm = &ov5695_pm_ops,
 		.of_match_table = of_match_ptr(ov5695_of_match),
 	},
-	.probe		= &ov5695_probe,
-	.remove		= &ov5695_remove,
+	.probe		= ov5695_probe,
+	.remove		= ov5695_remove,
 };
 
 module_i2c_driver(ov5695_i2c_driver);
-- 
2.36.1

