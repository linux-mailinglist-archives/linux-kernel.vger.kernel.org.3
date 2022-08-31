Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904265A889C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiHaVzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiHaVyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:54:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA70100D;
        Wed, 31 Aug 2022 14:54:46 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-057-024.ewe-ip-backbone.de [91.96.57.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 457BE6601DF3;
        Wed, 31 Aug 2022 22:54:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661982885;
        bh=rnG6GZ4GkpM0T3h0AvOlwd/MDv92M08/myKuULiUtsA=;
        h=From:To:Cc:Subject:Date:From;
        b=euyOpVZEpIBG33CK/yC2jYG2yORzUekIfAEmNcDp/BAuHZeq6Nz6EXyf4F/dXk+lD
         1I6mdxNHE+icEtN2lGU7GpYvkv5L9WZqLatG2OIarvQ28ag3s+lvKh4zj9KRgX11LF
         bn950B8PoDGY+vTGRg/W+KJ0ctf++C8DjbCqwScDZkFXXTo/mTjUQ0LERcFyxWeItC
         goiYZQoD1fQWF19ZFWT19vFjbuSTGzCzG9E8Uo/9a/GsGQvoztvUyhvOC8Dg0zHSSJ
         6rG5m/HzQdoVKSlzi93QWRRAu+/i+QK2aRO1cx3aBimzMVUSwW4tw3sxYbcHVwMtlv
         f2Zr8/8LTsEKA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2D57048015C; Wed, 31 Aug 2022 23:54:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 00/13] Introduce RK806 Support
Date:   Wed, 31 Aug 2022 23:54:24 +0200
Message-Id: <20220831215437.117880-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Rockchip RK3588 Evaluation Boards use SPI connected RK806
PMICs. Downstream this is handled by a new driver, but apart
from being SPI connected this chip is quite similar to the
ther Rockchip PMICs (also RK806 is promoted to also support
I2C). Thus this series instead updates RK808.

-- Sebastian

Sebastian Reichel (13):
  mfd: rk808: convert to device managed resources
  mfd: rk808: use dev_err_probe
  clk: RK808: reduce 'struct rk808' usage
  regulator: rk808: reduce 'struct rk808' usage
  rtc: rk808: reduce 'struct rk808' usage
  mfd: rk808: replace 'struct i2c_client' with 'struct device'
  mfd: rk808: split into core and i2c
  dt-bindings: mfd: add rk806 binding
  mfd: rk8xx: add rk806 support
  pinctrl: rk805: add rk806 pinctrl support
  regulator: rk808: Use dev_err_probe
  regulator: rk808: add rk806 support
  ASoC: rk817: Remove 'select REGMAP_I2C'

 .../bindings/mfd/rockchip,rk806.yaml          | 388 ++++++++++++++
 drivers/clk/clk-rk808.c                       |  34 +-
 drivers/mfd/Kconfig                           |  19 +
 drivers/mfd/Makefile                          |   4 +-
 drivers/mfd/{rk808.c => rk8xx-core.c}         | 343 +++++-------
 drivers/mfd/rk8xx-i2c.c                       | 205 ++++++++
 drivers/mfd/rk8xx-spi.c                       | 128 +++++
 drivers/pinctrl/pinctrl-rk805.c               | 189 ++++++-
 drivers/regulator/rk808-regulator.c           | 496 +++++++++++++++++-
 drivers/rtc/rtc-rk808.c                       |  47 +-
 include/linux/mfd/rk808.h                     | 417 ++++++++++++++-
 sound/soc/codecs/Kconfig                      |   1 -
 12 files changed, 1964 insertions(+), 307 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
 rename drivers/mfd/{rk808.c => rk8xx-core.c} (71%)
 create mode 100644 drivers/mfd/rk8xx-i2c.c
 create mode 100644 drivers/mfd/rk8xx-spi.c

-- 
2.35.1

