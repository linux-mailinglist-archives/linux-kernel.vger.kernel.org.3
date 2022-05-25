Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FCF533FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiEYO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbiEYO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:58:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C505E6C0FE;
        Wed, 25 May 2022 07:58:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 6B8481F450F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653490687;
        bh=+4m7P+pQtDoPRLeJ/o/TRoRtSsTCzrenQkb157P79lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlKOHXS3aCs3rvje9nB1n31DpTc3NvRCrZn0OdKzxRi9cxs4OLRCPXZpVxuGqj0GX
         R5j8gxzle1zXngChlMkXIILoTvIpAvjWBNDuIvAM9yY3TXpkf354PccFwBpqSJwbk4
         qsutJTt2eILUFYhM7/33ZP8HXp3a91pV3NsKqnR4JV4NhaEC++K+n1qcW5h+wpLNDU
         qcYbmr/ynYBC/IkbqNxvPinv6L1kcyEfKBHzdQrymVcKCQ7NRQ/TzDrQnp5dEWf1y5
         ILHxR8jodll6ex09bsZZYvTz2ZmLPqXKFQDhoAvMbnZAw/jp2uF6g7j0GuW/xpAOdx
         J/8Z0nqT5Ving==
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: Add compatible for Mali Valhall (JM)
Date:   Wed, 25 May 2022 10:57:46 -0400
Message-Id: <20220525145754.25866-2-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
References: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
MIME-Version: 1.0
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

From the kernel's perspective, (pre-CSF, "Job Manager") Valhall is more
or less compatible with Bifrost, although they differ to userspace. Add
a compatible for Valhall to the existing Bifrost bindings documentation.

As the first SoC with a Valhall GPU receiving mainline support, add a
specific compatible for the MediaTek MT8192, which instantiates a
Mali-G57.

v2: Change compatible to arm,mali-valhall-jm (Daniel Stone).

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
CC: devicetree@vger.kernel.org
---
 .../bindings/gpu/arm,mali-bifrost.yaml        | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 85f8d4764740..78964c140b46 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -14,16 +14,21 @@ properties:
     pattern: '^gpu@[a-f0-9]+$'
 
   compatible:
-    items:
-      - enum:
-          - amlogic,meson-g12a-mali
-          - mediatek,mt8183-mali
-          - realtek,rtd1619-mali
-          - renesas,r9a07g044-mali
-          - renesas,r9a07g054-mali
-          - rockchip,px30-mali
-          - rockchip,rk3568-mali
-      - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson-g12a-mali
+              - mediatek,mt8183-mali
+              - realtek,rtd1619-mali
+              - renesas,r9a07g044-mali
+              - renesas,r9a07g054-mali
+              - rockchip,px30-mali
+              - rockchip,rk3568-mali
+          - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
+      - items:
+          - enum:
+              - mediatek,mt8192-mali
+          - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
 
   reg:
     maxItems: 1
-- 
2.35.1

