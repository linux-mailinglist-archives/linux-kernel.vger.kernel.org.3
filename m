Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48CB4FFE80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbiDMTJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiDMTJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:09:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7F86E366
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1760474wmz.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTPr3m/S0BGE4rHVT3R7JCsuYjNSptwx0algC29rCig=;
        b=v2uVvXJycyac1gbVQqLZdI38/uzuJ9skXiIPXFhlCSewK0xqrdfLrcxw27X/1Godto
         VJRqxXICMmllGYPYdUT4Ls8FC3yDY3Q+BsATnr+z5ctjntqs5nrBKMn+vbeXxZ7PJuYT
         LEIYlEEtgLUYu9lYAOi9QM72ZpLp/4pEmyLatoqx0OBNnVevZ7xZnJuN8BWsqi9r5ZTX
         WloZN66tmFyLL6BCiLEjc1rvsEfSwccX6uAqKxwTEifg4gG8646xo452RKibBcpm2JAR
         nG3QjI/4HfAAb/dZKAopgcKaUttAR/72hDeIcMBJJgkRqsr0qU27UN+AFoylzL8pu3FM
         NfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTPr3m/S0BGE4rHVT3R7JCsuYjNSptwx0algC29rCig=;
        b=yCx2NYi9c+TPNCtneiTa5Z/44mdfziPNOi9DMJjfof2kTrvjbQnqyeGOu6npkIt4/+
         53/UB23OkqK3+FqqciwzPisRPqg/tEbVRGwylAyiAF6AYokq4OAp+tk2zZitgvSdmO9e
         XRxi+m/+aOOfJiuYME0bXiev6Gl85JyO76QS5u6wRwfyFtIRv3kvtYQiOSVN3GaTbiuQ
         O+1CxxtoOhuL4zUpGIRqre8NDXdVQ8U9XQC248TpEooo9uda2AwyunPwNHW8F8wPYLH4
         btFHbQgXTx86YSWduDoTrVPJiaHlGaMlh7rqTDZYyYpAXGdtAr6MNBhJZE+/MlVkFe+E
         U0ug==
X-Gm-Message-State: AOAM533Vb3MV7E6tl5OREyMzyrHa0Jke192tUzOOxBtfg9fntHUGtOPv
        nU3I3YpZvY2KTyoam7PXQMm2EQ==
X-Google-Smtp-Source: ABdhPJy3Zm0d9WLFXlxY8wjdG5QcmyfAeFG5RnJbTiNY5DAeOozBTazEP8+Gnbptt0o1bwwfdklLKg==
X-Received: by 2002:a1c:2744:0:b0:382:a9b7:1c8a with SMTP id n65-20020a1c2744000000b00382a9b71c8amr127289wmn.187.1649876841577;
        Wed, 13 Apr 2022 12:07:21 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:20 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 00/33] crypto: rockchip: permit to pass self-tests
Date:   Wed, 13 Apr 2022 19:06:40 +0000
Message-Id: <20220413190713.1427956-1-clabbe@baylibre.com>
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

Since I didnt own rk3399 hardware, I worked on an emulated one until I
grab some co-worker rk3399 board.
People wanting to test this serie without the hardware can try my qemu branch at
https://github.com/montjoie/qemu/tree/rkcrypto

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

 .../crypto/rockchip,rk3288-crypto.yaml        | 133 +++++
 .../bindings/crypto/rockchip-crypto.txt       |  28 -
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  11 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  20 +
 drivers/crypto/Kconfig                        |  15 +
 drivers/crypto/rockchip/rk3288_crypto.c       | 511 ++++++++--------
 drivers/crypto/rockchip/rk3288_crypto.h       | 107 ++--
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 267 +++++----
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 543 ++++++++++--------
 include/dt-bindings/clock/rk3399-cru.h        |   6 +-
 11 files changed, 953 insertions(+), 695 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt

-- 
2.35.1

