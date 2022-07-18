Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3914757802B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiGRKu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiGRKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:50:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BDD1FCCB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 103A9B81122
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F26C341C0;
        Mon, 18 Jul 2022 10:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658141454;
        bh=ZOMFxP9OjT6H8eo3v377jvuAkq+xdKfVbWdL9uH1JLw=;
        h=From:To:Cc:Subject:Date:From;
        b=EY0SGOlMHr3B6knTpfV/e92bUya9mSTekPBHqbgvDorqDP7I9B5H6S4zE7CEZdLJK
         ZDttGHXLWPDkKb2TU2Gl2+pvyApZjNQZlQ9mDU7knT93/8casb9GEuyd9+A1j6Jyza
         U9gLIMZfx0GX/Qq7ukSzsuLngoUShFb+DChWDaI1yRBbVDa20IVPfwLOSHBZVGXnjs
         tuwWz694p5sGk5q/9ZsP7VZBHxbmimZ+MmI7OwMUxsMqKZ2CNkC6ysR/zHOKcUUsfG
         KUJQ3orW7WT456s+jB8gWmvt7Fv+ksxWe8oq3zPe9ROfSwkdEVsD6rHS5SmdbXALxO
         sYGwuQwWSeVgw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] platform/chrome: cros_kbd_led_backlight: fix build warning
Date:   Mon, 18 Jul 2022 10:50:47 +0000
Message-Id: <20220718105047.2356542-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/platform/chrome/cros_kbd_led_backlight.c got a new build warning
when using the randconfig in [1]:
>>> warning: unused variable 'keyboard_led_drvdata_ec_pwm'

The warning happens when CONFIG_CROS_EC is set but CONFIG_OF is not set.
Reproduce:
- mkdir build_dir
- wget [1] -O build_dir/.config
- COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 \
  O=build_dir ARCH=s390 SHELL=/bin/bash drivers/platform/chrome/

Fix the warning by using __maybe_unused.  Also use IS_ENABLED() because
CROS_EC is a tristate.

[1]: https://download.01.org/0day-ci/archive/20220717/202207170538.MR39dw8m-lkp@intel.com/config

Fixes: 40f58143745e ("platform/chrome: cros_kbd_led_backlight: support EC PWM backend")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1 (https://patchwork.kernel.org/project/chrome-platform/patch/20220718061608.2303425-1-tzungbi@kernel.org/):
- Use __maybe_unused.

 drivers/platform/chrome/cros_kbd_led_backlight.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 5ad41c10412d..793fd3f1015d 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -119,7 +119,7 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
 
 #endif /* CONFIG_ACPI */
 
-#ifdef CONFIG_CROS_EC
+#if IS_ENABLED(CONFIG_CROS_EC)
 
 static int
 keyboard_led_set_brightness_ec_pwm(struct led_classdev *cdev,
@@ -180,18 +180,18 @@ static int keyboard_led_init_ec_pwm(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
+static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
 	.init = keyboard_led_init_ec_pwm,
 	.brightness_set_blocking = keyboard_led_set_brightness_ec_pwm,
 	.brightness_get = keyboard_led_get_brightness_ec_pwm,
 	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
 };
 
-#else /* CONFIG_CROS_EC */
+#else /* IS_ENABLED(CONFIG_CROS_EC) */
 
-static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
+static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
 
-#endif /* CONFIG_CROS_EC */
+#endif /* IS_ENABLED(CONFIG_CROS_EC) */
 
 static int keyboard_led_probe(struct platform_device *pdev)
 {
-- 
2.37.0.170.g444d1eabd0-goog

