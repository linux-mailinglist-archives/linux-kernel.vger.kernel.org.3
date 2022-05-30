Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35EF538405
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiE3OzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbiE3Ono (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 10:43:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9012749
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:55:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h5so6664437wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZM5eYcuIY3/VuL1Woj6kSDisyNbm6FYEhsWCF5AlxTQ=;
        b=S37b2Djh5PZwJVNwauCbaYraC21CjX03rx/iQFhFOYUtKB971JORGxK89ePlyNFzxr
         pO2ZzDwk40Axo8A1xqsSkPEWbpKM1O1zPG9J5mBvsOk2cN/ePewdLaM7ZysPdcGdS22v
         tNQb3HK3nGxIbiLILgjd2odLwh+n0iqmHgK9k2I/5NJfwiXeF7QSUQz3ihn/yEblVkHP
         HNh9yaSnDFjdPneQIb9CdS4j+bOX4DvniIRn7PyROFWhHxCMiRKpImBIRKhO45tR4Y/S
         bAeeDkZNvO+QEiZlUeqtnYje9tEQyfHnp+pqZlWf36axIJw8HVuOWMOqZdGn1lQdHJj8
         2CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZM5eYcuIY3/VuL1Woj6kSDisyNbm6FYEhsWCF5AlxTQ=;
        b=gQjf9Ty24UEgmASnudPUusqrPPbpS74OjzSN/vRtfKZG9GrxO2Dp1QREvfAw6p4TdR
         CPXVVVEUAJWTbWYtsznMx2aIlmJa8UBalK49GABpLAuyKaEKWXXeD74+F5sNTuC3znbJ
         U9U++hX0vBF4tchPHbC4HW0jcADVavOjtUUq0GcMHlI+pTJJJi7Gvlom5To1j+pmMXl+
         LC/LY0LWYf+xfvUG2zB7CuTXcbftdnIe1ZXjZAgaqRUl7MZSvKD2kpXe7tLRqp6EdzZ7
         GdzPNq3gpTvJqZKL3d62CkhBVJlOfYrSly52cb9frfv/o4SbVCpxed2iudQ6JWn8ci7j
         s+KQ==
X-Gm-Message-State: AOAM530bvcnWwngytnLLdqyZsjMQREE66eerjfzWpxaJhhmZkGuPfsnt
        j2iEr/FKCRTZOwZLQ0PH/HNv1A==
X-Google-Smtp-Source: ABdhPJz4bx/yd7NERuUgiDWlU20pbMHsaQibRRol4g1P3jXWGbuvbaDgPUGuEW7ONxcStVl57WBYOQ==
X-Received: by 2002:a5d:4601:0:b0:20d:53a:2f39 with SMTP id t1-20020a5d4601000000b0020d053a2f39mr45981113wrq.347.1653918941461;
        Mon, 30 May 2022 06:55:41 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id w9-20020adfee49000000b0020cfed0bb7fsm9214856wro.53.2022.05.30.06.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:55:40 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: soc: mediatek: pwrap: add MT8365 SoC bindings
Date:   Mon, 30 May 2022 15:55:20 +0200
Message-Id: <20220530135522.762560-1-fparent@baylibre.com>
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

Add pwrap binding documentation for

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index 0581dbda4828..00b94601071e 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -29,6 +29,7 @@ Required properties in pwrap device node.
 	"mediatek,mt8183-pwrap" for MT8183 SoCs
 	"mediatek,mt8186-pwrap" for MT8186 SoCs
 	"mediatek,mt8195-pwrap" for MT8195 SoCs
+	"mediatek,mt8365-pwrap" for MT8365 SoCs
 	"mediatek,mt8516-pwrap" for MT8516 SoCs
 - interrupts: IRQ for pwrap in SOC
 - reg-names: "pwrap" is required; "pwrap-bridge" is optional.
@@ -38,6 +39,8 @@ Required properties in pwrap device node.
 - clock-names: Must include the following entries:
   "spi": SPI bus clock
   "wrap": Main module clock
+  "sys": System module clock (for MT8365 SoC)
+  "tmr": Timer module clock (for MT8365 SoC)
 - clocks: Must contain an entry for each entry in clock-names.
 
 Optional properities:
-- 
2.36.1

