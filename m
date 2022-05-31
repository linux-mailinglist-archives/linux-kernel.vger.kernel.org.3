Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ECF538ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbiEaK2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbiEaK2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:28:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A3456FBA;
        Tue, 31 May 2022 03:28:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c196so927235pfb.1;
        Tue, 31 May 2022 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCuNxdxEl/Pa+Q1Tl/1IqS2eBImhteY7BuJjNZre0UY=;
        b=ddBzTN95GMoX0CaJGTtPS6vTL0AnoQbyHYWBeR5En094CARo9fP8XnCry6FucMTfcH
         GOolfIuQmh1frd8tJhFDh44zTULDnjJvqxDsfGIWu74Srb6P4U1KmdmV/5ihRfpYqUc/
         odZOIXUoPvRMV5ANkLBAHNy6H2WCibXzxKw37DzP0cDB612M8k/3imY3QNvwzomUJ7Jj
         JOduDIkBKttMvu2H0WJa9uPrEa/VYygguEpkira+Ns0u9Vgwshary5JKxOhZZ93DHBD1
         gShUBo9SXg6m9jF/9yr/BsKaWFG2g72lyrq9fHnfTBbbH2PA1KSyQxCU6MIe0hTJyxNx
         1PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dCuNxdxEl/Pa+Q1Tl/1IqS2eBImhteY7BuJjNZre0UY=;
        b=QHWE6u26Dn6i6i4wwpx0nUr0P9EdOrDgD+0oZW2c/D7qNU5sJDhm/9h5PVm33zqd27
         TkNnKKEwuht+MT2cnDsNpZ+zV2H/p9knL+HbwI8dDREUzFY2Jx+AnT1zFjl8DBjDcgp5
         fbKk+knyehwCtSBQybXlY+NWS3ApH7ciIPYDtWhJyaJAXkkiAqIg43tdFLDeGLcIKm7c
         owBy44V2NyNTEx4nyxyltTYZ1cKRbNf9pBInX2Ur/izYLKeRKHhhi2iT4RCUemVtuODR
         RS2hLJFDk2kN7jcv4ISUqRi0ZMgTaiTdPkvMNBl9xrkZYcMl72ZIj2pLxVfTptdzi3pn
         cyEQ==
X-Gm-Message-State: AOAM530lmG+VsbEhsTRDM+peExYopU6JUNF8dIQU7t2xFGSH4jofnHtz
        CdiH8aC/UjbvNzpTslQo9TM4SFSetqE=
X-Google-Smtp-Source: ABdhPJwcOU7hN03w15oFG5H5N77JgYCYAlHLih2xVDtKhz7lppX5afVES+QpkZNat/9CXlws186kOw==
X-Received: by 2002:a05:6a00:1595:b0:518:a5b2:28d7 with SMTP id u21-20020a056a00159500b00518a5b228d7mr41960281pfk.80.1653992916963;
        Tue, 31 May 2022 03:28:36 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id c1-20020a63d501000000b003c14af50631sm10216519pgg.73.2022.05.31.03.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:28:36 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 00/14] Add Mediatek MT6370 PMIC support
Date:   Tue, 31 May 2022 18:27:55 +0800
Message-Id: <20220531102809.11976-1-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

This patch series add Mediatek MT6370 PMIC support. The MT6370 is a
highly-integrated smart power management IC, which includes a single cell
Li-Ion/Li-Polymer switching battery charger, a USB
Type-C & Power Delivery (PD) controller, dual Flash LED current sources,
a RGB LED driver, a backlight WLED driver, a display bias driver and a
general LDO for portable devices.

Alice Chen (3):
  leds: mt6370: Add Mediatek MT6370 Indicator support
  leds: flashlight: mt6370: Add Mediatek MT6370 flashlight support
  dt-bindings: leds: Add Mediatek MT6370 flashlight binding
    documentation

ChiYuan Huang (7):
  mfd: mt6370: Add Mediatek MT6370 support
  usb: typec: tcpci_mt6370: Add Mediatek MT6370 tcpci driver
  regulator: mt6370: Add mt6370 DisplayBias and VibLDO support
  dt-bindings: usb: Add Mediatek MT6370 TCPC binding documentation
  dt-bindings: leds: mt6370: Add Mediatek mt6370 indicator documentation
  dt-bindings: backlight: Add Mediatek MT6370 backlight binding
    documentation
  dt-bindings: mfd: Add Mediatek MT6370 binding documentation

ChiaEn Wu (4):
  iio: adc: mt6370: Add Mediatek MT6370 support
  power: supply: mt6370: Add Mediatek MT6370 charger driver
  video: backlight: mt6370: Add Mediatek MT6370 support
  dt-bindings: power: supply: Add Mediatek MT6370 Charger binding
    documentation

 .../backlight/mediatek,mt6370-backlight.yaml  |  110 ++
 .../leds/mediatek,mt6370-flashlight.yaml      |   48 +
 .../leds/mediatek,mt6370-indicator.yaml       |   57 +
 .../bindings/mfd/mediatek,mt6370.yaml         |  282 ++++
 .../power/supply/mediatek,mt6370-charger.yaml |   60 +
 .../bindings/usb/mediatek,mt6370-tcpc.yaml    |   35 +
 drivers/iio/adc/Kconfig                       |    9 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/mt6370-adc.c                  |  257 ++++
 drivers/leds/Kconfig                          |   11 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/flash/Kconfig                    |    9 +
 drivers/leds/flash/Makefile                   |    1 +
 drivers/leds/flash/leds-mt6370-flash.c        |  665 ++++++++++
 drivers/leds/leds-mt6370.c                    |  994 +++++++++++++++
 drivers/mfd/Kconfig                           |   13 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/mt6370.c                          |  273 ++++
 drivers/power/supply/Kconfig                  |   11 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/mt6370-charger.c         | 1132 +++++++++++++++++
 drivers/regulator/Kconfig                     |    8 +
 drivers/regulator/Makefile                    |    1 +
 drivers/regulator/mt6370-regulator.c          |  389 ++++++
 drivers/usb/typec/tcpm/Kconfig                |    8 +
 drivers/usb/typec/tcpm/Makefile               |    1 +
 drivers/usb/typec/tcpm/tcpci_mt6370.c         |  212 +++
 drivers/video/backlight/Kconfig               |    8 +
 drivers/video/backlight/Makefile              |    1 +
 drivers/video/backlight/mt6370-backlight.c    |  338 +++++
 .../dt-bindings/iio/adc/mediatek,mt6370_adc.h |   18 +
 include/dt-bindings/mfd/mediatek,mt6370.h     |   83 ++
 32 files changed, 5038 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
 create mode 100644 drivers/iio/adc/mt6370-adc.c
 create mode 100644 drivers/leds/flash/leds-mt6370-flash.c
 create mode 100644 drivers/leds/leds-mt6370.c
 create mode 100644 drivers/mfd/mt6370.c
 create mode 100644 drivers/power/supply/mt6370-charger.c
 create mode 100644 drivers/regulator/mt6370-regulator.c
 create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6370.c
 create mode 100644 drivers/video/backlight/mt6370-backlight.c
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
 create mode 100644 include/dt-bindings/mfd/mediatek,mt6370.h

-- 
2.25.1

