Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BCB5130F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiD1KNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiD1KMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:12:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513D42483
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:04:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so6039266wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbMt1g6aoE0Bg5dwfqmFelsLQshOG2+YZf5M70rMj8Q=;
        b=eDHxmC6WsUWOrWLtgePXgUyYSARbuIpxRXqT83D+MT5KWhvRUkaRmVEDHIEuZK6a6/
         SgTx+6aOSj/uNyNwjy/w0C3vfP21G+btolT7n89mozDMEnkZh8KaR3J9AXZiiTGeDpff
         fWPJ6oduu0twIwFmfkUv8PsBJskvta0iFptbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbMt1g6aoE0Bg5dwfqmFelsLQshOG2+YZf5M70rMj8Q=;
        b=1ox3Dip5w8d5PNOumbxPHpyAE7aumD++SKQMCgKGv9Qiye5K1WPXuE5bPLi6DBcz1Q
         iDPKpPSI0HLRApxVGyMN6XLNtjfRuv62uiR8YBkDY1HXTSlzjEQnyHDBhwLt/fzfXd8S
         B1XHNRFPLtFZKj/9siPWrk0ehXsl54oVXvgbVFpRs07cf+L/vcqZdxxyHZ2Ow/xM4+Yl
         fY1jDxR8ezNLn+HdOnxJEYIW0AX6ctN7LI7n7D+hKuCjC3giDA+se+roErUk/wnQSX4w
         vbBLar0zTrwxl9pwcn2OLYszTMzMpaTp0/YFFbXDUctngaYkL+mF6qnpOR1jFDY373gd
         XbTg==
X-Gm-Message-State: AOAM531Q94hNllBJ1rKLmDu59/UQdXVAa9M7dV+Hkv/elqFrNnWffRon
        ja2S7e+dFoMzwYKJJW4J3UZ/ew==
X-Google-Smtp-Source: ABdhPJyqFzeu7gO4jIJIJSD11VQmMog/KOSnjjmdVpYp4MOAqrZyPlPZSH+cTzEL0sYYjh71p4fM7Q==
X-Received: by 2002:a5d:4f08:0:b0:20a:ddfe:bd99 with SMTP id c8-20020a5d4f08000000b0020addfebd99mr15546448wru.339.1651140270334;
        Thu, 28 Apr 2022 03:04:30 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6785000000b0020a792848eesm15080449wru.82.2022.04.28.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:04:29 -0700 (PDT)
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
Subject: [PATCH v6 0/4] Add channel type support to pwm-cros-ec
Date:   Thu, 28 Apr 2022 10:04:17 +0000
Message-Id: <20220428100421.247471-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes from v5:
(https://patchwork.kernel.org/project/chrome-platform/list/?series=633811)
- reworded the binding patch commit subject
- added one more review tag

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
  dt-bindings: google,cros-ec-pwm: add the new -type compatible
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
2.36.0.rc2.479.g8af0fa9b8e-goog

