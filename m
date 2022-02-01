Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9518B4A68D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbiBAX5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbiBAX5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:57:03 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3BCC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:57:03 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id i10so55852695ybt.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 15:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HIrYku5aFARUbBbcgp5i8kFtNjI3jPS25XQjKlm2bkc=;
        b=nfDmYX/o3/Z3c1znv6UB5SjAhPsH+2AJ74lNYzOOx8mGtplrqGCPFTYfbAnJMf7mb7
         1pWWy/Wv3N7yPXMnQ8ZcqcCOtyATnu7MUnHfYjasIcM2vsJ/R1AvvM08c3BYYGxX94hy
         h8oFxNzwk+QKkSlhQs+nNcvJk0VU/Cy+WIgYigxW0BmEHtzya8NtfShbNDxlaZViE/Uc
         7m2F90fR6QIAFuK9DuTuxeygPiQtoDRpOE/okyoveuiMmF1L9W2O3Rd0akm9Y3arRxWw
         y1vj6elV72nzBmtAdEMPmyoVdNVx+hH6BWMltwxW1cmPF0bhemx6FcZvrP/XAaLC9Po/
         TXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HIrYku5aFARUbBbcgp5i8kFtNjI3jPS25XQjKlm2bkc=;
        b=QMKrHyT0oxdheIW+WQPAz6gfzMLOXZcwETEwQkgqe4MM8QfsyhQf2L/I0rwQLqXC2g
         0WTfFOEKQiWEHVd6BsHeJ0CRNHmOIYIRJ5/KYIa1nrFyHGLKFJx/W6GCosRoQ5yJ4XxJ
         uxVGt5IO30Szbcs+lhKi/ygVLkcgKfpkofQYS3OBQdbN9g6jz625Hrj8Ti3r2yLh5UAJ
         Ai2omO+cq1vrufPpY55VMPpWbp72ZutuyWEBex4/rN76rDgSL0Xl08WdwPMLGdOasNWy
         EfYUJ6OXTdrAJkTJeAOCVB6X+AbypO8LXXK9pwVzJaG9IueEk+fD2lwuATV2OtCgwvcE
         dHIg==
X-Gm-Message-State: AOAM531RwBTSvfULPeRDAPVK0TgH/wZvpMwdpamjAOoEcJHBFtMQV9Ib
        ctBMSZoyuNhBUVJvqXMqA8ml94jWYr5WStLXoBncvQ==
X-Google-Smtp-Source: ABdhPJyUW3nhaZHHiJgw4N1wpJjmP+xwtRJfwGP3736e2qqeEPVFEJQ6c4AmotEXLnrzb7KkVkPEjK8jf0JROFhnDKY=
X-Received: by 2002:a25:8c3:: with SMTP id 186mr37911468ybi.587.1643759822660;
 Tue, 01 Feb 2022 15:57:02 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Feb 2022 00:56:51 +0100
Message-ID: <CACRpkdanZHES7tKFdq6_VjL+1PVCUXHADS+q-KR-MJ3b8tjsEA@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a set of pin control fixes for the v5.17 series.
Most interesting and urgent is the Intel stuff affection
Chromebooks and Laptops.

The rest is business as usual.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07=
:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.17-2

for you to fetch changes up to baf927a833ca2c6717795ac131079f485cb7a5dc:

  pinctrl: microchip-sgpio: Fix support for regmap (2022-01-31 12:07:31 +01=
00)

----------------------------------------------------------------
Pin control fixes for the v5.17 kernel cycle:

- Fix up group name building on the Intel Thunderbay
- Fix interrupt problems on the Intel Cherryview
- Fix some pin data on the Sunxi H616
- Fix up the CONFIG_PINCTRL_ST Kconfig sort order as noted during
  the merge window
- Fix an unexpected interrupt problem on the Intel Sunrisepoint
- Fix a glitch when updating IRQ flags on all Intel pin controllers
- Revert a Zynqmp patch to unify the pin naming, let's find some
  better solution
- Fix some error paths in the Broadcom BCM2835 driver
- Fix a Kconfig problem pertaining to the BCM63XX drivers
- Fix the regmap support in the Microchip SGPIO driver

----------------------------------------------------------------
Andre Przywara (1):
      pinctrl: sunxi: Fix H616 I2S3 pin data

Andy Shevchenko (2):
      pinctrl: Place correctly CONFIG_PINCTRL_ST in the Makefile
      pinctrl: intel: Fix a glitch when updating IRQ flags on a
preconfigured line

Florian Fainelli (1):
      pinctrl: bcm2835: Fix a few error paths

Gerhard Engleder (1):
      pinctrl: zynqmp: Revert "Unify pin naming"

Hans de Goede (1):
      pinctrl: cherryview: Trigger hwirq0 for interrupt-lines without a map=
ping

Horatiu Vultur (1):
      pinctrl: microchip-sgpio: Fix support for regmap

Julian Braha (1):
      pinctrl: bcm63xx: fix unmet dependency on REGMAP for GPIO_REGMAP

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v5.17-4' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into fixes

Rafa=C5=82 Mi=C5=82ecki (2):
      pinctrl: thunderbay: comment process of building functions a bit
      pinctrl: thunderbay: rework loops looking for groups names

=C5=81ukasz Bartosik (1):
      pinctrl: intel: fix unexpected interrupt

 drivers/pinctrl/Makefile                    |  2 +-
 drivers/pinctrl/bcm/Kconfig                 |  1 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c       | 23 +++++---
 drivers/pinctrl/intel/pinctrl-cherryview.c  |  5 +-
 drivers/pinctrl/intel/pinctrl-intel.c       | 64 +++++++++++---------
 drivers/pinctrl/pinctrl-microchip-sgpio.c   |  3 +-
 drivers/pinctrl/pinctrl-thunderbay.c        | 90 +++++++++++--------------=
----
 drivers/pinctrl/pinctrl-zynqmp.c            | 10 ++--
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c |  8 +--
 9 files changed, 101 insertions(+), 105 deletions(-)
