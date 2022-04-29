Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62274515548
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380662AbiD2URD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380638AbiD2UQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:16:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1CD5E94;
        Fri, 29 Apr 2022 13:13:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id D924D1F469D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651263211;
        bh=Ygrrf/uiE7GKex7nmfQ7KPictd649a7293BtSJxSJ28=;
        h=From:To:Cc:Subject:Date:From;
        b=bF5Y9hNQy9VcyUwBt8enhkN46rRy0LwPqcxZlpmJQqFG7afz+RUXNOBkIXxBWSW7l
         n5f0x+aG7Z8YNagVc31Zq9jt0XQ3BxPvCMxt4b4RSwkHBnMAoX8zHn519KzNttEn4y
         zcYjx2Sxb8GKHejIaPnZix4Vqgg0t+qwcgN+4QKBOeY8rOnaNrcbFpym/oDFFxzS8Y
         O5HZWV8mK1NwIccTscOUmVd0y5b0wMSD3GzDx7nw2UN1qxjLjn99L3NF2/mYg73kkM
         WCw6i/oukTLnr7AJ4bDybinpRUOPB0WRM5iPsG9Uz1MgXENXUlHcDBUplbhDpKm5JW
         gMj/arQdA1m3g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: regulator: mt6315: Enforce regulator-compatible, not name
Date:   Fri, 29 Apr 2022 16:13:24 -0400
Message-Id: <20220429201325.2205799-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
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

The MT6315 PMIC dt-binding should enforce that one of the valid
regulator-compatible is set in each regulator node. However it was
mistakenly matching against regulator-name instead.

Fix the typo. This not only fixes the compatible verification, but also
lifts the regulator-name restriction, so that more meaningful names can
be set for each platform.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../devicetree/bindings/regulator/mt6315-regulator.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
index 61dd5af80db6..5d2d989de893 100644
--- a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
@@ -31,7 +31,7 @@ properties:
         $ref: "regulator.yaml#"
 
         properties:
-          regulator-name:
+          regulator-compatible:
             pattern: "^vbuck[1-4]$"
 
     additionalProperties: false
-- 
2.36.0

