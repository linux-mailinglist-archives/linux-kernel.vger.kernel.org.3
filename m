Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47AB54E221
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377099AbiFPNie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377126AbiFPNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:38:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F013E93
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:38:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a10so789963wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wvAKrFjJUAy1rbIq7AduR0p2M09bI4Jv7oukOvIyz28=;
        b=DWHy3SG/wsE2T9Q1rnbshZgTGjXu1R+4GV6HC5a4ibBbEUebaZ6zZRW1MPmiXZgVY+
         1cIGlig+dhb7pIcH+9BDqU9AFsyq8uynKwh7GG/p7AQPt72nAE2PlEc117brO8Uc/Isy
         EGxFuG/sKknm5lmCGC0DVCh37H1SJbJMByLVxN4AVvJq20N6MEDAaAwmyQVRzoUkc8mw
         wAw4gOtUi/wxnCqRyGyQ3ILAkV6JtStMcbJenlJHA5JNeLEvyFQwZaNU2Bc/vEjUFqBv
         QMjaltNklBOWrFXOKQ4wsEyFqvVs03+iSmX8lcQ0DiQhhFms3E8ODhmfzm4Vh2ejoWwG
         6VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wvAKrFjJUAy1rbIq7AduR0p2M09bI4Jv7oukOvIyz28=;
        b=WDeND7H0IOQZjZ36XchKQbESk7vQ2yQE91DykiKNiueCFWMu13LmJA1g7sdIamhRPT
         /uZ56osqFsvIwoulaWjDtvVUkb+CswDjpI/zFXljMxfWSaAOHLHKce8cLtOataxdOFyF
         XJbc8hIdKm4WxzXzmsHzOunIjIgFSVoAHb5k9amxOmipEnVg8y804RRbi754KiZKYFVY
         fZ5t666XyeH9UM0EZUS7PovdwnisvH4fZ1fYfjboXlT/gIZJzji9b1BQKwDqY81NMVma
         22VDF4bcvQAgxKyBZ3wJMyFtdm2ezE74Nk41u7Mjq/Kgcldh8ak4mijrn1jYuMcx+jIY
         B16g==
X-Gm-Message-State: AJIora/AKlge7wR2C2PizYl4u2r0xMsmprI0AYkZyhg9sJlhQdRbeDPt
        VoTTUyoYsD1r1Tz/x2oM2wtjOQ==
X-Google-Smtp-Source: AGRyM1vq8S96jIW+uk5lkEUyMx3tmLM5T2LiS2+Uri5idB2675B3Vf49kXUdWT/UgN2E4ubVvLQo9g==
X-Received: by 2002:a05:600c:35ce:b0:39c:7dc2:aec0 with SMTP id r14-20020a05600c35ce00b0039c7dc2aec0mr5170072wmq.33.1655386698378;
        Thu, 16 Jun 2022 06:38:18 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:34f:da80:9c48:d9f8:5c33:3dd5])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d678c000000b0020c5253d90asm1935423wru.86.2022.06.16.06.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:38:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 0/2] phy: amlogic: Add support for the G12A Analog MIPI D-PHY
Date:   Thu, 16 Jun 2022 15:38:09 +0200
Message-Id: <20220616133811.1674777-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
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

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
panels, this adds the bindings.
    
This Analog D-PHY works with a separate Digital MIPI D-PHY.

This serie adds the Bindings and the PHY driver.

Changes from v3 at [3]:
- Add sentinel comment as requested by Martin

Changes from v2 at [2]:
- Bindings example fix

Changes from v1 at [1]:
- Bindings fixes

[1] https://lore.kernel.org/r/20201123145157.300456-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20210210080736.771803-1-narmstrong@baylibre.com
[3] https://lore.kernel.org/r/20220107150512.614423-1-narmstrong@baylibre.com

Neil Armstrong (2):
  dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
  phy: amlogic: Add G12A Analog MIPI D-PHY driver

 .../phy/amlogic,g12a-mipi-dphy-analog.yaml    |  35 ++++
 drivers/phy/amlogic/Kconfig                   |  12 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 177 ++++++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c

-- 
2.25.1

