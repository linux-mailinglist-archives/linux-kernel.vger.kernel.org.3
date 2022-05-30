Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF81538770
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbiE3Sir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242848AbiE3Sin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:38:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91B88D6A4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:38:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p19so6882550wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAZcIMVkbwQAZDaJSRG1uLvlbaEmw/pRqP3mytMc9Sk=;
        b=SSgqIfRN0e3iUy0WuvEyWAskLlKpZcfPbBZyeZwWyTWSZlWlnExNurqhWYS8sLxgJs
         7AnGX6iYAE/6GhEXOEm2FfMW6r7e/yEPkJ+PrRGgT9Uj/cHp0YFa3cURpQV5JM8vr9jK
         BYkmPCoItCfRIsVO8xEq3T2KiHK34zxYxAOWzToJ25n563MLV64bq+nTA81GC7P+uShv
         OiLSM7gSyh/46FH92dhVAQW2MwUvMn0PthAI145pTEhIGJsGV0ginynxkdvOSaX0qeL7
         h6It4lXQuM/Tv4KXceslm6JN7BV1I2WEER5Ume6m6qw44SStThVESKEORJHCA4mSG3qy
         lYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAZcIMVkbwQAZDaJSRG1uLvlbaEmw/pRqP3mytMc9Sk=;
        b=xPWI6GGnUdIz0KpW3VZ2KBDVlyADrjBHHNIWcPHGrAgaLq9rbtyfBFMbYJPrW/W8PP
         TiUOXxWmJt9LKJn1yqwmUI8oGjeooFIJVxLsPQ8kKFIpRbHUPrG24l0ahN0LN8Iqw7zD
         CReSe1CewZ8S1LKrnq1fBMrQllk6clT37ma2n2WQ75CVm5D+V06NFkNa8zRAymTK/BAz
         RW/PQdKOsbSbZ84tkW7iq7IgRJ6BetZd4eJ2HyE+4KWst/J3gt7Rvl8lj1RlQzEPVjjV
         Z2E4MSFrEu3xnV1m9AuEngwVUjl64cibRntPYPbON5md4qYAStsSO5/FozUYPrckbcw7
         lMpQ==
X-Gm-Message-State: AOAM5319HwQhXgsl2jKXw2X2h7ZXsNch8YSzsTnlMvXcvrWbCXorSoLI
        iCXNWP4kG69zNOgWhWwsMRIZoA==
X-Google-Smtp-Source: ABdhPJynr97IYtN0ZgoGAiRMpzW0FEJgGKAE0GAOj8GidWDJahFEiTIA+vDnJ9z6b1hv/Uv3l1DE/A==
X-Received: by 2002:a05:600c:3799:b0:397:7c8c:bbd4 with SMTP id o25-20020a05600c379900b003977c8cbbd4mr19488928wmr.161.1653935919394;
        Mon, 30 May 2022 11:38:39 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe389000000b0020c5253d8fcsm11459088wrm.72.2022.05.30.11.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 11:38:38 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
Date:   Mon, 30 May 2022 20:38:31 +0200
Message-Id: <20220530183833.863040-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation for the thermal support on MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 5c7e7bdd029a..ba4ebffeade4 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -14,6 +14,7 @@ Required properties:
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
   - "mediatek,mt7622-thermal" : For MT7622 SoC
   - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
+  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
   - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
-- 
2.36.1

