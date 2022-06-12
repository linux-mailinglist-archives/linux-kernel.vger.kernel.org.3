Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98518547A5E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiFLNao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiFLNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:30:41 -0400
X-Greylist: delayed 480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Jun 2022 06:30:39 PDT
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF3C29822;
        Sun, 12 Jun 2022 06:30:35 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 089F841B15;
        Sun, 12 Jun 2022 18:22:27 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1655040149; bh=4P4Yo9juYPmc1HsdcY3wTsaGBQEFZChnEzFSe+0r7N4=;
        h=From:To:Cc:Subject:Date:From;
        b=ur2BtFIJDW/ewh7EHsoVsR8d8/7miVvTaxHvl/A0A95oI/Xmq1l/xNVMbpds+HHsu
         A5lyKul18co7zYKk0Fbd+NcsIr8FYGCK9A5q6xjOHYvGjy/fpAHLArRqrodl4PnrHa
         E0rcHowg1mPdzASdnyP3+8L/8+XE3xz2fwPEq3VQbwo9qpF9lbwfjZq20YVQF3ZADG
         hbKyHlXHr9oKs5UQUAyKIXNujpxoCKdsCLkl53y9B42dyvvKBzZ/lyeb834u+SAu7E
         AQG5BTDZKHjvFWXIdVY9K87XEr2qpQh14axxgXqforZ8zdwZqLzOkl0xwMGfwHh5/y
         UWIbzJcEv6t5g==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.or,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v7 0/2] Clock based PWM output driver
Date:   Sun, 12 Jun 2022 18:22:01 +0500
Message-Id: <20220612132203.290726-1-nikita@trvn.ru>
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

Nikita Travkin (2):
  dt-bindings: pwm: Document clk based PWM controller
  pwm: Add clock based PWM output driver

 .../devicetree/bindings/pwm/clk-pwm.yaml      |  46 ++++++
 drivers/pwm/Kconfig                           |  10 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-clk.c                         | 141 ++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
 create mode 100644 drivers/pwm/pwm-clk.c

-- 
2.35.3

