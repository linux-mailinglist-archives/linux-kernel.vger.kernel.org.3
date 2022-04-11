Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6014FC67A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350104AbiDKVPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344812AbiDKVPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ADA528989
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649711575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOfEjGDhyNc9e2ZohfZoZhj46Tns/ai5DoWmszx5PGM=;
        b=YmvrdQc4Slg05Hihf/DbCBScyHU1E4xKAjalTQwnQ66iY6ckOg1itpjPlSYwwODwskzWy5
        a0mFL2h9PjuVXiqoHV/0seeH+ZXr69BLkh3lqq2FRu66npY4GVLR4c2wP4bVvF6Ih1m+sZ
        OgraeYYHzBl98ciFN7fd3lYd9tWUI2w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-YEFfPAwjONmJd94Gt0mvVw-1; Mon, 11 Apr 2022 17:12:54 -0400
X-MC-Unique: YEFfPAwjONmJd94Gt0mvVw-1
Received: by mail-wm1-f71.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so212907wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOfEjGDhyNc9e2ZohfZoZhj46Tns/ai5DoWmszx5PGM=;
        b=imLWPLN9FoaIBJe4yeqHwUPIylbtWjzXCyPS5V1s95xS2e8zqP8gF6bi2/IfWUP53Y
         PQ4rux1QA9BTagMP3XPEkP9TtTUWyRepOgv57vmRJYLHEWv5/37Go6OAVmgrVRQ2m4Lk
         EBLwMhMaJfjrJW/g12tzZduzZ42GBhBOZB5++HMCCKMYDkDuy81OgYMy7Ms1l6047uRy
         ky5ueyvkaNb7vT8ZnKDkmQg4eU07/HSiXt1uCY9uawiYruuSQ6QLhMoEozsrjbkMx3n4
         4pyx8m0WNBnszjliJJUndJMHiaSl8uHIu7qol/ksLkfRii5Uoa59mNS4zshfXhtMsqEa
         kklg==
X-Gm-Message-State: AOAM533Pu3U4dOIZKY87tEgMdYQpDvAXlRMgPNux71MT1xSjuW+yanco
        xA8Oa7AT0CfNJu4deOC+kMrAdp1aqvTywPfTxbqIxIFdXWj1RmxmGL5d/QMI7nL5DzaSz9fiT76
        dUz2Kn4ueZsQ95DGx1ZNMBhka78qimxJNJxdHd2GVHaN6pqvg2LKBQwnD0kGK86hjRgBSBOJgUs
        s=
X-Received: by 2002:adf:eb81:0:b0:1e3:2bf5:132 with SMTP id t1-20020adfeb81000000b001e32bf50132mr26144648wrn.246.1649711573012;
        Mon, 11 Apr 2022 14:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTCKXEjVBa6ZiAkJVgXv3Un1Fp+W8yDtHc844corf4v+tD4JqXCWEFTkdomwZsnwALRaVSUw==
X-Received: by 2002:adf:eb81:0:b0:1e3:2bf5:132 with SMTP id t1-20020adfeb81000000b001e32bf50132mr26144630wrn.246.1649711572769;
        Mon, 11 Apr 2022 14:12:52 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm28723722wrs.43.2022.04.11.14.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:12:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v2 3/5] drm/solomon: Add ssd130x new compatible strings and deprecate old ones.
Date:   Mon, 11 Apr 2022 23:12:41 +0200
Message-Id: <20220411211243.11121-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411211243.11121-1-javierm@redhat.com>
References: <20220411211243.11121-1-javierm@redhat.com>
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
---

(no changes since v1)

 drivers/gpu/drm/solomon/ssd130x-i2c.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index d099b241dd3f..87abe1fe31fc 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -87,6 +87,27 @@ static struct ssd130x_deviceinfo ssd130x_ssd1309_deviceinfo = {
 };
 
 static const struct of_device_id ssd130x_of_match[] = {
+	{
+		.compatible = "sinowealth,sh1106",
+		.data = &ssd130x_sh1106_deviceinfo,
+	},
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
 		.compatible = "sinowealth,sh1106-i2c",
 		.data = &ssd130x_sh1106_deviceinfo,
-- 
2.35.1

