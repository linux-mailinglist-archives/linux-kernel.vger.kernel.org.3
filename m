Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C9D518FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiECVPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240189AbiECVPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:15:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D292F3B8;
        Tue,  3 May 2022 14:11:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 56AF01F417FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651612287;
        bh=wTlOS8O93LdQ3MZ6Pc0zTUq7Pc+a0aYpZvVoWcRP7HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzSazz1tK90Q9PV9UW17Y7+FKQeT43UIJllNJzWKH28JQXxB3qTDrJA25wkDRYJVa
         7BvGRuBU6nsidwYJ34eUmqTm4xn96Zszvt6v4qSaLn7YCrzzua8YDIlHsA08NI2fLv
         sPUK2hKb9ofGOHQIhH3bvXF2j4kmXdgZs6no/FLLhA+WiC0dQCN1ULHQf42UjOLfTo
         jk9dJ24cr4gJC8rVz1KVBHsXoE3IMidBLhmTCy3YqyQz4Lw5tRb2c4uzXwgHe+ZN1J
         fX5k98xqZy/XPWuUhpWRnHcHF87r67Awf6Yz9/oYiQRo/WR1gS8oFcTetYQDsNkLry
         rJPHKNqs4cjPg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg optional for mtk,scp
Date:   Tue,  3 May 2022 17:11:13 -0400
Message-Id: <20220503211114.2656099-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503211114.2656099-1-nfraprado@collabora.com>
References: <20220503211114.2656099-1-nfraprado@collabora.com>
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

The SCP has three memory regions: sram, cfg and l1tcm. While the first
two are required, l1tcm is optional. Fix the dt-binding so that it can
be omitted and update the description. This gets rid of dtbs_check
warnings for devicetrees where the l1tcm reg is missing like mt8183.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v3:
- Made the cfg reg required again. After looking again into the mtk-scp
  driver, only l1tcm is optional.
- Added mention that a dtbs_check warning gets fixed by patch in commit
  message.

 Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index 823a236242de..eeea84379a1e 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -23,11 +23,13 @@ properties:
 
   reg:
     description:
-      Should contain the address ranges for memory regions SRAM, CFG, and
-      L1TCM.
+      Should contain the address ranges for memory regions SRAM, CFG, and,
+      optionally, L1TCM.
+    minItems: 2
     maxItems: 3
 
   reg-names:
+    minItems: 2
     items:
       - const: sram
       - const: cfg
-- 
2.36.0

