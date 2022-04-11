Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB94FC687
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiDKVPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiDKVPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0A6C28989
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649711571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n0gtWVG0aimnuoPQwNXoXZOG0mpWKStMnE3++TkqLKY=;
        b=ERHTTA/9vs5a8UrmVCQMG+cGbGNIlvH1yfEvV7E4PNR/QSF2ve/7K3K/rxUbBAfrY+v26/
        9njcoGv5EQ4O69mxr7Xy6j7aBc44WdZ7pKpbJiqBaIud18NbcCe8pDznLVqVIK5slZ3RZv
        ykPVhpBoJTR6CbLHy+wNXerhA2EwqWk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-3X-P5kq1McCQbp3HHFoJGA-1; Mon, 11 Apr 2022 17:12:50 -0400
X-MC-Unique: 3X-P5kq1McCQbp3HHFoJGA-1
Received: by mail-wm1-f71.google.com with SMTP id l19-20020a05600c1d1300b0038e736f98faso5037488wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0gtWVG0aimnuoPQwNXoXZOG0mpWKStMnE3++TkqLKY=;
        b=bYVFPDpyWHlb1sWR5G9UKkueo/Ixre8nK8tdS5nxIMUed+9YoSr5Of9iuRKGXdNz93
         iMb2MzIbeXcxoywcIMz6DdtbMl8HXcFpOlkeVDbRdz8UMglSnICcoOvtSCdTddzjp+YM
         DIa2agxDzqdi/PKTs2IH+4fKnfiUSaFNLxj53GY8tU82wDK8OfB6R2MMOVmhCEAK61Wo
         8cYjBi+dDzmTME2cgRPyTDwDarOxWT2g/q2rHAw1z1MSabaKGxF117Xw0+YZ6+tLGGDH
         /UAcT8x3IZwf3gADfp1iNwEtZv42nMuWe5X2Qg8eE+Ry2O7P6Yj0aLDJzwCDaL8uNftd
         pBhw==
X-Gm-Message-State: AOAM531tsDrbjVEw7Q2iiyfoEePN/h5BMuaGJkrDXNkJFrbDI+sJuB97
        wekyMBSqhYdxjpjUdC4WfmslOH5nvwEXzayueXS6+i37Pv0nhFblvq4tp0CWc0ElhrSP/9nblpj
        VP0xM3lBD2vobU0V0O/74ckMVZXTYZ4a6MWg8MFMpP3FQ4xcot45W+lJt77q71Yxt7uJpfh7V7O
        o=
X-Received: by 2002:a05:600c:198f:b0:38c:a9e9:754a with SMTP id t15-20020a05600c198f00b0038ca9e9754amr985284wmq.146.1649711569499;
        Mon, 11 Apr 2022 14:12:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIG64xz0G/zDMtKH809CxNshjqiDFUCpZN0F0DuF+gDgN8/smhV2a82KJnAYzO7uRz0AUIkA==
X-Received: by 2002:a05:600c:198f:b0:38c:a9e9:754a with SMTP id t15-20020a05600c198f00b0038ca9e9754amr985248wmq.146.1649711569194;
        Mon, 11 Apr 2022 14:12:49 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm28723722wrs.43.2022.04.11.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:12:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] drm/solomon: Add SSD130x OLED displays SPI support
Date:   Mon, 11 Apr 2022 23:12:38 +0200
Message-Id: <20220411211243.11121-1-javierm@redhat.com>
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
support for SSD130x OLED controllers that can be accessed through a SPI.

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

This is a v2 that addresses the issues pointed out in v1.

Best regards,
Javier

Changes in v2:
- Drop the -i2c suffixes from the compatible strings too (Geert Uytterhoeven).
- Don't add compatible strings with an "-spi" suffix (Geert Uytterhoeven).
- Drop ssd13x_variant_to_info() and just use the array index (Neil Armstrong).
- Add Mark Brown's Acked-by tag to all patches.

Javier Martinez Canillas (5):
  dt-bindings: display: ssd1307fb: Deprecate "-i2c" compatible strings
  dt-bindings: display: ssd1307fb: Extend schema for SPI controllers
  drm/solomon: Add ssd130x new compatible strings and deprecate old
    ones.
  drm/solomon: Move device info from ssd130x-i2c to the core driver
  drm/solomon: Add SSD130x OLED displays SPI support

 .../bindings/display/solomon,ssd1307fb.yaml   |  74 +++++--
 drivers/gpu/drm/solomon/Kconfig               |   9 +
 drivers/gpu/drm/solomon/Makefile              |   1 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |  64 +++---
 drivers/gpu/drm/solomon/ssd130x-spi.c         | 184 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c             |  45 ++++-
 drivers/gpu/drm/solomon/ssd130x.h             |  12 ++
 7 files changed, 332 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-spi.c

-- 
2.35.1

