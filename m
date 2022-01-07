Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7F48793A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347883AbiAGOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:49:18 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:60372 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347864AbiAGOtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:49:16 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowABnb5_VUthhJmv7BQ--.49088S2;
        Fri, 07 Jan 2022 22:48:53 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] tty/serial: Check for null pointer after calling devm_ioremap
Date:   Fri,  7 Jan 2022 22:48:52 +0800
Message-Id: <20220107144852.4081390-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABnb5_VUthhJmv7BQ--.49088S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4UZry8tw4UKr17Cr45Jrb_yoWkCrg_GF
        n5uan5Cw18CF4Fya17JryfZFWqq390vayxWrn2gr9Iq3sxAF4kXFZrWrn3Zw4UW3yqvFyU
        CrZruF47Zr1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry5MxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
        CI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUVxRhUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the devres_alloc(), the devm_ioremap()
may return NULL pointer.
And the 'port->membase' will be used in mlb_usio_startup() without the
check.
Therefore, in order to avoid the dereference of the NULL pointer, it
should be better to add the check to guarantee the success of the probe.

Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog

v1 -> v2

* Change 1. Refine the commit message to be more clear.
---
 drivers/tty/serial/milbeaut_usio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 8f2cab7f66ad..1ecbf6d0dc79 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -523,6 +523,10 @@ static int mlb_usio_probe(struct platform_device *pdev)
 	}
 	port->membase = devm_ioremap(&pdev->dev, res->start,
 				resource_size(res));
+	if (!port->membase) {
+		ret = -ENOMEM;
+		goto failed;
+	}
 
 	ret = platform_get_irq_byname(pdev, "rx");
 	mlb_usio_irq[index][RX] = ret;
-- 
2.25.1

