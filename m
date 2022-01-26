Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5849CA33
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbiAZM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:59:20 -0500
Received: from box.trvn.ru ([194.87.146.52]:43373 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbiAZM7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:59:19 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C2A86400A0;
        Wed, 26 Jan 2022 17:59:15 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1643201956; bh=GUlkCjYIMDJixhkKakoCmGFOj/gSSWCHWkXVR92EQ1c=;
        h=From:To:Cc:Subject:Date:From;
        b=1SrbTTm/up3IRRGAWdDegOy7xbx3LEAJBSk0a5PWhDMxWONGdzZcaAzwIOTayffeD
         3c/hUeADmtdqwmi2W6N5MTxWmKlDz1G0MLJngg+5ZtwfX/kk52izWa2UjhsfaxQH0h
         iE/EfeYTmDGnGsFZEKCWpCGghlhFebTMQxoMmCYuSkst4irSYuhmoH5N+RDUZkN+C3
         X0IjZsultEZ2Kiqdr+Eyk+nM3bRderM2qrZ8lN86Kx8Rghp0D+XIjF1u9Z3CWV5weD
         ZEBScFJUxDbGtj1n42SKF4MfphuaxbDNboEuo+iOpogesSVEQyncnxyJIqQgx5wQEV
         +dYvTW/DaOIvA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v4 0/2] Clock based PWM output driver
Date:   Wed, 26 Jan 2022 17:58:47 +0500
Message-Id: <20220126125849.75572-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces an "adapter" driver that allows PWM consumers
to control clock outputs with duty-cycle control.

Some platforms (e.g. some Qualcomm chipsets) have "General Purpose"
clocks that can be muxed to GPIO outputs and used as PWM outputs.
Those outputs may be connected to various peripherals such as
leds in display backlight or haptic feedback motor driver.

To avoid re-implementing every single PWM consumer driver with clk
support (like in [1]) and don't put the burden of providing the PWM
sources on the clock drivers (as was proposed in [2]), clk based
pwm controller driver is introduced.

There is an existing driver that provides the opposite function
in drivers/clk/clk-pwm.c with a compatible "pwm-clock" so the new
driver uses the opposite naming scheme: drivers/pwm/pwm-clk.c
and compatible "clk-pwm".

Changes in v2:
 - Fix filename in the DT schema.
 - Address Uwe's review comments.
Changes in v3:
 - Fix node pattern in the core pwm schema.
 - Address Uwe's review comments.
Changes in v4:
 - Drop the (incorrect) pwm schema change.
 - Use generic node name in the dt bindings example.

[1] https://lore.kernel.org/lkml/20191205002503.13088-1-masneyb@onstation.org/
[2] https://lore.kernel.org/lkml/CACRpkdZxu1LfK11OHEx5L_4kyjMZ7qERpvDzFj5u3Pk2kD1qRA@mail.gmail.com/

Nikita Travkin (2):
  dt-bindings: pwm: Document clk based PWM controller
  pwm: Add clock based PWM output driver

 .../devicetree/bindings/pwm/clk-pwm.yaml      |  45 ++++++
 drivers/pwm/Kconfig                           |  10 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-clk.c                         | 139 ++++++++++++++++++
 4 files changed, 195 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
 create mode 100644 drivers/pwm/pwm-clk.c

-- 
2.34.1

