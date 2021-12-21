Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72347C2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhLUPWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:22:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57002 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhLUPWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:22:02 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BLFLku0064740;
        Tue, 21 Dec 2021 09:21:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640100106;
        bh=dE4T1fnuau00k5Mo7+ksZdAC/dHCWN8R7vt1VAKqDi8=;
        h=From:To:CC:Subject:Date;
        b=exUm+UNDhDkYMEAks0RboPUf/AVUPfEMp+w3IOR9x+148iqK78pmz+3/u5auUlKaF
         SpCXl0KHznni6QEkTxADpX2UNnQl+IlBwn5IFEUtSm5hiVH2oLwXHqb/SCfRejx4Gk
         iIUoUSZnehXoxJk1rbYmpUwr7upfsrTWn5Fzvjkw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BLFLjRg018631
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 09:21:45 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Dec 2021 09:21:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Dec 2021 09:21:45 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BLFLhIL075869;
        Tue, 21 Dec 2021 09:21:43 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v2] arm64: defconfig: Enable USB drivers for TI K3 SoC
Date:   Tue, 21 Dec 2021 20:51:40 +0530
Message-ID: <20211221152140.15151-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Cadence USB, TI USB and required SERDES drivers to support USB on
TI K3 SoCs.

Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

v2:
Drop Cadence PCIe driver configs as they cannot be built as modules
based on feedback at [1].

v1: https://lore.kernel.org/r/20211208060856.16106-1-vigneshr@ti.com

[1] https://lore.kernel.org/linux-arm-kernel/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/

 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f2e2b9bdd702..dfa34bd06949 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -822,6 +822,10 @@ CONFIG_USB_RENESAS_USBHS_HCD=m
 CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_ACM=m
 CONFIG_USB_STORAGE=y
+CONFIG_USB_CDNS_SUPPORT=m
+CONFIG_USB_CDNS3=m
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_USB_CDNS3_HOST=y
 CONFIG_USB_MTU3=y
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_MUSB_SUNXI=y
@@ -1123,6 +1127,7 @@ CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_SUN4I_USB=y
+CONFIG_PHY_CADENCE_SIERRA=m
 CONFIG_PHY_MIXEL_MIPI_DPHY=m
 CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_HISTB_COMBPHY=y
@@ -1146,6 +1151,8 @@ CONFIG_PHY_SAMSUNG_UFS=y
 CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_TEGRA_XUSB=y
+CONFIG_PHY_AM654_SERDES=m
+CONFIG_PHY_J721E_WIZ=m
 CONFIG_ARM_SMMU_V3_PMU=m
 CONFIG_FSL_IMX8_DDR_PMU=m
 CONFIG_HISI_PMU=y
-- 
2.34.1

