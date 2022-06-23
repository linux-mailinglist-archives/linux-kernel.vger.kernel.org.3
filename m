Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00394558973
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiFWTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiFWToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:44:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC81101E1;
        Thu, 23 Jun 2022 12:37:12 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C448C66017EB;
        Thu, 23 Jun 2022 20:37:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656013031;
        bh=kok2Tk9hNC8W/8hBE+yjTgkvfCjAF1IKTQhZZf2MFyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6UvB1vgu6Ke9+L8pNqa9NYbo0Ma5QNsklJOHsPJQiCYD0Nt+bJD+wvZZi25MVYmd
         bdGsdXKjCH63Cd1KQ8ord23GcpnzboiI7MynL6TBUwRH1AMG74rGQ4rI/QqaPVrgeh
         SwZqRrjfYFn1XZbHTHpEAkvwYjtLqf8aJ38vt7Dq2KVttpve7cXznmCCVv3P9kFVMT
         hv7lYf22stokSgbpIAX0x/iWcuEL9fhyln4jFppmTcOrofFnIRHVRptG7uTkoBclDZ
         NZqWh4EpdllpxED/zZSk9tKfOfw1oiJfuw8ApPtCc99MnxmEMCv/A9Z4uW3ZxLgRjg
         wPRcM8EBIgTdA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: usb: mtk-xhci: Make all clocks required
Date:   Thu, 23 Jun 2022 15:37:00 -0400
Message-Id: <20220623193702.817996-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623193702.817996-1-nfraprado@collabora.com>
References: <20220623193702.817996-1-nfraprado@collabora.com>
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

All of the clocks listed in the binding are always wired to the XHCI
controller hardware blocks on all SoCs. The reason some clocks were made
optional in the binding was to account for the fact that depending on
the SoC, some of the clocks might be fixed (ie not controlled by
software).

Given that the devicetree should represent the hardware, make all clocks
required in the binding. Subsequent patches will make the DTS changes to
specify fixed-clocks for the clocks that aren't controllable.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Undid clock list changes that allowed middle clocks to be missing from
  v1 and made all clocks required instead
- Rewrote commit message and title

 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 63cbc2b62d18..1444d18ef9bc 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -67,7 +67,6 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 1
     items:
       - description: Controller clock used by normal mode
       - description: Reference clock used by low power mode etc
@@ -76,9 +75,8 @@ properties:
       - description: controller clock
 
   clock-names:
-    minItems: 1
     items:
-      - const: sys_ck  # required, the following ones are optional
+      - const: sys_ck
       - const: ref_ck
       - const: mcu_ck
       - const: dma_ck
-- 
2.36.1

