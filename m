Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BD75804C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiGYTvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiGYTvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:51:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EABDC6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:51:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a13so14179322ljr.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ps5/CCHuqY7+cZdChN5ZBwBuVuATjoZQbxBn5m9FSk=;
        b=HjrTErUgQQ6O5qzdgEIN2RutjLDFe1LgytUqZMmdNM4nDv/E+FNm4AVLMCsdUYFdH0
         RNi4hBqdapWg0rVP/C1nGhVHAxdkJyX6cM3QqyDrlPkGkicdD2JPwd60gmvz7srKe2eG
         5Hwjy/kzl1Yxabl13vPhBDVHC+Amgexhq68yqwsgFc+3kwTNq7C+zQ3qhN0MVIy8qTXM
         lnuPlTIiYj8kVFdnLUehA56qcQ71ibOLyRe1vDDUvdPNc9lX5ri9Ez1XWvhaYrHH9W45
         4+Rg/MU1Tt4sfGx7odAqJWU4aLvJO0vw4rn7YBDFD9eKxrmOvmtco2BfjFnYWWdrDlN8
         rNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ps5/CCHuqY7+cZdChN5ZBwBuVuATjoZQbxBn5m9FSk=;
        b=hW3kWW35KryiqEw7+kyWWEgfVlsE4BD2/2bcZHKPNja/+ry7KEv7Qg9B0a/X5OIt5Y
         xDA01bRHjaSP3rqC8WzUQzqGOuA5kTXDPTkFJsUt5XENMruiWSxBsr6bC7MIvZaP+d01
         CGYd20FV8lLk1f60jY+Ri2s7yExby6sKxtASHiJEdAdoUTSTWau4AxHLZtiD/t91/c0V
         0BmvFTF8ZKmBr5n9gkJDXhk52sDS15rNjY+zSZ4QbA+zdtUaaLhAQgAbn0om+Z7uhzHi
         FKKmBrJuwn33PTjHCO5UDtpvLkVZ3GJACiKR51e6JYbDFR+Yu1AnLKyrt6Zw22eGsmp2
         4P8w==
X-Gm-Message-State: AJIora8RB6nkawpEV+80FjWWaHVHsM+i7V0rhjNT2SJRjvgKz5RZ242c
        pcLl9G7/5KFthi9hFIwWjeOHfg==
X-Google-Smtp-Source: AGRyM1sYYBhch95RxeLVobgA3XR5XMMqveMrHinpaIfSvj6CqzsXX7nBefxB9ISmggR5ZGNwo3bVSQ==
X-Received: by 2002:a05:651c:158c:b0:250:a23d:2701 with SMTP id h12-20020a05651c158c00b00250a23d2701mr5123421ljq.475.1658778691203;
        Mon, 25 Jul 2022 12:51:31 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id a20-20020a056512201400b004790a4ce3e5sm2824973lfb.278.2022.07.25.12.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:51:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: net: cdns,macb: use correct xlnx prefix for Xilinx
Date:   Mon, 25 Jul 2022 21:51:26 +0200
Message-Id: <20220725195127.49765-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Use correct vendor for Xilinx versions of Cadence MACB/GEM Ethernet
controller.  The Versal compatible was not released, so it can be
changed.  Zynq-7xxx and Ultrascale+ has to be kept in new and deprecated
form.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Harini Katakam <harini.katakam@xilinx.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 762deccd3640..77d3b73718e4 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -20,10 +20,17 @@ properties:
 
       - items:
           - enum:
-              - cdns,versal-gem       # Xilinx Versal
               - cdns,zynq-gem         # Xilinx Zynq-7xxx SoC
               - cdns,zynqmp-gem       # Xilinx Zynq Ultrascale+ MPSoC
           - const: cdns,gem           # Generic
+        description: deprecated
+
+      - items:
+          - enum:
+              - xlnx,versal-gem       # Xilinx Versal
+              - xlnx,zynq-gem         # Xilinx Zynq-7xxx SoC
+              - xlnx,zynqmp-gem       # Xilinx Zynq Ultrascale+ MPSoC
+          - const: cdns,gem           # Generic
 
       - items:
           - enum:
@@ -183,7 +190,7 @@ examples:
             #address-cells = <2>;
             #size-cells = <2>;
             gem1: ethernet@ff0c0000 {
-                    compatible = "cdns,zynqmp-gem", "cdns,gem";
+                    compatible = "xlnx,zynqmp-gem", "cdns,gem";
                     interrupt-parent = <&gic>;
                     interrupts = <0 59 4>, <0 59 4>;
                     reg = <0x0 0xff0c0000 0x0 0x1000>;
-- 
2.34.1

