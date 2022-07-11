Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8895570BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiGKUeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGKUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:33:57 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CC94E84C;
        Mon, 11 Jul 2022 13:33:56 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 61DA040151;
        Tue, 12 Jul 2022 01:33:48 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1657571630; bh=on71Fn6PJmPzhtPge1o/S9PoCOQqQHfSiY+DRr0U3Mc=;
        h=From:To:Cc:Subject:Date:From;
        b=Asgocgy5VCeyyV3unXB41fx422WbhirjUjfTmAz4gLdvATaazpBbym+tplMZVMmrN
         70SRVHH7opuT8nyoTdoC2b0FxFENX3wBkad3eZQVThIcXxCl4pTZTRFLyBHIrTtdt6
         oxg7V7XWAhVWuzsfBH4L8e4IbiKisRv9+mdF2lBEkyTQoDKKu1tRLmgB9RhgtbEend
         gCgEGGDgn7pweaYacbHiauLHT5EQhzl2HSk8p7C9df6eKiU3ibK+PwkggmkQQJNxDS
         zIME6sofpI/OlG/6V1uwibABcQTSEi96PDnuejrcv7zVCpxztvrlhh+YsNPhr9VuJ7
         EHE62NcKd/Pyw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v9 0/2] Clock based PWM output driver
Date:   Tue, 12 Jul 2022 01:33:38 +0500
Message-Id: <20220711203340.648007-1-nikita@trvn.ru>
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
Changes in v9:
 - Fix incorrect patch message separators ('---')

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

