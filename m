Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE78510C04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355821AbiDZW2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355813AbiDZW2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:28:09 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51521DDC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:25:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y2so216033ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EV+TAEhhQGHizbiyEwFNCKJ3yV/bj2Q/hZXTJ7mg+rA=;
        b=KBp5bancmjPg3dzBBKpsZBSkfVLwArP6IX1/BeEhymLUv+GyVeGOU6SSuyXL25tHmO
         +YBf4Hey+bKBWsaX+HJ1I4AMem7EbjSCbkdJenXQAeaIfawedsobSyMfKs19/TUt1Ia/
         qqovQBRVA6I79VIYoLI4MUGV8bns5c7xnQ8EgzGl6TMiRnDRmBJUrGFAtRRfhWxqUULR
         splJkG3XoLnQT0NTVLDf4Nuhr8y+UDdmIl64bemOpAICBMRaOCPuz+eZKlpvpiCsBX/S
         +gTx9sezdBgt97WsrbZpLm8/JHFBYRekfZu5EoxgiD1Twue7HwPlQ4r0CCKTSZ9H0CBA
         0X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EV+TAEhhQGHizbiyEwFNCKJ3yV/bj2Q/hZXTJ7mg+rA=;
        b=iGjEKapOTSNvliVJCrBZxuUCjPabXVNkdtMnGlQnjZttpiokewjjVJzZum45ukJXpD
         +Zy+WiamDDHZ06MwgDnA3UcofF2OqZHLVWOjyCinUn3CW70jX8dELiW2ygVf9PxWAud7
         Sij4BKg9ydi3sOUl09HWcuy8FJiklRN3STuNNpPGsOWx6BcwoW4vBfsR5HJQ/KVJ0eGd
         BDPfy3fly7NOU9zfzi+y18tvOwCGBXsZLNECnW3UTEc5hm+RaHWcQnNsGA/RiX84Xlsl
         MdOIHPajqKaWcAI3kdMSb2ZKat5npxrFp7+6204ee3PWdnWK4O2e6MeEGu5GR9QzXSic
         1k5g==
X-Gm-Message-State: AOAM531v3raxdc1GjzXbyIES58s+K96ggEIgEMpBFoMDyy6d7ZYZk6HV
        TQjQjqLHoSydoeDwlalyWysEZ8BZ5UaLDBRHtcwRv3yrg3zNzw==
X-Google-Smtp-Source: ABdhPJwu2VS3xkflIc+SbbETaKm5+YCtuEqcEV/NTj/2J6MfoRTD7NT9UlajKDT3asBghxU84w0+JmJiWtgPvpXV5FA=
X-Received: by 2002:a25:a12a:0:b0:644:e94e:5844 with SMTP id
 z39-20020a25a12a000000b00644e94e5844mr22826150ybh.492.1651011899535; Tue, 26
 Apr 2022 15:24:59 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Apr 2022 00:24:48 +0200
Message-ID: <CACRpkda+GO6iZEZVTY1dWheVCz=1FaGs7NNYHhBn8Ssht3-rhg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some assorted collected pin control fixes.

Details in the signed tag!

Please pull them in.

Yours,
Linus Walleij

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.18-2

for you to fetch changes up to 0c9843a74a85224a89daa81fa66891dae2f930e1:

  pinctrl: pistachio: fix use of irq_of_parse_and_map() (2022-04-24
16:24:09 +0200)

----------------------------------------------------------------
Pin control fixes for v5.18:

- Fix some register offsets on Intel Alderlake

- Fix the order the UFS and SDC pins on Qualcomm SM6350

- Fix a build error in Mediatek Moore.

- Fix a pin function table in the Sunplus SP7021.

- Fix some Kconfig and static keywords on the Samsung
  Tesla FSD SoC.

- Fix up the EOI function for edge triggered IRQs and keep
  the block clock enabled for level IRQs in the
  STM32 driver.

- Fix some bits and order in the Rockchip RK3308 driver.

- Handle the errorpath in the Pistachio driver probe()
  properly.

----------------------------------------------------------------
Andy Shevchenko (1):
      pinctrl: alderlake: Fix register offsets for ADL-N variant

Krzysztof Kozlowski (2):
      pinctrl: samsung: staticize fsd_pin_ctrl
      pinctrl: samsung: fix missing GPIOLIB on ARM64 Exynos config

Linus Walleij (2):
      Merge tag 'intel-pinctrl-v5.18-2' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into fixes
      Merge tag 'samsung-pinctrl-fixes-5.18' of
https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung into
fixes

Luca Ceresoli (2):
      pinctrl: rockchip: fix RK3308 pinmux bits
      pinctrl: rockchip: sort the rk3308_mux_recalced_data entries

Luca Weiss (1):
      pinctrl: qcom: sm6350: fix order of UFS & SDC pins

Lv Ruyi (1):
      pinctrl: pistachio: fix use of irq_of_parse_and_map()

Marek Vasut (2):
      pinctrl: stm32: Do not call stm32_gpio_get() for edge triggered
IRQs in EOI
      pinctrl: stm32: Keep pinctrl block clock enabled when LEVEL IRQ requested

Wells Lu (1):
      pinctrl: Fix an error in pin-function table of SP7021

YueHaibing (1):
      pinctrl: mediatek: moore: Fix build error

 arch/arm/mach-exynos/Kconfig                   |  1 -
 drivers/pinctrl/intel/pinctrl-alderlake.c      | 60 ++++++++++++++--------
 drivers/pinctrl/mediatek/Kconfig               |  1 +
 drivers/pinctrl/pinctrl-pistachio.c            |  6 +--
 drivers/pinctrl/pinctrl-rockchip.c             | 69 ++++++++++++++++----------
 drivers/pinctrl/qcom/pinctrl-sm6350.c          | 16 +++---
 drivers/pinctrl/samsung/Kconfig                | 11 ++--
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |  2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c          | 23 ++++++++-
 drivers/pinctrl/sunplus/sppctl_sp7021.c        |  8 +++
 10 files changed, 128 insertions(+), 69 deletions(-)
