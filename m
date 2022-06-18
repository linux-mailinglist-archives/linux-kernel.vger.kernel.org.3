Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E217F55066A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiFRRpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiFRRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D5F95F67
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655574246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5hi5Y2P4AaoHxeRi+XOi4q2sXUxnWpwxAI+NUv1HLlI=;
        b=GyvMUHt3trhtkM4cvPNphUNcuEBUkUTK1svLM2eEySN5rGgW/zkenkbIJ1W0Ygl1Oynb7L
        JgYQ+VvLt4aWIVU9B7fMwrV+tR2D4NaFkjD9qt+zD0GJaHAj8qhF5YjwkyWVbnbJVtKGhq
        +6B9sE0c2IK25YhLKnjNSzszaqii+yQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-POcSIzpPMqylfzqhnjONIw-1; Sat, 18 Jun 2022 13:44:05 -0400
X-MC-Unique: POcSIzpPMqylfzqhnjONIw-1
Received: by mail-wm1-f72.google.com with SMTP id 206-20020a1c02d7000000b0039c9a08c52bso2204126wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 10:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hi5Y2P4AaoHxeRi+XOi4q2sXUxnWpwxAI+NUv1HLlI=;
        b=z9V9fWCJXKDgsv1VSc80CvUDCaSKXDRVmM3MS19bZxQWqJsmZkhNab9Gz0iPosJCFR
         zEKQMcxWR5plZOfoZWkH4VlROxicft9sJ1/Sq33PnOkYdVez4Bna3To/cO2DQXvFw89B
         wp1d87GF4HzdEK5BkRYFC4GZ5E1tfbOwc5W4qfBTXYnYB23/kMt8YXdkZL894oIlGGkS
         XLJxhn6xp0ZtFV0HOhl/Pu+w0XToBgVnoE/+5nTVkufiSrM7IyFM5QhKlhFvwu0MX31J
         aR4fv+hi0u5swm5/ztR/Zai4L9d3sgaGFzodLuwuCxn7TgnaZ8JlFykB4zduHhBdCm9n
         i6Mg==
X-Gm-Message-State: AJIora8weDtnDMhZv8wfuJofUWwRFysm1kdcvIZWL12FUpqwK3T3Fo+X
        +geh5uHdEvU71XNWiSvoUxemHAg41QtDjvRZi+JZ5SBqn8QgxocUw4HR5xSFnCKyLoQXtJE0V3J
        VQX3mJG4IQP3TJO+C+1dCfvlsM9SHztliYVuv0tgKYHMyDywriO6KaFsgQIUymRVDzwXoK5NWhk
        s=
X-Received: by 2002:a05:6000:1d97:b0:210:25d6:e125 with SMTP id bk23-20020a0560001d9700b0021025d6e125mr14547066wrb.464.1655574243906;
        Sat, 18 Jun 2022 10:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uY9IYbz2YfUSz6WUjcqKlLdvkCI/TbZjixWRpmwqANowJNbfNJDqbKBvqI4F3Ge4YezLzLxQ==
X-Received: by 2002:a05:6000:1d97:b0:210:25d6:e125 with SMTP id bk23-20020a0560001d9700b0021025d6e125mr14547040wrb.464.1655574243532;
        Sat, 18 Jun 2022 10:44:03 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r184-20020a1c2bc1000000b0039749b01ea7sm11790681wmr.32.2022.06.18.10.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 10:44:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Use new regmap bulk write support to drop custom bus
Date:   Sat, 18 Jun 2022 19:43:38 +0200
Message-Id: <20220618174338.2253021-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data writes for the ssd130x 4-wire SPI protocol need special handling, due
the Data/Command control (D/C) pin having to be toggled prior to the write.

The regmap API only allowed drivers to provide .reg_{read,write} callbacks
to do per register read/write, but didn't provide a way for drivers to do
the same for bulk read/writes.

For this reason, a custom regmap bus was used by the driver just to define
a bulk write callback that implements the D/C pin toggling. But the regmap
API has been extended to support defining bulk read/write handlers, so the
custom regmap bus is not needed anymore and could just be dropped.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

This patch depends on the following regmap fixes:

https://lkml.org/lkml/2022/6/16/198


 drivers/gpu/drm/solomon/ssd130x-spi.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index 43722adab1f8..72f066ccd2d9 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -18,11 +18,6 @@ struct ssd130x_spi_transport {
 	struct gpio_desc *dc;
 };
 
-static const struct regmap_config ssd130x_spi_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 /*
  * The regmap bus .write handler, it is just a wrapper around spi_write()
  * but toggling the Data/Command control pin (D/C#). Since for 4-wire SPI
@@ -56,17 +51,12 @@ static int ssd130x_spi_read(void *context, const void *reg, size_t reg_size,
 	return -EOPNOTSUPP;
 }
 
-/*
- * A custom bus is needed due the special write that toggles a D/C# pin,
- * another option could be to just have a .reg_write() callback but that
- * will prevent to do data writes in bulk.
- *
- * Once the regmap API is extended to support defining a bulk write handler
- * in the struct regmap_config, this can be simplified and the bus dropped.
- */
-static struct regmap_bus regmap_ssd130x_spi_bus = {
+static const struct regmap_config ssd130x_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
 	.write = ssd130x_spi_write,
 	.read = ssd130x_spi_read,
+	.can_multi_write = true,
 };
 
 static int ssd130x_spi_probe(struct spi_device *spi)
@@ -90,8 +80,7 @@ static int ssd130x_spi_probe(struct spi_device *spi)
 	t->spi = spi;
 	t->dc = dc;
 
-	regmap = devm_regmap_init(dev, &regmap_ssd130x_spi_bus, t,
-				  &ssd130x_spi_regmap_config);
+	regmap = devm_regmap_init(dev, NULL, t, &ssd130x_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.36.1

