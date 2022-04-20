Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBA50863C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377818AbiDTKsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378096AbiDTKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:48:12 -0400
X-Greylist: delayed 966 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 03:45:19 PDT
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1117313F66;
        Wed, 20 Apr 2022 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7ut0Q
        D0SeAhwHJ2wa4JZOw2v3iSr/i3NVuFHELZO3Hs=; b=iaitjDKGmArIa/RPsuIEE
        uEdtSERqqRtURhqUx7BHXlYyE0/CAP0PZ3lIF2Min+CujtsfLf9GLnqFDtArgVWa
        8eU9niGT+Dqr8RGBQ4uQK/Lg2k+mMzVFJs+TmUIim1CjoJV5TpOTYCqEOpkvpWS1
        mg+3vZYGicnICipA0AZcxY=
Received: from localhost.localdomain (unknown [112.97.59.179])
        by smtp4 (Coremail) with SMTP id HNxpCgDX9AlY4F9i69iSAA--.8118S2;
        Wed, 20 Apr 2022 18:28:42 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com
Cc:     gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        slark_xiao@163.com, bbhatt@codeaurora.org,
        christophe.jaillet@wanadoo.fr, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: mhi: host: Add support for Cinterion MV32-WA/MV32-WB
Date:   Wed, 20 Apr 2022 18:28:11 +0800
Message-Id: <20220420102811.3157-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDX9AlY4F9i69iSAA--.8118S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw48JF17ArW8KFyktr4xJFb_yoW5GFWDpF
        WIvrWYyF4vqayaqanay34qgF98Cw4kG343KrnrKw12ywn0y34kZFykK343tFyYvw4vqrs3
        tr1vqrW3uF4Dt3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zioGQfUUUUU=
X-Originating-IP: [112.97.59.179]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdRPoZGBbCtHDJAAAst
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
product MV31-W.
Add some new items for mv32 to separate it from
mv31-w, in case we need to do any changes in
future.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/pci_generic.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 541ced27d941..a2da40340df7 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -406,6 +406,41 @@ static const struct mhi_pci_dev_info mhi_mv31_info = {
 	.mru_default = 32768,
 };
 
+static const struct mhi_channel_config mhi_mv32_channels[] = {
+	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 64, 0),
+	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 64, 0),
+	/* MBIM Control Channel */
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 64, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 64, 0),
+	/* MBIM Data Channel */
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 512, 2),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 512, 3),
+};
+
+static struct mhi_event_config mhi_mv32_events[] = {
+	MHI_EVENT_CONFIG_CTRL(0, 256),
+	MHI_EVENT_CONFIG_DATA(1, 256),
+	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101),
+};
+
+static const struct mhi_controller_config modem_mv32_config = {
+	.max_channels = 128,
+	.timeout_ms = 20000,
+	.num_channels = ARRAY_SIZE(mhi_mv32_channels),
+	.ch_cfg = mhi_mv32_channels,
+	.num_events = ARRAY_SIZE(mhi_mv32_events),
+	.event_cfg = mhi_mv32_events,
+};
+
+static const struct mhi_pci_dev_info mhi_mv32_info = {
+	.name = "cinterion-mv32",
+	.config = &modem_mv32_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+};
+
 static const struct mhi_channel_config mhi_sierra_em919x_channels[] = {
 	MHI_CHANNEL_CONFIG_UL_SBL(2, "SAHARA", 32, 0),
 	MHI_CHANNEL_CONFIG_DL_SBL(3, "SAHARA", 256, 0),
@@ -475,6 +510,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
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

