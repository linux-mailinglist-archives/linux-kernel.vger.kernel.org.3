Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74564A9A2B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358496AbiBDNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:43:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240545AbiBDNnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643982234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H5esco7azdiruVAyvRxpYC4oCr4WW6uFBnyTeQyuFsU=;
        b=PWPKgudlRqdc4Cf5zsJ+QBoMXbfPQiXuzTGprLVjnO1ifAKOQ1Cd6JdpZyRDvYO+HpE5Zf
        ySP3mJMZmFcB/pI/yRc/A0Ft9//8l8uDGLvJ4LorSO8+ms6l6/gRFLHkjn5mdUXGHDmUmz
        YzbP0AcEZmW3khbfZZt0Qkg/OJ4H6sU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-5SxtQbxJOcGA3Ct7rKlJEQ-1; Fri, 04 Feb 2022 08:43:54 -0500
X-MC-Unique: 5SxtQbxJOcGA3Ct7rKlJEQ-1
Received: by mail-wm1-f71.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso2399818wmb.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5esco7azdiruVAyvRxpYC4oCr4WW6uFBnyTeQyuFsU=;
        b=oPcq05wzd/vYxfFeLdDUzk1gaHHudxzadd3BgbDOuM9Z81lGEQV/iVckAvGhdlSniy
         NqwKurtx0z1mytWyLEsBdrWHH5c5TzMA2M+3MAxsc05f9K3N7eIKILqHZTaACL+Ti74m
         FOtT9LKrmvWQoFcHwHCWq2NSB/hJQzbjxFSY0KQyiAY/Nb7OyYxeiChzBPKfojhsQGcp
         HSMABqkNRHu2xQIp8TJ1OU4TC6yPNDKlzQyHgHtMZix2RFjm2eaSo5F438vR7xQRb8/6
         Z/iYJcIkMViXhO1uLaBc2Wg5t+jelctBqt6xRKjaCG3Ue91y5wJkDonSWMpSvwKjJXh9
         8YWA==
X-Gm-Message-State: AOAM533rhg0veISzUNCp6Ln8D2M32nyNr+22Gq9PQ+WVYKdkuBhi67vv
        GJnn/HHpn+eiun8wfszFlhaERb7rC0/SN35ZZGA0BPkUX09Fh9pM3LsDNjsp0XnCAXFGopH+y2W
        LfRcotyi1U2vbekXTeZta8ZGJ0gILUJdkWOlcyxAiSCSlp7OwJs0eK2hxiR2cJuRpGvvpe5uDLz
        o=
X-Received: by 2002:a5d:4703:: with SMTP id y3mr2602646wrq.277.1643982232606;
        Fri, 04 Feb 2022 05:43:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNEVPxf9D3BSc9PXf0lMOYyEHkzq9ZzRZkaw2OBYe/H95+tszrYIazMw6ofG8uiI7auodIxA==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr2602606wrq.277.1643982232280;
        Fri, 04 Feb 2022 05:43:52 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r3sm1871692wrt.102.2022.02.04.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:43:51 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
Date:   Fri,  4 Feb 2022 14:43:43 +0100
Message-Id: <20220204134347.1187749-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.

Using the DRM fb emulation, all the tests from Geert Uytterhoeven's fbtest
(https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes:

    ./fbtest -f /dev/fb1
    Using drawops cfb32 (32 bpp packed pixels)
    Available visuals:
      Monochrome
      Grayscale 256
      Truecolor 8:8:8:0
    Using visops truecolor
    Running all tests
    test001: PASSED
    test002: PASSED
    test003: PASSED
    test004: PASSED
    test005: PASSED
    test006: PASSED
    test008: PASSED
    Screen size too small for this test
    test010: PASSED
    Benchmarking... 10x10 squares: 414.41 Mpixels/s
    Benchmarking... 20x20 squares: 858.31 Mpixels/s
    Benchmarking... 50x50 squares: 1586.33 Mpixels/s
    test012: PASSED
    Benchmarking... R5 circles: 234.68 Mpixels/s
    Benchmarking... R10 circles: 498.24 Mpixels/s
    Benchmarking... R25 circles: 942.34 Mpixels/s
    test013: PASSED

This is a v2 that addresses all the issues pointed in v1, thanks a lot
to everyone that gave me feedback and reviews. I tried to not miss any
comment, but there were a lot so forgive me if something is not there.

Patch #1 adds two new helpers, drm_fb_gray8_to_mono_reversed() to convert
from grayscale to monochrome and a drm_fb_xrgb8888_to_mono_reversed() to
convert from XR24 to monochrome. The latter internally use thes former.

Patch #2 adds the driver. The name ssd130x was used instead of ssd1307fb
to denote that this driver is not only for SSD1307, but also for other
displays from the same chip family.

Patch #3 just adds a MAINTAINERS entry for the DRM driver and patch #4
adds myself as a co-maintainer of the existing Device Tree binding for
ssd1307fb, since the same is shared between the fbdev and DRM drivers.

Best regards,
Javier

Changes in v2:
- Drop patch that was adding a DRM_MODE_CONNECTOR_I2C type.
- Invert order of backlight {en,dis}able and display {on,off} (Sam Ravnborg)
- Don't clear the screen and turn on display on probe (Sam Ravnborg)
- Use backlight_get_brightness() macro to get BL brightness (Sam Ravnborg)
- Use dev managed version of devm_backlight_device_register() (Sam Ravnborg)
- Use dev_name(dev) for backlight name instead of an array (Sam Ravnborg)
- Drop the .get_brightness callback since isn't needed  (Sam Ravnborg)
- Add myself as co-maintainer of the ssd1370fb DT binding (Sam Ravnborg)
- Add Sam Ravnborg's acked-by tag to patch 3/4.
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
- Also add a drm_fb_xrgb8888_to_mono_reversed() helper (Thomas Zimmermann)
- Add a drm_fb_gray8_to_mono_reversed_line() helper (Thomas Zimmermann)

Javier Martinez Canillas (4):
  drm/format-helper: Add drm_fb_{xrgb8888,gray8}_to_mono_reversed()
  drm/tiny: Add driver for Solomon SSD130X OLED displays
  MAINTAINERS: Add entry for Solomon SSD130X OLED displays DRM driver
  dt-bindings: display: ssd1307fb: Add myself as binding co-maintainer

 .../bindings/display/solomon,ssd1307fb.yaml   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/drm_format_helper.c           |  80 ++
 drivers/gpu/drm/tiny/Kconfig                  |  12 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ssd130x.c                | 971 ++++++++++++++++++
 include/drm/drm_format_helper.h               |   7 +
 7 files changed, 1079 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/ssd130x.c

-- 
2.34.1

