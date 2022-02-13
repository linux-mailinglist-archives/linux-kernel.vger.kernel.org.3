Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705BF4B3D4C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiBMUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:13:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbiBMUNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:13:10 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5611532DE;
        Sun, 13 Feb 2022 12:12:59 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCpoH123615;
        Sun, 13 Feb 2022 14:12:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644783171;
        bh=QUgtMxF0n5onBV3IW94Ab7+3PnJF6Yddzd42KgZ6mtE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kCpg9w09zb2X4KXzCLZJElHZ92/Xam/SM9JQjNsA6BVyl4Ka5CsKkFf//CwAlm3EJ
         TaOGMbj3BWlZaFtzfTcsD3/iHICmu/7ZZJAb+ujl+Jhvkef9GNnuZNsj/TMUggv8T1
         gZoHhCUHMvOZaENehHgu6dDFBntE5LFoZETDwhfI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21DKCprF112367
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Feb 2022 14:12:51 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 13
 Feb 2022 14:12:49 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 13 Feb 2022 14:12:49 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCnWQ020625;
        Sun, 13 Feb 2022 14:12:49 -0600
Received: from localhost ([10.249.37.221])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 21DKCnmY002421;
        Sun, 13 Feb 2022 14:12:49 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Hari Nagalla <hnagalla@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 4/5] remoteproc: k3-dsp: Refactor mbox request code in start
Date:   Sun, 13 Feb 2022 14:12:45 -0600
Message-ID: <20220213201246.25952-5-s-anna@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220213201246.25952-1-s-anna@ti.com>
References: <20220213201246.25952-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor out the mailbox request and associated ping logic code
from k3_dsp_rproc_start() function into its own separate function
so that it can be re-used in the soon to be added .attach() ops
callback.

Signed-off-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v3: Updated license years, no code changes
v2: https://patchwork.kernel.org/project/linux-remoteproc/patch/20210723220248.6554-5-s-anna@ti.com/
v1: https://patchwork.kernel.org/project/linux-remoteproc/patch/20210522000309.26134-6-s-anna@ti.com/


 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 67 ++++++++++++++---------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 939c5d90b562..b3ee03da5569 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -2,7 +2,7 @@
 /*
  * TI K3 DSP Remote Processor(s) driver
  *
- * Copyright (C) 2018-2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
  *	Suman Anna <s-anna@ti.com>
  */
 
@@ -216,6 +216,43 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
 	return ret;
 }
 
+static int k3_dsp_rproc_request_mbox(struct rproc *rproc)
+{
+	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct mbox_client *client = &kproc->client;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	client->dev = dev;
+	client->tx_done = NULL;
+	client->rx_callback = k3_dsp_rproc_mbox_callback;
+	client->tx_block = false;
+	client->knows_txdone = false;
+
+	kproc->mbox = mbox_request_channel(client, 0);
+	if (IS_ERR(kproc->mbox)) {
+		ret = -EBUSY;
+		dev_err(dev, "mbox_request_channel failed: %ld\n",
+			PTR_ERR(kproc->mbox));
+		return ret;
+	}
+
+	/*
+	 * Ping the remote processor, this is only for sanity-sake for now;
+	 * there is no functional effect whatsoever.
+	 *
+	 * Note that the reply will _not_ arrive immediately: this message
+	 * will wait in the mailbox fifo until the remote processor is booted.
+	 */
+	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_ECHO_REQUEST);
+	if (ret < 0) {
+		dev_err(dev, "mbox_send_message failed: %d\n", ret);
+		mbox_free_channel(kproc->mbox);
+		return ret;
+	}
+
+	return 0;
+}
 /*
  * The C66x DSP cores have a local reset that affects only the CPU, and a
  * generic module reset that powers on the device and allows the DSP internal
@@ -273,37 +310,13 @@ static int k3_dsp_rproc_unprepare(struct rproc *rproc)
 static int k3_dsp_rproc_start(struct rproc *rproc)
 {
 	struct k3_dsp_rproc *kproc = rproc->priv;
-	struct mbox_client *client = &kproc->client;
 	struct device *dev = kproc->dev;
 	u32 boot_addr;
 	int ret;
 
-	client->dev = dev;
-	client->tx_done = NULL;
-	client->rx_callback = k3_dsp_rproc_mbox_callback;
-	client->tx_block = false;
-	client->knows_txdone = false;
-
-	kproc->mbox = mbox_request_channel(client, 0);
-	if (IS_ERR(kproc->mbox)) {
-		ret = -EBUSY;
-		dev_err(dev, "mbox_request_channel failed: %ld\n",
-			PTR_ERR(kproc->mbox));
+	ret = k3_dsp_rproc_request_mbox(rproc);
+	if (ret)
 		return ret;
-	}
-
-	/*
-	 * Ping the remote processor, this is only for sanity-sake for now;
-	 * there is no functional effect whatsoever.
-	 *
-	 * Note that the reply will _not_ arrive immediately: this message
-	 * will wait in the mailbox fifo until the remote processor is booted.
-	 */
-	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_ECHO_REQUEST);
-	if (ret < 0) {
-		dev_err(dev, "mbox_send_message failed: %d\n", ret);
-		goto put_mbox;
-	}
 
 	boot_addr = rproc->bootaddr;
 	if (boot_addr & (kproc->data->boot_align_addr - 1)) {
-- 
2.32.0

