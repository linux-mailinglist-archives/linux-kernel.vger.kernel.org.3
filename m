Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDD1508A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbiDTOT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380270AbiDTOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:18:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849F643ACF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:16:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e21so2455229wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTYoMHmRd8x2g8GH9Ji8JGhHbq82MUsWN/GB8tPt1yU=;
        b=n8mi8e7eEYzj/at3sY83ewAcZVoqenDD9PYYKJWyE+15q6pkMyzz5Hpi7FRz0qBxCN
         5zrG9je4/2Y1jvnu+WUp7vD0nk86sTnRGciDbCHXk7fStN7xvCERFy9W7lqomZAE7WF3
         3aMkn81BILnSO+oJ3aozsKRh2t5vVAngNjTR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTYoMHmRd8x2g8GH9Ji8JGhHbq82MUsWN/GB8tPt1yU=;
        b=L8wMz5eVuNmIYtbMGy7WwGHAGZEnAVdAsz2s2NuSz9iIQCzzyKhzYPiZAyJQmu6CXm
         hrmR2tVxu145x5GoeLVy97Y+wAUwT8Y7k2tlqRR+7Bvbh+IOhiXZa5hCUxxX7FIIxP7U
         nrR74cUlC1PrpYbKLAAsDWbzoeExPDA7uV8tQVhjYDU5BUhG0bygAs7q42LTzHOWSKNy
         kgeEfkgL0ldtRYOXrqlmtrYo8VTF7hjBJ8rSyBmotwWczuIt6s+9DxG9+XZ3LS1dh5P5
         5j7Z1pH5kAIYNg55E2uBqf6ZzDRRigm4YSbFthvoc0at+khFth1FfCqj1oIqnA/EO9iI
         jsGQ==
X-Gm-Message-State: AOAM533z2GxJeIKZEw3LCocw8FEi9KE3hc5STCeKVJk8z4XJZwKYt/Sl
        hQs8d10DV9Zaw6eT3WifLx2m8Q==
X-Google-Smtp-Source: ABdhPJzrC+wiN8Z4WSTVKPyrot7MeUxiYsCYgUc+BR8e7Wp2Gmf2AocqvfIHgXDNK2O8R53eI1B5Cg==
X-Received: by 2002:adf:db8b:0:b0:207:9a90:3819 with SMTP id u11-20020adfdb8b000000b002079a903819mr16431510wri.617.1650464159041;
        Wed, 20 Apr 2022 07:15:59 -0700 (PDT)
Received: from localhost.localdomain ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0020aa790a258sm12447wra.8.2022.04.20.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:15:58 -0700 (PDT)
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
Subject: [PATCH v5 0/4] Add channel type support to pwm-cros-ec
Date:   Wed, 20 Apr 2022 14:15:52 +0000
Message-Id: <20220420141556.681212-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Tested on a sc7180-trogdor board, build tested on x86.

Changes from v4:
(https://patchwork.kernel.org/project/chrome-platform/list/?series=632212)
- fixed wrong indentation in the devietree file on patch 3
- added review and ack tags from the previous run

Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/list/?series=631131)
- actually reworded patch 2 commit description
- reworked patch 2 to use of_device_is_compatible() instead of compatible .data

Changes from v2:
(https://patchwork.kernel.org/project/chrome-platform/list/?series=627837)
- reworded patch 2 commit description
- reworked the driver and dt documentation to use a new compatible rather than
  boolean property
- dropped the comment about build test only, tested on actual hardware
  (trogdor), build test on x86 (with CONFIG_OF=n).

Changes from v1:
(https://patchwork.kernel.org/project/chrome-platform/list/?series=625182)
- fixed the dt include file license
- fixed the property name (s/_/-/)
- rebased on current linus tree (few dts files changed from a soc tree
  pull, so patch 4 needs a recent base to apply correctly)

[1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/common/pwm.c;l=24
[2] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/depthcharge/src/drivers/ec/cros/ec.c;l=1271-1273

Fabio Baltieri (4):
  dt-bindings: add mfd/cros_ec definitions
  pwm: pwm-cros-ec: add channel type support
  dt-bindings: update google,cros-ec-pwm documentation
  arm64: dts: address cros-ec-pwm channels by type

 .../bindings/pwm/google,cros-ec-pwm.yaml      |  9 +-
 .../mt8183-kukui-jacuzzi-fennel-sku1.dts      |  4 +-
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  4 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  1 +
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  4 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  9 +-
 .../qcom/sc7280-herobrine-herobrine-r0.dts    |  7 +-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  7 +-
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |  4 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  7 +-
 .../boot/dts/rockchip/rk3399-gru-bob.dts      |  4 -
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  5 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  4 -
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  1 +
 drivers/pwm/pwm-cros-ec.c                     | 82 +++++++++++++++----
 include/dt-bindings/mfd/cros_ec.h             | 18 ++++
 16 files changed, 121 insertions(+), 49 deletions(-)
 create mode 100644 include/dt-bindings/mfd/cros_ec.h

-- 
2.36.0.rc0.470.gd361397f0d-goog

