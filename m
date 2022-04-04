Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AFC4F113D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiDDItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbiDDItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0033A3B577;
        Mon,  4 Apr 2022 01:47:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2C2291F4594C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649062058;
        bh=S50/Hcr9j9pF7DFx0XZaG5Lg/9YZaQvfERAo6Uzrf2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAQJFLlLFt/+CSfNqJpqiK03y6QdsUYR9Fxn8RkhlNObY+OToJsp3bsYB4j7nQ/41
         OqwGzxAEmHg1cR+Ef+LLuW8jkftYMJydxdr2+OpP8jBXhSNBBfhBoLbDKzyv5zWLrT
         3hlxfXRAAvbG7ATR7ek4gk8LoZe991Ngj9Efb6094hBOysIB603gnW4pzHrT7GXfrN
         xAbAlNALN17GX3DRcXbFhISisYC9vxGiz83b4IoTBMtMhPDxlBDhznJYRpJjT+yBdI
         y8TDF3km8BIKppP7rdE+DLvzKrEgDzOjldCoLCwFVL89iQel/igBwbD6n41zvx/XKe
         rLhWftGdZ/RLQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com, krzysztof.kozlowski@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/2] dt-bindings: mfd: syscon: Add support for regmap fast-io
Date:   Mon,  4 Apr 2022 10:47:32 +0200
Message-Id: <20220404084732.14096-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404084732.14096-1-angelogioacchino.delregno@collabora.com>
References: <20220404084732.14096-1-angelogioacchino.delregno@collabora.com>
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

The syscon driver now enables the .fast_io regmap configuration when
the 'fast-io' property is found in a syscon node.

Keeping in mind that, in regmap, fast_io is checked only if we are
not using hardware spinlocks, allow the fast-io property only if
there is no hwlocks reference (and vice-versa).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 13baa452cc9d..621b0983b115 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -83,11 +83,26 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 4, 8]
 
+  fast-io:
+    description:
+      Indicates that this bus has a very fast IO, for which
+      different locking methods should be used to reduce
+      overhead (e.g. spinlock instead of mutex).
+    type: boolean
+
   hwlocks:
     maxItems: 1
     description:
       Reference to a phandle of a hardware spinlock provider node.
 
+if:
+  required:
+    - hwlocks
+then:
+  not:
+    required:
+      - fast-io
+
 required:
   - compatible
   - reg
-- 
2.35.1

