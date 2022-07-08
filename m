Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE7456C45D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiGHT0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbiGHT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:26:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8E20189;
        Fri,  8 Jul 2022 12:26:13 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52D5866019F2;
        Fri,  8 Jul 2022 20:26:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657308371;
        bh=XB+Q5+iW9bzcYdl1fBbqu9s42fjAPkdcGjUotn5OaPM=;
        h=From:To:Cc:Subject:Date:From;
        b=aAjTkJkxs/dZshN+srt3jMFNrbpIL9P4Xd9CTTckQX5iZDBqf1Ce/WjXCA+ekWoUE
         qBLcmyhpoR/8rczvCLZwMVOp4tKqKTs9Y/nUzg+TSzbowItA6xb/GoxwjnEV2pUDgB
         wAF0Qq97/uPv3kXY8F5kdsfP3OrqUMLHDBulNZ1JJlqSACpP5Cx6vCW2rhmXt36eWf
         DXne89DgjSxE1AZWLja3vqAJiinx/G7Y1bTSjNcL07NZ5rg8zj9cC05qP4uLgFIEhT
         Jv5DHCY/Re4aRnglvJYWNVPjGBV75pGJDCmpGMO7p7OQDDQqqorNEs+XcEcptx5D8J
         UNHbLJPMIl2hA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH] Revert "dt-bindings: usb: mtk-xhci: Make all clocks required"
Date:   Fri,  8 Jul 2022 15:26:05 -0400
Message-Id: <20220708192605.43351-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.0
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

This reverts commit ebc4969ae125e65fdb563f66f4bfa7aec95f7eb4. That
commit was supposed to make the binding better reflect the MediaTek XHCI
hardware block by requiring all clocks to be present. But doing that
also causes too much noise in the devicetrees, since it requires
updating old MediaTek DTs to add clock handles for the fixed clocks, and
going forward every new clock added to the binding would require even
more updates.

The commit also didn't update the example to match the changes, causing
additional warnings.

Instead let's keep the clocks optional so that old devicetrees can keep
omitting the fixed clocks, and we'll just add the clocks as required on
new DTs.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 1444d18ef9bc..63cbc2b62d18 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -67,6 +67,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 1
     items:
       - description: Controller clock used by normal mode
       - description: Reference clock used by low power mode etc
@@ -75,8 +76,9 @@ properties:
       - description: controller clock
 
   clock-names:
+    minItems: 1
     items:
-      - const: sys_ck
+      - const: sys_ck  # required, the following ones are optional
       - const: ref_ck
       - const: mcu_ck
       - const: dma_ck
-- 
2.37.0

