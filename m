Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D214F05E5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbiDBTlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344315AbiDBTlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:41:47 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D9E5BD03;
        Sat,  2 Apr 2022 12:39:54 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id 8so4191097ilq.4;
        Sat, 02 Apr 2022 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qk+7Fg1Zoh8JjazLypzcfYRZulzMbo4YuMWQZUu9Rmo=;
        b=NyymN1uEmKv3L742+Ma6teYe+Mu9M9cUhovjD9CR5MlApKgvyrC53C8Fe/YsVJiQik
         F/qhAVFBHDVepiA9zCdmlteOpE4dgxZ0vzznKpnSuwXKNOtcvfWYL+jzdpb4sLYg/nef
         q1VvmshzjTso1IP37yUz2iIBay6prVjdvqjn5ZKAxwhkPHBwE0WXCRnmf0qbXn6RLwXD
         rLJ9gg9mZ88U5ckNWwj5zU2b7LT6wIDUfVObu+xSjXo0woJDBoSXZknOEeDJLua0NDyv
         8BkloeRpFt9xg0PsmdLdQxFjzKm/xN0+1/jLSBvPMEyNLS1+JvjhkBaBZREU7fdP90zT
         1l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qk+7Fg1Zoh8JjazLypzcfYRZulzMbo4YuMWQZUu9Rmo=;
        b=DUN/jCauPj9z4tPYLp6Rz+yMm+IuvM/B6ngYtpYfU0nN+z11kjpnKR1TNSQA8sSxsr
         d50a451vWxeY/XhqD/bueMYlNJDbDVlq8qh1SffCCtmH/Ef3TdDh8CMUKNFUNSkM9D37
         fg3FE3oFcNUBh+dJJTlGOxKK/f18noecDjJRuRCNZ1lVF7qRKjHuxz9NQJTFJnHYvJTD
         cVWMOsxdrawK9f1CioMrKzTiBMG1pk4brl4yAMUe1ErgYnr1XGGutj/tjVJLlexHTbVA
         oW51e5SYioI63Jxds5scbmMvEZQjh0a5HIOpKdeAl05CcIRNAY/HN7N6H8oF/7Z0XzKv
         5ahA==
X-Gm-Message-State: AOAM533agHia78IR63EIAROG0c0HbUCljddCJnz5mo3h3BF72Voig6ZI
        61QwA/OobABT+mdJn6bNh3sKq8eav5LRvQ==
X-Google-Smtp-Source: ABdhPJwO9Cu3DTwuQ7YnaGBlaodb7nn2ATOa+6kpgNs3kj4GgKRCCPZUVtBFvIhAsPocfcuYIo5ZWQ==
X-Received: by 2002:a92:c247:0:b0:2ca:8e7:58c3 with SMTP id k7-20020a92c247000000b002ca08e758c3mr2448917ilo.40.1648928393148;
        Sat, 02 Apr 2022 12:39:53 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6ab1:a455:ad1b:e8da])
        by smtp.gmail.com with ESMTPSA id a14-20020a056e020e0e00b002c9e2f0fd76sm3261756ilk.13.2022.04.02.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:39:52 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     haibo.chen@nxp.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
Date:   Sat,  2 Apr 2022 14:39:39 -0500
Message-Id: <20220402193942.744737-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220402193942.744737-1-aford173@gmail.com>
References: <20220402193942.744737-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDHC controller in the imx8mn and imx8mp have the same controller
as the imx8mm which is slightly different than that of the imx7d.
Using the fallback of the imx8mm enables the controllers to support
HS400-ES which is not available on the imx7d. After discussion with NXP,
it turns out that the imx8qm should fall back to the imx8qxp, because
those have some additional flags not present in the imx8mm.

Suggested-by: haibo.chen@nxp.com
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Marked the imx7d-usdhc as deprecated when there are better
     fallback options or the fallback isn't needed.
     Leave the deprecated fallback in the YAML to prevent errors
     Remove Reviewed-by from Krzysztof Kozlowski due to the above

V2:  Update the table per recomendation from Haibo.

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 7dbbcae9485c..11f039320d79 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -34,23 +34,34 @@ properties:
           - fsl,imx6ull-usdhc
           - fsl,imx7d-usdhc
           - fsl,imx7ulp-usdhc
+          - fsl,imx8mm-usdhc
+          - fsl,imx8qxp-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
       - items:
           - enum:
               - fsl,imx8mm-usdhc
+              - fsl,imx8mq-usdhc
+            # fsl,imx7d-usdhc fallback is deprecated for imx8mm-usdhc
+          - const: fsl,imx7d-usdhc
+      - items:
+          - enum:
               - fsl,imx8mn-usdhc
               - fsl,imx8mp-usdhc
-              - fsl,imx8mq-usdhc
-              - fsl,imx8qm-usdhc
-              - fsl,imx8qxp-usdhc
+          - const: fsl,imx8mm-usdhc
+            # fsl,imx7d-usdhc fallback is deprecated
           - const: fsl,imx7d-usdhc
       - items:
           - enum:
-              - fsl,imx93-usdhc
               - fsl,imx8ulp-usdhc
+              - fsl,imx93-usdhc
           - const: fsl,imx8mm-usdhc
-
+      - items:
+          - enum:
+              - fsl,imx8qm-usdhc
+          - const: fsl,imx8qxp-usdhc
+            # fsl,imx7d-usdhc fallback is deprecated
+          - const: fsl,imx7d-usdhc
   reg:
     maxItems: 1
 
-- 
2.34.1

