Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94344E2AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349277AbiCUOeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350098AbiCUOd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:33:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4240A5D1A9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:32:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so20939658wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rz2kPyhob/Zn4b4eynOw/6UOyfstxjJm01L/htyIYCc=;
        b=J9iqLc21143U4IqrHGZbl43PU2GcDIexyXwwfNg978gKFJ++vuXmJOnT4lv/HRd0dA
         KhTJ0wFqyMYnKGSo+Arx6XL89qwnqi9YDs2QkCF+5rUz9Zcj2NNdqny+c19uCLiJ12S/
         BBYe8FQDOdmnbZHKvEmOoX2I+hnhW61pr2jZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rz2kPyhob/Zn4b4eynOw/6UOyfstxjJm01L/htyIYCc=;
        b=6hXIrUFOft9A2PZwIgNuz/ZPGr5hjsBUNFoC8nk1DGRU3Ap0A+Gpz2tdb7G6n8MNKM
         4OYxBo9KV+PWpT3iNRlgpHSLrTQb2Q0lkKNwWCWXjS14JWtphiM3PBXWKQk7OV+nDTNC
         w9QVpDL3Mvlj/cziuXXrPDyZZ8W9I/Es6Pz78vpU+YYGaVVfb2avTTdtu20KLPzsbZoA
         obcaRW8IasqYY8G6Mbcv6pQcuu+ago1gDM7I20acdPag7sxzClwdI83RXJ1xBtSZJ+yX
         FeqYthAP/B/3eXNDKj5pb8JdeX0KiSXAURXc5ea0joKodIOYDYAgkksTZZCsEaHS6kIC
         QTOA==
X-Gm-Message-State: AOAM532nPcoI81bsWnzhvtdDrs06+SZ0oWqlWT0lcps3mvsMOTjE7F+J
        GJSXPhvz2azHmURG+xoWZSRmYw==
X-Google-Smtp-Source: ABdhPJwlF27a1NJ6xMacbGdjU1rd5N8lVS4V0IPQ+1pI4C3wPK4QyQWn/uHzsmotIgUqlAj4AnT7RQ==
X-Received: by 2002:adf:f281:0:b0:203:e3a2:de5d with SMTP id k1-20020adff281000000b00203e3a2de5dmr18548830wro.598.1647873150811;
        Mon, 21 Mar 2022 07:32:30 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b00389efe9c512sm19092793wmq.23.2022.03.21.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:32:30 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH 0/4] Add channel type support to pwm-cros-ec
Date:   Mon, 21 Mar 2022 14:32:18 +0000
Message-Id: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The ChromiumOS EC PWM host command protocol supports specifying the
requested PWM by type rather than channel. [1]

This series adds support for specifying PWM by type rather than channel
number in the pwm-cros-ec driver, which abstracts the node definitions
from the actual hardware configuration from the kernel perspective,
aligns the API with the one used by the bootloader, and allows removing
some dtsi overrides.

Tested on a sc7180-trogdor board, but on a version based on an older
kernel, so this exact series is build only tested.

[1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/common/pwm.c;l=24
[2] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/depthcharge/src/drivers/ec/cros/ec.c;l=1271-1273

Fabio Baltieri (4):
  dt-bindings: add mfd/cros_ec definitions
  drivers: pwm: pwm-cros-ec: add channel type support
  dt-bindings: update google,cros-ec-pwm documentation
  arm64: dts: address cros-ec-pwm channels by type

 .../bindings/pwm/google,cros-ec-pwm.yaml      |  6 ++
 .../mt8183-kukui-jacuzzi-fennel-sku1.dts      |  4 +-
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  3 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  1 +
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  4 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  8 +-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  6 +-
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |  3 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  6 +-
 .../boot/dts/rockchip/rk3399-gru-bob.dts      |  4 -
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  4 -
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  1 +
 drivers/pwm/pwm-cros-ec.c                     | 80 +++++++++++++++----
 include/dt-bindings/mfd/cros_ec.h             | 18 +++++
 15 files changed, 113 insertions(+), 39 deletions(-)
 create mode 100644 include/dt-bindings/mfd/cros_ec.h

-- 
2.35.1.894.gb6a874cedc-goog

