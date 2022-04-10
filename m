Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C26A4FAFCB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbiDJTiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiDJTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:38:09 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C545675F;
        Sun, 10 Apr 2022 12:35:57 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 9so16459296iou.5;
        Sun, 10 Apr 2022 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OoM9N7gAcL1d/1QfBxr0+hst6MaoVrluKO3H52z5ckY=;
        b=SxbSn+vQ0He6FR1PGQmKjJijrpOeLnxsh7NJhXocRKQ7uyLDjtjzslL+t/TpdFHrW6
         duOfC+PHPVcurOnpGQ37UtqjNc8yEJePYta3p9W6BQdGqBjQHtP+l15xlJ2dYgJ/U1X/
         8jHdC+SHGG7yRXrHlA9UQNyQ2lkhvB5wBaM36EbHRsW9D3sZiuJ8FtPfs+zZHNrRu96S
         HcwsNFLDJOCdLWw2ADCEdoU36xu9Ha9fVu+dxpezLJIVuTWW2t5wMOdD4bikgoaAJ0hu
         zDjFaVAgWou4Vm9Cdipy5Nb8D8KX0s+O1vEGJj4bI2aUpLe0RjE5yA53Qu56wEoVu4J6
         q6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OoM9N7gAcL1d/1QfBxr0+hst6MaoVrluKO3H52z5ckY=;
        b=GzlAs5jFUIz4JwMTI726+OWsEV27uVFCRIIrpIkkDXOxj8/SaMgBZ9vHIN+ZziLRD1
         YMmLTwPAHhvHLJRplGhCxsFaqMmCT9b3OEoINFQ3WZhlhtTA1YUd8ocggFkw165Hx0VS
         cXOIv7khGkQ1SdRHkYlex41JdNZM8I88cSFcA62yJYdBLFcKAk/VzUk+1CgvU/UpwEVF
         0ki5Tg05poNKbz7WglSc938NVKloJvTO6t9T9CcMojarrSZq28dnhhzx4zNyO0l4VXr0
         Hb9tJk3ZXWn4FxgnUZDJi8VQ0kBimY8fDxSkyk98PX/G96Gpprw4FMZvsAB9r32bMSLn
         B4QQ==
X-Gm-Message-State: AOAM532fO0Bb2cOlXIw7Btmv0KFUnTTRexMGN2htYHvOd53E3Z+y7QiR
        a309qWSIgFo196kh+UQ2Xlfsh4x7Kfw=
X-Google-Smtp-Source: ABdhPJxBgn0fjnm8kPAHoN3v+ZE7RGxfdnz/32Jw7hl3KO7lGjTHAZrwur9qH+22pIu7Py0o1R6aSA==
X-Received: by 2002:a6b:b786:0:b0:645:b8e7:2d1d with SMTP id h128-20020a6bb786000000b00645b8e72d1dmr12083391iof.52.1649619356614;
        Sun, 10 Apr 2022 12:35:56 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:1e67:6f3b:4d7f:4f90])
        by smtp.gmail.com with ESMTPSA id m6-20020a923f06000000b002ca74f4fab2sm7218409ila.14.2022.04.10.12.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 12:35:55 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        haibo.chen@nxp.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/3] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
Date:   Sun, 10 Apr 2022 14:35:41 -0500
Message-Id: <20220410193544.1745684-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Mark the current state of the fallbacks as deprecated, and add the
proper fallbacks so in the future, the deprecated combination can be
removed and prevent any future devices from using the wrong fallback.

Suggested-by: haibo.chen@nxp.com
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:  Mark deprecated items with "deprecated: true" instead of a comment
V3:  Add support for the interim fallback on imx8mn and imx8mp where
     they both fallback to imx8mm, but keep the imx7d to prevent any
     breakage.

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 7dbbcae9485c..58447095f000 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -34,22 +34,46 @@ properties:
           - fsl,imx6ull-usdhc
           - fsl,imx7d-usdhc
           - fsl,imx7ulp-usdhc
+          - fsl,imx8mm-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
+      - items:
+          - enum:
+              - fsl,imx8mq-usdhc
+          - const: fsl,imx7d-usdhc
+      - items:
+          - enum:
+              - fsl,imx8mn-usdhc
+              - fsl,imx8mp-usdhc
+              - fsl,imx93-usdhc
+              - fsl,imx8ulp-usdhc
+          - const: fsl,imx8mm-usdhc
+      - items:
+          - enum:
+              - fsl,imx8qm-usdhc
+          - const: fsl,imx8qxp-usdhc
       - items:
           - enum:
               - fsl,imx8mm-usdhc
               - fsl,imx8mn-usdhc
               - fsl,imx8mp-usdhc
-              - fsl,imx8mq-usdhc
               - fsl,imx8qm-usdhc
               - fsl,imx8qxp-usdhc
           - const: fsl,imx7d-usdhc
+        deprecated: true
       - items:
           - enum:
-              - fsl,imx93-usdhc
-              - fsl,imx8ulp-usdhc
+              - fsl,imx8mn-usdhc
+              - fsl,imx8mp-usdhc
           - const: fsl,imx8mm-usdhc
+          - const: fsl,imx7d-usdhc
+        deprecated: true
+      - items:
+          - enum:
+              - fsl,imx8qm-usdhc
+          - const: fsl,imx8qxp-usdhc
+          - const: fsl,imx7d-usdhc
+        deprecated: true
 
   reg:
     maxItems: 1
-- 
2.34.1

