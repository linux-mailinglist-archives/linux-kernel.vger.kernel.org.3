Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D62538479
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiE3PDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243267AbiE3PBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86F368BD13
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653919395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rC0eN7t3z6ODekS0ZqenuKqbnlhAc460c9vZw1utlEU=;
        b=cjZ6+drduH9XX7+jizuJkyEqK4Vj/j1Tx0ewnmye8IzN3Fe7aoCXg5w25wVa0JuYKyPjJb
        l4N/MaWVTopG6k7JlRahr71ReavRpJ5NtHiZNhZpdJfFoEuI3BVi92XV4FIPT/taoeNMj4
        /O3thEJhJWfb6xDJQ9Y8KZB9Qkk2DS4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-tMocUGKMOs6sZHZxpG6dZQ-1; Mon, 30 May 2022 10:03:14 -0400
X-MC-Unique: tMocUGKMOs6sZHZxpG6dZQ-1
Received: by mail-wr1-f72.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so1630195wrg.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rC0eN7t3z6ODekS0ZqenuKqbnlhAc460c9vZw1utlEU=;
        b=qYra6eD8QtnYlBiMUnaYqzLEVQvtrRTEu+A8wZHUT+P3Ho5nuvvrAsz3dkDiy9kPq7
         Lda6Q+GTopTmTFkdMiFxWouRgOcgsom2wsZHHVV37xPBfSA7lJ+Q5JXO2lBB4IItB9YX
         NWUCJKK50hVq3htwKfp3EZlw0OvEobXNzK1VzrcGK+jJe2V8yKuOFrBPAjo0qr6FBs2r
         fw9zsmDHzVrTiqsvAaIpwruhVlv8r+7tWpn9lSE0bgUNaa+Mg/9t7nib1XAgpss9w9pD
         4W6LXfXUh88JId3HXcwpAwCv+DiNTV4eGMBrfJGQjb8voPxqS1jy7kLIJXeD32fyy/3j
         P4fg==
X-Gm-Message-State: AOAM530cTIcT1I7Ep3TFPB8OQCjtSUlrBTH/hrxWKzpRYLX+FptaWwrV
        4rrspS5BK5Ms+kK1Enrgjq9ACdXy9s1Ne5DsFxC9B4RYlI4kzra3n1/JwBwydWlXG3t+fLy8LlO
        aNjBPsAEQENxRJvFglNLWGKCVYukyZNh1SwEJdUgEsGVtbJGe5FQe+rsbgXrcYNFesetbg0+FhT
        I=
X-Received: by 2002:a05:6000:15c1:b0:20f:c1d3:8a89 with SMTP id y1-20020a05600015c100b0020fc1d38a89mr40174127wry.287.1653919392648;
        Mon, 30 May 2022 07:03:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygJwMi3I5Al7M7Nn7GvI6xqupt54m+kg76DqqOBO1hzb2Izc3i81He1uttnWN3YXnrWy+hgw==
X-Received: by 2002:a05:6000:15c1:b0:20f:c1d3:8a89 with SMTP id y1-20020a05600015c100b0020fc1d38a89mr40174093wry.287.1653919392345;
        Mon, 30 May 2022 07:03:12 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ay5-20020a05600c1e0500b0039765a7add4sm10539109wmb.29.2022.05.30.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 07:03:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Only define a SPI device ID table when built as a module
Date:   Mon, 30 May 2022 16:02:46 +0200
Message-Id: <20220530140246.742469-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot reports a compile warning due the ssd130x_spi_table
variable being defined but not used. This happen when ssd130x-spi driver
is built-in instead of being built as a module, i.e:

  CC      drivers/gpu/drm/solomon/ssd130x-spi.o
  AR      drivers/base/firmware_loader/built-in.a
  AR      drivers/base/built-in.a
  CC      kernel/trace/trace.o
drivers/gpu/drm/solomon/ssd130x-spi.c:155:35: warning: ‘ssd130x_spi_table’ defined but not used [-Wunused-const-variable=]
  155 | static const struct spi_device_id ssd130x_spi_table[] = {
      |                                   ^~~~~~~~~~~~~~~~~

The driver shouldn't need a SPI device ID table and only have an OF device
ID table, but the former is needed to workaround an issue in the SPI core.
This always reports a MODALIAS of the form "spi:<device>" even for devices
registered through Device Trees.

But the table is only needed when the driver built as a module to populate
the .ko alias info. It's not needed when the driver is built-in the kernel.

Fixes: 74373977d2ca ("drm/solomon: Add SSD130x OLED displays SPI support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x-spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index 43722adab1f8..07802907e39a 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -143,6 +143,7 @@ static const struct of_device_id ssd130x_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ssd130x_of_match);
 
+#if IS_MODULE(CONFIG_DRM_SSD130X_SPI)
 /*
  * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
  * if the device was registered via OF. This means that the module will not be
@@ -160,6 +161,7 @@ static const struct spi_device_id ssd130x_spi_table[] = {
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);
+#endif
 
 static struct spi_driver ssd130x_spi_driver = {
 	.driver = {
-- 
2.36.1

