Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0853F567
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 06:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiFGE5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 00:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiFGE5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:57:22 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD14D305;
        Mon,  6 Jun 2022 21:57:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2574v7O9026512;
        Mon, 6 Jun 2022 23:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654577827;
        bh=Cdif7KJdXOI98yjbTpb3S7eZDYdMM1OYv04stK4sVrU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iI2Rc4xhelfcpTnSIXQp5+UOJy0nPmtnGyDlyw0nVemyv9CnammsXK8Dn3XpCLjiR
         Gs4Vo8T5WRf2hBciLgV2ouSf/pFcNXokDGtZLYB1tt2iOQNexfGlwZv795f3C1P7Ds
         MIEhqYvNFRQjkOd2VCGhf4hYsRX/Re1K4W9Q68OA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2574v7rR030522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jun 2022 23:57:07 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Jun 2022 23:57:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Jun 2022 23:57:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2574v6Ll111771;
        Mon, 6 Jun 2022 23:57:06 -0500
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <p-mohan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <rogerq@kernel.org>, <grygorii.strashko@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <robh@kernel.org>
Subject: [PATCH v5 6/6] remoteproc: pru: add support for configuring GPMUX based on client setup
Date:   Tue, 7 Jun 2022 10:26:50 +0530
Message-ID: <20220607045650.4999-7-p-mohan@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220607045650.4999-1-p-mohan@ti.com>
References: <20220607045650.4999-1-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Client device node property ti,pruss-gp-mux-sel can now be used to
configure the GPMUX config value for PRU.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[s-anna@ti.com: simplify the pru id usage]
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
---
V4->v5
* This patch was included in v4 and had some checkpatch errors that have
  been resolved in v5
---
 drivers/remoteproc/pru_rproc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 2977eb50631b..f2c6c55f0f20 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -123,6 +123,7 @@ struct pru_private_data {
  * @dbg_single_step: debug state variable to set PRU into single step mode
  * @dbg_continuous: debug state variable to restore PRU execution mode
  * @evt_count: number of mapped events
+ * @gpmux_save: saved value for gpmux config
  */
 struct pru_rproc {
 	int id;
@@ -141,6 +142,7 @@ struct pru_rproc {
 	u32 dbg_single_step;
 	u32 dbg_continuous;
 	u8 evt_count;
+	u8 gpmux_save;
 };
 
 static inline u32 pru_control_read_reg(struct pru_rproc *pru, unsigned int reg)
@@ -250,6 +252,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 	struct device *dev;
 	const char *fw_name;
 	int ret;
+	u32 mux;
 
 	try_module_get(THIS_MODULE);
 
@@ -273,6 +276,22 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 
 	mutex_unlock(&pru->lock);
 
+	ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
+	if (ret) {
+		dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
+		goto err;
+	}
+
+	ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
+					 &mux);
+	if (!ret) {
+		ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
+		if (ret) {
+			dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
+			goto err;
+		}
+	}
+
 	if (pru_id)
 		*pru_id = pru->id;
 
@@ -310,6 +329,7 @@ void pru_rproc_put(struct rproc *rproc)
 
 	pru = rproc->priv;
 
+	pruss_cfg_set_gpmux(pru->pruss, pru->id, pru->gpmux_save);
 	pru_rproc_set_firmware(rproc, NULL);
 
 	mutex_lock(&pru->lock);
-- 
2.17.1

