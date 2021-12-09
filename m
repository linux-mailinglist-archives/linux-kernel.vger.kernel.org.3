Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9046ECF1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbhLIQYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:24:19 -0500
Received: from box.trvn.ru ([194.87.146.52]:43087 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240974AbhLIQYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:24:19 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C09824016B;
        Thu,  9 Dec 2021 21:20:32 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639066836; bh=9FyqTnutPFDqkCaAlSKqgdtESMt8HmYG2QEpB4N70g8=;
        h=From:To:Cc:Subject:Date:From;
        b=w7MGT+QGl9flIxRotCXNI/jWjtbGDY/8r17Pp6diy3j8DfUcZr4li2GvFZP0pibdF
         Kp+0kMPrHYlneOfVnHBoWsEXY6rsFIbQ7hUAKHEsPU3rCC4Z0M+33ktZJ3jJNmcO4l
         QsmKmUtb5LSgQQKnmSf+5CBAACnejKDfhD4FV5rHQTj2YoWXd6giOOIR6+I2lZP0yP
         59zZjr0OpYY5rfPEKGXYMhyfckBLLJka0iU1oJIWeBQLJMFCOc09vCTaDHBBvoTOHk
         //8394V42WLYK25p3pGBhOOG/zA/eJ41XSnTuw+oaSbT0f8Kf1t55kuvZ0dAwHMKgA
         KSCSua4WkkIGw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/2] Clock based PWM output driver
Date:   Thu,  9 Dec 2021 21:20:18 +0500
Message-Id: <20211209162020.105255-1-nikita@trvn.ru>
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

[1] - https://lore.kernel.org/lkml/20191205002503.13088-1-masneyb@onstation.org/
[2] - https://lore.kernel.org/lkml/CACRpkdZxu1LfK11OHEx5L_4kyjMZ7qERpvDzFj5u3Pk2kD1qRA@mail.gmail.com/

Nikita Travkin (2):
  dt-bindings: pwm: Document clk based PWM controller
  pwm: Add clock based PWM output driver

 .../devicetree/bindings/pwm/clk-pwm.yaml      |  45 +++++++
 drivers/pwm/Kconfig                           |  10 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-clk.c                         | 119 ++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
 create mode 100644 drivers/pwm/pwm-clk.c

-- 
2.30.2

