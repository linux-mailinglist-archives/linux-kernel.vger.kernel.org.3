Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781915A9782
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiIAM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiIAM5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:57:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BEC2AE04
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:57:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k17so8978502wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7ZlMqpIh3IyUq1dD/WzYgapnFJuX5D8gbR5mj33rR84=;
        b=L9kP09nqRH+Z+bWAt0KuRPx2ICiZGYDf0QG4pqMW9mJHKChmL6+bIqrMDYTGkui8FF
         b4n+l/zK7COuOfIqfV/9DHa/vWYUauG4RmYB/OlGdIJeFQfpkammZDjynZxYZ6SC/anh
         +eDr7oKp9T4ayau0RAbt6/arHAXVBvaYwb6SKaoArrAq0C5Dx2W1YSLWWXyvaaon3ubA
         BmnMXTKkuXJ1NxAo35VsPdSl1EGQ3P+sAc/Xt2uA1aYWKkGiDlupiFLCqrIjYeswWyrh
         LBJz9cTpcU1FrM8UUzEDqqE/o6DsKMKsQ+LetpL0LNkhLmXMaPpTFN+i7omadyWAQjtt
         aG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7ZlMqpIh3IyUq1dD/WzYgapnFJuX5D8gbR5mj33rR84=;
        b=qo9EcrnOZCnUEgtv/IJPCauVy5TI7uY23LLBU78mUz1vx8iNNKU4ncbw8hCLQhy6fv
         mInJh0jjGlLuRsiVno/mc+nqu3aqvY8QWUIzKNuaV3ao5wTzsNYMwmjbjphnnxgjdnSm
         dXx13uzSEEAqZN+IXnB1f9JeusC/0iEMtmmEm+dxX03NX8xruuAEloZJTNtpEPGcCVvJ
         h+OB2xwxENsX8KyqabpPI3cVdz3daXieO9NFQb6lLPQfVeL8w59ak/VRYtkLgpZ4ubLm
         cn+i8cGvfLu4srh9Hz8TdsmGREMk3Nr3ThFWCEUJ12fRak1rgZmzmQ+rNhfTRrvW43iT
         BoJw==
X-Gm-Message-State: ACgBeo1IVn9O+2AwMONxpJG80ZsSYt7JotWsqI247hajRfVsN9qVtRsv
        6nhcLHbtGumTGuav+qPoCNwMqQ==
X-Google-Smtp-Source: AA6agR4WxFW8MYMrAHnjtjYeK13E0krxBtcRYabXQEB9F9fEoJ3KLT3ciBgiYJKbXPpTmciIet5qbg==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr5162262wmq.188.1662037036916;
        Thu, 01 Sep 2022 05:57:16 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm15556709wry.6.2022.09.01.05.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:57:16 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v9 00/33] crypto: rockchip: permit to pass self-tests
Date:   Thu,  1 Sep 2022 12:56:37 +0000
Message-Id: <20220901125710.3733083-1-clabbe@baylibre.com>
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

This whole serie is tested on a rk3328-rock64, rk3288-miqi and
rk3399-khadas-edge-v with selftests (with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)

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

Changes since v3:
- full rewrite of support for RK3399
- splited dt-binding patch in two

Changes since v4:
- Another full rewrite of support for RK3399
- Fixed dt-binding from Krzysztof Kozlowski's comments
- Use readl_poll_timeout() instead of read_poll_timeout()
- Rewrite the fallback SG tests

Changes since v5:
- fixed errors in DT binding patch

Change since v6:
- remove quotes around const values in dt-bindings

Changes since v7:
- added lot of reviewed/tested by
- In patch 14: keep initial reset pulse.

Changes since v8:
- Removed some useless min/maxitems from dt-binding as reported by dt_binding_check

Corentin Labbe (33):
  crypto: rockchip: use dev_err for error message about interrupt
  crypto: rockchip: do not use uninitialized variable
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
  crypto: rockchip: add myself as maintainer
  crypto: rockchip: use read_poll_timeout
  crypto: rockchip: fix style issue
  crypto: rockchip: add support for rk3328
  crypto: rockchip: rename ablk functions to cipher
  crypto: rockchip: rework rk_handle_req function
  crypto: rockchip: use a rk_crypto_info variable instead of lot of
    indirection
  crypto: rockchip: use the rk_crypto_info given as parameter
  dt-bindings: crypto: convert rockchip-crypto to YAML
  dt-bindings: crypto: rockchip: convert to new driver bindings
  clk: rk3399: use proper crypto0 name
  arm64: dts: rockchip: add rk3328 crypto node
  arm64: dts: rockchip: rk3399: add crypto node
  crypto: rockchip: store crypto_info in request context
  crypto: rockchip: Check for clocks numbers and their frequencies
  crypto: rockchip: rk_ahash_reg_init use crypto_info from parameter
  crypto: rockchip: permit to have more than one reset
  crypto: rockchip: Add support for RK3399

 .../crypto/rockchip,rk3288-crypto.yaml        | 127 ++++
 .../bindings/crypto/rockchip-crypto.txt       |  28 -
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  11 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  20 +
 drivers/crypto/Kconfig                        |  15 +
 drivers/crypto/rockchip/rk3288_crypto.c       | 506 ++++++++--------
 drivers/crypto/rockchip/rk3288_crypto.h       | 107 ++--
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 267 +++++----
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 543 ++++++++++--------
 include/dt-bindings/clock/rk3399-cru.h        |   6 +-
 11 files changed, 949 insertions(+), 688 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt

-- 
2.35.1

