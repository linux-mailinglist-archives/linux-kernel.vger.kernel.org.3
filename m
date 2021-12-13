Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA1473002
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhLMPDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:03:50 -0500
Received: from box.trvn.ru ([194.87.146.52]:47229 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231924AbhLMPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:03:49 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 7599341913;
        Mon, 13 Dec 2021 20:03:45 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639407826; bh=xaECMniEgeLQimWXB5Wx+TWe2YFpdAVS8hZchSxL7Q8=;
        h=From:To:Cc:Subject:Date:From;
        b=JT9rv1BpAwgKcN+I8uQSrKLev9bLLp3byJWVpjEfoz6IhvJRiK1BuQDW5+N1IME5W
         YxzsoSMPMgjwEnOBnWfZ4uMTfiEXzWMVBk5vfA3hDYtCgENt8rXrvIBNEx2TggljfE
         UX/3X9n2+lSUlY60zAbrZ7WDD/TCmQBwyfZ+kRe5gVri4S9zbMTAu1HCt++ddQIRXe
         5wIBYcODMu31qKLiXQKUn+sbfDFiW/JpXmdmlV2T0RNukOcPAkcvoONrD5DdAI7v3g
         8pS8gZ4mpZKcEcIuoQXersnbUM4lSZpFVI0KF03jv+GypKS1mLKHQk3HxzaieHXrc9
         1BXWAUUbRKrYw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 0/2] Clock based PWM output driver
Date:   Mon, 13 Dec 2021 20:03:33 +0500
Message-Id: <20211213150335.51888-1-nikita@trvn.ru>
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

[1] - https://lore.kernel.org/lkml/20191205002503.13088-1-masneyb@onstation.org/
[2] - https://lore.kernel.org/lkml/CACRpkdZxu1LfK11OHEx5L_4kyjMZ7qERpvDzFj5u3Pk2kD1qRA@mail.gmail.com/

Nikita Travkin (2):
  dt-bindings: pwm: Document clk based PWM controller
  pwm: Add clock based PWM output driver

 .../devicetree/bindings/pwm/clk-pwm.yaml      |  45 ++++++
 drivers/pwm/Kconfig                           |  10 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-clk.c                         | 143 ++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
 create mode 100644 drivers/pwm/pwm-clk.c

-- 
2.30.2

