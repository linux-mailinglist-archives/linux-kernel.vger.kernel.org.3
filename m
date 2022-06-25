Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7255A8E9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiFYKhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiFYKh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74772A266;
        Sat, 25 Jun 2022 03:37:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z21so8502110lfb.12;
        Sat, 25 Jun 2022 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RhpY9q307vkYuavF4O5uT48LhWT/p2dvSpT/WVpY8QA=;
        b=D7ghu+f6ICIMbeM3+3iundy78ehQ3Xsf8inMsSq+QGLlKLnzF9fGMMNGT/rIOKLGHy
         tYcJUiS4Y0cljBTHeNbpVdQrOJ9P4hUknvVWE6NgDeYuWsYOP2DKan+7QAG6AGfn7wjg
         lwUY5VcyWc+Jg4GVJ+R4r/wPFp1+J04dnJNZKLNTjwEjJr75UBf2e770q045ukSvtNWh
         pZMEnvl+jkrtg0tlNLw2sGspdITFAWI4yDPRHKNOM9HXMExmpwiy6K3O396kCxyrn4DF
         QrU4WvGgJZKg4cYmDTHFvMtXK38x9DGDRDa1tX4iJsILSFZ6bTeChxFAgHXVochIFOPQ
         eS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RhpY9q307vkYuavF4O5uT48LhWT/p2dvSpT/WVpY8QA=;
        b=AA+8x/4HWhjvobEtshRxnKVmI0nov9cfDu9xY3bAlZE5DPpUIqoyJ5JbfTJxfE14pB
         pYDU30Ba/+0G4JKT3TskA9lVGJ0GwqLBpTrxmVhOFfJZAclW/Qz3dy79pkingjNoIDp3
         L/TOPfJ8AeFsGGQ2SPS60TkHYSqAvAkJaW1zpTMw6XBZXS3vl/GFPTGSdJ4egx+3fxyO
         8sH2onR2dhqV2UQ3kNdtRtmG3FrAr9otu/xHyQEzlTBWRdKiAPcBuM7Bnk+bz/O5jdI7
         A9ygXizpudVdsp0GrWqsC3ajFRPc31mrPDmPg4xKXYmlgIOr5p/nKQvbnEwjutuChPPU
         DsRw==
X-Gm-Message-State: AJIora+ItLpV/nXauqiEKI9I0ip8k5lT6BFA/ddsPQC/8N9lwrQrMpKa
        WAVh5imYblDMyGR4BbB+B3A=
X-Google-Smtp-Source: AGRyM1u7On5+J34DXqynsZaKmqm81Ck2L1jsz6Q42brQDBSolDljmXm3Jd7TnO/ffxppz9+G64kFng==
X-Received: by 2002:a05:6512:3d0a:b0:47f:73c2:bf7e with SMTP id d10-20020a0565123d0a00b0047f73c2bf7emr2141042lfv.192.1656153444082;
        Sat, 25 Jun 2022 03:37:24 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:23 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
Date:   Sat, 25 Jun 2022 12:38:48 +0200
Message-Id: <20220625103853.2470346-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Data Ready Output Pin is either hard wired to work as high
impedance or push-pull. Make it configurable.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
        - Removed default value and changed description (Krzysztof Kozlo)

 .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index 95ab285f4eba..57a16380f864 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -36,6 +36,13 @@ properties:
     description: IRQ line of the ADC
     maxItems: 1
 
+  microchip,data-ready-hiz:
+    description:
+      Data Ready Pin Inactive State Control
+      true = The DR pin state is high-impedance when data are NOT ready
+      false = The DR pin state is a logic high when data are NOT ready
+    type: boolean
+
   microchip,device-addr:
     description: Device address when multiple MCP3911 chips are present on the same SPI bus.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.36.1

