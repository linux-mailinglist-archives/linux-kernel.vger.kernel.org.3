Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B26507C22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358072AbiDSVv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbiDSVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23BC33FDA5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650404916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRH7/XsoiL6rwdT/9IqjyebTEGbdFQMOqcD3x5JmGak=;
        b=LkNua0P5ijUdj9CfvFVZtEDMMoPqKQ9SEZRQyvcW3AyyVrCNfzC19eURRGnzvG3I6kimYd
        vbf7J+AKW8mHknOkm1Qsj9Hz2TF/1EtJ6KXDdYPjseT0m+j2CLyQT0Z5iKWR9bAGGFPTXc
        zTXUJ8ZIFNbm0plsotvrAjhl4u8JsF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-njbaI5_IN82BCqtnuA7rRQ-1; Tue, 19 Apr 2022 17:48:35 -0400
X-MC-Unique: njbaI5_IN82BCqtnuA7rRQ-1
Received: by mail-wm1-f70.google.com with SMTP id b12-20020a05600c4e0c00b003914432b970so8274wmq.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRH7/XsoiL6rwdT/9IqjyebTEGbdFQMOqcD3x5JmGak=;
        b=ytbr/07W0hPlOvkIoci8hLIyLCC065g/feUmnmuRrGYRoKjLsz28fRwg1FGt4N0Cyk
         K9PenOIpAQl0HQrLwTznGMmbI8DQDc+V3vlsfJIqZyAptNFgr3mEcD/ramvtCon9COzO
         RrCvX5YIsrZbJ4zIZRm8gxGxKL3faQFXO0ZONEDSnaHaUKRCrb7buTo0WA22LsU30DKd
         1XLT1FbE2o18NwjvmcQ1hS09dVn+dWXrLisiMEuVPOzfj/DqO2KBnpTTTSUOP2KmR6/w
         IOZcxGqRMn7UptqF/phLTTUpnGT0/EHzMHXYNYeIJL7wviQ5jx4sgg+gTvI8bGQJicE+
         11bA==
X-Gm-Message-State: AOAM530Ha4/WfnQx+iskYZhkH18selsEaUiXwDlIEAMEV0tx0W1pZsWs
        tARra5csG6KN056QpUt19edmK3qhfwlp+9k4NeKuKn1InYMZAw++H2zVo4OYYW8sO+aF/cdQOg/
        qS6OloypuxWYGZACoDofK4XKxhMA1qrSKauv/Y67oa5kCLoG3xrbmwo3vTPQsztlRAf9fRFdkEY
        Y=
X-Received: by 2002:a5d:50ce:0:b0:207:bb5e:ad27 with SMTP id f14-20020a5d50ce000000b00207bb5ead27mr13329530wrt.84.1650404913978;
        Tue, 19 Apr 2022 14:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGiUWXSsU4DetoBt3ut0OT5Db3AG0bTsAxOWQgbdm53BhlvdW/DOLJi54rlv1isl8O0rnW9Q==
X-Received: by 2002:a5d:50ce:0:b0:207:bb5e:ad27 with SMTP id f14-20020a5d50ce000000b00207bb5ead27mr13329512wrt.84.1650404913690;
        Tue, 19 Apr 2022 14:48:33 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b00207a8cde900sm13333699wrv.19.2022.04.19.14.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:48:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v5 3/5] drm/solomon: Add ssd130x new compatible strings and deprecate old ones.
Date:   Tue, 19 Apr 2022 23:48:21 +0200
Message-Id: <20220419214824.335075-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419214824.335075-1-javierm@redhat.com>
References: <20220419214824.335075-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

