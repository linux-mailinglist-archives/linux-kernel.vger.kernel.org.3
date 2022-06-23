Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E00558455
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiFWRlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiFWRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:37:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B039217C;
        Thu, 23 Jun 2022 10:07:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j21so91565lfe.1;
        Thu, 23 Jun 2022 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9hirshugQrBiBu7BVIXgDl5HJGPuOlxL8cHUey9ErY=;
        b=eyDXyaakL+t64wKHttYScosWHhadSVwSvD2Hj49UITiJlLprGrD0QnAJBtqYH/MVd3
         orUCuxoiFSKdV32jUlu6lWSLKeeidlKw54kSIDAv7BDG0fzfgz+Go9U2wiWp62tViAJK
         mc7U26X+DIYOM064sg55Atb56iqpVHySeaqv/2bUXNBv19mTYUxz/6ukAML7GoTjllZ6
         lV51lG8E/RTLexabib8SyY2kzbkmD9qmNyHe9x61OxSfyE8VQU6priXO2AfdEl/xUexs
         BCFdSheYtVEqwKpSHDC0A4AsNXzfEoZmCRZnqXWKL5pUMU4Lng8LtyUjTtjuPm58UcLr
         5ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9hirshugQrBiBu7BVIXgDl5HJGPuOlxL8cHUey9ErY=;
        b=i5m+VEr0Ra/vvB9CC6B4oc880MDS4dcIDmoPlgAXNn5gGOWkYyQwiW22suHYhPDCUv
         k5S5i2Py+/8ikUf/BdUhhkp+IzQpRHxVKHYcXCYMj+hupivuBM5K1gaN65qBhdLRXfbf
         NHn27CzDQxCNlVxH0smEhQFVI+usROSFFRyAtx5o3Y6kBnkH/ESyX4pXnjd5UUTLzNQ1
         wpDy2++LoQIDbSWXV+hk+HlULCifYmWX+WZ2xiGbfbqTKjKVfxtrGEVEW3N6lG3IPo/f
         kkam7NJiAiqeItzIFGaaJXv/yrwCorUfIv8z1BFh9QiEEFvlB0YiJqM8z6LUb8c62Rsy
         1GAg==
X-Gm-Message-State: AJIora+jZ+2106ck2rENADs6yef2tPSCw5hdpLwVlr3Bfh4i1y0S/yKg
        qLDuuqI/7D8BoYcyqUgn2dc=
X-Google-Smtp-Source: AGRyM1tVqxCUPNrOx6l18BO/MTilQeecDmIMWAET+X9ac9JTv5yu65+bqfVy2FhWxIKzOlZC41k4Zw==
X-Received: by 2002:a05:6512:c20:b0:47f:6ebe:4de5 with SMTP id z32-20020a0565120c2000b0047f6ebe4de5mr6282273lfu.322.1656004030388;
        Thu, 23 Jun 2022 10:07:10 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:09 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
Date:   Thu, 23 Jun 2022 19:08:39 +0200
Message-Id: <20220623170844.2189814-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
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
 .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index 95ab285f4eba..74b333e44bfd 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -36,6 +36,14 @@ properties:
     description: IRQ line of the ADC
     maxItems: 1
 
+  microchip,data-ready-hiz:
+    description:
+      Data Ready Pin Inactive State Control bit
+      true = The DR pin state is high-impedance when data are NOT ready
+      false = The DR pin state is a logic high when data are NOT ready
+    type: boolean
+    default: false
+
   microchip,device-addr:
     description: Device address when multiple MCP3911 chips are present on the same SPI bus.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.36.1

