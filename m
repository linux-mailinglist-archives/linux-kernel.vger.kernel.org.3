Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455B7509C30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387584AbiDUJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387575AbiDUJZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:25:22 -0400
X-Greylist: delayed 82401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Apr 2022 02:22:32 PDT
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 630DA27145;
        Thu, 21 Apr 2022 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aiyjT
        wKr2WrCCCy47eXa+PFgD09doEJV9YGfIs9RReM=; b=FR9+Ia5Ppk1WIAJQ/fowA
        eRvsqxGkQG/YHAF5CPfIfJzyYTZr1oaWNEgnDICUIcoMY64t3fWFTEL0EedR5iBO
        aEQqefVxoZNgj1WialM4M2fgdbLjf74R2gOXZy5xuaTthqEh0CD8lEszEKJC0c3q
        1Myz0iYIUprxsuSIHGc+Xw=
Received: from localhost.localdomain (unknown [112.97.55.38])
        by smtp1 (Coremail) with SMTP id GdxpCgBnYN8yImFiFnrxCA--.411S2;
        Thu, 21 Apr 2022 17:22:00 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, hemantk@codeaurora.org
Cc:     gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        slark_xiao@163.com, bbhatt@codeaurora.org,
        christophe.jaillet@wanadoo.fr, thomas.ulrich@thalesgroup.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] bus: mhi: host: Add support for Cinterion MV32-WA/MV32-WB
Date:   Thu, 21 Apr 2022 17:21:41 +0800
Message-Id: <20220421092141.3984-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgBnYN8yImFiFnrxCA--.411S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw48JrWDCr1kAF17tr1xGrg_yoW5Aw4DpF
        WxZrWayF48tFWaqa1vka4v9as8Gws7G3s8KrnrK3W2ywn8C34DXF1kG34SyF1Yy397Xrsr
        tr4FqFW7W3WDtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEYL9DUUUUU=
X-Originating-IP: [112.97.55.38]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDRjpZFaEIUY8WQAAsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MV32-WA is designed based on Qualcomm SDX62, and
MV32-WB is designed based on QUalcomm SDX65. Both
products' enumeration would align with previous
product MV31-W.So we merge MV31 and MV32 to MV3X
for some common settings.

Fixes: 87693e092bd0 ("bus: mhi: pci_generic: Add Cinterion MV31-W PCIe to MHI")
Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/pci_generic.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 9527b7d63840..ef8c16746b76 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -371,7 +371,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
 	.sideband_wake = false,
 };
 
-static const struct mhi_channel_config mhi_mv31_channels[] = {
+static const struct mhi_channel_config mhi_mv3x_channels[] = {
 	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 64, 0),
 	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 64, 0),
 	/* MBIM Control Channel */
@@ -382,25 +382,33 @@ static const struct mhi_channel_config mhi_mv31_channels[] = {
 	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 512, 3),
 };
 
-static struct mhi_event_config mhi_mv31_events[] = {
+static struct mhi_event_config mhi_mv3x_events[] = {
 	MHI_EVENT_CONFIG_CTRL(0, 256),
 	MHI_EVENT_CONFIG_DATA(1, 256),
 	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
 	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101),
 };
 
-static const struct mhi_controller_config modem_mv31_config = {
+static const struct mhi_controller_config modem_mv3x_config = {
 	.max_channels = 128,
 	.timeout_ms = 20000,
-	.num_channels = ARRAY_SIZE(mhi_mv31_channels),
-	.ch_cfg = mhi_mv31_channels,
-	.num_events = ARRAY_SIZE(mhi_mv31_events),
-	.event_cfg = mhi_mv31_events,
+	.num_channels = ARRAY_SIZE(mhi_mv3x_channels),
+	.ch_cfg = mhi_mv3x_channels,
+	.num_events = ARRAY_SIZE(mhi_mv3x_events),
+	.event_cfg = mhi_mv3x_events,
 };
 
 static const struct mhi_pci_dev_info mhi_mv31_info = {
 	.name = "cinterion-mv31",
-	.config = &modem_mv31_config,
+	.config = &modem_mv3x_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+};
+
+static const struct mhi_pci_dev_info mhi_mv32_info = {
+	.name = "cinterion-mv32",
+	.config = &modem_mv3x_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
 	.mru_default = 32768,
@@ -475,6 +483,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* MV31-W (Cinterion) */
 	{ PCI_DEVICE(0x1269, 0x00b3),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
+	/* MV32-WA (Cinterion) */
+	{ PCI_DEVICE(0x1269, 0x00ba),
+		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
+	/* MV32-WB (Cinterion) */
+	{ PCI_DEVICE(0x1269, 0x00bb),
+		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
 	{  }
 };
 MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
-- 
2.25.1

