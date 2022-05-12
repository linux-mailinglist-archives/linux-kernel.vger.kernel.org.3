Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E531524CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353704AbiELMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353676AbiELMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:24:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C5B248E29
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so5037052wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/vo83decuajkRrKEOpC1GzPZTUXB5e+eKL6t2IioWU=;
        b=qrZVmCr4+Kam5J5VAbk3WUFfCf19Xux9cw0bcqcO04gU3ydSFxVkqFQf+wrCt3IH8n
         q/IU6+KUbiEQe0Omod83VJY4kdbiut8tJZOZ1NGloiTo4jbupWjISwtFa6nAlWQZPv1j
         /paqUE5V13OzgyVhBWVHCPVJm5OHtbCsU7Y9OtFPtkXxA5h1WdyDtdHevW49DI6SHUvf
         d8Dnz5cVV8Kvb4EykZBVWMcK6c/3igHe3lBxdFrBDF78G3hyh3fh6N6jbDrMYHz3AZlb
         wnzIj0YDS8eu05D0a6PYEgIeIQDvkT08/d7Jkw6JqVAp93r7AeiTYICwOe5HT8n7Q0S9
         K6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/vo83decuajkRrKEOpC1GzPZTUXB5e+eKL6t2IioWU=;
        b=NcHV5rClsouPs8Hd/2FJM//e+IllAWGsDH3QvwhGMm8FWyFwvEqEFo0+19NAXv5U4U
         eWrjaXC2or+pdgaecElQfaQjsXUngMxlXfZa/WfdBqeYTKp8viZlhj9P2C7ghg6688vq
         WCaz958TcjJPw+TDU6szKtBCAp5tVjbx2yYdxRg3LKMg/UFZM2PURH86kJsoX5EEAu6L
         GBqUQGuoGPzCQpn6LLM6wgYa9zA/cB46MucFnCcTKB9wmzt3FpgHvwRtEkYHbaMQGaHf
         xgs10C+Y9cHqouZfpvpL/KjFCQ7gQTn1SM+UtyH9aKGyW/oIHUu7PqB2RbQ1iMn3Geh4
         VQig==
X-Gm-Message-State: AOAM532MGu8vSuigvaJd3k3BsisykdrfAwMrson1ReT2y/mvGPSmxmxv
        V907oubEBdpJWFhAvpMogAZeRQ==
X-Google-Smtp-Source: ABdhPJyriTjj+xEsQg0Rd8dZU3OKFWfF/Q7++pVpnNRF2car0YMBp3BYa8rH7qnU6+ejyHZQ7w1hOw==
X-Received: by 2002:a05:600c:1e89:b0:394:9587:cbe0 with SMTP id be9-20020a05600c1e8900b003949587cbe0mr9917994wmb.89.1652358281444;
        Thu, 12 May 2022 05:24:41 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc156000000b003942a244f30sm3047819wmi.9.2022.05.12.05.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:24:41 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, michael.kao@mediatek.com,
        ben.tseng@mediatek.com, ethan.chang@mediatek.com,
        frank-w@public-files.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v6 4/7] dt-bindings: thermal: Add binding document for mt8195 thermal controller
Date:   Thu, 12 May 2022 14:24:30 +0200
Message-Id: <20220512122433.1399802-5-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512122433.1399802-1-abailon@baylibre.com>
References: <20220512122433.1399802-1-abailon@baylibre.com>
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

This patch adds binding document for mt8195 thermal controller.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../devicetree/bindings/thermal/mediatek-thermal-lvts.yaml  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
index 69ffe7b14c21..2e1ae00d4fd1 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
@@ -12,7 +12,11 @@ maintainers:
 
 properties:
   compatible:
-    const: mediatek,mt6873-lvts
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt6873-lvts
+              - mediatek,mt8195-lvts
 
   reg:
     maxItems: 1
-- 
2.35.1

