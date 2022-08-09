Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73458DCFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbiHIRVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244508AbiHIRU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:20:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7BA23BDF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:20:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z16so14993203wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=y545aVrkkuDGPQff6D7mZBdsso6g+4hQEnF5Ijp4clg=;
        b=mwm18OvAvb3DN1qMcM6AJRveexnF9QeK2qJBPRDNYGf7ZskAiyyp7cqKO+165fN9Ny
         cnRcxxAYqIZnMVfhFK2yPzYW9JA9JBZT6ocT+r+5QfEA8ofsx/1r5jPDKCqMJv5T7cDh
         0iXVd0XPxwIs1T4eBVIWlcS5pJ0rs0qizPcAQODhbdftpgVKKoHdJ2EvkmGNqXnVw+0D
         iyOGoPeNcS0PLvl6QA3MtERhJQSzgs+ILk8UFg2k30D+BH0Bt3IKZiY/Tof4etb7r6KQ
         jQ3V6EEtmFNaQXUD3SfXHZjC060HODxuj2msch63CZSE14EwVFCd8fzIegfKJ6D2gjh4
         ppyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=y545aVrkkuDGPQff6D7mZBdsso6g+4hQEnF5Ijp4clg=;
        b=m7k6LXiKW6Cveu85FtQudE6zxI78ztkBcpJXNlD8lQUzC7mDIMIlMbaeJFJ3lmaEkg
         fKZ5gOVC5TkmOaULV9SYd9l2xYXgh4marYm0jGF3lixDFCVrjSyqrnHHuJyqJYInTaPa
         97oemRsKCUylQXhVj/2blakNxDFs0c3Zggv9aRgGvq5KmhgUpBrnJ2nkTZ2S145gY3jK
         2n9SZQApkSion3QDwLmVXbEYM4jDUVy5bNVCgfOHqhoKlkKGQ5W2qT5LvUHT09EWR68b
         TSAv4fuCnMyEsDyx62vUzBA2gy41qZvU2LZzEigSIoE0xAnWBOvlwKoUgWp1/A5Y1DEd
         +BlQ==
X-Gm-Message-State: ACgBeo0TF97zo/LPw8eLlZBB8k+8s0T6tTfpHkjhBNBRfd1MY2R8NYM1
        IGVRbdz1XnQizmrPi+2J3A6Tag==
X-Google-Smtp-Source: AA6agR7oIC+WFbM03wya4VinLOUGhi0StzJsyj9eBnMCq0cT6vT0Oq+1Eh1Yn9+7C+63+1UPZ0SEgg==
X-Received: by 2002:a5d:63cb:0:b0:21e:b81d:8b0d with SMTP id c11-20020a5d63cb000000b0021eb81d8b0dmr14767021wrw.526.1660065656092;
        Tue, 09 Aug 2022 10:20:56 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id b3-20020a05600010c300b002206261cb6esm13915030wrx.66.2022.08.09.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:20:55 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        narmstrong@baylibre.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Da Xue <da@libre.computer>
Subject: [PATCH 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
Date:   Tue,  9 Aug 2022 19:20:16 +0200
Message-Id: <20220809172017.215412-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809172017.215412-1-aouledameur@baylibre.com>
References: <20220809172017.215412-1-aouledameur@baylibre.com>
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

SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
pin biais when idle. Therefore define three pinctrl names:
- default: SPI pins are controlled by spi function.
- idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
by spi function.
- idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
by spi function.

Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 50de0da42c13..10707a8216f5 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -43,6 +43,14 @@ properties:
     minItems: 1
     maxItems: 2
 
+  pinctrl-0:
+    minItems: 1
+
+  pinctrl-1:
+    maxItems: 1
+
+  pinctrl-names: true
+
 if:
   properties:
     compatible:
@@ -69,6 +77,13 @@ else:
       items:
         - const: core
 
+    pinctrl-names:
+      minItems: 1
+      items:
+        - const: default
+        - const: idle-high
+        - const: idle-low
+
 required:
   - compatible
   - reg
-- 
2.37.1

