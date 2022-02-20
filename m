Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178604BCE49
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 12:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbiBTLvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 06:51:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBTLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 06:51:27 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410BF4BFC0;
        Sun, 20 Feb 2022 03:51:06 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 523E94013D;
        Sun, 20 Feb 2022 16:50:52 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1645357854; bh=Uf6HYUxn28IZAPxShVWn4wFM8oxeVc0cjXkSVYshVfk=;
        h=From:To:Cc:Subject:Date:From;
        b=gVXeiOMmpGlXWSmykXoo+2fcwzekUokom4ag3iZN+7jrGOVxbWaXFhG3x8C3/g4pN
         sHZIkz+FHA6gxhZGEidKvC5I7oRrVv1Dv53959T3N6on/Zp8H+xc4mEXkfwpNKBDpM
         d1OFZqyAM36UnHEaHcxFssKBiBJz/FRpl8AbLw5h9/ulStz1tnrpCvcQxHui4PKskJ
         HlCMh5VzYBYDkE2oRD40mJpf80+GfbG77vwu1tYQR2UW6DmQGei5o6PhLnQyVYKITh
         KGjlgKIlxFYEeHwb3usxB8GZrVZfGXYjcA51pb9wZ/nDtlvznnZbK1dwoD2z0twc2Y
         IFxsYXmqQwgQg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v6 0/2] Clock based PWM output driver
Date:   Sun, 20 Feb 2022 16:50:28 +0500
Message-Id: <20220220115030.23772-1-nikita@trvn.ru>
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

Nikita Travkin (2):
  dt-bindings: pwm: Document clk based PWM controller
  pwm: Add clock based PWM output driver

 .../devicetree/bindings/pwm/clk-pwm.yaml      |  46 ++++++
 drivers/pwm/Kconfig                           |  10 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-clk.c                         | 139 ++++++++++++++++++
 4 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
 create mode 100644 drivers/pwm/pwm-clk.c

-- 
2.34.1

