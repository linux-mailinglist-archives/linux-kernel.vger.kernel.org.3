Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A1355CE50
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiF0OW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236880AbiF0OUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:20:42 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4728F10FE9;
        Mon, 27 Jun 2022 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ahW4iZmMaeHR2imkET+ZUEfD0C88QvD2NHELBTx02Vw=; b=xi5fpx3qYTev2mqbXFkxzG5YXV
        N0CfzNRaeWNAXIkz28A6LXzkbR7xjpXGvI8pWCrz9zWp5/NgytqKQKVxVSG3im6UL66P+Hhkmi8u5
        EyFYgMIU97NNoUugy0lEradt6Z/FtUWzchF4tagJq5Zffk6pexN1y2ZaFWO6PhRLEf2wImIUTZd2m
        0OcJcS+1YCGPqef5kx3HCPGIQreTfouxAb44O5j7pTcPyiyjD28KHJ3hCF/dIuyMrw+2BGRlc8N26
        1z3bNLfVPPHAh7faoF5couQo3d01u0cBRQ1f7+S7LFooKmjoXCEjkupjzXmuliEwX921YCKdwSqVn
        uLShdarg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o5pbL-003N2J-Eu; Mon, 27 Jun 2022 17:20:30 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7/v3 04/22] arm64: tegra: Add Host1x context stream IDs on Tegra186+
Date:   Mon, 27 Jun 2022 17:19:50 +0300
Message-Id: <20220627142008.2072474-5-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627142008.2072474-1-cyndis@kapsi.fi>
References: <20220627142008.2072474-1-cyndis@kapsi.fi>
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

