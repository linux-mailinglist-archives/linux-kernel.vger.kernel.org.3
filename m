Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9D252F2AF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352704AbiETSbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352672AbiETSa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:30:56 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038E5F7B;
        Fri, 20 May 2022 11:30:53 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so6043590otf.11;
        Fri, 20 May 2022 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za+JFS8UrUe1EXtSy/HN8YRbGNE25Vj78rAPO0Rkf/g=;
        b=o6Tx0LzPHIhCpfrRIsc95kozM8a+KwgIDkmt8N/jDxvtQZqIPGgXK164juK2RVXwOX
         GWDJHgXi5NGg9NBQJW4Vru8DxkxlfjWiG9WGUekie0LgziLRuvTIraofgJp/QlQk+s7V
         h9dX77Ndbojz45f3QR2S2ixdbc2LTL5klQ31FbQUslkFOl02mqZQD3zxQL+tQWPlObFn
         o3WlsJVSE0FCUWnJ2aSMjlh6UJPgZ9UaW3fF2i16LEz2UpqpjPc+aYq/o2hT1jDa43er
         Qk6DY93E1MLDMXPBjXpIaT1IEEnwp53xeXkDon5AfzFpxgegcPzcR+nTiSMDBsQipGpL
         vk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za+JFS8UrUe1EXtSy/HN8YRbGNE25Vj78rAPO0Rkf/g=;
        b=tRb/vJysg58nsL3KZu/haW/hoksGbblbzSwu08JK7fhUd20T11zVuPwFRKNdtQoAFx
         CmRZ+Gi6CG7W/n+DXNx2gEm6bZzKkl2na/ppe7GJ6qmEE3bjFPrHMPbbdSPLYT08DeYU
         LqYvyAT5Nb4C10FI06rFNRnpsYftH+SzRT9fZxVpG6BMplcEoQ+92MT3C+HdCcP6cf2g
         vVSN2NDFUeG2jRaSQwyoxSzNPnnZWTYqR+tJhKbfZmrCFBWH93yCblVsSv3kTUV58i1b
         pGF8aXu/xS3TPtKczfRRGXxNG3M9kIMiOH9c/D+ivcN+d5cx0CpCLFItZBOaSuAG5L71
         J/vA==
X-Gm-Message-State: AOAM5315v3az6cTmk9wkiKpu1gQGUfQ3K7AkTDOw34qpSV3W9n4U5fLC
        Uacs8BF+Dl+Bgt0ETFg0kxNMWYuN73Ep5Q==
X-Google-Smtp-Source: ABdhPJyerJGQBYBXYu2NsSfmJk2S2dCsqe0iHzS308XxRXfoTAcER2mEziZSk7jviJ+AgOc+c/A+bw==
X-Received: by 2002:a9d:7dc2:0:b0:606:1ad9:9956 with SMTP id k2-20020a9d7dc2000000b006061ad99956mr4502990otn.214.1653071452656;
        Fri, 20 May 2022 11:30:52 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id w12-20020a4ab6cc000000b0035eb4e5a6d0sm1339467ooo.38.2022.05.20.11.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:30:52 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, sre@kernel.org, jon.lin@rock-chips.com,
        zyw@rock-chips.com, zhangqing@rock-chips.com,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND 1/4 v7] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Fri, 20 May 2022 13:30:34 -0500
Message-Id: <20220520183037.2566-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520183037.2566-1-macroalpha82@gmail.com>
References: <20220520183037.2566-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Create dt-binding documentation to document rk817 battery and charger
usage. New device-tree properties have been added.

- rockchip,resistor-sense-micro-ohms: The value in microohms of the
                                      sample resistor.
- rockchip,sleep-enter-current-microamp: The value in microamps of the
                                         sleep enter current.
- rockchip,sleep-filter-current: The value in microamps of the sleep
                                 filter current.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Note that this patch requires the following commit (still pending):
https://lore.kernel.org/linux-rockchip/20220519161731.1168-1-macroalpha82@gmail.com/

 .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index bfc1720adc43..d0dccb1aaf4c 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -117,6 +117,47 @@ properties:
         description:
           Describes if the microphone uses differential mode.
 
+  charger:
+    description: |
+      The child node for the charger to hold additional properties. If a
+      battery is not in use, this node can be omitted.
+    type: object
+    properties:
+      monitored-battery:
+        description: |
+          A phandle to a monitored battery node that contains a valid
+          value for:
+          charge-full-design-microamp-hours,
+          charge-term-current-microamp,
+          constant-charge-current-max-microamp,
+          constant-charge-voltage-max-microvolt,
+          voltage-max-design-microvolt,
+          voltage-min-design-microvolt,
+          and a valid ocv-capacity table.
+
+      rockchip,resistor-sense-micro-ohms:
+        description: |
+          Value in microohms of the battery sense resistor. This value is
+          used by the driver to set the correct divisor value to translate
+          ADC readings into the proper units of measure.
+        enum: [10000, 20000]
+
+      rockchip,sleep-enter-current-microamp:
+        description: |
+          Value in microamps of the sleep enter current for the charger.
+          Value is used by the driver to calibrate the relax threshold.
+
+      rockchip,sleep-filter-current-microamp:
+        description:
+          Value in microamps of the sleep filter current for the charger.
+          Value is used by the driver to derive the sleep sample current.
+
+    required:
+      - monitored-battery
+      - rockchip,resistor-sense-micro-ohms
+      - rockchip,sleep-enter-current-microamp
+      - rockchip,sleep-filter-current-microamp
+
 allOf:
   - if:
       properties:
@@ -323,6 +364,13 @@ examples:
                 };
             };
 
+            rk817_charger: charger {
+                monitored-battery = <&battery>;
+                rockchip,resistor-sense-micro-ohms = <10000>;
+                rockchip,sleep-enter-current-microamp = <300000>;
+                rockchip,sleep-filter-current-microamp = <100000>;
+            };
+
             rk817_codec: codec {
                 rockchip,mic-in-differential;
             };
-- 
2.25.1

