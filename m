Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CDF5705FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiGKOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiGKOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:41:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465016D2D9;
        Mon, 11 Jul 2022 07:41:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so9191900eja.8;
        Mon, 11 Jul 2022 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6Zj+nqjcsDd+NxhePZjBVz5AR3AOdLdAAs0/s0+tm4=;
        b=cBbGuPcQD+ZjS63KeFX2qPQN5vCp8xFqIK1PTPwX9fC14jJd3tRL21NrTYSE2zO/8B
         BE5OAslf7uoaJ4WjCosdd5DI3N7LRRycbGnssKrvwoPGhClkn3DrsHg0AgP2KhD//e85
         cca38UnHPAm68zYJZvoUapQ5HS3imwAaO9vzo8FI4Vmdz1USXFa1pv3X21evFu2KzpL9
         W5IWxY9OhhFJCvW79V67qm1K25G3I9L8iskonW8tm72MfyqWUSdXWJ0AnYxRr1J8WPgg
         eHUzjADqLRBnUrDrOOcDkeLe8w9RLfvF7mNme3ZUFSp00MUaThpSEbhzZ6OYSy2yw3vx
         Q8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6Zj+nqjcsDd+NxhePZjBVz5AR3AOdLdAAs0/s0+tm4=;
        b=F54YDZbyemG5Okw0Lhfp6q7Aukzv9Hf+qyY25i8GqsJTfBKCVJieop2lhD6E0pWMUE
         C/A5uIxWbk9PP8xNGwv0O9Zn2Mic3PYu+E/0gqJOx0lCXDYT5ikIaGRN21soeYDtFBls
         LI7eqzT6jCFJaPjS/ddBTxhcGTZix7P+Qu/8ndzOw1IlVBm8Oy9HE9ahzIdMmJa3E/Mi
         uXaHvPkOhvCL+cIHgOHQCIaz0KIDNQL4JVOHVOpEqvjITAxldcvBKtjOtrXnt2OiSykt
         ZrWhXovhFYvNCcKoQNeJvmslTeRrxB7IQuHDpnsF5ABDtbPHFpcKVCUJ7XEfN6PO1ORs
         qkFw==
X-Gm-Message-State: AJIora+2IgBiv14URFRxt8HJQQ5DrYnE5EnRuO0w6WBrv7JRBlnfzXz4
        akylTW3qTHS+rdcQEWBwi44=
X-Google-Smtp-Source: AGRyM1sH98oGAJcOqSGL5OSD5kaPxRCErdFpvV2XHvYjJ+VaYuHbYKSG1pNmaLBkNFEfrowdMIlRnw==
X-Received: by 2002:a17:907:7f09:b0:726:2ba7:21c2 with SMTP id qf9-20020a1709077f0900b007262ba721c2mr18994687ejc.744.1657550506618;
        Mon, 11 Jul 2022 07:41:46 -0700 (PDT)
Received: from localhost.localdomain (89-39-107-113.hosted-by-worldstream.net. [89.39.107.113])
        by smtp.gmail.com with ESMTPSA id cm10-20020a0564020c8a00b00436f3107bdasm4461390edb.38.2022.07.11.07.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:41:46 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] media: dt-bindings: ak7375: Add supplies
Date:   Mon, 11 Jul 2022 18:40:38 +0400
Message-Id: <20220711144039.232196-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711144039.232196-1-y.oudjana@protonmail.com>
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add supply properties to describe regulators needed to power
the AK7375 VCM.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/i2c/asahi-kasei,ak7375.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
index 22b1251b16ee..22a810fc7222 100644
--- a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
@@ -20,9 +20,17 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: VDD supply
+
+  vio-supply:
+    description: I/O pull-up supply
+
 required:
   - compatible
   - reg
+  - vdd-supply
+  - vio-supply
 
 additionalProperties: false
 
@@ -35,6 +43,9 @@ examples:
         ak7375: camera-lens@c {
             compatible = "asahi-kasei,ak7375";
             reg = <0x0c>;
+
+            vdd-supply = <&vreg_l23a_2p8>;
+            vio-supply = <&vreg_lvs1a_1p8>;
         };
     };
 
-- 
2.37.0

