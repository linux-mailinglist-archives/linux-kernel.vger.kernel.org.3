Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B158E6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiHJGA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiHJGAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:00:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147FEE03
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:00:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3282fe8f48fso118404037b3.17
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 23:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=TCO2xyxVuPd3/tBUV+s0EeQJwLyZQsGvsrrIoFAUabA=;
        b=BvFe715tdJHTFzLiuUTS/Q7VYOCApMDwcI0d8adcuT6VY23Mzv0LjVB/oCe1EYUH6I
         GrUEBHGuCyX9om+3m+2zl2rmB8DHkIoDhCoJHkxwfbcimGGF2Au9Yt8rAFlE5vLE4zOT
         FBke0i6x4PfWRbfl2D3iR0cCU4z0WmA3iKlcfcXB0BYjlIhk2JqckwGp1G7FtAQR48/7
         pqJ0XtbeVUishXdC4XToLF9FWmAVWf/m/3RJfH4tl7k3Jd+oE21AZHO7Wt0qAh9vtQ8/
         piA6XmFBChiJiUmunvUDrKZvlyy2Mu3J3SrWw8IQ6KPqPhlxUX1s7KWZK+OvnRu3v5v3
         Y72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=TCO2xyxVuPd3/tBUV+s0EeQJwLyZQsGvsrrIoFAUabA=;
        b=F04GeoaFT/XXoLa1BZpnqBW22zj8go2BwCR400fUBQQNtj4guimrVUy7Gq4Q5mdISr
         KXYqrN3g+PZsb/0ginc0XiDmfVVnGgSOvGt1AOSGdVi7wl6Xjt6EFlQNF4Ay2Ck6afE4
         YJsH6nsDu97kXQhXlQffk2QlRC8yRj4pWnGsgL2CyXlTOwLbCyxxUlaBIySbfM1NSZ09
         Z9DQFsY0WRkuTv6ek+PfX3L3nbTTypJncJj+cq9iAtCJBwzWWD/QUKVaSEfpAF9+mhUK
         OyQVo6wlp8l1TsBJ5M1RECZ5RHrWtlUaNETjs8v8Ah+ZryKjsF0tOtirkx/3lb9h19cr
         NBOw==
X-Gm-Message-State: ACgBeo2iz9kwPSqUW1vcdzf+bNi1ldVUvoiemZtweo2ywym1diL91Fe+
        Wn/Sf2FQpjxWSVZjE7pESxIlmQyIEMaCkg0=
X-Google-Smtp-Source: AA6agR4Luo9mfYOGUmow5n6t7VfAyPObtMuTRPi8OYX4fTwH65RIMuWKTPOsfnkREdcPNXAbTsM3U3vFPMT0E+A=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f21:76ca:766f:e0ab])
 (user=saravanak job=sendgmr) by 2002:a25:7613:0:b0:67a:700a:f9e1 with SMTP id
 r19-20020a257613000000b0067a700af9e1mr23778556ybc.53.1660111247299; Tue, 09
 Aug 2022 23:00:47 -0700 (PDT)
Date:   Tue,  9 Aug 2022 23:00:29 -0700
Message-Id: <20220810060040.321697-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 0/9] fw_devlink improvements
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves fw_devlink in the following ways:

1. It no longer cares about a fwnode having a "compatible" property. It
   figures this our more dynamically. The only expectation is that
   fwnode that are converted to devices actually get probed by a driver
   for the dependencies to be enforced correctly.

2. Finer grained dependency tracking. fw_devlink will now create device
   links from the consumer to the actual resource's device (if it has one,
   Eg: gpio_device) instead of the parent supplier device. This improves
   things like async suspend/resume ordering, potentially remove the need
   for frameworks to create device links, more parallelized async probing,
   and better sync_state() tracking.

3. Handle hardware/software quirks where a child firmware node gets
   populated as a device before its parent firmware node AND actually
   supplies a non-optional resource to the parent firmware node's
   device.

4. Way more robust at cycle handling (see patch for the insane cases).

5. Stops depending on OF_POPULATED to figure out some corner cases.

6. Simplifies the work that needs to be done by the firmware specific
   code.

This took way too long to get done due to typo bugs I had in my rewrite or
corner cases I had to find and handle. But it's fairly well tested at this
point and I expect this to work properly.

Abel & Doug,

This should fix your cyclic dependency issues with your display. Can you
give it a shot please?

Alexander,

This should fix your issue where the power domain device not having a
compatible property. Can you give it a shot please?

Tony,

This should handle the odd case of the child being the supplier of the
parent. Can you please give this a shot? I want to make sure the cycle
detection code handles this properly and treats it like it's NOT a cycle.

Geert,

Can you test the renesas stuff I changed please? They should continue
working like before. Any other sanity test on other hardware would be
great too.

Sudeep,

I don't think there are any unfixed issues you had reported in my other
patches that this series might fix, but it'll be nice if you could give
this a sanity test.

Guenter,

I don't think this will fix the issue you reported in the amba patch, but
it's worth a shot because it improves a bunch of corner case handling. So
it might be better at handling whatever corner cases you might have in the
qemu platforms.

Thanks,
Saravana

Cc: Abel Vesa <abel.vesa@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Stultz <jstultz@google.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>

Saravana Kannan (9):
  driver core: fw_devlink: Don't purge child fwnode's consumer links
  driver core: fw_devlink: Improve check for fwnode with no
    device/driver
  soc: renesas: Move away from using OF_POPULATED for fw_devlink
  gpiolib: Clear the gpio_device's fwnode initialized flag before adding
  driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
  driver core: fw_devlink: Allow marking a fwnode link as being part of
    a cycle
  driver core: fw_devlink: Consolidate device link flag computation
  driver core: fw_devlink: Make cycle detection more robust
  of: property: Simplify of_link_to_phandle()

 drivers/base/core.c             | 437 +++++++++++++++++++++-----------
 drivers/gpio/gpiolib.c          |   6 +
 drivers/of/property.c           |  84 +-----
 drivers/soc/renesas/rcar-sysc.c |   2 +-
 include/linux/device.h          |   1 +
 include/linux/fwnode.h          |  12 +-
 6 files changed, 323 insertions(+), 219 deletions(-)

-- 
2.37.1.559.g78731f0fdb-goog

