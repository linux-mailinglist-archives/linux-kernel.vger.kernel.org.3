Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB5517C0D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiECCvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiECCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:51:17 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C330135864;
        Mon,  2 May 2022 19:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bLBOG
        DgcmNltK6UF/fMVaVtqnF7C3zMmNOYidlKN9Rk=; b=B1e2Fxc1Zm6MuCdZqEX8F
        BZFFiFweM51pGDkYTn3vN4Vc62+vzBSRGoMBotMOuhkMtZvUBucXTkbfcz/ADnSU
        w5nvXLIkUNS0s+aB6UIkl6GrEHZalttD+mFF7cIm99k8XWzHPpVl0bztNoALaGms
        TRwAE/dMvSD/gtY9TBT4Jo=
Received: from localhost.localdomain (unknown [112.97.63.58])
        by smtp5 (Coremail) with SMTP id HdxpCgBX2zgil3BiSChTAg--.9943S2;
        Tue, 03 May 2022 10:44:52 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com
Cc:     gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        slark_xiao@163.com, bbhatt@codeaurora.org,
        christophe.jaillet@wanadoo.fr, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] bus: mhi: host: Add support for Foxconn T99W373 and T99W368
Date:   Tue,  3 May 2022 10:43:49 +0800
Message-Id: <20220503024349.4486-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgBX2zgil3BiSChTAg--.9943S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4DWr1ftF4kWF1DKr4xXrb_yoW8Cr4xpF
        4SvrWjyFWkJF45t3ykA39ruas5uan3Ary3KF1xGw1a9w4qy3yYqrn2gw129FyYv398XFW3
        tFyDWFyag3WDKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_WlydUUUUU=
X-Originating-IP: [112.97.63.58]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAwb1ZGB0KLK3cgAAsf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Product's enumeration align with previous Foxconn
SDX55, so T99W373(SDX62)/T99W368(SDX65) would use
 the same config as Foxconn SDX55.
Remove fw and edl for this new commit.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/bus/mhi/host/pci_generic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 24c94c23d78b..6fbc5915ea36 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -371,6 +371,15 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
 	.sideband_wake = false,
 };
 
+static const struct mhi_pci_dev_info mhi_foxconn_sdx65_info = {
+	.name = "foxconn-sdx65",
+	.config = &modem_foxconn_sdx55_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
 static const struct mhi_channel_config mhi_mv3x_channels[] = {
 	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 64, 0),
 	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 64, 0),
@@ -560,6 +569,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* T99W175 (sdx55), Based on Qualcomm new baseline */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0bf),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+	/* T99W368 (sdx65) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d8),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
+	/* T99W373 (sdx62) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d9),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
 	/* MV31-W (Cinterion) */
 	{ PCI_DEVICE(0x1269, 0x00b3),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
-- 
2.25.1

