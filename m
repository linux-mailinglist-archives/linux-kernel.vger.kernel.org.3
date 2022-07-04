Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B84D56567C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiGDNGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiGDNG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:06:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74260CE1B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:06:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j21so15750298lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5jqoFqY9t4pG6Ih7jeiXaIVhWUo5Kb1qS0mgGRz8PU=;
        b=eKzQ9peRdGhtKbJZ8ANkHcSHbDsdYDZtmVttDAYCcL+5hJIZ0dionog9WoFpAJcJrU
         FE0m6vAaDrn2cobxIWV/GHTtlIovQ25mLgcfD/Gzby76TKXZYQJ9Al3R2P2oFAzIwtDO
         OJ/y/zyxLqWGFrIDOl0OkfSS1UlfUZC3s2GvOaZDXLFmaSdXdaFVabfAm/yAov0SNI8Y
         3t28xdyRWCvuoklzlNUwkRPNVWi6hDaDQH0DkkBNjNZZdEedfRRFM/rh/UiRISHCUPto
         17qY4614w5PT65EY0yFDJA/SSrtICilg4cJzswVSA1BztPsaXTRxWoIxPW4ilsqS8GEN
         gzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5jqoFqY9t4pG6Ih7jeiXaIVhWUo5Kb1qS0mgGRz8PU=;
        b=Gf4HzmFH0SLJLrApJlMqXkxwIL52xFdK0PMXF7eUY2hjQcwtst4QHDMnaDMczQraVa
         TMXXSTHwrNUwiWxG+9zLsfUx78/B8nITRpbZC/+7vVChpS5JnjS5Nkje4RDNFArNyLEC
         Hjo4xJh89Ie2de5JeQUf+xWbqi8TgIiv13LVVzUfQGOrOvYJ99I7l8wWb6xUG8vnXpd6
         NmGkMUSWNKuHGUCptkmqvRNVnCm0izzyufNbGrVerl5grjVRYfuxRdYnUyjqIATxepQ1
         ckaTbJIT8YL45CV0oUeo+l4PbKxgwaKiW7n4/G/TX10UizCnSIrnZrQbYy+Ci4Y/i9Np
         emVA==
X-Gm-Message-State: AJIora/q1d7hJQ4ZN6OC2tA7g97BPX3R402SM1hTHa67EqJ21ltgsgRE
        ngtD4k33NUY8TXkX8gNbwYdmRw==
X-Google-Smtp-Source: AGRyM1uynXFoT9txapI2XEBOctelNPzglsHt63ycz7EI3SibzdqD549cN1ZKzRZ/mdclHxBlXLWMSw==
X-Received: by 2002:a05:6512:c06:b0:481:1cb1:ed44 with SMTP id z6-20020a0565120c0600b004811cb1ed44mr19156119lfu.323.1656939984753;
        Mon, 04 Jul 2022 06:06:24 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bt30-20020a056512261e00b0047861c163d0sm5115092lfb.37.2022.07.04.06.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:06:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] spi: dt-bindings: zynqmp-qspi: add missing 'required'
Date:   Mon,  4 Jul 2022 15:06:18 +0200
Message-Id: <20220704130618.199231-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220704130618.199231-1-krzysztof.kozlowski@linaro.org>
References: <20220704130618.199231-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the conversion the bindings lost list of required properties.

Fixes: c58db2abb19f ("spi: convert Xilinx Zynq UltraScale+ MPSoC GQSPI bindings to YAML")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index ea72c8001256..fafde1c06be6 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -30,6 +30,13 @@ properties:
   clocks:
     maxItems: 2
 
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

