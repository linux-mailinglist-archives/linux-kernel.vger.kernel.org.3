Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34274DB4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354725AbiCPPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357221AbiCPPPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:15:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36E05C852;
        Wed, 16 Mar 2022 08:13:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 8E8691F44699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647443622;
        bh=/bhUnlYrfsDoQs+TNn3x9vAxRBVThPY75bVuGDqvUHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xev6M37ThJ7B5XZLX6Q+n2iHghpH/+e9tfo2nYJOl6J1bwh4RKsp35BngBcse0qMN
         g6MTwYFglWVkWDvI+DxEts7TYamFkFi7SuJB6aHFgIRiecAz/YrfesTduJcz2BRTiB
         7wxHq3rZ1uzTVqoj+RRtrWfr4KtynQ/nYco66bb+Z+rnNMDOHqMoqme7iER0k8qGFR
         tbtkks7BsKP8/1qRDAeTvJElH2TTEnNGtBGBwvjNqOjEY9TrmvIh2NPeunixYXqMFR
         ywIDgjQbsu7YA20oJ8ssPysp1NROFRRQdA1FKRKsOgZ6gPgmi33fG/i1qBn9TsivqZ
         i3N54e9f2TUEg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 08/10] arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
Date:   Wed, 16 Mar 2022 11:13:25 -0400
Message-Id: <20220316151327.564214-9-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316151327.564214-1-nfraprado@collabora.com>
References: <20220316151327.564214-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Elan eKTH3000 i2c trackpad present on Asurada. It is
connected to the I2C2 bus and has address 0x15.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

 .../boot/dts/mediatek/mt8192-asurada.dtsi      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 3b4c74d5d5c3..b911f4fc3038 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -109,6 +109,16 @@ &i2c2 {
 	clock-stretch-ns = <12600>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins>;
+
+	trackpad@15 {
+		compatible = "elan,ekth3000";
+		reg = <0x15>;
+		interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+		vcc-supply = <&pp3300_u>;
+		wakeup-source;
+	};
 };
 
 &i2c3 {
@@ -440,6 +450,14 @@ pins-bus {
 			bias-disable;
 		};
 	};
+
+	trackpad_pins: trackpad-default-pins {
+		pins-int-n {
+			pinmux = <PINMUX_GPIO15__FUNC_GPIO15>;
+			input-enable;
+			mediatek,pull-up-adv = <3>;
+		};
+	};
 };
 
 &spi1 {
-- 
2.35.1

