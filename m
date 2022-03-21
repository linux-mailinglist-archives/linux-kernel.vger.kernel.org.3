Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2245A4E3119
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352921AbiCUUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352899AbiCUUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:09:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F3103BAD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:07:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so212422wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpGd4BgFciLAC/AOKn8WnKSRlZJshCJsO8rO8N9T8Mg=;
        b=V7cv1Gp5aYUibydiPpyC1iMAPbfElb1ADdcdh2NllNmvAz5EkPjMAvKfhwkfbY1IAd
         OXbsHhDDuxNxPSB2aUioeFasHP5Wzsq9zehd1ydDT/K7KZFV7rbFVPOneG4k8Qz3JWfp
         dVaY4fquxKPKPWmNOS1S4d/1SjqX66IvzwHmTJF+xGEJNEKU/c0o6Vh5X0dxBa/UD7MI
         u5g9nUMIo1/XMBeU293pMbxYl9aRpHQ5iysFjutGUsI6ivPRv5ELA3IWx6F177v4iGye
         cC5C6BnkB1YpuYYbuaIHZJ0VJ6lU8zP+4KoQe2RG1J+ryBwrum+OKcot28iki2N9IFlw
         Rfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpGd4BgFciLAC/AOKn8WnKSRlZJshCJsO8rO8N9T8Mg=;
        b=lN7NspMz/Bw6KF4W9WjQeG9Hp7svNDlsobk6hOOEiO+o6E8lWHRLTFEKoepFVve1QX
         DHvGuIKPY7dpy61K6fPsExTI4Nn8zu6l1zr3dlZcoLVOElx6V/EtoGqouWtJkxI0ZIyr
         v7NVzq8GnZF+OOJECx1vLXZH271wemr2kXDwohThkfaBU0gtYiQa2NyaO/ljAyQR6d+q
         KJJsxhrYzp9zLwVX8PjY4TrMNclSs2Dpm3HNumE8hyrqyDiNnRDYpveHB1+tErqUS6Bz
         yEHBoRGzaZAvqC9OJWETRdn65yGgAwgf4KXRjT2li9DZzg1RWAvqTsUs1f7Gp3D5yeUU
         +9Bg==
X-Gm-Message-State: AOAM532jgmpWa4UOp+1jq51pluSkeLKqM3t4auVdnADeCFM+QilOEjEb
        JV5E4mJ0rc/rn51N/zaVPjAZjQ==
X-Google-Smtp-Source: ABdhPJwZTaaNTA/qSdU39RAezvG8FUGCtvMy8rvdvR8ZMrlNQk+E0JLW8u50BBVObfgDdD/uXVdHNA==
X-Received: by 2002:a05:600c:3c9d:b0:37f:a5c3:fccf with SMTP id bg29-20020a05600c3c9d00b0037fa5c3fccfmr669083wmb.13.1647893268904;
        Mon, 21 Mar 2022 13:07:48 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm24426988wry.72.2022.03.21.13.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:07:48 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 00/26] crypto: rockchip: permit to pass self-tests
Date:   Mon, 21 Mar 2022 20:07:13 +0000
Message-Id: <20220321200739.3572792-1-clabbe@baylibre.com>
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

Hello

The rockchip crypto driver is broken and do not pass self-tests.
This serie's goal is to permit to become usable and pass self-tests.

This whole serie is tested on a rk3328-rock64, rk3288-miqi with selftests (with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)
The serie is also tested on a rk3399 by Hugh Cole-Baker <sigmaris@gmail.com>

Regards

Changes since v1:
- select CRYPTO_ENGINE
- forgot to free fallbacks TFMs
- fixed kernel test robots warning
- add the PM patch

Changes since v2:
- Added DMA clock back to 3288 since it dont work without it
- fallback needed to select CBC and ECB configs
- Added support for rk3399
- Added more patch (style, read_poll_timeout)

Corentin Labbe (26):
  crypto: rockchip: use dev_err for error message about interrupt
  crypto: rockchip: do not use uninit variable
  crypto: rockchip: do not do custom power management
  crypto: rockchip: fix privete/private typo
  crypto: rockchip: do not store mode globally
  crypto: rockchip: add fallback for cipher
  crypto: rockchip: add fallback for ahash
  crypto: rockchip: better handle cipher key
  crypto: rockchip: remove non-aligned handling
  crypto: rockchip: rework by using crypto_engine
  crypto: rockchip: rewrite type
  crypto: rockchip: add debugfs
  crypto: rockchip: introduce PM
  crypto: rockchip: handle reset also in PM
  crypto: rockchip: use clk_bulk to simplify clock management
  crypto: rockchip: add support for r3399
  clk: rk3399: use proper crypto0 name
  arm64: dts: rockchip: rk3399: add crypto node
  arm64: dts: rockchip: add rk3328 crypto node
  ARM: dts: rk3288: crypto does not need reset-names anymore
  dt-bindings: crypto: convert rockchip-crypto to yaml
  crypto: rockchip: add support for rk3328
  crypto: rockchip: Check for maximum frequency of clocks
  crypto: rockchip: add myself as maintainer
  crypto: rockchip: fix style issue
  crypto: rockchip: use read_poll_timeout

 .../bindings/clock/qcom,gcc-other.yaml        |   2 +-
 .../crypto/rockchip,rk3288-crypto.yaml        |  84 +++
 .../bindings/crypto/rockchip-crypto.txt       |  28 -
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/rk3288.dtsi                 |   1 -
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  10 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  12 +
 drivers/crypto/Kconfig                        |  15 +
 drivers/crypto/rockchip/rk3288_crypto.c       | 498 ++++++++----------
 drivers/crypto/rockchip/rk3288_crypto.h       | 109 ++--
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 274 ++++++----
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 480 ++++++++++-------
 include/dt-bindings/clock/rk3399-cru.h        |   6 +-
 13 files changed, 880 insertions(+), 646 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt

-- 
2.34.1

