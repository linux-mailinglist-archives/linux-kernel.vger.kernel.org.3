Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273BD56030E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiF2OaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiF2O3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:29:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EF5205CF;
        Wed, 29 Jun 2022 07:29:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n1so22733711wrg.12;
        Wed, 29 Jun 2022 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h68PRQAH5qAHTVc1B0ZAXo6MScyFSWdG4r8hcoymSm4=;
        b=ZzBfIRg6BIlKfbZ3Pr9TmxYWj5V+nvkQU/kxZqp4hpFHQICyT39F5+eDs8MH+pLJbs
         9XeiRgNpN+DL8gODKJHPwpJKFYqNsUsU/7uYqtUNwyQQEixKWRwAvYC8junE3aOqzGc4
         uSD2XzKYj4AbZof5aIVvyKNcvIOkTJTpgrejXy2pJwPWzVHWfjVX9dKWfnbtt4hyQMN5
         KLpc5SNYJHET6aJkJxSI7SJUibfe+wztz5kMyHqiScJEw3DB/NPdsy6fQv0qF2ZJB2gJ
         JYfdgXOUjDkoxBzpJdlnX/jtbGgqDt5B6YAy8vPADqrkxmAC8jtqYgUVv8/LIt5u3/kF
         Ttqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h68PRQAH5qAHTVc1B0ZAXo6MScyFSWdG4r8hcoymSm4=;
        b=QBm7YQJScf0IJotDWDzV5P83VcBX4f6jPemHT+gFEDbZKFG6qIpIJ2/aiYfDG22N7x
         qZF8QPLKZQS2cP6040scshGAT4zmRCdMPI3iLDxQrFpn2D6lfzahUYyYJtoSVbUcG2gx
         hsYfVXH9Dezui75pSpfj2flvYZJ7WvUU4/fQ9W69fytQtz6WaWSDHASjj+m5KzUpRqKi
         4gmaDNtP3m4v4M5Y7aFUDZbTJUQFen6ZsT2EmVso4gynSJ4Rm6XDq9lky/VdJOE5KreL
         RV9KQwzcS/Vg8owpml9elFzmi+dFFp+1XQmTWDZvNLrJqIBrXTx8fOVoqtPBzSdcFGEw
         3sNA==
X-Gm-Message-State: AJIora+HUHKkA7IiooZ4/6uQJMcY6cGUH3irZRljmDqmV3JNDwgDcMdj
        0fV8wg/kP813Kh+4bOuSDzE=
X-Google-Smtp-Source: AGRyM1ulVuYTFwDTQS4CmWqBbMXNvDIvW8djsN1u7U9GWzvV9MUvkqtTfNFDKXhYSng/aet0v1v0DQ==
X-Received: by 2002:a5d:64e2:0:b0:21b:b1ab:254e with SMTP id g2-20020a5d64e2000000b0021bb1ab254emr3357969wri.451.1656512990684;
        Wed, 29 Jun 2022 07:29:50 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b0020e5b4ebaecsm16901432wrt.4.2022.06.29.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:29:50 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 03/15] dt-bindings: power: supply: axp20x: Add AXP192 compatible
Date:   Wed, 29 Jun 2022 15:30:34 +0100
Message-Id: <20220629143046.213584-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
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
different USB current limits and a different offset for the VBUS
status register.

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

