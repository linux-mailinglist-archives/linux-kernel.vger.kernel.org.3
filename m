Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB5F588FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiHCP4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiHCP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:56:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8014BB7F2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:56:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso1142203wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=mxMtG/Q251T7R62iX9Xk/wpEgTp311fOpnJ0ShthtKM=;
        b=B4+uBSxdHMiSA/FZHsjqRDTozx+JSIc1seFJm34ExPeztEVDD07wRjHK6FzULPj52N
         0EMMYg3C77CqUFN29Loe0BUvz9T7wymLNRWvAVD/cIeIv0TUhupDo7MN1Pz5qwUDAn+7
         BN5c/JV8oa3KMpsf5W+JM2rqd/VNTOpME5Zc9FtJVWEJYzaIQktD0/XCDYoLzNhYvn5f
         7ftKrnOMC/S5QQvtkDaDyjY63dAnPxsBSjdnN9I0z+Meib5U4r1inilkPVme/npe8a6u
         JMfE2ZYEVFLITL4oLRmvF3dRRMEYgoAiwOlWNDjQDUXb8Q2Xk+rL21TfON4HgoYl27YA
         0MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=mxMtG/Q251T7R62iX9Xk/wpEgTp311fOpnJ0ShthtKM=;
        b=RFqs54MJjehkLhiJbGEmyBOo1H4EbJhop35ZotHjJLMWqKwDKnluK50K9QfzbkTf8T
         CWVZeWrtTy5lulWAfziGQRNt9+VsxvXNFRRJRJcVz5jDfrPUNOjxweLvsn5u2PoZHgIi
         SMckaLN3GSDA6psI/yFiQWFH6dbESDcoMLH2DYEZQqh9ZDp5mp8K0f3uHYbLoIanjp+p
         q9UYoLQHsqSTDSHC5ZV0fMVsx1t7Zt2bRvsG5Lv6dZP0Da2EdKGEYxFQsTnOmIOkwGi0
         H4PGG7xjLaD0mP/J+5XEqHBd+cDBbhhMrb0o1UaTBfYStnBvFHDQmXYxEmuUewVSqJSo
         /ueQ==
X-Gm-Message-State: ACgBeo3Enp7qnTRU3Ps3pyvvFoWCeQ/Mzaw5uj2RiSULXOnTyPVc5DbT
        tMJTEqJ7yKmIUAXrah35RfgRig==
X-Google-Smtp-Source: AA6agR5BfqTfNvlJd1g6OG5xcTlUNOnmja0gCtgMu3jkzJTU+0HROXQ6ioslOvzyFPUGUa6hAhSIyA==
X-Received: by 2002:a05:600c:19d2:b0:3a3:2cdb:cc02 with SMTP id u18-20020a05600c19d200b003a32cdbcc02mr3313498wmq.182.1659542160960;
        Wed, 03 Aug 2022 08:56:00 -0700 (PDT)
Received: from henark71.. ([93.107.66.220])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm18107277wro.91.2022.08.03.08.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:56:00 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atul Khare <atulkhare@rivosinc.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4] dt-bindings: gpio: sifive: add gpio-line-names
Date:   Wed,  3 Aug 2022 16:55:40 +0100
Message-Id: <20220803155539.800766-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
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

From: Atul Khare <atulkhare@rivosinc.com>

Fix device tree schema validation messages like 'gpio-line-names'
does not match any of the regexes: 'pinctrl-[0-9]+' From schema: ...
sifive,gpio.yaml'.

The bindings were missing the gpio-line-names element, which was
causing the dt-schema checker to trip-up.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Atul Khare <atulkhare@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v3[0]:
- Dropped patch 1 & the now unneeded cover letter
- Added Rob's Ack
- Changed the patch title to include the subsystem

0 - https://lore.kernel.org/all/20220726170725.3245278-3-mail@conchuod.ie/
---
 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
index 939e31c48081..fc095646adea 100644
--- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
@@ -46,6 +46,10 @@ properties:
     maximum: 32
     default: 16
 
+  gpio-line-names:
+    minItems: 1
+    maxItems: 32
+
   gpio-controller: true
 
 required:
-- 
2.37.1

