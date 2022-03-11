Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339BE4D66BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350481AbiCKQsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350576AbiCKQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:48:01 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544AA1CCB0F;
        Fri, 11 Mar 2022 08:46:58 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m2so8171623pll.0;
        Fri, 11 Mar 2022 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0evMKcNHbnEUU3UUblkb4v6Qg7HJ0pQwF4PG/exC3S8=;
        b=I00/VYry8gLudKRXnfL7MVmXm0qror0wvEUtHg1CLQzMIV9uiHVPZaHop/PNDulqBQ
         5EQnA8J2q+zstl3dpVYBi2jol25YU3FO9lARnOv0CELHVAT3UGuqTPfM3f/mJkdS83aF
         gLfmZN731iV3Cs3oX6CAUnVEr0XQKbI4lYEpWpIIpkjXbefoGij+zJr6q6SJbih31AVO
         nv4XZXvwh1OSVbBG1IUG1A82BBu0+9pSLnSIHyeMJ0a/f2o8BSm+7ROCTPq8cGGjeFlZ
         8wEDThqF+b6EZxKnuz5MbUAndOEefZaXXyDvMb02oOhz/kpuNixT7rTQiiHAYgWJce4K
         bDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0evMKcNHbnEUU3UUblkb4v6Qg7HJ0pQwF4PG/exC3S8=;
        b=iCmXQscCO3g6xNjnLJsctv+iAikwxrl1h8dJmtMiaArWOwV8StC41VUX96hPCZuVV4
         NNsqiLbSqDfsluSWNXLj5DigVBqP9zHYzNppJ26NtYMiMEimxQOOGY3hLEUZh+t+rYP3
         uupLxFsJ7NeHXC8nZzvozUt+2rdQ/uqhsog7DcjJ172S2o0nfV8S3ABzD6QSyrn3tB0V
         h+Iyfpi5kKkGfxv0+mYmfz5Vi/sRzD22mvHRdBRXxZ+5khexk2LLGfQq9jsc8T3hw5zP
         WDddntGbl45+0dmkcVhmeWgisrjk+n5F8tPbRZYdvrWhXlYy0vnU9fpjAW1V1IIYJolq
         PH9Q==
X-Gm-Message-State: AOAM531ast3JcRd0fmxIF5HYV1KkA1sfJUeZTSKlL1jiPHHgr/HK2yEY
        8D5GjONA/ZwEqKKdTnv5Nmk=
X-Google-Smtp-Source: ABdhPJz5x9eAY4loAdPf+lg8yXW2S+E6UlbsjJ6QSIb1JBgAEhuPf4kfwkpIrBTVDcKiJUhfJMOu8g==
X-Received: by 2002:a17:903:192:b0:151:8df9:6cdb with SMTP id z18-20020a170903019200b001518df96cdbmr11536377plg.20.1647017217824;
        Fri, 11 Mar 2022 08:46:57 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm11107869pfx.81.2022.03.11.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:46:57 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc dtbindings
Date:   Sat, 12 Mar 2022 00:46:22 +0800
Message-Id: <20220311164628.378849-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311164628.378849-1-gengcixi@gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

sprd,ump9620-adc is one variant of sc27xx series, add ump9620 in
dtbindings.

Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
index caa3ee0b4b8c..331b08fb1761 100644
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
@@ -20,6 +20,7 @@ properties:
       - sprd,sc2723-adc
       - sprd,sc2730-adc
       - sprd,sc2731-adc
+      - sprd,ump9620-adc
 
   reg:
     maxItems: 1
@@ -37,9 +38,32 @@ properties:
     maxItems: 2
 
   nvmem-cell-names:
-    items:
-      - const: big_scale_calib
-      - const: small_scale_calib
+    description: Names for each nvmem-cells specified.
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - sprd,ump9620-adc
+then:
+  properties:
+    nvmem-cell-names:
+      items:
+        - const: big_scale_calib
+        - const: small_scale_calib
+
+else:
+  properties:
+    nvmem-cell-names:
+      items:
+        - const: big_scale_calib1
+        - const: big_scale_calib2
+        - const: small_scale_calib1
+        - const: small_scale_calib2
+        - const: vbat_det_cal1
+        - const: vbat_det_cal2
 
 required:
   - compatible
-- 
2.25.1

