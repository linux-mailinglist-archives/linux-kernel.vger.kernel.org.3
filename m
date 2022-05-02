Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7835D517765
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387121AbiEBT2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387086AbiEBT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:27:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD71022;
        Mon,  2 May 2022 12:24:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id E2D341F43621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651519466;
        bh=vHihAny00/plbHUVJRmkYGyvszXuKSJzxYZuye6XI3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpQqhjaAxa5faEQtAsKCmgXiugtsTXMLqjEWTrs1HlSSGtpuwbTN9iX+Cz0kOJaFa
         ZbKr4bnDb/xWp9p9PRJAUgU8IIQTNBdovEiIorjCTjd+zecDsy04ZLW1XgutGmgAC2
         XJllqbTfFdIyc2n+WRIJBaip0pUk111qe3FePJ/LD0aqGP8zLdaYvZMpqL2j6Kk/y8
         zLiL+kz4CbpPBDM9zBpEWdhBJey8fpSq+hWjFxxEi/aJBIHkj5xISEpA6LUy0zJ6g4
         v4P1W0vsxxMgxHwfGWREJScjhQajlJlsqBJ7H1JIuMEBk9rSsIxCfQZWRymkIkSpP+
         fdfY++J7xgZkw==
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
Subject: [PATCH v2 1/2] dt-bindings: remoteproc: mediatek: Fix optional reg-names for mtk,scp
Date:   Mon,  2 May 2022 15:24:19 -0400
Message-Id: <20220502192420.2548512-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502192420.2548512-1-nfraprado@collabora.com>
References: <20220502192420.2548512-1-nfraprado@collabora.com>
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

The SCP has three memory regions: sram, l1tcm and cfg. Only sram is
required, the other two are optional. Fix the dt-binding so that the
optional regions can be omitted and passed in any order.

Also add the missing minItems to the reg property and update the
description.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v1)

 .../devicetree/bindings/remoteproc/mtk,scp.yaml      | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index 823a236242de..ec9ddeb6ca2c 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -24,14 +24,20 @@ properties:
   reg:
     description:
       Should contain the address ranges for memory regions SRAM, CFG, and
-      L1TCM.
+      L1TCM. Only SRAM is required, while CFG and L1TCM are optional.
+    minItems: 1
     maxItems: 3
 
   reg-names:
+    minItems: 1
     items:
       - const: sram
-      - const: cfg
-      - const: l1tcm
+      - enum:
+          - l1tcm
+          - cfg
+      - enum:
+          - l1tcm
+          - cfg
 
   clocks:
     description:
-- 
2.36.0

