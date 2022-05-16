Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EABB528040
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiEPIyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242054AbiEPIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:53:42 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774113F0F;
        Mon, 16 May 2022 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ahW4iZmMaeHR2imkET+ZUEfD0C88QvD2NHELBTx02Vw=; b=RQECGerS/MFzorT0+EOKb0rHfg
        gJk9QfilenpVE/vsYMO9xLCzn3wUk7Fe4j3Whd5wU2D03i8kIJQ1rpRtOqNdBDJDhhHq247pL9TMd
        X7N8+xO+sYbIYmGMscGu2oik1SJZ1nILzok1NgWzYu+XwC4obCB0MjoBE3IGotuMgi8xeCjMNMTdS
        F6waak3gJG7/466mAREt9CZ+ie5AO0eBwew6utThVNkjhmVmI+v6DYJrSU2cb9aBDhOSTopVst+HW
        LqKeyNFi9LaxVOVSNEqdo6kBFAYuvztelUvifSK8bttU50yibQaD1olPGS1WtlOsM/OI/qUPMokDx
        KFPR1ykA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nqWTe-0005fd-Vw; Mon, 16 May 2022 11:53:19 +0300
From:   cyndis@kapsi.fi
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v5 6/9] arm64: tegra: Add Host1x context stream IDs on Tegra186+
Date:   Mon, 16 May 2022 11:52:55 +0300
Message-Id: <20220516085258.1227691-7-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516085258.1227691-1-cyndis@kapsi.fi>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Add Host1x context stream IDs on systems that support Host1x context
isolation. Host1x and attached engines can use these stream IDs to
allow isolation between memory used by different processes.

The specified stream IDs must match those configured by the hypervisor,
if one is present.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
* Added context devices on T194.
* Use iommu-map instead of custom property.
v4:
* Remove memory-contexts subnode.
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 0e9afc3e2f26..5f560f13ed93 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1461,6 +1461,17 @@ host1x@13e00000 {
 
 		iommus = <&smmu TEGRA186_SID_HOST1X>;
 
+		/* Context isolation domains */
+		iommu-map = <
+			0 &smmu TEGRA186_SID_HOST1X_CTX0 1
+			1 &smmu TEGRA186_SID_HOST1X_CTX1 1
+			2 &smmu TEGRA186_SID_HOST1X_CTX2 1
+			3 &smmu TEGRA186_SID_HOST1X_CTX3 1
+			4 &smmu TEGRA186_SID_HOST1X_CTX4 1
+			5 &smmu TEGRA186_SID_HOST1X_CTX5 1
+			6 &smmu TEGRA186_SID_HOST1X_CTX6 1
+			7 &smmu TEGRA186_SID_HOST1X_CTX7 1>;
+
 		dpaux1: dpaux@15040000 {
 			compatible = "nvidia,tegra186-dpaux";
 			reg = <0x15040000 0x10000>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index d1f8248c00f4..613fd71dec25 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1769,6 +1769,17 @@ host1x@13e00000 {
 			interconnect-names = "dma-mem";
 			iommus = <&smmu TEGRA194_SID_HOST1X>;
 
+			/* Context isolation domains */
+			iommu-map = <
+				0 &smmu TEGRA194_SID_HOST1X_CTX0 1
+				1 &smmu TEGRA194_SID_HOST1X_CTX1 1
+				2 &smmu TEGRA194_SID_HOST1X_CTX2 1
+				3 &smmu TEGRA194_SID_HOST1X_CTX3 1
+				4 &smmu TEGRA194_SID_HOST1X_CTX4 1
+				5 &smmu TEGRA194_SID_HOST1X_CTX5 1
+				6 &smmu TEGRA194_SID_HOST1X_CTX6 1
+				7 &smmu TEGRA194_SID_HOST1X_CTX7 1>;
+
 			nvdec@15140000 {
 				compatible = "nvidia,tegra194-nvdec";
 				reg = <0x15140000 0x00040000>;
-- 
2.36.1

