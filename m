Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F394B3D71
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiBMUdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:33:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBMUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:33:01 -0500
X-Greylist: delayed 1196 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 12:32:55 PST
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BE953700;
        Sun, 13 Feb 2022 12:32:55 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCnMN106250;
        Sun, 13 Feb 2022 14:12:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644783169;
        bh=VlsO5Co1YhSU4oiDDo1I0Cx/Bw8CNI0Q8dDUb0hAK2I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NawsxXxR6eIs7TMKija8kqcc++qcaNWEq8iHOncWMtPphMzxSPm00wLL5k5HwAkJZ
         x6V/xlwE0pACnm8G2773C+3nVWmr7lV5f65AgRpaj9t00bpjBkgdvMmSC+6QRExXFI
         zB/3uV49CYeEdTPY5k9NSqZf/mTZevmelqps/94s=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21DKCnPd065490
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Feb 2022 14:12:49 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 13
 Feb 2022 14:12:49 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 13 Feb 2022 14:12:49 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCnsU020622;
        Sun, 13 Feb 2022 14:12:49 -0600
Received: from localhost ([10.249.37.221])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 21DKCnFd002415;
        Sun, 13 Feb 2022 14:12:49 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Hari Nagalla <hnagalla@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 2/5] remoteproc: k3-r5: Refactor mbox request code in start
Date:   Sun, 13 Feb 2022 14:12:43 -0600
Message-ID: <20220213201246.25952-3-s-anna@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220213201246.25952-1-s-anna@ti.com>
References: <20220213201246.25952-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor out the mailbox request and associated ping logic code
from k3_r5_rproc_start() function into its own separate function
so that it can be re-used in the soon to be added .attach() ops
callback.

Signed-off-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v3: Updated license years, no code changes
v2: https://patchwork.kernel.org/project/linux-remoteproc/patch/20210723220248.6554-3-s-anna@ti.com/
v1: https://patchwork.kernel.org/project/linux-remoteproc/patch/20210522000309.26134-4-s-anna@ti.com/

 drivers/remoteproc/ti_k3_r5_remoteproc.c | 68 ++++++++++++++----------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 969531c05b13..ff4e1fac1c7f 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -2,7 +2,7 @@
 /*
  * TI K3 R5F (MCU) Remote Processor driver
  *
- * Copyright (C) 2017-2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2017-2022 Texas Instruments Incorporated - https://www.ti.com/
  *	Suman Anna <s-anna@ti.com>
  */
 
@@ -376,6 +376,44 @@ static inline int k3_r5_core_run(struct k3_r5_core *core)
 				       0, PROC_BOOT_CTRL_FLAG_R5_CORE_HALT);
 }
 
+static int k3_r5_rproc_request_mbox(struct rproc *rproc)
+{
+	struct k3_r5_rproc *kproc = rproc->priv;
+	struct mbox_client *client = &kproc->client;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	client->dev = dev;
+	client->tx_done = NULL;
+	client->rx_callback = k3_r5_rproc_mbox_callback;
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
+
 /*
  * The R5F cores have controls for both a reset and a halt/run. The code
  * execution from DDR requires the initial boot-strapping code to be run
@@ -495,38 +533,14 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 {
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
-	struct mbox_client *client = &kproc->client;
 	struct device *dev = kproc->dev;
 	struct k3_r5_core *core;
 	u32 boot_addr;
 	int ret;
 
-	client->dev = dev;
-	client->tx_done = NULL;
-	client->rx_callback = k3_r5_rproc_mbox_callback;
-	client->tx_block = false;
-	client->knows_txdone = false;
-
-	kproc->mbox = mbox_request_channel(client, 0);
-	if (IS_ERR(kproc->mbox)) {
-		ret = -EBUSY;
-		dev_err(dev, "mbox_request_channel failed: %ld\n",
-			PTR_ERR(kproc->mbox));
+	ret = k3_r5_rproc_request_mbox(rproc);
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
 	/* TODO: add boot_addr sanity checking */
-- 
2.32.0

