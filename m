Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F2496324
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378826AbiAUQyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiAUQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:54:13 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC97C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:54:12 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bf5so14378271oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/wXgvmfD5hnFKzIbHMpJPxxZzeJRho2pBUaKHYdU7c=;
        b=SHYRhXZxGtHHVY1mz7SHrYJvOjaD/E6cCWozTvW4aKCVkJOgiRJnR1qpqWu6wgfW/l
         pEvGuE36gWds96wEjCrrnfgLZfKLCUnwDn2bd66LVx0Zs8W+bntqn/KIeHPetJ68UQoX
         FVAITn4OWq0aZt91cZcaQyxG9NcjU8KM1zhO6D9y7lHrFyZCfuC/jum6WPBvOpjnVAoh
         eiUWFjw6tw2c/rkFV0G0hp/yZr7QAbXWm5FyAvkWfQJkJ1bvs9Im236zWexdbIw3YxUu
         6nNZ4+tYmGCIKKkZc3HfLWn0XCPxPi+49o9q2T9Een7oivvaz1Yjf8qMy4r5TWDTaQZ+
         zwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/wXgvmfD5hnFKzIbHMpJPxxZzeJRho2pBUaKHYdU7c=;
        b=R46gtC7gkkUsPYj74ZiBn2k8oiqOIWO/k1qTuG0U+rVoih/GExIsglQBo9H0xEDrn1
         id05ixfstnnewVqsux9PvApIf9EUZHw7905NogiukxCRUNfXWWJoatxF3yY46curjiVW
         HzouQA7w/mnlAg3QZO31aU/CUmlsDNIDjUS0mudNwaxSGlIN5N41fIkkWmC+yfvPUgqq
         0NGUnOEE00/srCXT9Cl89NcVvZeku9h8qtErO55zzbzm5JLxcoWXvXOhwCz3k6aZZ8uy
         k3H+C56vNmXNTVCG8/Ve+EGnTaEMisG96YAZHnWWq4hnVT+4/uim5VjvayUrNegqSS3l
         wDQg==
X-Gm-Message-State: AOAM531pB7k3ArzLshyIhKOkf6pTIiraI1uFTQUiQr5+d4yoMUQ5IO+Q
        8xyRXRVtws2uQOyF0aj3kvYNVPjRE/o=
X-Google-Smtp-Source: ABdhPJzVt5Ii+s0yvm3Ub20uLTVUjT/EC4FsQXQYdy5gYoz75/u6DX2P2q8CHBXYlqg+Des9k/PIcw==
X-Received: by 2002:a54:4002:: with SMTP id x2mr1259166oie.42.1642784051850;
        Fri, 21 Jan 2022 08:54:11 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:11 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH 00/31] leds: start removing obsolete/useless enum
Date:   Fri, 21 Jan 2022 13:54:05 -0300
Message-Id: <20220121165436.30956-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches aims to replace the enum led_brightness in
include/linux/leds.h with unsigned int, as requested in the TODO file in
the drivers/leds folder. The first step is to change the old definitions
LED_OFF, LED_ON, LED_HALF and LED_FULL with the values.

This was done using find/grep/sed and later I did a review of the patch
to check that everything was right. A compilation using allmodconfig was
done to test that nothing broke.

I have more patches coming that will replace all the enum led_brightness
with unsigned int, as the led class now has support for max_brightness.

Please help review this patch.

Best regards,

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>

