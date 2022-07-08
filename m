Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DADD56BBB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbiGHOaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiGHOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:30:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17B01BE8F;
        Fri,  8 Jul 2022 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657290606; x=1688826606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zf+7kH8bgglyGlJ9EsT7S7ho3SnvVd1w2aOxWrS9FR4=;
  b=J70APxQYsP5Pw4tTZZinQ77A9ypj4y5XboJRuI0J23EVVIkVVEaYjVjL
   fIDhSLNvvMaKAmik+kw39TzmHpEqtEJXfpF7b33GDazdC3Srd2BfDD5st
   A+udSeiQ0AnS7q+Kk5YeAqQtUUHPgBz0M2IraG1EE3h5PUL/c2D/oXR2k
   m9CNBn6J59C6M/xR5/73NXawB8KYPnouGrj/GYHQvGNnW8NFMn4ODd7lY
   e10N30NUxJ9amPgdnmBQjM/ywI5M8dhbu/AclBdL/DWFpsNggirJnw82w
   ZxN4t4W7XRiPGxZ63QZQEwpEPXZ3tJA1qPbyGMNxml3L17k9sB/nhYBZC
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="103658933"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 07:30:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 07:30:05 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 07:30:03 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/4] dt-bindings: pwm: fix microchip corePWM's pwm-cells
Date:   Fri, 8 Jul 2022 15:29:35 +0100
Message-ID: <20220708142937.1120121-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708142937.1120121-1-conor.dooley@microchip.com>
References: <20220708142937.1120121-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

corePWM is capable of inverted operation but the binding requires
\#pwm-cells of 2. Expand the binding to support setting the polarity.

Fixes: df77f7735786 ("dt-bindings: pwm: add microchip corepwm binding")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
index a7fae1772a81..cd8e9a8907f8 100644
--- a/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
@@ -30,7 +30,9 @@ properties:
     maxItems: 1
 
   "#pwm-cells":
-    const: 2
+    enum: [2, 3]
+    description:
+      The only flag supported by the controller is PWM_POLARITY_INVERTED.
 
   microchip,sync-update-mask:
     description: |
-- 
2.36.1

