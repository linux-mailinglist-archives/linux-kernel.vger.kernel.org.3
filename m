Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82E581278
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbiGZL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbiGZL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:58:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A3F32EFF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:58:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y11so22135213lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYLUai/g9PzuNxtQk+5u3lNYDu3DEs371sQhIxnEx1U=;
        b=O5XnnAMMkLU5W9I+tb5iv/V7zHyqMVQ2/oyx7HN2nXIWsA+IPy0usF+WqhJT+McHqW
         7wwRUIj6hmKY8KzKaYLJQwx6DDhI/87xRjMmR1HBDQ+fPOVpKXR0jl1t5IjjppA/CWxF
         ALiEc0pLYC6sEFTn10XkTbRDHaBEXFXL9nXWIwyP1LOE0BhzF3Xr7KznoIA8LWIaW9v8
         1q57WAz9E7eOTZInOwKwgJeTPJQYTBxm250WEgM3YrPZqOR04Nj/ljxmqKkFDb9cBbjQ
         MHCvL5s4Zug2V7cinWP6TQl7L7cPhmtc9j9ME66HrT+GfkcT39ZRk0fjnTaBF/z1VWKh
         WeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYLUai/g9PzuNxtQk+5u3lNYDu3DEs371sQhIxnEx1U=;
        b=qG4IqMEXDaM+VpN6Wtq2QkF69yeEX9ng8fbyv5lJORljIuYlz/0dcBDnLH/JzXPy0S
         L656upNommnWeq0e/2pBz1zOiuOAjTuXLxdF9F7lteVmfTIjirHuTEN2Hvu7gCl00RM8
         qB3nt2M+50LE2n1MKFQyxeOLfO7geyVgH5kcp1RRX+IE1kzhQCfPU+prCg12MXKzAIm5
         wv4fu2OrBF1e5KsjfUBsgMh0miEdAf1yuU1t2otspa0uuqR8mX+nkjn0V3fffcEOlWuO
         RNCeZIldKCni74P+6jZ+kkUQBfnpIzSKUTt72AdP7s1Q23LLOaTAi7RZui0Z+wbPEftq
         wFYA==
X-Gm-Message-State: AJIora/VpzMFfxUuv5lOdHJZiVMJPYdVhUYoOaUzuFoNdlu2Opp7fyAm
        WB8Wd41M4xEFzPxywzgkhVhHng==
X-Google-Smtp-Source: AGRyM1tLfSE4Egbpb2Jc+QspZmgwcEtAhCJrpE9RcM7ZQ/Hv4z8qtRIbJ7R3a7sa5pIKYoCWF64K8A==
X-Received: by 2002:ac2:5f9c:0:b0:48a:8595:c84f with SMTP id r28-20020ac25f9c000000b0048a8595c84fmr4424871lfe.657.1658836678359;
        Tue, 26 Jul 2022 04:57:58 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id g24-20020a19e058000000b0048a7d05739asm222219lfj.4.2022.07.26.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 04:57:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sebastian Reichel <sre@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        David Lechner <david@lechnology.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        =?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Klein <michael@fossekall.de>,
        Dan Murphy <dmurphy@ti.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Stephan Gerhold <stephan@gerhold.net>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] dt-bindings: power: reset: drop quotes when not needed
Date:   Tue, 26 Jul 2022 13:57:47 +0200
Message-Id: <20220726115748.101015-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
References: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

string literals do not need quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/power/reset/regulator-poweroff.yaml     | 2 +-
 .../devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
index 03bd1fa5a623..e9417557cd30 100644
--- a/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
+++ b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
@@ -16,7 +16,7 @@ description: |
 
 properties:
   compatible:
-    const: "regulator-poweroff"
+    const: regulator-poweroff
 
   cpu-supply:
     description:
diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
index 68d7c14a7163..46de35861738 100644
--- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
@@ -15,7 +15,7 @@ description: |
 
 properties:
   compatible:
-    const: "xlnx,zynqmp-power"
+    const: xlnx,zynqmp-power
 
   interrupts:
     maxItems: 1
-- 
2.34.1

