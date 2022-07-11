Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E3B56D4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiGKGY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGKGYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:24:05 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406E426FB;
        Sun, 10 Jul 2022 23:24:00 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C1BD24015A;
        Mon, 11 Jul 2022 11:23:56 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1657520638; bh=3cnpKi6/HBOePrysglXwD5oxzEtYdajsh9lp/kXhHHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lFd1d6tVrkbl2rdq5V/BrS34QMmsaVOpWw/FjO7kHlUptTKmTlnNT02H5ifKbRi/h
         dgHGlqZFznIj1/jz8yOJ9XzwHsok8yaIjqArDuKUJ2NsYxLNXAbuABy/uYtC5QYjC2
         0fUo18m38+KbxMBjlIP1xAdp5ZUwQ3QQxAxc4TXRQTHjrwYIxaOlDd5NGgiQERrNwD
         tMVcUN+olsusBn7mWy9XwnfwmN9jOT4/GbqUzAjCJW9w7HjA7WXo81c/Ei9WHAQtOx
         Lf9R+927261GfYHZf/RKBuDSAli0Z+TezMGwClZiWqjfso60xAphnr6quZ59iz8FD6
         gjF2xAKb/hp9g==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v8 0/2] Clock based PWM output driver
Date:   Mon, 11 Jul 2022 11:23:28 +0500
Message-Id: <20220711062330.4923-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes in v5:
 - Correct required properties.
 - add missed returns.
Changes in v6:
 - Add missed error cleanup
 - Adjust limitations comment
Changes in v7:
 - Rename some variables to be in line with common naming
Changes in v8:
 - Document the glitch that happens inbetween multiple clock operations

Nikita Travkin (2):
  dt-bindings: pwm: Document clk based PWM controller
  pwm: Add clock based PWM output driver

 .../devicetree/bindings/pwm/clk-pwm.yaml      |  46 ++++++
 drivers/pwm/Kconfig                           |  10 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-clk.c                         | 148 ++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
 create mode 100644 drivers/pwm/pwm-clk.c

-- 
2.35.3

