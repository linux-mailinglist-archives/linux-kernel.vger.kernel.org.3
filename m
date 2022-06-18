Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB32550720
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiFRVkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiFRVkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34FEEE10;
        Sat, 18 Jun 2022 14:40:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me5so14614983ejb.2;
        Sat, 18 Jun 2022 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0YNmYIukGGfykI+FtYFbZdPS5Nw7Xun3tGXTmtw+hKk=;
        b=LmuSRxF3BkGn/vNWWXv5fOudLr4rbnKQ1yhSNm9kXRoOGC9Y/cnJYwfy47qRGwKUi6
         uZhUHgh3XWLEVIkaP6kdOHpA3cGszo+nYvRuSgOFXIf3XcQhhmryS9F0+OYz0DhGPFIC
         Z5B4Iulrlt67ID8WM5DrP7kOFOivk7YFfAoUcYTul+9SsgSEL3CJGhwSJj/QmfujXypX
         EKD2Oi3q9A0FkjJi5bf18nw3FuL2RhD5Iby4uzcbmJtanHo5lmdbERe6S9jDmVH+AVOJ
         Zro9HgnNr1yMCIdsBAqSoqMwtqAQzs0UHjClBCkZd6Nfwp6IHjqEaxg9p1WSbMBfQFpS
         OE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0YNmYIukGGfykI+FtYFbZdPS5Nw7Xun3tGXTmtw+hKk=;
        b=3g5a55/vpHHFqty4VY0EGchCJVIRYEatYrWjQxz/Jo2coK8nI0N2Jc1/86Iec5o0s4
         3sAzL3S7JLY2SHqwPFJzcYA9XTaz0yxn0/aBzg0QYSz6ZBStCV4DiLvqRA+ZbdbmjM29
         13ObzhHgMq0YiM1wWj1shGy2lxInUmGsb2enf8HxuicABdeSRp16cmBwtOPJk8iAsCVa
         TlTTvB0c3Qzzp3nfR8u6q9V1mSqjdWnGQtyt/xWw68Ow5hbKV1KStVzQIQ3NeCDgfxjG
         z6aK8usV0lyYiq51lhN171UpKuksFl01hgyhSdrPbp4+ptQXyQ8ZQKVvcCBbynDucLmE
         Grtw==
X-Gm-Message-State: AJIora+OWAQkF1gr5/JTguyLU6KtsbwsdcLaccQd2kXnMOAJvrLtDXD5
        qvWxwACKq504c99G3JqiiCY=
X-Google-Smtp-Source: AGRyM1sKUnzY6BfzCuQwM6IhZ2fXFb0cfw9f33VUewZUTPkwkjDirQDnd2IyYoOSM7Vte+xEFk+Faw==
X-Received: by 2002:a17:907:7d8e:b0:711:cf4b:9c5 with SMTP id oz14-20020a1709077d8e00b00711cf4b09c5mr14621433ejc.637.1655588404011;
        Sat, 18 Jun 2022 14:40:04 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id bx25-20020a170906a1d900b006fe8d8c54a7sm3827586ejb.87.2022.06.18.14.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:03 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 05/16] dt-bindings: power: supply: axp20x: Add AXP192 compatible
Date:   Sat, 18 Jun 2022 22:39:58 +0100
Message-Id: <20220618214009.2178567-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192's USB power supply is similar to the AXP202 but it has
different USB current limits.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 0c371b55c9e1..e800b3b97f0d 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - x-powers,axp192-usb-power-supply
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
-- 
2.35.1

