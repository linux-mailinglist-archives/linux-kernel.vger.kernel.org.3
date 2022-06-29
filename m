Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B589560524
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiF2QBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiF2QAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA8925C53;
        Wed, 29 Jun 2022 09:00:31 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E41E26601942;
        Wed, 29 Jun 2022 17:00:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518430;
        bh=KmNdf8Lk6p2VGyZm7KaMsN4jtyH8AqBYDyDnUr4zQv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFvFtIfBURHS3ZZHKugEn0//ZEcsdDsTrErP5vkTXbzEcdAbsOIwyazlkOyABX1he
         ER6r/KqucfUgDcuSYnU9gui98HdQI+juVDsi8+An/KpWk+5304ocKtlr4elPkS7uFb
         H4IFywTLAg/VtTN/8VzY9Wt+KUpYIdHwqDTVn1j6UBkytA8IjkxA+ahyoNR0gdUAp/
         A8yqflPdo3ZoiU2GlKq3/CMnVMmjal7PBN4UarjnQQxnSsV9362Y5zNWqnwNCQrdIq
         dk45ILOlvXooKcWslEcJrX4tUR+ilpKGTBte1kptsMEfCQw+KvR/36CrNWI8pdXoB1
         ns3qT56GKTOvw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 18/19] arm64: dts: mediatek: asurada: Enable SCP
Date:   Wed, 29 Jun 2022 11:59:55 -0400
Message-Id: <20220629155956.1138955-19-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629155956.1138955-1-nfraprado@collabora.com>
References: <20220629155956.1138955-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the SCP co-processor present on MT8192. It is used
as part of the video encoding and decoding processes.

A region of memory is carved out for its use, and remoteproc setup for
communication with the ChromeOS EC.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v4:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 7b89f6e552c5..a5625b3cb317 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -105,6 +105,12 @@ reserved_memory: reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		scp_mem_reserved: scp@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+
 		wifi_restricted_dma_region: wifi@c0000000 {
 			compatible = "restricted-dma-pool";
 			reg = <0 0xc0000000 0 0x4000000>;
@@ -680,6 +686,12 @@ pins-pcie-en-pp3300-wlan {
 		};
 	};
 
+	scp_pins: scp-pins {
+		pins-vreq-vao {
+			pinmux = <PINMUX_GPIO195__FUNC_SCP_VREQ_VAO>;
+		};
+	};
+
 	spi1_pins: spi1-default-pins {
 		pins-cs-mosi-clk {
 			pinmux = <PINMUX_GPIO157__FUNC_SPI1_A_CSB>,
@@ -735,6 +747,20 @@ &pmic {
 	interrupts-extended = <&pio 214 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&scp {
+	status = "okay";
+
+	firmware-name = "mediatek/mt8192/scp.img";
+	memory-region = <&scp_mem_reserved>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&scp_pins>;
+
+	cros-ec {
+		compatible = "google,cros-ec-rpmsg";
+		mediatek,rpmsg-name = "cros-ec-rpmsg";
+	};
+};
+
 &spi1 {
 	status = "okay";
 
-- 
2.36.1

