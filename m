Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE44495226
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376921AbiATQPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:15:05 -0500
Received: from box.trvn.ru ([194.87.146.52]:52625 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233059AbiATQPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:15:03 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 53F3E40CA6;
        Thu, 20 Jan 2022 21:14:59 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1642695300; bh=dJkfCt/wf01BgFz4htQDsVYJD+1/n2Njx5/ps0xEzUs=;
        h=From:To:Cc:Subject:Date:From;
        b=3OaUOJOeeMsO3xquiajjO5zTAA8+537EFlk1zt1x4SJRhSl+g8IowMQZkCSA/aMql
         AaarPT65ZyC/U7wKAhbgLlycoxLT4Yv8FF3dRzJtkqVjKo7bY0dGzsmHcehpzgWvuj
         WiAkfCKRlRx8XNSjJf8MQLSZX2v7OXMtd3PF8SH73lrEQWhHq+JANM5QzewVJMXcQj
         zwv4wr/N0ZM2lippvBSAiSoPUmem7RmgmsIMI4+av3+oOsw9h4/wGeX24S1BtjRTWs
         hWK8EHUSHvPJ4Ssvo9n+E67ORCr1GLbPLpJExKpa7EaVjzYYvJb1tHN/sd22m7uyEM
         mLuGsGayp1s5w==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 0/3] Clock based PWM output driver
Date:   Thu, 20 Jan 2022 21:14:39 +0500
Message-Id: <20220120161442.140800-1-nikita@trvn.ru>
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

[1] https://lore.kernel.org/lkml/20191205002503.13088-1-masneyb@onstation.org/
[2] https://lore.kernel.org/lkml/CACRpkdZxu1LfK11OHEx5L_4kyjMZ7qERpvDzFj5u3Pk2kD1qRA@mail.gmail.com/

Nikita Travkin (3):
  dt-bindings: pwm: Fix node name pattern
  dt-bindings: pwm: Document clk based PWM controller
  pwm: Add clock based PWM output driver

 .../devicetree/bindings/pwm/clk-pwm.yaml      |  45 ++++++
 .../devicetree/bindings/pwm/pwm.yaml          |   2 +-
 drivers/pwm/Kconfig                           |  10 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-clk.c                         | 139 ++++++++++++++++++
 5 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
 create mode 100644 drivers/pwm/pwm-clk.c

-- 
2.30.2

