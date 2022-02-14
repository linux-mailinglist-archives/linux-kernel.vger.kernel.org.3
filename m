Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821904B51CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345780AbiBNNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:37:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354306AbiBNNho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:37:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A45604F9E2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644845855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E7VbCtE2KmCInyzJqMXW68a9E8Ah5Xd1OvC5Dcb2NGA=;
        b=FQPJzt+yDLDnzXUIIzTsywmLecmhCbL26G9OqF4fPvLde4JOTlmmHfBcX/V1vUx7a3NVdg
        P4wsjgDKZd+soe2OsPFh2Ge0es1aRW33ytdkVjQmWEjcN+Y5MQg6rr8lb6Slf7rNIDxUYY
        GT4D6AQj7BUcFH0/99SdZvwnF54VpT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-2UO-cA6OM42X-Sfs1wh_0Q-1; Mon, 14 Feb 2022 08:37:34 -0500
X-MC-Unique: 2UO-cA6OM42X-Sfs1wh_0Q-1
Received: by mail-wm1-f70.google.com with SMTP id p2-20020a05600c430200b0037bb72b5865so1614154wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7VbCtE2KmCInyzJqMXW68a9E8Ah5Xd1OvC5Dcb2NGA=;
        b=x2YZlqjPj1B5Up8qxnVWpnOHs6ZuMMeCcmor10ybIGp0ygTux+M6qBmMKQFcvf2mH/
         /bXwInLXLkyiVp/6mXQud8fGvJUdnuEID3PUG2MxrvkWgiLx1dXOyKRwFNXsIxh+E6GS
         NtFHw6rNXrpqLRzP1hFhWS0WJ14OoKknArEe+icy95V/8eFmYRFcAaYq394/Y7qV842h
         f82RxipvnCF2z8HWqzg9WPqIi071PGQCjgY7NdcZPoAvGfVPvk5Gv6H9AJJH7cEnqTBm
         h4nwXvKPF8VY8v8tXkKEn+Voj37mKbCfG/eBbUnYPMRBC55J4+rju5oyu1dggWnPfPQv
         a7lw==
X-Gm-Message-State: AOAM533f4+i8vYKUyKOn9tzcZ6rnIOQnok9tjtfRSavWuc14HGetX4r4
        zU74OdDtKKwQ0csGfIUCvbeHtxRihhhWjm0Yzb3BrFjbE4xoWxm8A8ZWwNHEguQZbxoaqnppzdE
        LMO5dkW5UqpY0QI2BLq+VfR0fifNVEee5ZIg2UrHCLUdEYguDyWPLfa5+k7c7WNKhFJWwyQnHgk
        c=
X-Received: by 2002:a05:6000:156c:: with SMTP id 12mr11043224wrz.387.1644845853274;
        Mon, 14 Feb 2022 05:37:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEJcPlMluZEUn6DLefymoUGFabsVNHTL+FcWwwnNPI7RmBtR+DFGGYeprSdmw5t1Xg99qx8g==
X-Received: by 2002:a05:6000:156c:: with SMTP id 12mr11043183wrz.387.1644845852826;
        Mon, 14 Feb 2022 05:37:32 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y6sm3568918wrd.30.2022.02.14.05.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:37:32 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v6 0/6] drm: Add driver for Solomon SSD130x OLED displays
Date:   Mon, 14 Feb 2022 14:37:04 +0100
Message-Id: <20220214133710.3278506-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.

