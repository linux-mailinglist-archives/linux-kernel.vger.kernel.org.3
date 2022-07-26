Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A8A581819
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiGZRIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiGZRID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:08:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96A1F632
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:08:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u5so21044550wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jzo7E3iuffF68CMucGWsT/yGzhnjiXcilx74DK/3MzI=;
        b=PJwcnD/GOZLAyqo5HYBp+ugAHaWK3jD+s39TePD+rKuCuI6iI14Xay2w+UOL0js0v6
         LSBHiEPB44Ii2OaSGoDqNOVSO6rNg69fZ7u0WIM6Le6oRMF2IRUbOBE0P+5dIMhS9yGa
         QC+F0XyZryu1sFqAVoIRgh46Ge6GRHy1WkUhbRG8gjFB5aNyx26K2hN41i4YG7PvuOCR
         qf2apmc2qvQe6Azfk9JX5P9HelPwx7VJwIQamSA2IvtkS0pvhPy9Hm+mGBmhrdG9C2hq
         YvnISfSwHYV42XaarrfP6SM31clvkoOOFn/3MvggwSxR06Rcuh2QbKN3LYeFiRPBr0y1
         VnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jzo7E3iuffF68CMucGWsT/yGzhnjiXcilx74DK/3MzI=;
        b=2daUBTU8jcG18oU/KL8QnsIJMADwbcV6SfmFh1Ddiyvtmb+WTMiw+I2R+wcB8X7VXO
         1Ji9Y/Xkoa961tUCZ7dkeZASPEVDArRep/7ZH9gbyadnhi8l642Stvy59H6JrWYhLv+K
         TxkLLwI0HX2a6TepJU24CeApkgk4htWqd3kvxeMppcrskpwwb1Ssa8d8uFVuEytYoKQD
         ReQakJq/ItquThMss/zy3gXRdTHHoxbgPa/ey5CNcX6l5wsBLTS2oX6eZliLyD7N3S3n
         IPel6llYDyl2V4XpYCxZLC93vnAxFhdVP1pIadX1beNcvNQJzeINVnKKgQA627TEu7KT
         8Djg==
X-Gm-Message-State: AJIora+W0ZIZZhjoyi5COFnQDU/EdBL3X9Nkw7TCvKi9DODtyDopM8ZZ
        Cuy3p4ZjY8F1lg0wzKbL0+orGg==
X-Google-Smtp-Source: AGRyM1tirn6tXbKRAXaMvkLrwVqgAF4lGynuVfCpdqZGZCoxCIG6G3hqB0PYq/iIx1kid07GWxSsVg==
X-Received: by 2002:adf:eec2:0:b0:21e:61cd:64c7 with SMTP id a2-20020adfeec2000000b0021e61cd64c7mr11543092wrp.324.1658855279436;
        Tue, 26 Jul 2022 10:07:59 -0700 (PDT)
Received: from henark71.. ([109.76.124.168])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm14859618wrv.94.2022.07.26.10.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:07:58 -0700 (PDT)
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
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: sifive: add gpio-line-names
Date:   Tue, 26 Jul 2022 18:07:26 +0100
Message-Id: <20220726170725.3245278-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726170725.3245278-1-mail@conchuod.ie>
References: <20220726170725.3245278-1-mail@conchuod.ie>
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

Signed-off-by: Atul Khare <atulkhare@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
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

