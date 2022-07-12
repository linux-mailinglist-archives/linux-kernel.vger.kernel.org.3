Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256C2571C64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiGLO0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiGLO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:26:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26C3AAB23;
        Tue, 12 Jul 2022 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657635968; x=1689171968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGvCmSdLGhHwliGLCezI146iFxUX+rnhWkr8xC90Ykk=;
  b=S//76q8XD4x9KvIngqdT4FSMn1FxIr1xMs6l9ibX2ye9Ke5nxpW37LIe
   313uHujmrKiJZIkZDVk5Opm3Li1Qc99udFAzwQ0z8QatxXSmnyGl6F7aY
   Sh5h37KZMWH90Kk5F2a0PJAXdFp7CcTXUiGZTCC+zXi/BZi0ohSpZ6+ck
   WRiiyVutIENlNRRRB23eHb/AfxfM34303AjKrgOLr4AIHZsb7Fw3Dv29W
   CbznXgqIq7281dj5kinTacwStjhcoRkCEdbgDM+1O0qlJy9W5//TaXPCs
   XvKQ4gIl5MqCtXvWqi51MHQYLcZr+tQg6ZU5sC1ex5/L9W9RjylXomr7x
   g==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="181795577"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 07:26:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 07:26:08 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 12 Jul 2022 07:26:05 -0700
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
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: pwm: fix microchip corePWM's pwm-cells
Date:   Tue, 12 Jul 2022 15:25:54 +0100
Message-ID: <20220712142557.1773075-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712142557.1773075-1-conor.dooley@microchip.com>
References: <20220712142557.1773075-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Acked-by: Rob Herring <robh@kernel.org>
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