Using the DRM fbdev emulation, all the tests from Geert Uytterhoeven repo
(https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes.

I've also tested it using the display as a VT output and even though fbcon
seems to work, it is mostly unusable on a 128x64 SSD1306 display.

This is a v6 that addresses the issues pointed in v5. Thanks a lot to all
reviewers that gave me feedback and comments.

I didn't include the patch that adds the SPI support this time, because it
will require changes in the existing Device Tree binding. And I wanted to
avoid that bikesheeding for now, to focus on the core and I2C parts.

Once this series land, I'll post patches for the SPI support. But the WIP
patch posted in v3 should still apply cleanly on top of this v6:

https://patchwork.kernel.org/project/dri-devel/patch/20220209091204.2513437-1-javierm@redhat.com/

Patch #1 splits per-line conversion logic in drm_fb_xrgb8888_to_gray8() to
a separate drm_fb_xrgb8888_to_gray8_line() helper function.

Patch #2 adds a new drm_fb_xrgb8888_to_mono_reversed() helper function to
convert from XR24 to reversed monochrome. The latter internally converts
each line first to 8-bit grayscale and then to 1-bit reversed monochrome.

Patch #3 adds the driver. This only has the core support and doesn't have
any bus specific code, separate drivers are needed for the transport used.

Patch #4 adds a driver to use the I2C bus to communicate with the device.

Patch #5 adds a MAINTAINERS entry for the DRM driver and patch #6 adds
myself as co-maintainer of the existing DT binding for the ssd1307fb,
since the same DT binding is used for both the fbdev and DRM drivers.

Best regards,
Javier

Changes in v6:
- Add Andy Shevchenko's Reviewed-by to patch #1.
- Add Andy Shevchenko's Reviewed-by to patch #2.
- Just return regmap_bulk_write() in ssd130x_write_data() (Andy Shevchenko)
- Remove unnecessary cast in ssd130x_write_cmd() (Andy Shevchenko)
- Return ERR_PTR(dev_err_probe(...)) everywhere in probe (Andy Shevchenko)

Changes in v5:
- Add Thomas Zimmermann's Reviewed-by to patch #1.
- Use drm_WARN_ON* macros instead of deprecated ones (Thomas Zimmermann)
- Include <linux/bits.h> header (Andy Shevchenko)
- Drop parenthesis for command options macros (Andy Shevchenko)
- Explain in ssd130x_write_cmd() comment how commands are sent (Andy Shevchenko)
- The pwm_*() functions check for NULL already (Andy Shevchenko)
- Remove unnecesary blank line (Andy Shevchenko)
- Simplify error handling for backlight registration failure (Geert Uytterhoeven)
- Don't clear screen on enable, instead send the full buffer (Thomas Zimmermann)
- Add Andy Shevchenko's Reviewed-by tag to patch #4.
- Add Andy Shevchenko's Reviewed-by tag to patch #5.
- Add Andy Shevchenko's Reviewed-by tag to patch #6.

Changes in v4:
- Rename end_offset to end_len (Thomas Zimmermann)
- Warn once if dst_pitch is not a multiple of 8 (Thomas Zimmermann)
- Drop drm_fb_gray8_to_mono_reversed() that's not used (Thomas Zimmermann)
- Allocate single buffer for both copy cma memory and gray8 (Thomas Zimmermann)
- Add Thomas Zimmermann Reviewed-by tag to patch adding XR24 -> mono helper.
- Rename vbat supply to vcc since is how's labeled in the device (Mark Brown)
- Don't make the regulator option since is always needed (Mark Brown)
- Add solomon Kconfig source and directory inclusion sorted (Andy Shevchenko)
- Use SSD130x instead of SSD130X to denote is not a model name (Andy Shevchenko)
- Check if there's a reset pin in the callee and not the caller (Andy Shevchenko)
- Define missing commands instead of using magic numbers (Andy Shevchenko)
- Use GENMASK() and FIELD_PREP() macros when possible (Andy Shevchenko)
- Avoid using ternary operators to ease code readablity (Andy Shevchenko)
- Use i++ instead of --i on some for loops (Andy Shevchenko)
- Remove redundant blank lines (Andy Shevchenko)
- Rename power_off label to out_power_off (Andy Shevchenko)
- Use dev_err_probe() even if no -EPROBE_DEFER (Andy Shevchenko)
- Don't use plural Authors if there's only one (Andy Shevchenko)
- Remove unnecessary casting (Geert Uytterhoeven)
- Remove redundant blank lines (Andy Shevchenko)
- Remove comma after of_device_id table terminator (Andy Shevchenko)
- Add Rob Herring Acked-by tag to patch adding as DT binding co-maintainer.

Changes in v3:
- Add a drm_fb_xrgb8888_to_gray8_line() helper function (Thomas Zimmermann)
- Also add a drm_fb_xrgb8888_to_mono_reversed() helper (Thomas Zimmermann)
- Split lines copy to drm_fb_gray8_to_mono_reversed_line() (Thomas Zimmermann)
- Handle case where the source buffer is not aligned to 8 (Thomas Zimmermann)
- Move driver from tiny sub-dir to drivers/gpu/drm/solomon (Sam Ravnborg)
- Split driver in a bus agnostic core and bus specific (Andy Shevchenko)
- Use regmap to access the chip registers (Andy Shevchenko)
- Remove unnecessary blank lines (Andy Shevchenko)
- Remove unneeded inline specifier in functions (Andy Shevchenko)
- Add a comment about always returning a single mode (Andy Shevchenko)
- Change write command logic to use do while loop (Andy Shevchenko)
- Use "firmware description" instead of "device tree" (Andy Shevchenko)
- Use return foo() instead of returning the return value (Andy Shevchenko)
- Don't split lines longer than 80 chars if makes less readable (Andy Shevchenko)
- Remove redundant else statements in .mode_valid callback (Andy Shevchenko)
- Rename powero{n,ff}() functions to power_o{n,ff)() (Andy Shevchenko)
- Use dev_err_probe() to prevent spam logs on probe deferral (Andy Shevchenko)
- Remove ',' after sentinel terminator in array (Andy Shevchenko)
- Fix a bug when doing partial updates (Geert Uytterhoeven)
- Add a separate driver for SSD130X chips I2C support (Andy Shevchenko)
- Adapt MAINTAINERS entry to point to the new drivers/gpu/drm/solomon directory.

Changes in v2:
- Drop patch that was adding a DRM_MODE_CONNECTOR_I2C type.
- Invert order of backlight {en,dis}able and display {on,off} (Sam Ravnborg)
- Don't clear the screen and turn on display on probe (Sam Ravnborg)
- Use backlight_get_brightness() macro to get BL brightness (Sam Ravnborg)
- Use dev managed version of devm_backlight_device_register() (Sam Ravnborg)
- Use dev_name(dev) for backlight name instead of an array (Sam Ravnborg)
- Drop the .get_brightness callback since isn't needed  (Sam Ravnborg)
- Rename driver to ssd130x since supports a display family (Thomas Zimmermann)
- Drop the TINY prefix from the Kconfig symbol (Thomas Zimmermann)
- Sort the Kconfig symbol dependencies alphabetically (Thomas Zimmermann)
- Rename struct ssd130x_array to struct ssd130x_i2c_msg (Thomas Zimmermann)
- Rename struct ssd130x_i2c_msg .type member to .cmd (Thomas Zimmermann)
- Use sizeof(*foo) instead of sizeof(struct foo) (Thomas Zimmermann)
- Use struct_size() macro to calculate sizeof(*foo) + len (Thomas Zimmermann)
- Use kcalloc() instead of kmalloc_array() + memset() (Thomas Zimmermann)
- Use shadow plane helpers virtual screen support (Thomas Zimmermann)
- Remove unused goto label in ssd1307_fb_blit_rect() (Thomas Zimmermann)
- Use drm_set_preferred_mode() inset of manually set (Thomas Zimmermann)
- Use shadow plane helpers virtual screen support (Thomas Zimmermann)
- Remove unused goto label in ssd1307_fb_blit_rect() (Thomas Zimmermann)
- Use drm_set_preferred_mode() inset of manually set (Thomas Zimmermann)
- Reorganize code in probe to make it more legible (Thomas Zimmermann)
- ssd130x_write_cmd() uses varargs to simplify I2C code (Thomas Zimmermann)
- Move regulator/pwm init logic to display pipe enable callback.
- Add Sam Ravnborg's acked-by to patch adding a MAINTAINERS entry (Sam Ravnborg)
- Add myself as co-maintainer of the ssd1370fb DT binding (Sam Ravnborg).

Javier Martinez Canillas (6):
  drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
  drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()
  drm: Add driver for Solomon SSD130x OLED displays
  drm/solomon: Add SSD130x OLED displays I2C support
  MAINTAINERS: Add entry for Solomon SSD130x OLED displays DRM driver
  dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer

 .../bindings/display/solomon,ssd1307fb.yaml   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/drm_format_helper.c           | 141 ++-
 drivers/gpu/drm/solomon/Kconfig               |  21 +
 drivers/gpu/drm/solomon/Makefile              |   2 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c         | 116 +++
 drivers/gpu/drm/solomon/ssd130x.c             | 843 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.h             |  76 ++
 include/drm/drm_format_helper.h               |   4 +
 11 files changed, 1202 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/solomon/Kconfig
 create mode 100644 drivers/gpu/drm/solomon/Makefile
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-i2c.c
 create mode 100644 drivers/gpu/drm/solomon/ssd130x.c
 create mode 100644 drivers/gpu/drm/solomon/ssd130x.h

-- 
2.34.1

