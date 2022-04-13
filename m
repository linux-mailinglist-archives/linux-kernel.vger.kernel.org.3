Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853574FFB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiDMQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiDMQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF864E87
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649867066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRH7/XsoiL6rwdT/9IqjyebTEGbdFQMOqcD3x5JmGak=;
        b=AHg3WV8TPilpa6zJV6pVXwkPiPvCSrg9srF5Kpdo6nT7AKfQz6BCg2Tm0BXnx3zik0oL6S
        KEm2Y02xucwbtJUQ6o7+0y6j5pKT5kCaGqQhCnu65x6uE/Gecgv42ACOr8+1BguwNSjZSU
        vgYZiy70duEvmhVT0HEMwX+sQ505C3Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-O57zgDETPCKWEBlHzGr8ZQ-1; Wed, 13 Apr 2022 12:24:24 -0400
X-MC-Unique: O57zgDETPCKWEBlHzGr8ZQ-1
Received: by mail-wm1-f70.google.com with SMTP id r132-20020a1c448a000000b0038eaca2b8c9so676115wma.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRH7/XsoiL6rwdT/9IqjyebTEGbdFQMOqcD3x5JmGak=;
        b=flerCP+QoBU0R6tam/B7Ua7KbZpGyp0XTXgcFXVdDCpdqsXwMbolqHygsOHHtuL2zp
         MT7eBWEKjNVo7CCQRNVGcI2uEyETigkGnLdudKVySWtBDKj94W7aVR47CCCrutKi4fSR
         zzMT2+E8To0j47G2Btzcv2mH4qMCHAGodkVP01Jf9Otn4ANirlZdH7GA+Oi/0qFOtrv9
         eF5VsuB9M+gH90XWqhmORoMPFy6H4j3ogJW8Z+UXQYY92+qWLNaf65Bge2+wyLn+k5eG
         sN59vAL3QG+BIEiFM93FP2BQ6VNoVy6ssWUtDrRCrxathWErUEzOH0a46Qcdz/cZD8Ly
         9fAg==
X-Gm-Message-State: AOAM533bSsGNGAUYn6ebtP63Bpu20SebFo1BB5naXIZLcwBrvaTBTVzx
        iZlZIDvXDpogEX661DUBn541WgF7NsUnPebpCv5q1AtcJtxwTKyHa4luz+QRac9w2k0VIK7k13P
        my56U7YPdNKoIGPIIB/nMNBFpfHr6nF75vJzVvOPsZ48Y/1q3t/L5AIrHccZ9mg05h+Gx+KbkPD
        8=
X-Received: by 2002:a05:600c:5010:b0:38e:d68c:3ee9 with SMTP id n16-20020a05600c501000b0038ed68c3ee9mr3410419wmr.158.1649867063211;
        Wed, 13 Apr 2022 09:24:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4kxMf3Cb6KxS8vVPDjgV7H72PDtBNHtSPxx4KJwLTukyhZMKu3eWr6UzlQdZRlAZKV6UnsA==
X-Received: by 2002:a05:600c:5010:b0:38e:d68c:3ee9 with SMTP id n16-20020a05600c501000b0038ed68c3ee9mr3410388wmr.158.1649867062911;
        Wed, 13 Apr 2022 09:24:22 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm25446096wra.96.2022.04.13.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:24:22 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v4 3/5] drm/solomon: Add ssd130x new compatible strings and deprecate old ones.
Date:   Wed, 13 Apr 2022 18:23:56 +0200
Message-Id: <20220413162359.325021-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413162359.325021-1-javierm@redhat.com>
References: <20220413162359.325021-1-javierm@redhat.com>
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

The current compatible strings for SSD130x I2C controllers contain an "fb"
and "-i2c" suffixes. These have been deprecated and more correct ones were
added, that don't encode a subsystem or bus used to interface the devices.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

(no changes since v3)

Changes in v3:
- Drop the "sinowealth,sh1106-i2c", wasn't in a released version (Chen-Yu Tsai)

Changes in v2:
- Use the compatible strings that don't have "fb-i2c" (Geert Uytterhoeven).

 drivers/gpu/drm/solomon/ssd130x-i2c.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index d099b241dd3f..45867ef2bc8b 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -88,9 +88,26 @@ static struct ssd130x_deviceinfo ssd130x_ssd1309_deviceinfo = {
 
 static const struct of_device_id ssd130x_of_match[] = {
 	{
-		.compatible = "sinowealth,sh1106-i2c",
+		.compatible = "sinowealth,sh1106",
 		.data = &ssd130x_sh1106_deviceinfo,
 	},
+	{
+		.compatible = "solomon,ssd1305",
+		.data = &ssd130x_ssd1305_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1306",
+		.data = &ssd130x_ssd1306_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1307",
+		.data = &ssd130x_ssd1307_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1309",
+		.data = &ssd130x_ssd1309_deviceinfo,
+	},
+	/* Deprecated but kept for backward compatibility */
 	{
 		.compatible = "solomon,ssd1305fb-i2c",
 		.data = &ssd130x_ssd1305_deviceinfo,
-- 
2.35.1

