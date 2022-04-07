Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03F34F8868
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiDGUaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDGUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C287488BC0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649362441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3ubm6YFhYAC6YInMSbu5d7oAdD3benT+KYPcFzTrtvY=;
        b=JqudqxJCNnY7aPxqUFDgPfRyySE3yMd95yEZh9DmBNFmnaB6TZUrDMVVWb19klfehlf89i
        0kFALsc5WMVYKu1b7V/3+rImbkUwKGzwVSy0jDDAGaJYzyghA2v0oUoLmDKXrj76WhPcmD
        hfOKUoDC1igZgfkFDblw80IyqhzwkTs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-Ycnj_EHIN-SmdLBoem_wfg-1; Thu, 07 Apr 2022 16:02:59 -0400
X-MC-Unique: Ycnj_EHIN-SmdLBoem_wfg-1
Received: by mail-wr1-f70.google.com with SMTP id 32-20020adf82a3000000b00207905f5b3eso212873wrc.15
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ubm6YFhYAC6YInMSbu5d7oAdD3benT+KYPcFzTrtvY=;
        b=Iq3+PRYtNK8IvWuu6dNko8mi0tLYX1zTwwk5Qqvu9k3G+W72mji4GKMMDPr7LlAdwy
         RUCok0y9VqFiHqICV73xb8T49RP+uqbTQ5WMA8JVU8JexfKr6s2Pdb+Z8lVgm2peGfH1
         RZMsKMW1hn0GSITaCn06DxzXTIw3d1ayvpWfV4gOHWGWxL6QPdFmm0SKo0xFG6EX+xSi
         BYiUauvtX1dP8npHhInws2a8b5u8jEo0d36nqC4skuIT04VjZnunPhMp9uW3rofB/9rV
         XAf2VDNAIoIOIA3p5twqGt1zGsNfidKdoPMc/ZlM5r/vcnR7CVWUKxIGnp2J0xHri676
         oayg==
X-Gm-Message-State: AOAM532lrSmOSJ9iwZBqZDSID8/Kk88XkZAkigkZfT2OnaD62mpK3ffj
        0wuE34ljBJ5XZLzVwQDHln389EnLMSsCcJ+ERSYkEOL/Bh2GgvA7wyUjeEorRBHVcPqbTB3J7WG
        Ne0CRL1DW949P0ghySgdvmbolI/nNPNjioaSa/HT44N+0Ow6omn9b4ZXUxX3QyG/vq9h760UaE+
        E=
X-Received: by 2002:a05:600c:3c8c:b0:38e:4c59:6852 with SMTP id bg12-20020a05600c3c8c00b0038e4c596852mr13621703wmb.194.1649361778448;
        Thu, 07 Apr 2022 13:02:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysWMrIHnSxlQAqg6ZsL9nRoRIt6fyQo/+UTGcvFjw2Wl1wRNhCzVnqbJMc1z8BK0S49w+MJg==
X-Received: by 2002:a05:600c:3c8c:b0:38e:4c59:6852 with SMTP id bg12-20020a05600c3c8c00b0038e4c596852mr13621668wmb.194.1649361778123;
        Thu, 07 Apr 2022 13:02:58 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b002078f74ccd2sm1048712wry.36.2022.04.07.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:02:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, devicetree@vger.kernel.org
Subject: [PATCH 0/5] drm/solomon: Add SSD130x OLED displays SPI support
Date:   Thu,  7 Apr 2022 22:01:59 +0200
Message-Id: <20220407200205.28838-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
binding to be deprecated, and add new ones that don't have an -fb suffix.

Patch #2 extends the DT binding with the compatible string and properties
needed to support the ssd130x-spi devices.

Patch #3 adds the new compatible strings to the OF device ID table in the
ssd130x-i2c DRM driver.

Patch #4 moves the device info for the different SSD130x variants from
the ssd130x-i2c transport driver to the ssd130x core driver.

Finally patch #5 adds the ssd130x-spi DRM driver for the OLED controllers
that come with a 4-wire SPI interface, instead of an I2C interface.

Best regards,
Javier


Javier Martinez Canillas (5):
  dt-bindings: display: ssd1307fb: Deprecate fbdev compatible strings
  dt-bindings: display: ssd1307fb: Extend schema for SPI controllers
  drm/solomon: Add ssd130x-i2c compatible strings without an -fb suffix
  drm/solomon: Move device info from ssd130x-i2c to the core driver
  drm/solomon: Add SSD130x OLED displays SPI support

 .../bindings/display/solomon,ssd1307fb.yaml   | 117 ++++++++---
 drivers/gpu/drm/solomon/Kconfig               |   9 +
 drivers/gpu/drm/solomon/Makefile              |   1 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |  60 +++---
 drivers/gpu/drm/solomon/ssd130x-spi.c         | 184 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c             |  60 +++++-
 drivers/gpu/drm/solomon/ssd130x.h             |  13 ++
 7 files changed, 376 insertions(+), 68 deletions(-)
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-spi.c

-- 
2.35.1

