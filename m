Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAD579617
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbiGSJSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiGSJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:17:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37608220C3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk26so20619849wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2cq2f4gsqT38Y5X3SDISvBVmQ+0SNOYPEuSXySidWQ=;
        b=Wb3wgHkeRrKQxt/ruuLete1XtM9dgGHYJgGrI2oVSe4qtTwDR6pWW4+8W1xONMtei+
         4ok5giAepngi1PKCfZURhIrG8BAsgOJyc4U+1qZnps+/0i5C3L7QpPCZmT61umFGs616
         RZFEV89eE2OzQvuzcX/gVBRI/N7YnQK9Ir8n7ybe5hWucGqVCWAkoa270s9G2s/nZONZ
         vzlJ+nsi/C1G7eQuGugCE8i4ncTJaSFVNtJNR2KQzgTn4TmYEdegT/5Ftpefu2PN+1UV
         ijDcY23TWJa64uNE664R64MbL9hhrP0xC50ZoZdeRyDhibxaMb8+QTrSt6XsEIz5b0i8
         GCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2cq2f4gsqT38Y5X3SDISvBVmQ+0SNOYPEuSXySidWQ=;
        b=KdY01FfsqITFm8mjVGvSLq3mqoGxdk791L7+/l+mqJSHhFzn5MgFuglGA7NV0LGTUH
         YEB6pR56sFUGGzyiwwevQ72LZAd/+IkqXCQslxEIfQ0bD2mEmJkH1XQwfVttlOIH+kgw
         H8LlO8XvVicpb4Si+7tS2MJ8CfH9++8k8Q6MyZvgleTmcLl2IbhUG8sJRnFmJdURH8MB
         y1ebEpGYT8Wp9DTWgr7cY14SQz/QikI8bcxiZxfPTgxyziTj7f1C8Vj76YsHZc77KyMD
         Rn9db7Ry2P34Wd+DblVcKmsRAzouJ96MHvssRakYjaMghK2X9Dk+tV1BYsXclEzK7I7x
         qxJA==
X-Gm-Message-State: AJIora+lskYBPP9aSOjNQY4GQTCbKK1vEblv+37zGWftDzC4KXGBBD6Y
        HXD8jPhLKOix1eeRcsTSlPSQJH9bOe2Mkg==
X-Google-Smtp-Source: AGRyM1uXPplmrT3YM1LVUa3KUvhxwsTgkdFEUsG9NkBsnYNKcQQARoFpyXfbfG1F2ZapCNIXKVlEOQ==
X-Received: by 2002:a05:6000:250:b0:21d:b3b5:3438 with SMTP id m16-20020a056000025000b0021db3b53438mr24127233wrz.203.1658222275768;
        Tue, 19 Jul 2022 02:17:55 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:17:55 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 04/14] regulator: dt-bindings: tps65219: Add power-button property
Date:   Tue, 19 Jul 2022 11:17:32 +0200
Message-Id: <20220719091742.3221-5-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

Add a power-button property to configure the EN/PB/VSENSE pin as a
powerbutton.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
index 6a60e62a313c..3f7f4c0280c3 100644
--- a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
@@ -36,6 +36,11 @@ properties:
       include/dt-bindings/interrupt-controller/irq.h
     const: 1
 
+  power-button:
+    type: boolean
+    description: Optional property that sets the EN/PB/VSENSE pin to be a
+      power-button.
+
 patternProperties:
   "^buck[1-3]-supply$":
     description: Input supply phandle of one regulator.
-- 
2.17.1

