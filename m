Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE96B562B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiGAGQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiGAGQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:16:35 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5466E248F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vqY49
        op8zSxUL8baAhR237zfSlqn0AZQ8crnI2RphPY=; b=khue8xj3bUnfjomZdu69H
        j+V6Rtoj2+OguDpU4LQb6MkzIkJUlUolscB7D51kA9D0w1e/ZkY9Vn3xAJIx22YR
        unEsQKtfEM4Np5CeATKcuMUx2kJphSQle0HnHTJXNenCgkFUwWcmO877gj4V6h6a
        UAyYS2vo9TO7YsPf+w5x38=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp14 (Coremail) with SMTP id EsCowACnrwcikb5i+c9YKg--.61416S2;
        Fri, 01 Jul 2022 14:16:08 +0800 (CST)
From:   huhai <15815827059@163.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        luriwen@kylinos.cn, liuyun01@kylinos.cn, huhai <huhai@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] firmware: arm_scpi: Fix error handle when scpi probe failed
Date:   Fri,  1 Jul 2022 14:16:06 +0800
Message-Id: <20220701061606.151366-1-15815827059@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACnrwcikb5i+c9YKg--.61416S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1UKr17KF4UJF47Cw13twb_yoWrKrW5pF
        y5Ja45KrW8Gr1fGryxAr15ZF4Yyw40ya17Wry7Gw1xA3WUAr98Xw1ftFWjg3W5JFW5ta47
        tr13XFy09F4Utw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSc_3UUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/xtbB3wgxhWBHKxOB-wAAsC
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huhai <huhai@kylinos.cn>

When scpi probe fails, do not just return the error code, but also reset
the global scpi_info to NULL, otherwise scpi_hwmon_probe() may get a UAF
and cause panic:

  scpi_protocol FTSC0001:00: incorrect or no SCP firmware found
  ... ...
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Mem abort info:
    ESR = 0x86000005
    Exception class = IABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
  user pgtable: 64k pages, 48-bit VAs, pgdp = (____ptrval____)
  [0000000000000000] pgd=0000000000000000, pud=0000000000000000
  Internal error: Oops: 86000005 [#1] SMP
  ... ...
  pc :           (null)
  lr : scpi_hwmon_probe+0x2c/0x4bc [scpi_hwmon]
  sp : ffff801fa13cfb20
  x29: ffff801fa13cfb20 x28: ffff00000931c1e8
  x27: ffff0000093b7318 x26: 000000000000000d
  x25: ffff801fa1174da8 x24: 0000000000000000
  x23: ffff801fa15e9000 x22: 0000000000000000
  x21: ffff0000012c0028 x20: ffff801fa15e9010
  x19: 0000000000000000 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000
  x15: 0000000000000400 x14: 0000000000000400
  x13: 0000000000000001 x12: 0000000000000018
  x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
  x9 : fefefefeff2f2f39 x8 : 7f7f7f7f7f7f7f7f
  x7 : 302f2f2f52525345 x6 : ffff801fa5771a8c
  x5 : 0000000000000000 x4 : 0000000000000000
  x3 : ffff801fa13bbc00 x2 : ffff000009360118
  x1 : 0000000000000000 x0 : ffff801fa13cfbbe
  Call trace:
             (null)
   platform_drv_probe+0x50/0xa0
   really_probe+0x240/0x420
   driver_probe_device+0x68/0x134
   __device_attach_driver+0xb8/0x130
   bus_for_each_drv+0x64/0xa0
   __device_attach+0xa8/0x194
   device_initial_probe+0x10/0x1c
   bus_probe_device+0x90/0xa0
   deferred_probe_work_func+0x90/0xe0
   process_one_work+0x1c0/0x390
   worker_thread+0x6c/0x384
   kthread+0xfc/0x12c
   ret_from_fork+0x10/0x18
  Code: bad PC value
  ---[ end trace b4b2f27a69b5712c ]---

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: huhai <huhai@kylinos.cn>
---
 drivers/firmware/arm_scpi.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index ddf0b9ff9e15..ad2355814bdf 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -924,17 +924,20 @@ static int scpi_probe(struct platform_device *pdev)
 	count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
 	if (count < 0) {
 		dev_err(dev, "no mboxes property in '%pOF'\n", np);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err;
 	}
 
 	scpi_info->channels = devm_kcalloc(dev, count, sizeof(struct scpi_chan),
 					   GFP_KERNEL);
-	if (!scpi_info->channels)
-		return -ENOMEM;
+	if (!scpi_info->channels) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	ret = devm_add_action(dev, scpi_free_channels, scpi_info);
 	if (ret)
-		return ret;
+		goto err;
 
 	for (; scpi_info->num_chans < count; scpi_info->num_chans++) {
 		resource_size_t size;
@@ -943,21 +946,24 @@ static int scpi_probe(struct platform_device *pdev)
 		struct mbox_client *cl = &pchan->cl;
 		struct device_node *shmem = of_parse_phandle(np, "shmem", idx);
 
-		if (!of_match_node(shmem_of_match, shmem))
-			return -ENXIO;
+		if (!of_match_node(shmem_of_match, shmem)) {
+			ret = -ENXIO;
+			goto err;
+		}
 
 		ret = of_address_to_resource(shmem, 0, &res);
 		of_node_put(shmem);
 		if (ret) {
 			dev_err(dev, "failed to get SCPI payload mem resource\n");
-			return ret;
+			goto err;
 		}
 
 		size = resource_size(&res);
 		pchan->rx_payload = devm_ioremap(dev, res.start, size);
 		if (!pchan->rx_payload) {
 			dev_err(dev, "failed to ioremap SCPI payload\n");
-			return -EADDRNOTAVAIL;
+			ret = -EADDRNOTAVAIL;
+			goto err;
 		}
 		pchan->tx_payload = pchan->rx_payload + (size >> 1);
 
@@ -983,7 +989,7 @@ static int scpi_probe(struct platform_device *pdev)
 				dev_err(dev, "failed to get channel%d err %d\n",
 					idx, ret);
 		}
-		return ret;
+		goto err;
 	}
 
 	scpi_info->commands = scpi_std_commands;
@@ -1004,7 +1010,7 @@ static int scpi_probe(struct platform_device *pdev)
 	ret = scpi_init_versions(scpi_info);
 	if (ret) {
 		dev_err(dev, "incorrect or no SCP firmware found\n");
-		return ret;
+		goto err;
 	}
 
 	if (scpi_info->is_legacy && !scpi_info->protocol_version &&
@@ -1024,7 +1030,15 @@ static int scpi_probe(struct platform_device *pdev)
 				   scpi_info->firmware_version));
 	scpi_info->scpi_ops = &scpi_ops;
 
-	return devm_of_platform_populate(dev);
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		goto err;
+
+	return ret;
+err:
+	/* stop exporting SCPI ops through get_scpi_ops */
+	scpi_info = NULL;
+	return ret;
 }
 
 static const struct of_device_id scpi_of_match[] = {
-- 
2.27.0

