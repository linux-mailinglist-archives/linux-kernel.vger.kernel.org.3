Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC754B217A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345116AbiBKJTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:19:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348442AbiBKJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06A35102A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pbRMjrOYXoV30kR7B4cKGNrPjuiwGwQkUxB9k4BkJUQ=;
        b=JQ2rRqO203NR4XIYoWi6bLLA9sWrbz5uCAZ+EPyZVRqwcIC+yYjKx5IhYParcsK2lXVMy8
        KyW1slVGRYXOlY3oPJaHSSWqmPymi4gIcDiMHViGIFUHHvs4vTWnbggO+gxQ9OJZV7ZrnZ
        6glId1z8yUB5PwmXnI0tzBOZhnDKZEk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-23Y8WZHDOGGAzpuMy5WN4w-1; Fri, 11 Feb 2022 04:19:37 -0500
X-MC-Unique: 23Y8WZHDOGGAzpuMy5WN4w-1
Received: by mail-wm1-f70.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so2264086wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbRMjrOYXoV30kR7B4cKGNrPjuiwGwQkUxB9k4BkJUQ=;
        b=1UZqiTG4ZxQ3ByeAcYN7glMRwlJKrR5WY1LtEAJ2MRPmziaVAVVdfVYXM0k/XLOCri
         syMZk3zdir0M79meaLC1XJgQYqj1pNQYfT0vhCZZVBrhsuWx4b+7kKLnOkddHXc4pT+k
         LYGoF+vcppwamhcKBmHNqgc1QZQ/c8syP003NAcMn3kvtL5Oo7XkuoPEVloI+dmaMLBv
         9m3SKEPEJ/KL4eF9xBPSnnemOj3bXuGGqPvm4yndE4O995mDIOLN+rItiC8F6bmOpqvn
         uv5MIGdAv9HRLQeyeLIPDE25ZNtL5EemXK51KQd3994G8k4Vq4Ro49T9qDIRKBah3xh5
         BNpg==
X-Gm-Message-State: AOAM5333vR1gkAb7DgMg2C3PZCWqN0vjTnZJNG9/+x4nvlTOrzE6cT9P
        iPPj9Y3Vrq246jsNi0NYhZotBq8N2nfMI09G3t/3Vq/MmBaTMxM5BPWlYSxyA6LhrpEHvWcV54E
        fNi5FgK90mvBQONfsYsvqr+biGTN/10vePag9/BzEdQTWmnQJ3OOl6kA6lWI2VT3lVFp/utSS2b
        s=
X-Received: by 2002:a05:600c:4f02:: with SMTP id l2mr648799wmq.115.1644571175608;
        Fri, 11 Feb 2022 01:19:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr0lW6hjWm3pVsSHTDsgb5mYafMoI0gJsI8Msc0Qhi547hDX6MT3H3LfS8grRnbdz9dc86hw==
X-Received: by 2002:a05:600c:4f02:: with SMTP id l2mr648757wmq.115.1644571175124;
        Fri, 11 Feb 2022 01:19:35 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r17sm3805578wmq.33.2022.02.11.01.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:19:34 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
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
Subject: [PATCH v4 0/6] drm: Add driver for Solomon SSD130x OLED displays
Date:   Fri, 11 Feb 2022 10:19:21 +0100
Message-Id: <20220211091927.2988283-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

This is a v4 that addresses the issues pointed in v3. Thanks a lot to all
reviewers that gave me feedback and comments.

I didn't include the patch that adds the SPI support this time, because it
will require changes in the existing Device Tree binding. And I wanted to
avoid that bikesheeding for now, to focus on the core and I2C parts.

Once this series land, I'll post patches for the SPI support. But the WIP
patch posted in v3 should still apply cleanly on top of this v4:

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
 drivers/gpu/drm/drm_format_helper.c           | 138 ++-
 drivers/gpu/drm/solomon/Kconfig               |  21 +
 drivers/gpu/drm/solomon/Makefile              |   2 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c         | 116 +++
 drivers/gpu/drm/solomon/ssd130x.c             | 852 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.h             |  76 ++
 include/drm/drm_format_helper.h               |   4 +
 11 files changed, 1208 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/solomon/Kconfig
 create mode 100644 drivers/gpu/drm/solomon/Makefile
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-i2c.c
 create mode 100644 drivers/gpu/drm/solomon/ssd130x.c
 create mode 100644 drivers/gpu/drm/solomon/ssd130x.h

-- 
2.34.1

