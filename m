Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70146487347
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiAGHE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:04:28 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:44376 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229560AbiAGHE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:04:27 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowABHKBXl5ddh41_HBQ--.14041S2;
        Fri, 07 Jan 2022 15:04:05 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     damien.lemoal@opensource.wdc.com, davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] ide: Check for null pointer after calling devm_ioremap
Date:   Fri,  7 Jan 2022 15:04:04 +0800
Message-Id: <20220107070404.3611861-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHKBXl5ddh41_HBQ--.14041S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4UtF4xKryxJF1xGFyUKFg_yoWkJrg_Aa
        1ruFZxWw4rAr1ktF17tr13uryFv34q9rZ7urnxtwsIq3sxXr17JryUurs8Ja18WFyI9r9F
        yFyDKw4fu343ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8CwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUh4SOUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the devres_alloc(), the devm_ioremap() and
devm_ioport_map() may return NULL pointer.
And then, the 'base' and 'alt_base' is used in plat_ide_setup_ports().
Therefore, it should be better to add the check in order to avoid the
dereference of the NULL pointer.

Fixes: 2bfba3c444fe ("ide: remove useless subdirs from drivers/ide/")
Cc: 5.10
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog

v1 -> v2

* Change 1. Add cc.
---
 drivers/ide/ide_platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
index 91639fd6c276..8c6e1af7b6eb 100644
--- a/drivers/ide/ide_platform.c
+++ b/drivers/ide/ide_platform.c
@@ -85,6 +85,10 @@ static int plat_ide_probe(struct platform_device *pdev)
 		alt_base = devm_ioport_map(&pdev->dev,
 			res_alt->start, resource_size(res_alt));
 	}
+	if (!base || !alt_base) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	memset(&hw, 0, sizeof(hw));
 	plat_ide_setup_ports(&hw, base, alt_base, pdata, res_irq->start);
-- 
2.25.1

