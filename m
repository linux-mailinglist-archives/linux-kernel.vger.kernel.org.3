Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF67B5701F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiGKMZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGKMZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:25:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF694505E;
        Mon, 11 Jul 2022 05:25:09 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E5AE366019FD;
        Mon, 11 Jul 2022 13:25:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657542308;
        bh=ubXAnOjRMe3Pb/tsTo7f8wxsG7B1OS2/1BE23DQJYdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYX3Z6lPDzkT6PllDgjFsxECGU8NYPw3L64OVYrYZQaG9AW8r13syjK00gbuL+9dG
         TZhKggimY+DoNIThs2H7+m5pnWDAtN2q35kJ69TCqzIrlmsAgU1Y0CIqXLZBbFX8Gk
         NrzHDPwd3a7ic6m8Vq2LZ92G2oj3oqVru+iFn0OqCmLUYOQ4NnBrvFTXf7acTxwJRw
         EaNBpdqsj9U5lccdQ9rrjSSZox++vhD6FTfc6WvJyIarKb5lSOqA0c7W2UMw0yszOx
         VBGvJsmXqNAoQrZQAWkEA/Z/HUJ+D0qsfgRsL8/B2ApiYRhstf5Eapu7V2mJFM5EnA
         M82cFU/4tT8yA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: [PATCH 1/3] dt-bindings: power: mediatek: Document phandle to SCPSYS syscon node
Date:   Mon, 11 Jul 2022 14:25:01 +0200
Message-Id: <20220711122503.286743-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
References: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a phandle to the syscon block providing access to SCPSYS registers:
this allows us to avoid using simple-mfd for the SCPSYS node and
nesting the System Power Manager node inside.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/power/mediatek,power-controller.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 135c6f722091..848fdff7c9d8 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -39,6 +39,11 @@ properties:
   '#size-cells':
     const: 0
 
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon block providing access to SCPSYS registers
+
 patternProperties:
   "^power-domain@[0-9a-f]+$":
     type: object
-- 
2.35.1

