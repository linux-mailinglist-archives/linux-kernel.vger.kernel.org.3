Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C254FE5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357618AbiDLQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357318AbiDLQaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4A855D5F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649780874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mo5J49WlO6IQDZ+qlm/WdbORrfFgaHGgkwawEPzuzxE=;
        b=FGW/tSP91WZhMTmZBM39rSA0BFvvq4f3WsWaZTYQ1om9jQzY+l5XX9Eb6S+WsIuZ2jrPw7
        Ul1kpz42XYnLZZOYtXu+IEqDUWpjGwQLuCwdIKxN2HfP71cUlFL05Q+27NVib9FBHvBn6X
        SEEU9MAaw017VSjRD/1eC4A0Ojao9W4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-RghSxd3GMcCATcLNtZm_kw-1; Tue, 12 Apr 2022 12:27:52 -0400
X-MC-Unique: RghSxd3GMcCATcLNtZm_kw-1
Received: by mail-wr1-f70.google.com with SMTP id f2-20020a056000036200b00207a14a1f96so1705531wrf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mo5J49WlO6IQDZ+qlm/WdbORrfFgaHGgkwawEPzuzxE=;
        b=LUIJ2S+oAUcrHReTmwK8aVrhqruLKJhHwg1tXKR0qWEtJLLMsEKaqZZRM5ftonvYm5
         y5ArhNzcLFKJmGTUb4oXmVh489HKHYis1x2ttmOWrT4RVdJ1MwrjysSFdENI48hiMnfq
         YB8+n+/eROC2XI5i2fYLW+qYcbaUIV8+HK0m2eEkrJJ4AIj6dMkXDHn/LsQslmLnd4J5
         oGg5AK1RvJoFAnT1vr2W2GPDCceFYUWDVj5IZ7BbG3JCbwV3pp4tKTJcB1fos3DFHPuk
         zdgzL/dB46i9YJWS/l5kR4M+sEEC4y/0K7T1/h7goN4B0fJ8/EBCxOnLvZx0FjRWmn1X
         s9BA==
X-Gm-Message-State: AOAM530M970PUV3dBtgq8V1ButOZ7MRbSQOtB2JNePPJdSs6OOzT35ZN
        9SIONQ1g5OD1OVWWp9jvBZNQgYGKnJb1Jn/Fi1vTgL7WYmhrK7xGNXx2/+WwgrwMK6LLSV2P3gK
        15T3nh1lLfVYpfYTekRO1fNCxCC98fFyCyIwIRdGawwSK4CiwPxEAYa/RpYxtcCB9X0w5iIoHsh
        Q=
X-Received: by 2002:a05:600c:4f15:b0:38c:b729:4838 with SMTP id l21-20020a05600c4f1500b0038cb7294838mr4905867wmq.132.1649780871564;
        Tue, 12 Apr 2022 09:27:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxFwQJtMdTDB/u8o8piRC+wUS5qF5b+LUpWOn//PSBN3fYXg6a2kN8KjW30Vy8Ka6FUFNzvg==
X-Received: by 2002:a05:600c:4f15:b0:38c:b729:4838 with SMTP id l21-20020a05600c4f1500b0038cb7294838mr4905834wmq.132.1649780871306;
        Tue, 12 Apr 2022 09:27:51 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00207a49fa6a1sm7700358wrq.81.2022.04.12.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 09:27:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v3 3/5] drm/solomon: Add ssd130x new compatible strings and deprecate old ones.
Date:   Tue, 12 Apr 2022 18:27:27 +0200
Message-Id: <20220412162729.184783-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412162729.184783-1-javierm@redhat.com>
References: <20220412162729.184783-1-javierm@redhat.com>
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

The current compatible strings for SSD130x I2C controllers contain an "fb"
and "-i2c" suffixes. These have been deprecated and more correct ones were
added, that don't encode a subsystem or bus used to interface the devices.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

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

