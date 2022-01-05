Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633E3485B48
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbiAEWHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244724AbiAEWHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDE8C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:03 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso462613pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFG0l9emxD+ju8/dHSykgBujSujZCyd7JKllBt6CzUo=;
        b=jecAfIY/6Qu8Buu8K/aqr0IrdQLnHApT+lYmFo6pyZE1a65d6H0naDK/SUJaACxmLW
         nLH++d4TzrDa5tBL3PginZNVAx1/s/oEPsEbc101uYtlAzzFgA548H3d+XoR8kMrDBkZ
         2qI3Gy+k72QSOdd7gj8tC9doNRg/w3aixN2dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFG0l9emxD+ju8/dHSykgBujSujZCyd7JKllBt6CzUo=;
        b=lQJOwO61fFS6B89JA5hDWSjkfwjb+ZdP1W4WLAlSx6tLLbd0IhCV45pUp8rzkAVD7q
         EoVciYgcq1rFlvGB+4QcSje0i8rH3izDCztUm+SUyvOcxXBpkcM/ZTJEQ5ZPOttpDVuz
         6yOOg0Vi3YkhPdiMpJ2qdr6LAR5rXQRytRQszPhPDA7dz3iK6U6c6qKzqqtKbvmeR7ua
         bnlq7nDs3o/YR3yA3VGEDI5d9K9OrNBz/2WHy9p7crG26PhKbVdJ0ONQEHHemOk2pGIC
         aeva3aAsqVvuoT6K4XVL0z1GFpZZOS335ae3wgUrAs1+EM7larePsw9LY6uAsym9aLET
         yXhQ==
X-Gm-Message-State: AOAM530eL8lncP6+byVOoKHnoiCq0LDLuFsmXWFSgOQOGcP5I4y9XpqB
        jHXXGg3F1WmiKBa1915pBdqVmw==
X-Google-Smtp-Source: ABdhPJw27ubGDdoaFjTWz8GID1OST2AU2oj7fn00pSUSmDTo8jYJgpQ3NgI0lwnigzi7BWQHPZDVUA==
X-Received: by 2002:a17:902:bd86:b0:149:5e5e:3857 with SMTP id q6-20020a170902bd8600b001495e5e3857mr51932157pls.36.1641420422574;
        Wed, 05 Jan 2022 14:07:02 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id y8sm3481746pjt.25.2022.01.05.14.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:01 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, dtor@chromium.org, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org, lee.jones@linaro.org, pmalani@chromium.org,
        sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 00/17] Add export symbol namespace PL_CHROMEOS
Date:   Wed,  5 Jan 2022 14:06:36 -0800
Message-Id: <20220105220653.122451-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a symbol namespace for functions exported by the plaform chromeos
subsystem.
Add depenencies for all drivers using these function.

'make nsdeps' is used to fix the dependencies.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Gwendal Grignou (17):
  plaform: chrome: Add PL_CHROMEOS export symbol namespace
  iio:cros_ec_sensors: Add PL_CHROMEOS dependency
  platform/chrome: Add PL_CHROMEOS dependency
  power_supply: chromeos: Add PL_CHROMEOS dependency
  rtc: wilco: Add PL_CHROMEOS dependency
  mfd: cros_ec_dev: Add PL_CHROMEOS dependency
  platform: chrome: Add PL_CHROMEOS dependency
  rtc: cros_ec: Add PL_CHROMEOS dependency
  extcon: cros_ec: Add PL_CHROMEOS dependency
  HID: google: Add PL_CHROMEOS dependency
  i2c: cros-ec-tunnel: Add PL_CHROMEOS dependency
  Input: cros_ec_keyb - Add PL_CHROMEOS dependency
  media: cros-ec-cec: Add PL_CHROMEOS dependency
  power: supply: PCHG: Add PL_CHROMEOS dependency
  pwm: cros-ec: Add PL_CHROMEOS dependency
  regulator: cros-ec-regulator: Add PL_CHROMEOS dependency
  ASoC: cros_ec_codec: Add PL_CHROMEOS dependency

 drivers/extcon/extcon-usbc-cros-ec.c           |  1 +
 drivers/hid/hid-google-hammer.c                |  1 +
 drivers/i2c/busses/i2c-cros-ec-tunnel.c        |  1 +
 .../cros_ec_sensors/cros_ec_sensors_core.c     |  1 +
 drivers/iio/proximity/cros_ec_mkbp_proximity.c |  1 +
 drivers/input/keyboard/cros_ec_keyb.c          |  1 +
 .../media/cec/platform/cros-ec/cros-ec-cec.c   |  1 +
 drivers/mfd/cros_ec_dev.c                      |  1 +
 drivers/platform/chrome/cros_ec.c              |  1 +
 drivers/platform/chrome/cros_ec_chardev.c      |  1 +
 drivers/platform/chrome/cros_ec_debugfs.c      |  1 +
 drivers/platform/chrome/cros_ec_i2c.c          |  1 +
 drivers/platform/chrome/cros_ec_ishtp.c        |  1 +
 drivers/platform/chrome/cros_ec_lightbar.c     |  1 +
 drivers/platform/chrome/cros_ec_lpc.c          |  1 +
 drivers/platform/chrome/cros_ec_proto.c        | 18 +++++++++---------
 drivers/platform/chrome/cros_ec_rpmsg.c        |  1 +
 drivers/platform/chrome/cros_ec_sensorhub.c    |  1 +
 .../platform/chrome/cros_ec_sensorhub_ring.c   |  4 ++--
 drivers/platform/chrome/cros_ec_spi.c          |  1 +
 drivers/platform/chrome/cros_ec_sysfs.c        |  1 +
 drivers/platform/chrome/cros_ec_typec.c        |  1 +
 drivers/platform/chrome/cros_ec_vbc.c          |  1 +
 drivers/platform/chrome/cros_usbpd_logger.c    |  1 +
 drivers/platform/chrome/cros_usbpd_notify.c    |  5 +++--
 drivers/platform/chrome/wilco_ec/debugfs.c     |  1 +
 drivers/platform/chrome/wilco_ec/mailbox.c     |  2 +-
 drivers/platform/chrome/wilco_ec/properties.c  |  8 ++++----
 drivers/platform/chrome/wilco_ec/telemetry.c   |  1 +
 drivers/power/supply/cros_peripheral_charger.c |  1 +
 drivers/power/supply/cros_usbpd-charger.c      |  1 +
 drivers/power/supply/wilco-charger.c           |  1 +
 drivers/pwm/pwm-cros-ec.c                      |  1 +
 drivers/regulator/cros-ec-regulator.c          |  1 +
 drivers/rtc/rtc-cros-ec.c                      |  1 +
 drivers/rtc/rtc-wilco-ec.c                     |  1 +
 sound/soc/codecs/cros_ec_codec.c               |  1 +
 37 files changed, 51 insertions(+), 18 deletions(-)

-- 
2.34.1.448.ga2b2bfdf31-goog

