Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B353C9E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbiFCMQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiFCMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:15:49 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805FC39826;
        Fri,  3 Jun 2022 05:15:48 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 253CFaNC078403;
        Fri, 3 Jun 2022 07:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654258536;
        bh=RUZPQ+k/CYQH8PVfKXR4X3F5fhUjffskd1cfh1MzVPE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mn81pSs2Fv/sYgGMQm3MtKYsg/rEcAMR2B/hEFHcBb5ft9AVcfsjSIWa+VBo2fk30
         stOKiGzocXa9OTpB+tOZdiKt1K7GM4ZkL6c1MtuQCkbtiDxZsZl5eYER3rRkdZW1wx
         YSJIV5sBmBjQdkxlwfqmmh2algmroMLRSrARlmmw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 253CFall113689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jun 2022 07:15:36 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Jun 2022 07:15:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Jun 2022 07:15:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 253CFYvT129114;
        Fri, 3 Jun 2022 07:15:35 -0500
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <p-mohan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <rogerq@kernel.org>, <grygorii.strashko@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <robh@kernel.org>
Subject: [PATCH v4 6/6] remoteproc: pru: add support for configuring GPMUX based on client setup
Date:   Fri, 3 Jun 2022 17:45:20 +0530
Message-ID: <20220603121520.13730-7-p-mohan@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603121520.13730-1-p-mohan@ti.com>
References: <20220603121520.13730-1-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/remoteproc/pru_rproc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 2977eb50631b..b532069fe259 100644
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
+        if (ret) {
+                dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
+                goto err;
+        }
+
+        ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
+                                         &mux);
+        if (!ret) {
+                ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
+                if (ret) {
+                        dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
+                        goto err;
+                }
+        }
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

