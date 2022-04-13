Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44134FFB35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiDMQ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiDMQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F15A053735
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649867101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9+iMkpFEjyk1AZtVXTOzqrt48AoAHLCVKi3QKP08JqE=;
        b=cpeJe0CxiJXnW53Cs/uRHfIr1QMvgm4B7PsS3vNmRdpBbzvQyn1GazV7fu3vQYQrUeTyjJ
        lRpRx1C25/yyZAff9hvjii0fe8RpsU0NndhyfF99irXZ6uhpltIsL2LlgIJ8G0kfmSmlZj
        v+2YMsml3yz+fmy25mT3YceDI90Pmz0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451--uv6_E8LPqaTv7hyEEi-LQ-1; Wed, 13 Apr 2022 12:24:20 -0400
X-MC-Unique: -uv6_E8LPqaTv7hyEEi-LQ-1
Received: by mail-wr1-f69.google.com with SMTP id 105-20020adf82f2000000b002079aba50b9so506976wrc.18
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+iMkpFEjyk1AZtVXTOzqrt48AoAHLCVKi3QKP08JqE=;
        b=Rk0PELu4lUEoS/efSuXWUMfrWoHGqjYHFDX7ml9B190IQtNIbZ2lmYrYP9M/Wl33WT
         niuhX4ERNify6zLws6VIExTf3HkhxP/aG0thH6rR76NftperRegg5+om9WTai/2ZAtjw
         JqgwFNY3w/ozmCS2ZU+FJiDhftYuvJIkpgGyXGag+/xSZzYW2+wRScwflM5WDz6kq+tC
         WmeS7ojHqLaw4hA2Qfd5mVRoafErQpKL2Yw1nSsmUnESNHk4wJoBQ9S3vFkr8Cf8PDOF
         NDVu22oCf4zBB5lmlxol/aCdWL9rGgVD1rhmTQEvp+VPGulbp5PRcuIy5cVp859RwpVB
         zYBw==
X-Gm-Message-State: AOAM531vXZRIS+UL9TaQReXa+1QAhmXa3BOePW7yh+BMieyBAswB61Yu
        tn5YQg5nLpwdKK37Ng1kT81UbYq5612+yJe6tK0ydE4Yd7fdavBczcdzNBPqg+lncUgFH+e+wmI
        KDuCj5dPQpuUJXx8e8MiZD+kogpbhFOt3JxB3W3IHyKGS9YgcJPYkZoNTkWNKyJ0UsQhM3b3JlW
        c=
X-Received: by 2002:a05:600c:2744:b0:38e:b6f7:d548 with SMTP id 4-20020a05600c274400b0038eb6f7d548mr9395341wmw.49.1649867059270;
        Wed, 13 Apr 2022 09:24:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwqGxQDzVECdH3ZUuCtLW9dxuvadtDdmYHzpNw2mfwNWoXu5bqtIEYbN/8mZRxCF6rsLOxRQ==
X-Received: by 2002:a05:600c:2744:b0:38e:b6f7:d548 with SMTP id 4-20020a05600c274400b0038eb6f7d548mr9395298wmw.49.1649867058909;
        Wed, 13 Apr 2022 09:24:18 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm25446096wra.96.2022.04.13.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:24:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 0/5] drm/solomon: Add SSD130x OLED displays SPI support
Date:   Wed, 13 Apr 2022 18:23:53 +0200
Message-Id: <20220413162359.325021-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds a ssd130x-spi driver that provides a 4-wire SPI transport
support for SSD130x OLED controllers that can be accessed over a SPI bus.

The driver is quite similar to existing ssd130x-i2c driver that is used by
I2C controllers, but there is a difference in the protocol used by SSD130x
depending on the transport used. The details are in patch #4 description.

Patch #1 just makes the current ssd130x-i2c compatible strings in the DT
binding to be deprecated, and add new ones that don't have an "fb-i2c".

Patch #2 extends the DT binding with the properties needed to support SPI.

Patch #3 adds the new compatible strings to the OF device ID table in the
ssd130x-i2c DRM driver and deprecate the old ones.

Patch #4 moves the device info for the different SSD130x variants from
the ssd130x-i2c transport driver to the ssd130x core driver.

Finally patch #5 adds the ssd130x-spi DRM driver for the OLED controllers
that come with a 4-wire SPI interface, instead of an I2C interface.

This is a v4 that addresses the issues pointed out in v3.

Best regards,
Javier

Changes in v4:
- Add a description for the dc-gpios property for SPI (Geert Uytterhoeven)
- Export ssd13x_variants array using EXPORT_SYMBOL_NS_GPL() (Andy Shevchenko)
- Use MODULE_IMPORT_NS(DRM_SSD130X) in the ssd130x-i2c driver (Andy Shevchenko)
- Use MODULE_IMPORT_NS(DRM_SSD130X) in the ssd130x-spi driver (Andy Shevchenko)

Changes in v3:
- Drop the "sinowealth,sh1106-i2c", wasn't in a released version (Chen-Yu Tsai)
- Continue enforcing required properties for deprecated strings (Maxime Ripard)
- Add a comment to the properties required for SPI (Geert Uytterhoeven)
- Drop the "sinowealth,sh1106-i2c", wasn't in a released version (Chen-Yu Tsai)
- s/it/they in the commit description (Geert Uytterhoeven)
- Drop unnecessary blank line (Geert Uytterhoeven)
- Export variants array and use &info[ID] in device table (Andy Shevchenko)
- Drop ssd130x_spi_get_dc() helper and open code it (Geert Uytterhoeven)
- Export variants array and use &info[ID] in device table (Andy Shevchenko)
- Add Geert Uytterhoeven's Reviewed-by tag to patches.

Changes in v2:
- Drop the -i2c suffixes from the compatible strings too (Geert Uytterhoeven)
- Don't add compatible strings with an "-spi" suffix (Geert Uytterhoeven)
- Use the compatible strings that don't have "fb-i2c" (Geert Uytterhoeven).
- Drop ssd13x_variant_to_info() and just use the array index (Neil Armstrong).
- Add the same compatible strings than I2C (Geert Uytterhoeven)
- Add Mark Brown's Acked-by tag to all patches.

Javier Martinez Canillas (5):
  dt-bindings: display: ssd1307fb: Deprecate "-i2c" compatible strings
  dt-bindings: display: ssd1307fb: Extend schema for SPI controllers
  drm/solomon: Add ssd130x new compatible strings and deprecate old
    ones.
  drm/solomon: Move device info from ssd130x-i2c to the core driver
  drm/solomon: Add SSD130x OLED displays SPI support

 .../bindings/display/solomon,ssd1307fb.yaml   |  86 +++++++--
 drivers/gpu/drm/solomon/Kconfig               |   9 +
 drivers/gpu/drm/solomon/Makefile              |   1 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |  64 +++----
 drivers/gpu/drm/solomon/ssd130x-spi.c         | 178 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c             |  35 +++-
 drivers/gpu/drm/solomon/ssd130x.h             |  14 ++
 7 files changed, 330 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-spi.c

-- 
2.35.1

