Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A7D485555
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbiAEPDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbiAEPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:03:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A018C061245;
        Wed,  5 Jan 2022 07:03:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CA61B81BA1;
        Wed,  5 Jan 2022 15:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F829C36AF2;
        Wed,  5 Jan 2022 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641394978;
        bh=4a2QEuqFlCM2WvcWwQ3fpa2T4cvV+711ubbZ7fDLReU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWoP6z7TVUmJgVcaIqeK+2FY4DTHXP5gh9puemV+V1NXxpX36JlxRG52boPnH8ltX
         eDPNESwdph+zJpr+uIDE+TuY9AuWpqb2pIaxEym/oLX6BE53vCXDKtpMijVvz/GBHV
         mpWgdCx2wK15O6soeKxPRrjUBZ55yAvy4AG+0lH/wWjhb6Y/XgJrRZNE3yMh9g3PB6
         JmEe1t5hXTcXH1nvatKfoKfX9AeNyCNkm/Q/zyX+YpvX3ROXeauVUZK9yjyk5GMXi1
         KTQ++W2mfMtxLXJ6KH3JrTU0U7FfFIn1y6FcFI5Dq8Eoa9rwk3e8i+Z+nyKDfDC/qL
         cgys20JflE2Eg==
Received: by pali.im (Postfix)
        id 1856582A; Wed,  5 Jan 2022 16:02:58 +0100 (CET)
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
Subject: [PATCH 07/11] PCI: mvebu: Add support for Advanced Error Reporting registers on emulated bridge
Date:   Wed,  5 Jan 2022 16:02:35 +0100
Message-Id: <20220105150239.9628-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220105150239.9628-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AER registers start at mvebu offset 0x0100. Registers PCI_ERR_ROOT_COMMAND,
PCI_ERR_ROOT_STATUS and PCI_ERR_ROOT_ERR_SRC are not supported on pre-XP
hardware and returns zeros.

Note that AER interrupt is not supported yet as mvebu emulated bridge does
not implement interrupts support at all yet.

Also remove custom macro PCIE_HEADER_LOG_4_OFF as it is unused and
correctly this register should be referenced via standard macros with
offset, e.g. as: PCIE_CAP_PCIERR_OFF + PCI_ERR_HEADER_LOG + 4.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 67 +++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 811af9e6ede5..9ea2f6a7c2b0 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -34,7 +34,7 @@
 #define PCIE_BAR_HI_OFF(n)	(0x0014 + ((n) << 3))
 #define PCIE_SSDEV_ID_OFF	0x002c
 #define PCIE_CAP_PCIEXP		0x0060
-#define PCIE_HEADER_LOG_4_OFF	0x0128
+#define PCIE_CAP_PCIERR_OFF	0x0100
 #define PCIE_BAR_CTRL_OFF(n)	(0x1804 + (((n) - 1) * 4))
 #define PCIE_WIN04_CTRL_OFF(n)	(0x1820 + ((n) << 4))
 #define PCIE_WIN04_BASE_OFF(n)	(0x1824 + ((n) << 4))
@@ -603,6 +603,37 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	return PCI_BRIDGE_EMUL_HANDLED;
 }
 
+static pci_bridge_emul_read_status_t
+mvebu_pci_bridge_emul_ext_conf_read(struct pci_bridge_emul *bridge,
+				    int reg, u32 *value)
+{
+	struct mvebu_pcie_port *port = bridge->data;
+
+	switch (reg) {
+	case 0:
+	case PCI_ERR_UNCOR_STATUS:
+	case PCI_ERR_UNCOR_MASK:
+	case PCI_ERR_UNCOR_SEVER:
+	case PCI_ERR_COR_STATUS:
+	case PCI_ERR_COR_MASK:
+	case PCI_ERR_CAP:
+	case PCI_ERR_HEADER_LOG+0:
+	case PCI_ERR_HEADER_LOG+4:
+	case PCI_ERR_HEADER_LOG+8:
+	case PCI_ERR_HEADER_LOG+12:
+	case PCI_ERR_ROOT_COMMAND:
+	case PCI_ERR_ROOT_STATUS:
+	case PCI_ERR_ROOT_ERR_SRC:
+		*value = mvebu_readl(port, PCIE_CAP_PCIERR_OFF + reg);
+		break;
+
+	default:
+		return PCI_BRIDGE_EMUL_NOT_HANDLED;
+	}
+
+	return PCI_BRIDGE_EMUL_HANDLED;
+}
+
 static void
 mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 				      int reg, u32 old, u32 new, u32 mask)
@@ -715,11 +746,45 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	}
 }
 
+static void
+mvebu_pci_bridge_emul_ext_conf_write(struct pci_bridge_emul *bridge,
+				     int reg, u32 old, u32 new, u32 mask)
+{
+	struct mvebu_pcie_port *port = bridge->data;
+
+	switch (reg) {
+	/* These are W1C registers, so clear other bits */
+	case PCI_ERR_UNCOR_STATUS:
+	case PCI_ERR_COR_STATUS:
+	case PCI_ERR_ROOT_STATUS:
+		new &= mask;
+		fallthrough;
+
+	case PCI_ERR_UNCOR_MASK:
+	case PCI_ERR_UNCOR_SEVER:
+	case PCI_ERR_COR_MASK:
+	case PCI_ERR_CAP:
+	case PCI_ERR_HEADER_LOG+0:
+	case PCI_ERR_HEADER_LOG+4:
+	case PCI_ERR_HEADER_LOG+8:
+	case PCI_ERR_HEADER_LOG+12:
+	case PCI_ERR_ROOT_COMMAND:
+	case PCI_ERR_ROOT_ERR_SRC:
+		mvebu_writel(port, new, PCIE_CAP_PCIERR_OFF + reg);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static const struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
 	.read_base = mvebu_pci_bridge_emul_base_conf_read,
 	.write_base = mvebu_pci_bridge_emul_base_conf_write,
 	.read_pcie = mvebu_pci_bridge_emul_pcie_conf_read,
 	.write_pcie = mvebu_pci_bridge_emul_pcie_conf_write,
+	.read_ext = mvebu_pci_bridge_emul_ext_conf_read,
+	.write_ext = mvebu_pci_bridge_emul_ext_conf_write,
 };
 
 /*
-- 
2.20.1

