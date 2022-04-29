Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A023E5155AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380780AbiD2UeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380751AbiD2UeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:34:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4592343EE6;
        Fri, 29 Apr 2022 13:30:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 13ED91F469D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651264251;
        bh=iA81JYnLAQQ56KXiWfdUYhI2+oyfPVXJFjeDzQn33UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEXLTWvqDvhD8CXoQFsb1+gzKNMCACdb8rlEhLrPyFd5Ezy+kLRcmFRgNDdCBsuKN
         F24McZ6t0CsiSnp6455dCY4H1vu7lXGmcYxl5ke4thYo5fhgXDCtnWhmwohSXFFCEj
         HR3NsmGWzRONXwoUFTxpZ98PUXsHAO6evwLPcOIAtkBXwsmkitIWiu1guxTspIsf2W
         I1oW750Zw+95Up0iRS8Enhwhs6IwLCwc7gx+FF85yE0Y6AuXegjBGms3Z/+t5khTEL
         tMxYkikxZsfLJf6KdIeL8LLyPo6mozWksZutDOsDDeMHPdcQdcmlNv0c3MRm5bX/y6
         35CkcCaxg8KMw==
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
Subject: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share properties
Date:   Fri, 29 Apr 2022 16:30:37 -0400
Message-Id: <20220429203039.2207848-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429203039.2207848-1-nfraprado@collabora.com>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mediatek AFE PCM controller for MT8192 allows sharing of an I2S bus
between two busses. Add a pattern for these properties in the
dt-binding.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
index 7a25bc9b8060..5b03c8dbf318 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
@@ -54,6 +54,11 @@ properties:
       - const: aud_infra_clk
       - const: aud_infra_26m_clk
 
+patternProperties:
+  "^i2s[0-35-9]-share$":
+    description: Name of the I2S bus that is shared with this bus
+    pattern: "^I2S[0-35-9]$"
+
 required:
   - compatible
   - interrupts
-- 
2.36.0

