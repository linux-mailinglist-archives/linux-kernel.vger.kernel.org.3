Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164725371AF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 17:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiE2Prc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiE2Pra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 11:47:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E09694B4
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 08:47:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s24so4414468wrb.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnKqeTPuz31MP8DkEz9vuj/dviTwiPnr2/Rmul7p7v0=;
        b=8XjeiF9dLX/F73sAN7jeHWEZLMLKRNbLyw6jpLljeZcZg+OoGSjNTRc6ZoajO/5wvg
         cad2nHEOy1MaqJdoPrdrV0nwtCyOIxLIJMCc8SB04mfmGu7B14Pn0+0HGHHV7dFaWm+H
         ztfLfrmEp1V4sXew+sJJV1gaxM6VxIY50hh9+S70ElnUYq9zH1RQIPgF7/Otd0WiPBut
         kCrGD4oOBJ6PdziomJL62cr31LuB/ObkkskAwpS9Nw28dYXEFgFwzaG0pAgjw6y+eRGv
         i5nWKASomuOe+J7WB4t266/wylOzHuzdGPcRCe5CrGYIApp1x96Vc1gJaPVvkmg2NqNU
         rgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnKqeTPuz31MP8DkEz9vuj/dviTwiPnr2/Rmul7p7v0=;
        b=vVMF5PgX0D9c+X+g5fU7+fIiMUZr9Ac8wAHTLpR67nKZwTQJiArw5Evnd8qqKcIIxO
         FBZg3FNX+VkkDT95dRXbwJ1gPytdwhIwlCPcDyYEFgduf2L0n/6Oyg+qmiGj29KkeFst
         OJKFPdziD4f469m8F4Nb2PVCAvd9ZzNhnVvV4nu7S8OPz8F1c2GQ1/C8/eVTMVTcLqTP
         qXzM8Q25gWvTeS4ZCb2UbBuEB27GpjYgK1evDWs1b28VbNayThuBeIFo7UekjvvHpMm9
         Xu1R5uhPv2trQRIatzkuWmX36optXl3QY68Etmm8iuY+MyPcOuHwZ5Pt+WDeXWMoWe3o
         gvKA==
X-Gm-Message-State: AOAM531muUWtuiaiOSQvxzwkv264dy+3Ai+0bUAImpElXUIuTOt5PtCO
        bXeCyEGOi72thKL53wTWvz/75Q==
X-Google-Smtp-Source: ABdhPJyJU60U7IvzKvUdTZ/qiORiBeb9Mht2Jqd7Q6qxgDKpWe+tfKckKrUT+DlJwG1A/b6NnHsI3Q==
X-Received: by 2002:a05:6000:2cc:b0:20d:e6c:e4f8 with SMTP id o12-20020a05600002cc00b0020d0e6ce4f8mr41592097wry.374.1653839245826;
        Sun, 29 May 2022 08:47:25 -0700 (PDT)
Received: from helium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id i2-20020a1c5402000000b003972dcfb614sm7549942wmb.14.2022.05.29.08.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 08:47:25 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: regulator: mt6315-regulator: fix invalid allowed mode
Date:   Sun, 29 May 2022 17:46:13 +0200
Message-Id: <20220529154613.337559-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the binding example, the regulator mode 4 is shown as a valid mode,
but the driver actually only support mode 0 to 2:

This generates an error in dmesg when copy/pasting the binding example:
[    0.306080] vbuck1: invalid regulator-allowed-modes element 4
[    0.307290] vbuck2: invalid regulator-allowed-modes element 4

This commit fixes this error by removing the invalid mode from the
examples.

Fixes: 977fb5b58469 ("regulator: document binding for MT6315 regulator")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/regulator/mt6315-regulator.yaml       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
index 5d2d989de893..37402c370fbb 100644
--- a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
@@ -55,7 +55,7 @@ examples:
           regulator-min-microvolt = <300000>;
           regulator-max-microvolt = <1193750>;
           regulator-enable-ramp-delay = <256>;
-          regulator-allowed-modes = <0 1 2 4>;
+          regulator-allowed-modes = <0 1 2>;
         };
 
         vbuck3 {
@@ -63,7 +63,7 @@ examples:
           regulator-min-microvolt = <300000>;
           regulator-max-microvolt = <1193750>;
           regulator-enable-ramp-delay = <256>;
-          regulator-allowed-modes = <0 1 2 4>;
+          regulator-allowed-modes = <0 1 2>;
         };
       };
     };
-- 
2.36.1

