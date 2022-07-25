Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7708957FB20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiGYIT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiGYITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:19:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A213CF7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso5872101wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1uBINhkXj5CiEZH5/8Pm1Qj/TstsEH9+dcozESvLJgY=;
        b=4VWKR6bZmkYqrWq3HipPRaTMH3acCvx2/KBXfW0kxl0JLH2/QaFB5eScM72+FYuodm
         1Ps0q3GVeNhtTBshvFoBo3Tg+luJAwRx41Xw2WtnWBJxDGW50QVjM//ZZ7wJvEAAosnM
         +Cpv9WmVQCiCmjmJ29j2Y2wEiCmig/9I5iyCVcpCZU1JQbrbcqLFkcPaZk6vTFVvSO4k
         r8HNjXFoAY4onmMo4mvQFeERGQPpAGzZMSpw4mwbD9NsJwuInYdD0TxA5EmnAe/IvGxy
         VFPQIIeLE0FjcUp5Z8aNVQnik0SGEXiA3bBapqYfkjetq4LhdY5qx9raqdGyxVn92K0p
         hIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1uBINhkXj5CiEZH5/8Pm1Qj/TstsEH9+dcozESvLJgY=;
        b=5UjJR2o5A+/Myg6GqLlZBEVsZMLzNUwkhf9tQCHIHdLpstk5RE6faLmbnO0XVOxTFl
         GX/UaEWSZo3JFanCXXHM7lUEaIfTwrzdYVRVQ3GB0YfqA7dxPEDZu1Wlc/CmxDFrHlnN
         lGfSoYSi+cv8WEWuKTTdwIdn4W5M7ltCq40ReNEE6F0FDsRKUmRSWsyIY7QyFq+ilmIq
         Ejfg3KMaan8xtIH2D7VSOiaIixoaTA4yHiCLeCun1jO3CAb4HUwB7/O/A6+EJLhuP4E+
         AnQ43Z1c8sIMFNe+G61ZZosbenR14BeUz87lmOsKmcgUY+eyNlPS1f/NMc7XDS3AsDRI
         HcfQ==
X-Gm-Message-State: AJIora8ioGqmWAHNE1oevA71Ft8Re0K0IsYsf7Z4A44qSW/w76C7GFEG
        Ipo7ws1O3kn9Nejbp4KTxFKzfQ==
X-Google-Smtp-Source: AGRyM1vVJst7/Aus6G68zbPeB5sjlhQjFaxS3scwhOLz5W4CplCDcGNlIQKvOud+yzBrYFf/TaeraA==
X-Received: by 2002:a7b:c851:0:b0:3a3:19df:2673 with SMTP id c17-20020a7bc851000000b003a319df2673mr7533079wml.75.1658737148896;
        Mon, 25 Jul 2022 01:19:08 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a243:806e:25e7:daa:8208:ceb])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm16695264wmh.33.2022.07.25.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 01:19:08 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 1/4] dt-bindings: power: Add MT8365 power domains
Date:   Mon, 25 Jul 2022 10:18:50 +0200
Message-Id: <20220725081853.1636444-2-msp@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725081853.1636444-1-msp@baylibre.com>
References: <20220725081853.1636444-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add power domains dt-bindings for MT8365.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    Changes in v2:
    - Made include/dt-bindings/power/mt8365-power.h dual-license.

 .../power/mediatek,power-controller.yaml      |  2 ++
 include/dt-bindings/power/mt8365-power.h      | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8365-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 135c6f722091..2c6d3e4246b2 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -29,6 +29,7 @@ properties:
       - mediatek,mt8186-power-controller
       - mediatek,mt8192-power-controller
       - mediatek,mt8195-power-controller
+      - mediatek,mt8365-power-controller
 
   '#power-domain-cells':
     const: 1
@@ -67,6 +68,7 @@ patternProperties:
               "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
               "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
               "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
+              "include/dt-bindings/power/mt8365-power.h" - for MT8365 type power domain.
         maxItems: 1
 
       clocks:
diff --git a/include/dt-bindings/power/mt8365-power.h b/include/dt-bindings/power/mt8365-power.h
new file mode 100644
index 000000000000..e6cfd0ec7871
--- /dev/null
+++ b/include/dt-bindings/power/mt8365-power.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8365_POWER_H
+#define _DT_BINDINGS_POWER_MT8365_POWER_H
+
+#define MT8365_POWER_DOMAIN_MM		0
+#define MT8365_POWER_DOMAIN_CONN	1
+#define MT8365_POWER_DOMAIN_MFG		2
+#define MT8365_POWER_DOMAIN_AUDIO	3
+#define MT8365_POWER_DOMAIN_CAM		4
+#define MT8365_POWER_DOMAIN_DSP		5
+#define MT8365_POWER_DOMAIN_VDEC	6
+#define MT8365_POWER_DOMAIN_VENC	7
+#define MT8365_POWER_DOMAIN_APU		8
+
+#endif /* _DT_BINDINGS_POWER_MT8365_POWER_H */
-- 
2.36.1

