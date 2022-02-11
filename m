Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2BD4B27FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350920AbiBKOeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:34:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350922AbiBKOeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:34:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38ED4381
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644590053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fz2Kno8PPLHlny0kFyGFu1CzpGMejC9s0k6wv2123LE=;
        b=NsDYQVf/Y4m5uXNyYgUm3QZhNwRRpRsOjg2r/p8kLhiLiSqnUyVPJVohOG4qHsdAce91bP
        Onn1DEFwjiCJxxY3L9aVmp6+PFAalmZ57WEcSU2U7kovUXuHPoSo3iYvlVWJpB96jgr8Vq
        YagrX0eiObub9H0CP09/H/fL1C2sLZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-AycPJlE0NeO4ngGawY8JwA-1; Fri, 11 Feb 2022 09:34:12 -0500
X-MC-Unique: AycPJlE0NeO4ngGawY8JwA-1
Received: by mail-wr1-f69.google.com with SMTP id v17-20020adf8b51000000b001e336bf3be7so3953339wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fz2Kno8PPLHlny0kFyGFu1CzpGMejC9s0k6wv2123LE=;
        b=fIDjz/J7oeM7ShyCPovRRltWvtXI8N5zv3FE5212bzYJDYBP0HClag1DKkd+O+tGyi
         RqgxzYVhiw71tb9SXOupU/acNNnCA6dw7jmo8Gi7cTJRKt5igBoH2AVcSyHkC/3dzAm/
         9wZjhhl3Q55CnJhGesvPyVPXnIFe12cqmwnBLy2hQigqDcgS7JUFn2TIDOpKCxk6jN7D
         3kSPvexeUGN+dR6NoWh5JwVzyJiXZrfpkUyKaBy6T6Sjk0dslUuf3BuKLmF1SpsUGFRm
         RtgM6OQ/+rdel5Ww9adG4N1mZ1VL9KQ0p9YFfX5alrlpPTCvSuZQaowwHUc6fNqjpRnq
         CMdg==
X-Gm-Message-State: AOAM531WSAnMISWxxBUVayTKxbSv0ppdX446/rpR7r2WK/RK6/Tl3quh
        YFk2qkNcx047r43oXm3NFLh8Hfz0sLYMtRuOYAbd5pQMg6MQOyR3YaCrVEhp0EH/wuX3UU1ELOh
        j1cjeTo6To1mMszYPsHyPtdJlA3t7NUJaYSMHYgCWRV3ja1fLZB5Gl2FTbiSpjSpEc59afn0ZQf
        Y=
X-Received: by 2002:adf:decd:: with SMTP id i13mr1616447wrn.314.1644590049881;
        Fri, 11 Feb 2022 06:34:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznBtKJaEhhYGX4nEC0I1gBzUDI6glrFk0hX33aohr/ENq8FE0yUVJyhR9x0JuIfNsT+0ZweA==
X-Received: by 2002:adf:decd:: with SMTP id i13mr1616415wrn.314.1644590049605;
        Fri, 11 Feb 2022 06:34:09 -0800 (PST)
Received: from minerva.redhat.com ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14sm24616012wry.104.2022.02.11.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:34:09 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v5 4/6] drm/solomon: Add SSD130x OLED displays I2C support
Date:   Fri, 11 Feb 2022 15:33:56 +0100
Message-Id: <20220211143358.3112958-5-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211143358.3112958-1-javierm@redhat.com>
References: <20220211143358.3112958-1-javierm@redhat.com>
MIME-Version: 1.0
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

The ssd130x driver only provides the core support for these devices but it
does not have any bus transport logic. Add a driver to interface over I2C.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v5:
- Add Andy Shevchenko's Reviewed-by tag to patch #4.

Changes in v4:
- Remove unnecessary casting (Geert Uytterhoeven)
- Remove redundant blank lines (Andy Shevchenko)
- Remove comma after of_device_id table terminator (Andy Shevchenko)

Changes in v3:
- Add a separate driver for SSD130X chips I2C support (Andy Shevchenko)

 drivers/gpu/drm/solomon/Kconfig       |   9 ++
 drivers/gpu/drm/solomon/Makefile      |   1 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c | 116 ++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-i2c.c

diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 7720a7039e8d..5861c3ab7c45 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -10,3 +10,12 @@ config DRM_SSD130X
 	  the appropriate bus transport in your chip also must be selected.
 
 	  If M is selected the module will be called ssd130x.
+
+config DRM_SSD130X_I2C
+	tristate "DRM support for Solomon SSD130x OLED displays (I2C bus)"
+	depends on DRM_SSD130X && I2C
+	select REGMAP_I2C
+	help
+	  Say Y here if the SSD130x OLED display is connected via I2C bus.
+
+	  If M is selected the module will be called ssd130x-i2c.
diff --git a/drivers/gpu/drm/solomon/Makefile b/drivers/gpu/drm/solomon/Makefile
index f685addb19fe..4bfc5acb0447 100644
--- a/drivers/gpu/drm/solomon/Makefile
+++ b/drivers/gpu/drm/solomon/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_DRM_SSD130X)	+= ssd130x.o
+obj-$(CONFIG_DRM_SSD130X_I2C)	+= ssd130x-i2c.o
diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
new file mode 100644
index 000000000000..3126aeda4ced
--- /dev/null
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DRM driver for Solomon SSD130x OLED displays (I2C bus)
+ *
+ * Copyright 2022 Red Hat Inc.
+ * Author: Javier Martinez Canillas <javierm@redhat.com>
+ *
+ * Based on drivers/video/fbdev/ssd1307fb.c
+ * Copyright 2012 Free Electrons
+ */
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include "ssd130x.h"
+
+#define DRIVER_NAME	"ssd130x-i2c"
+#define DRIVER_DESC	"DRM driver for Solomon SSD130x OLED displays (I2C)"
+
+static const struct regmap_config ssd130x_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int ssd130x_i2c_probe(struct i2c_client *client)
+{
+	struct ssd130x_device *ssd130x;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &ssd130x_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ssd130x = ssd130x_probe(&client->dev, regmap);
+	if (IS_ERR(ssd130x))
+		return PTR_ERR(ssd130x);
+
+	i2c_set_clientdata(client, ssd130x);
+
+	return 0;
+}
+
+static int ssd130x_i2c_remove(struct i2c_client *client)
+{
+	struct ssd130x_device *ssd130x = i2c_get_clientdata(client);
+
+	return ssd130x_remove(ssd130x);
+}
+
+static void ssd130x_i2c_shutdown(struct i2c_client *client)
+{
+	struct ssd130x_device *ssd130x = i2c_get_clientdata(client);
+
+	ssd130x_shutdown(ssd130x);
+}
+
+static struct ssd130x_deviceinfo ssd130x_ssd1305_deviceinfo = {
+	.default_vcomh = 0x34,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 7,
+};
+
+static struct ssd130x_deviceinfo ssd130x_ssd1306_deviceinfo = {
+	.default_vcomh = 0x20,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 8,
+	.need_chargepump = 1,
+};
+
+static struct ssd130x_deviceinfo ssd130x_ssd1307_deviceinfo = {
+	.default_vcomh = 0x20,
+	.default_dclk_div = 2,
+	.default_dclk_frq = 12,
+	.need_pwm = 1,
+};
+
+static struct ssd130x_deviceinfo ssd130x_ssd1309_deviceinfo = {
+	.default_vcomh = 0x34,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 10,
+};
+
+static const struct of_device_id ssd130x_of_match[] = {
+	{
+		.compatible = "solomon,ssd1305fb-i2c",
+		.data = &ssd130x_ssd1305_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1306fb-i2c",
+		.data = &ssd130x_ssd1306_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1307fb-i2c",
+		.data = &ssd130x_ssd1307_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1309fb-i2c",
+		.data = &ssd130x_ssd1309_deviceinfo,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ssd130x_of_match);
+
+static struct i2c_driver ssd130x_i2c_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = ssd130x_of_match,
+	},
+	.probe_new = ssd130x_i2c_probe,
+	.remove = ssd130x_i2c_remove,
+	.shutdown = ssd130x_i2c_shutdown,
+};
+module_i2c_driver(ssd130x_i2c_driver);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Javier Martinez Canillas <javierm@redhat.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