Luiz Sampaio (31):
  gpu: nouveau: nouveau_led: changing LED_FULL to actual value
  hid: changing LED_* from enum led_brightness to actual value
  hwmon: pmbus: changing LED_* from enum led_brightness to actual value
  iio: light: cm3605: changing LED_* from enum led_brightness to actual
    value
  input: keyboard: changing LED_* from enum led_brightness to actual
    value
  input: misc: changing LED_* from enum led_brightness to actual value
  input: touchscreen: changing LED_* from enum led_brightness to actual
    value
  leds: changing LED_* from enum led_brightness to actual value
  macintosh: changing LED_* from enum led_brightness to actual value
  media: radio: changing LED_* from enum led_brightness to actual value
  media: rc: changing LED_* from enum led_brightness to actual value
  media: v4l2-core: changing LED_* from enum led_brightness to actual
    value
  mmc: changing LED_* from enum led_brightness to actual value
  net: wireless: ath: changing LED_* from enum led_brightness to actual
    value
  net: wireless: atmel: changing LED_* from enum led_brightness to
    actual value
  net: broadcom: changing LED_* from enum led_brightness to actual value
  net: intersil: changing LED_* from enum led_brightness to actual value
  net: wireless: ralink: changing LED_* from enum led_brightness to
    actual value
  net: realtek: changing LED_* from enum led_brightness to actual value
  platform: x86: changing LED_* from enum led_brightness to actual value
  power: supply: changing LED_* from enum led_brightness to actual value
  tty: vt: changing LED_* from enum led_brightness to actual value
  usb: core: changing LED_* from enum led_brightness to actual value
  video: backlight: changing LED_* from enum led_brightness to actual
    value
  include: linux: leds: changing LED_* from enum led_brightness to
    actual value
  net: bluetooth: changing LED_* from enum led_brightness to actual
    value
  net: mac80211 : changing LED_* from enum led_brightness to actual
    value
  net: netfilter: changing LED_* from enum led_brightness to actual
    value
  net: rfkill: changing LED_* from enum led_brightness to actual value
  sound: core: changing LED_* from enum led_brightness to actual value
  sound: soc: sof: changing LED_* from enum led_brightness to actual
    value

 drivers/gpu/drm/nouveau/nouveau_led.c         |  4 +--
 drivers/hid/hid-bigbenff.c                    | 10 +++----
 drivers/hid/hid-elan.c                        |  2 +-
 drivers/hid/hid-lenovo.c                      |  2 +-
 drivers/hid/hid-lg4ff.c                       | 10 +++----
 drivers/hid/hid-picolcd_leds.c                |  6 ++--
 drivers/hid/hid-playstation.c                 |  2 +-
 drivers/hid/hid-sony.c                        |  4 +--
 drivers/hid/hid-steelseries.c                 | 14 ++++-----
 drivers/hid/hid-u2fzero.c                     |  4 +--
 drivers/hid/hid-wiimote-modules.c             |  4 +--
 drivers/hid/wacom_sys.c                       | 16 +++++-----
 drivers/hid/wacom_wac.c                       |  2 +-
 drivers/hwmon/pmbus/ibm-cffps.c               |  8 ++---
 drivers/iio/light/cm3605.c                    | 10 +++----
 drivers/input/keyboard/cap11xx.c              |  2 +-
 drivers/input/keyboard/qt2160.c               |  6 ++--
 drivers/input/keyboard/tm2-touchkey.c         | 12 ++++----
 drivers/input/misc/apanel.c                   |  4 +--
 drivers/input/misc/ims-pcu.c                  |  2 +-
 drivers/input/misc/wistron_btns.c             |  8 ++---
 drivers/input/touchscreen/stmfts.c            |  4 +--
 drivers/leds/blink/leds-lgm-sso.c             |  8 ++---
 drivers/leds/flash/leds-ktd2692.c             |  4 +--
 drivers/leds/flash/leds-lm3601x.c             | 10 +++----
 drivers/leds/flash/leds-mt6360.c              | 10 +++----
 drivers/leds/flash/leds-rt4505.c              |  8 ++---
 drivers/leds/flash/leds-rt8515.c              |  4 +--
 drivers/leds/flash/leds-sgm3140.c             |  4 +--
 drivers/leds/led-class.c                      |  6 ++--
 drivers/leds/led-core.c                       |  8 ++---
 drivers/leds/led-triggers.c                   |  4 +--
 drivers/leds/leds-adp5520.c                   |  2 +-
 drivers/leds/leds-an30259a.c                  |  8 ++---
 drivers/leds/leds-apu.c                       |  6 ++--
 drivers/leds/leds-ariel.c                     |  8 ++---
 drivers/leds/leds-asic3.c                     |  2 +-
 drivers/leds/leds-aw2013.c                    |  6 ++--
 drivers/leds/leds-bcm6328.c                   | 14 ++++-----
 drivers/leds/leds-bcm6358.c                   | 14 ++++-----
 drivers/leds/leds-bd2802.c                    | 14 ++++-----
 drivers/leds/leds-clevo-mail.c                |  6 ++--
 drivers/leds/leds-cobalt-qube.c               |  2 +-
 drivers/leds/leds-cpcap.c                     | 10 +++----
 drivers/leds/leds-da903x.c                    |  4 +--
 drivers/leds/leds-da9052.c                    |  4 +--
 drivers/leds/leds-dac124s085.c                |  2 +-
 drivers/leds/leds-el15203000.c                |  4 +--
 drivers/leds/leds-gpio.c                      |  4 +--
 drivers/leds/leds-is31fl319x.c                |  2 +-
 drivers/leds/leds-lm3530.c                    |  4 +--
 drivers/leds/leds-lm3532.c                    |  8 ++---
 drivers/leds/leds-lm3533.c                    |  4 +--
 drivers/leds/leds-lm3692x.c                   |  2 +-
 drivers/leds/leds-lm3697.c                    |  6 ++--
 drivers/leds/leds-lp3952.c                    |  4 +--
 drivers/leds/leds-lt3593.c                    |  2 +-
 drivers/leds/leds-max77650.c                  |  4 +--
 drivers/leds/leds-menf21bmc.c                 |  2 +-
 drivers/leds/leds-mlxcpld.c                   | 22 +++++++-------
 drivers/leds/leds-mlxreg.c                    | 10 +++----
 drivers/leds/leds-mt6323.c                    |  2 +-
 drivers/leds/leds-netxbig.c                   |  4 +--
 drivers/leds/leds-nic78bx.c                   |  2 +-
 drivers/leds/leds-ns2.c                       |  4 +--
 drivers/leds/leds-ot200.c                     |  2 +-
 drivers/leds/leds-pca9532.c                   |  6 ++--
 drivers/leds/leds-pca955x.c                   | 30 +++++++++----------
 drivers/leds/leds-pca963x.c                   |  4 +--
 drivers/leds/leds-pm8058.c                    |  8 ++---
 drivers/leds/leds-powernv.c                   | 12 ++++----
 drivers/leds/leds-pwm.c                       |  2 +-
 drivers/leds/leds-rb532.c                     |  2 +-
 drivers/leds/leds-regulator.c                 |  2 +-
 drivers/leds/leds-sc27xx-bltc.c               |  6 ++--
 drivers/leds/leds-spi-byte.c                  |  2 +-
 drivers/leds/leds-ss4200.c                    | 12 ++++----
 drivers/leds/leds-sunfire.c                   |  2 +-
 drivers/leds/leds-syscon.c                    |  2 +-
 drivers/leds/leds-tca6507.c                   |  8 ++---
 drivers/leds/leds-wm831x-status.c             |  8 ++---
 drivers/leds/leds-wm8350.c                    |  8 ++---
 drivers/leds/simple/simatic-ipc-leds.c        | 10 +++----
 drivers/leds/trigger/ledtrig-activity.c       |  2 +-
 drivers/leds/trigger/ledtrig-backlight.c      |  4 +--
 drivers/leds/trigger/ledtrig-camera.c         |  4 +--
 drivers/leds/trigger/ledtrig-cpu.c            |  4 +--
 drivers/leds/trigger/ledtrig-gpio.c           |  4 +--
 drivers/leds/trigger/ledtrig-heartbeat.c      |  4 +--
 drivers/leds/trigger/ledtrig-netdev.c         |  6 ++--
 drivers/leds/trigger/ledtrig-oneshot.c        |  6 ++--
 drivers/leds/trigger/ledtrig-panic.c          |  2 +-
 drivers/leds/trigger/ledtrig-pattern.c        |  2 +-
 drivers/leds/trigger/ledtrig-timer.c          |  2 +-
 drivers/leds/trigger/ledtrig-transient.c      |  6 ++--
 drivers/leds/trigger/ledtrig-tty.c            |  4 +--
 drivers/macintosh/via-pmu-led.c               |  2 +-
 drivers/media/radio/radio-shark.c             |  6 ++--
 drivers/media/radio/radio-shark2.c            |  4 +--
 drivers/media/rc/rc-main.c                    |  4 +--
 drivers/media/rc/redrat3.c                    |  4 +--
 drivers/media/rc/ttusbir.c                    |  4 +--
 drivers/media/rc/winbond-cir.c                |  6 ++--
 .../media/v4l2-core/v4l2-flash-led-class.c    |  4 +--
 drivers/mmc/core/core.c                       |  4 +--
 drivers/mmc/host/rtsx_usb_sdmmc.c             |  4 +--
 drivers/mmc/host/sdhci.c                      |  4 +--
 drivers/net/wireless/ath/ath5k/led.c          |  2 +-
 drivers/net/wireless/ath/ath9k/gpio.c         |  4 +--
 drivers/net/wireless/ath/ath9k/htc_drv_gpio.c |  4 +--
 drivers/net/wireless/atmel/at76c50x-usb.c     |  4 +--
 drivers/net/wireless/broadcom/b43/leds.c      |  2 +-
 .../net/wireless/broadcom/b43legacy/leds.c    |  2 +-
 drivers/net/wireless/intersil/p54/led.c       |  2 +-
 .../net/wireless/ralink/rt2x00/rt2400pci.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2500pci.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2500usb.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  4 +--
 .../net/wireless/ralink/rt2x00/rt2x00leds.c   | 16 +++++-----
 drivers/net/wireless/ralink/rt2x00/rt61pci.c  |  4 +--
 drivers/net/wireless/ralink/rt2x00/rt73usb.c  |  4 +--
 .../wireless/realtek/rtl818x/rtl8187/leds.c   |  4 +--
 drivers/platform/x86/acer-wmi.c               |  6 ++--
 drivers/platform/x86/asus-wireless.c          |  6 ++--
 drivers/platform/x86/dell/dell-laptop.c       |  2 +-
 drivers/platform/x86/dell/dell-wmi-led.c      |  4 +--
 drivers/platform/x86/fujitsu-laptop.c         | 28 ++++++++---------
 drivers/platform/x86/lg-laptop.c              | 18 +++++------
 drivers/platform/x86/system76_acpi.c          |  4 +--
 drivers/platform/x86/thinkpad_acpi.c          | 14 ++++-----
 drivers/platform/x86/topstar-laptop.c         |  4 +--
 drivers/platform/x86/toshiba_acpi.c           | 24 +++++++--------
 drivers/power/supply/power_supply_leds.c      | 26 ++++++++--------
 drivers/tty/vt/keyboard.c                     |  4 +--
 drivers/usb/core/ledtrig-usbport.c            |  6 ++--
 drivers/video/backlight/adp8860_bl.c          |  4 +--
 drivers/video/backlight/adp8870_bl.c          |  4 +--
 drivers/video/backlight/led_bl.c              |  2 +-
 include/linux/leds.h                          |  2 +-
 net/bluetooth/leds.c                          |  6 ++--
 net/mac80211/led.c                            | 10 +++----
 net/netfilter/xt_LED.c                        |  6 ++--
 net/rfkill/core.c                             |  8 ++---
 sound/core/control_led.c                      |  2 +-
 sound/soc/sof/control.c                       |  4 +--
 145 files changed, 434 insertions(+), 434 deletions(-)

-- 
2.34.1

