Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870744FC07A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347902AbiDKPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347861AbiDKPZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D43BBE4;
        Mon, 11 Apr 2022 08:22:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h126-20020a1c2184000000b0038eb17fb7d6so3751454wmh.2;
        Mon, 11 Apr 2022 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJAJib2gJSjDFpJZLEr0WrYni5c/odHFzzzrK2oaLMs=;
        b=qotKL6IwNlpMly192A7eHkVzVYvutYGSQcgUdjMNV/97YsLxHmix4aUzvDrXDgMBXa
         hKddXJzfXtSH7HIs8Ge2u7bXMe6OjV2U6po97fO8sJOmXUMaDFAU0XwtMzFFR23BP1/x
         WeDhWdBfNl8jF1Z18jGeoW06lS2JW9xYiW9Vn4cAh6lAd8Teb0kz2c35mT3VLnx6V/hd
         vW1i2ndwMRdO1NqXhArld84EmC9k8FrXleg6kZGB6vFfSbW3N0EBlRJcZCfkaS4fiw4L
         +1ICG2zwbsxeYPOD8lqgtzSHN+PiuqEY6dLzvYKzFCJn6tCVCd+8xvnKUApl/nHWe9w+
         DQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJAJib2gJSjDFpJZLEr0WrYni5c/odHFzzzrK2oaLMs=;
        b=jVmN5ujLYv9ewE/QR6kyIVl7sgwAD3BRNC87hQ6FYYt7WjaEh2w6bexveS3I9Sb6nE
         /s9VM+U9x3iZ4VGVU7pOrkTgLLeHd2RWofet0U/fSm8/EJLS/PvQ+NGDSyD42tb6zzFw
         i2j8GfyDX0bKgtIGqCxZaIuB59a50pXZkAGt+3bj4IT/GQmB0EPnZ30HQbMa3A139oWz
         ZQQFURHU47Ha8zmslQUSATbpwqs7e1+WedsYStXM8gZT64z8ek6IiJheIXlcviWHOjFu
         CgMfRewPaEFdxJsLpOIapmiIrzAxYd5SrhDRaQEipZTqG43Z+nts+cWiP4f8OkItL4G0
         KU1w==
X-Gm-Message-State: AOAM530mpKYLH7woJbV2ZL62c1zEw5Yqjc1IcV20v1Yng7LHJwna+bcj
        IDw9HXDB9pax6uVKNMA6yOI=
X-Google-Smtp-Source: ABdhPJxsCe87T5NI+JgIiJE/qfCIQTcZi/H4ZY84pU191xklSL3JJ6mrYDzYZWFd0iknWdI1IEiIIA==
X-Received: by 2002:a05:600c:4f87:b0:38c:adde:1d99 with SMTP id n7-20020a05600c4f8700b0038cadde1d99mr29149033wmq.16.1649690568265;
        Mon, 11 Apr 2022 08:22:48 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:47 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] dt-bindings: arm: fsl: imx6dl-colibri: Drop dedicated v1.1 bindings
Date:   Mon, 11 Apr 2022 17:22:21 +0200
Message-Id: <20220411152234.12678-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

The dedicated device tree for V1.1 modules has been dropped. Remove
its bindings too.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- Added Rob's Ack

 Documentation/devicetree/bindings/arm/fsl.yaml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..cf97171506ca 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -411,7 +411,6 @@ properties:
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
               - toradex,colibri_imx6dl      # Colibri iMX6 Modules
-              - toradex,colibri_imx6dl-v1_1 # Colibri iMX6 V1.1 Modules
               - udoo,imx6dl-udoo          # Udoo i.MX6 Dual-lite Board
               - vdl,lanmcu                # Van der Laan LANMCU board
               - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Board
@@ -492,13 +491,6 @@ properties:
           - const: toradex,colibri_imx6dl           # Colibri iMX6DL/S Module
           - const: fsl,imx6dl
 
-      - description: i.MX6DL Boards with Toradex Colibri iMX6DL/S V1.1 Modules
-        items:
-          - enum:
-              - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6DL/S V1.1 M. on Colibri Evaluation Board V3
-          - const: toradex,colibri_imx6dl-v1_1      # Colibri iMX6DL/S V1.1 Module
-          - const: fsl,imx6dl
-
       - description: i.MX6S DHCOM DRC02 Board
         items:
           - const: dh,imx6s-dhcom-drc02
-- 
2.20.1

