Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E014B501BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbiDNT2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345449AbiDNT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:28:22 -0400
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B32E338E;
        Thu, 14 Apr 2022 12:25:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08355352|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0126115-0.000601172-0.986787;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.NQo2Nhh_1649964349;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NQo2Nhh_1649964349)
          by smtp.aliyun-inc.com(33.40.38.164);
          Fri, 15 Apr 2022 03:25:50 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        paul@crapouillou.net
Cc:     linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, hns@goldelico.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v3 2/3] USB: dwc2: Add OTG support for Ingenic SoCs.
Date:   Fri, 15 Apr 2022 03:25:36 +0800
Message-Id: <1649964337-114337-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649964337-114337-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1649964337-114337-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OTG support for the JZ4775 SoC, the JZ4780 SoC, the X1000 SoC,
the X1600 SoC, the X1700 SoC, the X1830 SoC, and the X2000 SoC
from Ingenic.

Introduce support for disable Ingenic overcurrent detection, once
selected, it enables the GOTGCTL register bits VbvalidOvEn and
VbvalidOvVal to disable the VBUS overcurrent detection.

This patch is derived from Dragan Čečavac (in the kernel 3.18.3
tree of CI20). It is very useful for the MIPS Creator CI20 (r1).
Without this patch, OTG port of CI20 has a great probability to
face overcurrent warning, which breaks the OTG functionality.

Signed-off-by: Dragan Čečavac <dragancecavac@yahoo.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---

Notes:
    v1->v2:
    1.Add Minas Harutyunyan's Acked-by.
    2.Use "activate_ingenic_overcurrent_detection" instead
      "deactivate_ingenic_overcurrent_detection" as Greg's
      suggestion.
    
    v2->v3:
    No change.

 drivers/usb/dwc2/core.c   |  9 +++++++++
 drivers/usb/dwc2/core.h   |  5 +++++
 drivers/usb/dwc2/params.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index cf0bcd0..dc4fc72 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -1153,6 +1153,7 @@ static void dwc2_set_turnaround_time(struct dwc2_hsotg *hsotg)
 int dwc2_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 {
 	u32 usbcfg;
+	u32 otgctl;
 	int retval = 0;
 
 	if ((hsotg->params.speed == DWC2_SPEED_PARAM_FULL ||
@@ -1187,6 +1188,14 @@ int dwc2_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 		dwc2_writel(hsotg, usbcfg, GUSBCFG);
 	}
 
+	if (!hsotg->params.activate_ingenic_overcurrent_detection) {
+		if (dwc2_is_host_mode(hsotg)) {
+			otgctl = readl(hsotg->regs + GOTGCTL);
+			otgctl |= GOTGCTL_VBVALOEN | GOTGCTL_VBVALOVAL;
+			writel(otgctl, hsotg->regs + GOTGCTL);
+		}
+	}
+
 	return retval;
 }
 
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 88c337b..0683852 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -426,6 +426,10 @@ enum dwc2_ep0_state {
  *			detection using GGPIO register.
  *			0 - Deactivate the external level detection (default)
  *			1 - Activate the external level detection
+ * @activate_ingenic_overcurrent_detection: Activate Ingenic overcurrent
+ *			detection.
+ *			0 - Deactivate the overcurrent detection
+ *			1 - Activate the overcurrent detection (default)
  * @g_dma:              Enables gadget dma usage (default: autodetect).
  * @g_dma_desc:         Enables gadget descriptor DMA (default: autodetect).
  * @g_rx_fifo_size:	The periodic rx fifo size for the device, in
@@ -494,6 +498,7 @@ struct dwc2_core_params {
 	u8 hird_threshold;
 	bool activate_stm_fs_transceiver;
 	bool activate_stm_id_vb_detection;
+	bool activate_ingenic_overcurrent_detection;
 	bool ipg_isoc_en;
 	u16 max_packet_count;
 	u32 max_transfer_size;
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 1306f4e..fdb8a42f 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -73,6 +73,47 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
 	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
+static void dwc2_set_jz4775_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->otg_caps.hnp_support = false;
+	p->speed = DWC2_SPEED_PARAM_HIGH;
+	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
+	p->phy_utmi_width = 16;
+	p->activate_ingenic_overcurrent_detection =
+		!device_property_read_bool(hsotg->dev, "disable-over-current");
+}
+
+static void dwc2_set_x1600_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->otg_caps.hnp_support = false;
+	p->speed = DWC2_SPEED_PARAM_HIGH;
+	p->host_channels = 16;
+	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
+	p->phy_utmi_width = 16;
+	p->activate_ingenic_overcurrent_detection =
+		!device_property_read_bool(hsotg->dev, "disable-over-current");
+}
+
+static void dwc2_set_x2000_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->otg_caps.hnp_support = false;
+	p->speed = DWC2_SPEED_PARAM_HIGH;
+	p->host_rx_fifo_size = 1024;
+	p->host_nperio_tx_fifo_size = 1024;
+	p->host_perio_tx_fifo_size = 1024;
+	p->host_channels = 16;
+	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
+	p->phy_utmi_width = 16;
+	p->activate_ingenic_overcurrent_detection =
+		!device_property_read_bool(hsotg->dev, "disable-over-current");
+}
+
 static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -221,7 +262,14 @@ static void dwc2_set_stm32mp15_hsotg_params(struct dwc2_hsotg *hsotg)
 
 const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "brcm,bcm2835-usb", .data = dwc2_set_bcm_params },
-	{ .compatible = "hisilicon,hi6220-usb", .data = dwc2_set_his_params  },
+	{ .compatible = "hisilicon,hi6220-usb", .data = dwc2_set_his_params },
+	{ .compatible = "ingenic,jz4775-otg", .data = dwc2_set_jz4775_params },
+	{ .compatible = "ingenic,jz4780-otg", .data = dwc2_set_jz4775_params },
+	{ .compatible = "ingenic,x1000-otg", .data = dwc2_set_jz4775_params },
+	{ .compatible = "ingenic,x1600-otg", .data = dwc2_set_x1600_params },
+	{ .compatible = "ingenic,x1700-otg", .data = dwc2_set_x1600_params },
+	{ .compatible = "ingenic,x1830-otg", .data = dwc2_set_x1600_params },
+	{ .compatible = "ingenic,x2000-otg", .data = dwc2_set_x2000_params },
 	{ .compatible = "rockchip,rk3066-usb", .data = dwc2_set_rk_params },
 	{ .compatible = "lantiq,arx100-usb", .data = dwc2_set_ltq_params },
 	{ .compatible = "lantiq,xrx200-usb", .data = dwc2_set_ltq_params },
-- 
2.7.4

