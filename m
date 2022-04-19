Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7F507C21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358079AbiDSVv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357619AbiDSVvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C00DD3FD8F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650404916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iUv2NTJ7gTBOf8GrxhIvtx/g2bgEnpVi/9pLqch7VAA=;
        b=VAc087nz99Y925uSR4rvXGTDEnKwQUXWBKgGwHpdnJDD522VTqz6CpLKJYxHiKQHXeNAEZ
        aVbwZcDEvejfl+hGhDiPnMpYs5Mp1wLwVkt32F6ufh3XLq2XqX5aM6lF6TPkDAKaqQJA7V
        iV9MPRxqGvSH2+FrFDWQOnknxvUG4Js=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-_pnMZ80vNhavdSGMjCHVGw-1; Tue, 19 Apr 2022 17:48:32 -0400
X-MC-Unique: _pnMZ80vNhavdSGMjCHVGw-1
Received: by mail-wr1-f70.google.com with SMTP id s13-20020adfa28d000000b00205e049cff2so2127291wra.17
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iUv2NTJ7gTBOf8GrxhIvtx/g2bgEnpVi/9pLqch7VAA=;
        b=A1vWIQ1O5YuxB+dQTYaiGoUKctjFP/RBqFGXCEEYEtzUa1C8zwEvPQD9nUmxZmsutt
         K7Juh7VWQqTDp2MQI2xPPHd9AW0TMrgIDnwyroLCqKk/nMbV3cBtavMyhKXupBv5D/hM
         xvJbMo70a+iYkSvE+gwTIgTdj8wr3/zkGvjPYEakltKQV2Spc2qPYFhgGH0rfuqo4cf8
         gZHozFo78d/alblWvl+vS++T/mRrM7JmgutvQmDHkdJuAungRlvHixxLwhSbNwI5Zbq/
         SGPGjmnZYbR4LDnFAi9LxlwKiJo0fa4XzFqfSe4hnblH/2mIRpHH+2aEMgcW7DE5U4yP
         FeZA==
X-Gm-Message-State: AOAM530T7xRrHGwMCQGoTAPHy6sloY/YspKOcGtQ5VaCBSZeYLCwWNUc
        ugFDF91RVeCvs8SFnWFfsHZChQxlqXdgZWzhW9zDxlu5+usBmd4/gG6nQ+h0lEY3pTPcb7QuaIV
        iNmimFiBs4XR9WbgWgNriGTlZl3wMJ/3HDzFHC5FTO2zHy/NzeS1gKuQLQ3qKHdKlrjA6WFXwX/
        E=
X-Received: by 2002:a05:6000:156e:b0:20a:9665:ca9d with SMTP id 14-20020a056000156e00b0020a9665ca9dmr9055420wrz.172.1650404910492;
        Tue, 19 Apr 2022 14:48:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzTCCp+DmpxwaENdM0BASbGg3Ig10/xv8vgQpwOiaUtPU5pBeDOUif9F+KNHopbNeaYjdzPw==
X-Received: by 2002:a05:6000:156e:b0:20a:9665:ca9d with SMTP id 14-20020a056000156e00b0020a9665ca9dmr9055390wrz.172.1650404910137;
        Tue, 19 Apr 2022 14:48:30 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b00207a8cde900sm13333699wrv.19.2022.04.19.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:48:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, devicetree@vger.kernel.org
Subject: [PATCH v5 0/5] drm/solomon: Add SSD130x OLED displays SPI support
Date:   Tue, 19 Apr 2022 23:48:18 +0200
Message-Id: <20220419214824.335075-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

This is a v5 that addresses the issues pointed out in v4.

Best regards,
Javier

Changes in v5:
- Remove unnecessary blank line added by mistake in v4 (Andy Shevchenko).
- Remove cast by just using u8 *reg instead of void *data (Geert Uytterhoeven).
- Add Geert Uytterhoeven's Reviewed-by tag to patch 5/5.

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
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |  63 +++----
 drivers/gpu/drm/solomon/ssd130x-spi.c         | 178 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c             |  35 +++-
 drivers/gpu/drm/solomon/ssd130x.h             |  14 ++
 7 files changed, 329 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-spi.c

-- 
2.35.1

