Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241E7473198
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbhLMQWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhLMQWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:22:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0AC061751;
        Mon, 13 Dec 2021 08:22:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i12so12346237wmq.4;
        Mon, 13 Dec 2021 08:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmpF5nkRi2WoXriQpRMFXwjffTvFPB+sSSjc501wv0s=;
        b=n299pL2klwd1hvzFTB8rHTSz1AGUG7Yk6fsWfRcoPOcxD+kHEUlvFP+Tt2wBwsAVHl
         joDEJ5JmDUecihibaE3onopQl251ZYahhJlorEGIvVVDpm2E+2ymtqDaC5JNIMKRwcC4
         qnbkKoPtp5ycBlOgrJh3iPjTeEnApsB1XG/U7DQ/PCkKdiWUDataAah8miiLug0TbCJ4
         tihnwvLfuTXfK1gkstylTLHrjdNhA7oy41LlMlThVV4MKrXW5XvTjmuZxIBc2nq+4/Bw
         EDU9Ac8L13hV7zEmOcwYO82MOFh9/0Ar72VhuYo5JOFQhjnoyDl07cC7uCzjc0VhAig0
         WKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmpF5nkRi2WoXriQpRMFXwjffTvFPB+sSSjc501wv0s=;
        b=aX4qdwQOgMlg0G9tOW3qYz440QuHCk7baC8pO3reFnW0PeishNGaci7CTzQ0bY9xeH
         5D9F1so+ZKK9Q+Wihy5uDODeyZ81jH3eRp/kPQZZ2SjElJB188j0VGJRfbRd03lQTLjy
         wh1Y7vR3Lr/Vr1+VMU9ShtTUhWVsNAKRlbbBScwEesaqvOCmW+eRRxY55yK05yfkCVpw
         uqwMvnYpyALygWBgIznFLqIAEjjDIpa/U1t2RLtiRlwa5xL6a4XfXKvcArcDkiAq57SG
         dlskg0bxZ3G4OqQVN+8o8xwcvG4KyJLlD76szAq2o/IYd7RSIlL+qwXHYOVxvdiIzP3j
         LFuA==
X-Gm-Message-State: AOAM533wdZ9LbdL4GUbwWOqP/jBkq3Ex5T6Pw6jIYoMv9VdC8EUDFUjj
        acOEx4/Z34gC6Nq+vjO591Y=
X-Google-Smtp-Source: ABdhPJyT5chf5bWcaQzIHYkZllzHGAky7L6Om3dI3AdL8QxAtkZfKt6U1EEWI/zyEVxNQcTZY0pJCg==
X-Received: by 2002:a05:600c:1d0e:: with SMTP id l14mr37799060wms.64.1639412526853;
        Mon, 13 Dec 2021 08:22:06 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id y7sm10905251wrw.55.2021.12.13.08.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:22:05 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] arm64: tegra: Add memory controller on Tegra234
Date:   Mon, 13 Dec 2021 17:21:50 +0100
Message-Id: <20211213162151.916523-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213162151.916523-1-thierry.reding@gmail.com>
References: <20211213162151.916523-1-thierry.reding@gmail.com>
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

