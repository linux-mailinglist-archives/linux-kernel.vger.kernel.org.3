Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0047063A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbhLJQvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244076AbhLJQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:34 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D242CC061D5F;
        Fri, 10 Dec 2021 08:47:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j3so15978372wrp.1;
        Fri, 10 Dec 2021 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmpF5nkRi2WoXriQpRMFXwjffTvFPB+sSSjc501wv0s=;
        b=cyTP3KVyI+VC4Q++OWCN8m447L2kG16cVAy6fmhtmTax+gO1evWi+veQCUN1SuqtgV
         N66HZ2Alue9Z7o5JDrqFoGUAg9ElyfM3YIar1K4SmTWmTCF68H8IywCIZMc+QA1jXcCL
         3fe5+NR8AkV5/GoGBpwls65HkSHrmVH2YwxP/RmPgIRp+VDx3nwUKR1MVDzYvV5VYlDi
         NvG3FBi/0LVWSYq0I4rt31DjD2X/h0K8PC545gIFFV6KjJF6UUorRQxwS9Wob8IzSgwA
         NyJuyHDzR4HlBQxutyjBbBDe5ZubKSS5TlppxtxwWAyNiULwRVyCUdUVkiQVBdRox4Dg
         ypwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmpF5nkRi2WoXriQpRMFXwjffTvFPB+sSSjc501wv0s=;
        b=WH6/OZic/APci1uS9XQf7Pe6RDsaHbuYccH9kIy0hyXhg0uwBMa8PvoawsrXyQS7f6
         tHo3XXHF1e9Hqn2CxWlUxVODqlf/xAGJv8ylf45LFx+ruIVR+D6WVhEtBLgUME+ka+w4
         nzxsMylYOPthKexckqhlFzKyNI1lVJUnpKr1NSHKMeV3tPPn0tJyeXlLgNU/6JrRLPHQ
         11FkOqD6gWziEzKzHQJCLVKfeGa+w5Z//ioBMXoh8RzpkfcfiGD5Ij922l7EGuZOb8hp
         mnQw60EyBMAoSdwxohddnOPiESGVQjlJvhI7TGbF7D6LUVTVN2URwSacwuzZDEwd0ISt
         zAWQ==
X-Gm-Message-State: AOAM531Q66RZAiDtREoEE6Etp1g0P2geKKMUA9W90rFJjdWtMXPtPE3Q
        MmpQP2f4VCS/dhz2RajduLo=
X-Google-Smtp-Source: ABdhPJyxSsV/MDGkzJgNVMYKEKfJAsT5MvxbcUIpMJpsOoxGJuYOtJtBtOgZb1hBgydKjDpd7jeAuQ==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr15740277wrn.521.1639154877427;
        Fri, 10 Dec 2021 08:47:57 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id 10sm3997115wrb.75.2021.12.10.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:47:55 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: tegra: Add memory controller on Tegra234
Date:   Fri, 10 Dec 2021 17:47:40 +0100
Message-Id: <20211210164741.881161-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210164741.881161-1-thierry.reding@gmail.com>
References: <20211210164741.881161-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This adds the memory controller and the embedded external memory
controller found on the Tegra234 SoC.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- move EMC general interrupt from MC to EMC

 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index f8061b452046..a75b21c6a521 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/gpio/tegra234-gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/tegra186-hsp.h>
+#include <dt-bindings/memory/tegra234-mc.h>
 #include <dt-bindings/reset/tegra234-reset.h>
 
 / {
@@ -85,6 +86,54 @@ gpio: gpio@2200000 {
 			gpio-controller;
 		};
 
+		mc: memory-controller@2c00000 {
+			compatible = "nvidia,tegra234-mc";
+			reg = <0x02c00000 0x100000>,
+			      <0x02b80000 0x040000>,
+			      <0x01700000 0x100000>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			#interconnect-cells = <1>;
+			status = "okay";
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			ranges = <0x01700000 0x0 0x01700000 0x0 0x100000>,
+				 <0x02b80000 0x0 0x02b80000 0x0 0x040000>,
+				 <0x02c00000 0x0 0x02c00000 0x0 0x100000>;
+
+			/*
+			 * Bit 39 of addresses passing through the memory
+			 * controller selects the XBAR format used when memory
+			 * is accessed. This is used to transparently access
+			 * memory in the XBAR format used by the discrete GPU
+			 * (bit 39 set) or Tegra (bit 39 clear).
+			 *
+			 * As a consequence, the operating system must ensure
+			 * that bit 39 is never used implicitly, for example
+			 * via an I/O virtual address mapping of an IOMMU. If
+			 * devices require access to the XBAR switch, their
+			 * drivers must set this bit explicitly.
+			 *
+			 * Limit the DMA range for memory clients to [38:0].
+			 */
+			dma-ranges = <0x0 0x0 0x0 0x80 0x0>;
+
+			emc: external-memory-controller@2c60000 {
+				compatible = "nvidia,tegra234-emc";
+				reg = <0x0 0x02c60000 0x0 0x90000>,
+				      <0x0 0x01780000 0x0 0x80000>;
+				interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&bpmp TEGRA234_CLK_EMC>;
+				clock-names = "emc";
+				status = "okay";
+
+				#interconnect-cells = <0>;
+
+				nvidia,bpmp = <&bpmp>;
+			};
+		};
+
 		uarta: serial@3100000 {
 			compatible = "nvidia,tegra234-uart", "nvidia,tegra20-uart";
 			reg = <0x03100000 0x10000>;
-- 
2.34.1

