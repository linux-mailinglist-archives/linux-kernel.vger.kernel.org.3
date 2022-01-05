Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4A4485558
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiAEPDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241213AbiAEPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:02:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B90C0611FF;
        Wed,  5 Jan 2022 07:02:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 572F5B81BA6;
        Wed,  5 Jan 2022 15:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FF7C36AE9;
        Wed,  5 Jan 2022 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641394977;
        bh=ww7911UP3Fbvn/wTWNYU+t606JgfxRHZwCcarZxvnyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJtVffB5yuwmB3C5fBrCJVvMxTPsW0TdI4USgmOrOKNhw8pU/KeByEmg5JBLrvdVW
         qAbGFUstoysJOmG2ZQb5YD4247o9gBck7qoKj741GV7VxYPCtiIHqyfAiMB15Pg1Eg
         b0WZ1aOHxY/t5C6nzVc01hk5bRdzifU7zfc2AtRmW/w9OImbfzuuxMdmqM6DZvY8EO
         34zYJrE+k20FIwLNTf562k7EqQLK7HmhJMpz8STrw9syrmve+2Fc5yFD9WKsFOv1pU
         bTpgVWk0s2/8s7A775ZrOpRuS3iejXaZO/72DECS2vtsvqIZ4nvl09kLwaxPl7Gk7d
         fBoE+zXF/5V2A==
Received: by pali.im (Postfix)
        id AFEAF82A; Wed,  5 Jan 2022 16:02:56 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/11] PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID on emulated bridge
Date:   Wed,  5 Jan 2022 16:02:34 +0100
Message-Id: <20220105150239.9628-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220105150239.9628-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register with Subsystem Device/Vendor ID is at offset 0x2c. Export is via
emulated bridge.

After this change Subsystem ID is visible in lspci output at line:

  Capabilities: [40] Subsystem

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 0f2ec0a17874..811af9e6ede5 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -32,6 +32,7 @@
 #define PCIE_DEV_REV_OFF	0x0008
 #define PCIE_BAR_LO_OFF(n)	(0x0010 + ((n) << 3))
 #define PCIE_BAR_HI_OFF(n)	(0x0014 + ((n) << 3))
+#define PCIE_SSDEV_ID_OFF	0x002c
 #define PCIE_CAP_PCIEXP		0x0060
 #define PCIE_HEADER_LOG_4_OFF	0x0128
 #define PCIE_BAR_CTRL_OFF(n)	(0x1804 + (((n) - 1) * 4))
@@ -731,6 +732,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	struct pci_bridge_emul *bridge = &port->bridge;
 	u32 dev_id = mvebu_readl(port, PCIE_DEV_ID_OFF);
 	u32 dev_rev = mvebu_readl(port, PCIE_DEV_REV_OFF);
+	u32 ssdev_id = mvebu_readl(port, PCIE_SSDEV_ID_OFF);
 	u32 pcie_cap = mvebu_readl(port, PCIE_CAP_PCIEXP);
 	u8 pcie_cap_ver = ((pcie_cap >> 16) & PCI_EXP_FLAGS_VERS);
 
@@ -752,6 +754,8 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	 */
 	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver);
 
+	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
+	bridge->subsystem_id = ssdev_id >> 16;
 	bridge->has_pcie = true;
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
-- 
2.20.1

