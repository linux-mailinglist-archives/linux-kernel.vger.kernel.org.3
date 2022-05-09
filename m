Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD1520643
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiEIVC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiEIVCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:02:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F812B8D24;
        Mon,  9 May 2022 13:58:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 564EA1F42F48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652129932;
        bh=j+wdfrc3FXi43X0VkODadFay6bg9FKNBstYCTMpecA8=;
        h=From:To:Cc:Subject:Date:From;
        b=U74Ljn728Csp+ET2xThho9d1REqGnsswajm8GHfb67k2/RQZQWrjH38iHELrF44Nj
         xjNY6xlKH4B+68AQjDzJ4U9UXWZJZvRQXVg+CE577q+KjYL03FmMa/3TLtBWPFbaJc
         CZtRlFSbP4P6LvKc4+03hk9wBfEX4V83iyBOVw4o1AuuX92sETE6/YrYOK5HC+RLse
         usJnlXHQmatb4Tr1cmtTPqJ7rXIY3//R6J9m5ZXiAvwzZW6PwC2awkxQcnstozW5iT
         i1yFHZ/MGA/PZzO3rWICOJ8hBGFEU41lmBA6aSosZ+mnNFsx4iQ1oOlQOIjrv9EE/V
         Tc+X6cFr8gC1Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share properties
Date:   Mon,  9 May 2022 16:58:47 -0400
Message-Id: <20220509205847.607076-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
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

The Mediatek AFE PCM controller for MT8192 allows two I2S interfaces to
share the same clock and act as a single interface with both input and
output. Add patterns for these properties in the dt-binding. The
property is split into two patterns in order to allow all valid
interface pairings.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
The series from v1 of this patch was merged although some changes were
still needed in this patch, so the v1 of this patch was reverted [1] and
this standalone commit addresses the feedback from v1 and readds the
property.

[1] https://lore.kernel.org/all/20220509185625.580811-1-nfraprado@collabora.com

v1: https://lore.kernel.org/all/20220429203039.2207848-2-nfraprado@collabora.com/

Changes in v2:
- Added "mediatek," prefix to property
- Rewrote and added more information to property description
- Split into two patterns to validate that output-input pairings are
  done

 .../bindings/sound/mt8192-afe-pcm.yaml           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
index 7a25bc9b8060..2abf43c6c2c3 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
@@ -54,6 +54,22 @@ properties:
       - const: aud_infra_clk
       - const: aud_infra_26m_clk
 
+patternProperties:
+  "^mediatek,i2s[13579]-share$":
+    description:
+      Each I2S interface has a single data line, input if its index is even or
+      output if the index is odd. An input and an output I2S interface can be
+      used together as if they were a single I2S interface with both input and
+      output data lines by sharing the same clock. This property represents this
+      pairing. The value should be the name of the interface whose clock is
+      used, and the property name the other interface that depends on this
+      clock.
+    pattern: "^I2S[0268]$"
+
+  "^mediatek,i2s[0268]-share$":
+    description: Same as above.
+    pattern: "^I2S[13579]$"
+
 required:
   - compatible
   - interrupts
-- 
2.36.0

