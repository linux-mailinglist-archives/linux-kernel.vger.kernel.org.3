Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265835B0655
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIGOWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIGOWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:22:14 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316832AB4;
        Wed,  7 Sep 2022 07:22:07 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id F2C2920000F;
        Wed,  7 Sep 2022 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662560526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VgbxwdFt5PQppcOV7X5ar9OBFO85n+/rhDp625ejemw=;
        b=K3xa18hD5THvri4wHGXS1ynPnBzxFd5Zor2sm9QM6SMroLfr12HiVYVsbewqW89p0iqgV4
        IlnnpUFS8seVJT3Mtv0E7rprRb3KqgTrVixWJN+fNMl6fibdHrWSEwwduzd3sEN9D7C5Kf
        7R+Hh0+gkO0A4KbbemjizLE5quL2C8M20AJgKZJhM1WaQ1sNXjU+2lpBbooX5O5HfXNQAx
        q/o/FegSFyelVAKO3y8zlWkcJtcN+6eGCdGElS9d+wfZg76iBu4oazIuQ7Bww9Ry0x2qvA
        rIYgWb+yghfJ2U2bCudSsu/kIAyKbz6kVQr6rHL9gI+PC6OAaCk3UAm1q4QbRg==
From:   luca.ceresoli@bootlin.com
To:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/8] ASoC: rockchip: rk3308: add audio card bindings
Date:   Wed,  7 Sep 2022 16:21:18 +0200
Message-Id: <20220907142124.2532620-3-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

Add device tree bindings document for the audio card based on the internal
I2S of the Rockchip RK3308 SoC.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .../rockchip,rk3308-audio-graph-card.yaml     | 50 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml
new file mode 100644
index 000000000000..8445a69dcdbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/rockchip,rk3308-audio-graph-card.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3308 Audio card based on internal I2S
+
+maintainers:
+  - Luca Ceresoli <luca.ceresoli@bootlin.com>
+
+allOf:
+  - $ref: /schemas/sound/audio-graph.yaml#
+
+properties:
+  compatible:
+    const: rockchip,rk3308-audio-graph-card
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "rockchip,rk3308-audio-graph-card";
+        dais = <&i2s_8ch_2_port>;
+    };
+
+    i2s_8ch_2 {
+        i2s_8ch_2_port: port {
+            i2s_8ch_2_endpoint: endpoint {
+                remote-endpoint = <&acodec_endpoint>;
+                dai-format = "i2s";
+
+                /* The RK3308 acodec has no clock dividers, use the CPU */
+                bitclock-master = <&i2s_8ch_2_endpoint>;
+                frame-master = <&i2s_8ch_2_endpoint>;
+            };
+        };
+    };
+
+    acodec {
+        port {
+            acodec_endpoint: endpoint {
+                remote-endpoint = <&i2s_8ch_2_endpoint>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d53a8e74cb1e..079bdd95dc49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17594,6 +17594,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
 F:	include/dt-bindings/sound/rockchip,rk3308-codec.h
 
+ROCKCHIP RK3308 SOUND CARD DRIVER
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml
+
 ROCKCHIP VIDEO DECODER DRIVER
 M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
 L:	linux-media@vger.kernel.org
-- 
2.34.1

