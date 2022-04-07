Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF984F889B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiDGURo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiDGURf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EAC32E2A09
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649362404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x93PCRKwviqgnFctHZ564pBYePcJr5i4ENQzOlQlhIE=;
        b=bre6y9kmkFesh5K5hR2IzZ3OOzoGncQDyOzOdPQ4VqMtyrh7AX192jN5wckMeiwLfhAmzr
        NqG6cT3CEOuDZFWEMcTxWgvEgnAyXiH9oyk4oYalfHLDImeuSUiHIpwwnQ0YdNcMosOQvx
        adtliUxkhUMVTZJHnzDtxIB1NcQRhJc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-eplbEYb3P6GFdWgK-Cdisw-1; Thu, 07 Apr 2022 16:03:03 -0400
X-MC-Unique: eplbEYb3P6GFdWgK-Cdisw-1
Received: by mail-wm1-f69.google.com with SMTP id j6-20020a05600c1c0600b0038e7d07ebcaso1769728wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x93PCRKwviqgnFctHZ564pBYePcJr5i4ENQzOlQlhIE=;
        b=KGUcx7Cbp0sXrzqhHi17dzdfcVe43UAVDGcx2hDdkMWk8nODmUuUmaTPqb2VDVrIqY
         c+bbz+TLXpe2LeSbpXKAOpc/b2Jgjt6OyhH5W5Sy2PfDonsaRHvDnVdIs9RO96OGw0Kt
         FKHay5hRI1AtmfSFDM0eCymZqTxHSfRhNLkqCRVBZOq4WYAV9WE/w+t7MBFO2rJI8RFh
         bhdhfcZoRLUfbFT92DfCY8E0zKiOUEyACKXOTWSycNh0N9U9ro/s65iZJyDXf0rAtubN
         riKRvc43prULU3sPXETqnAT1LVlQ75eIbR1rWr0txFIZwzVPYevY/fjf2e7t87oI8s0+
         7oWg==
X-Gm-Message-State: AOAM531gE11rA6BX45GvGkmCJYFYk3lJd3L3pv1hlUDvkXoNThB9jHR1
        7xN+S6oxlSnkBnEbZALaBbDJCAijfXWIHYJ/DjWZqkqXVi+JuEWpS1sXvDBYzTwgXacPn++xoN9
        bHr4aISWDszXGikHNKuS2sGybKuQsxa7MWaihS4oC55elhiW+J/cMIEjkxDurDBonN83+NWhgD3
        Q=
X-Received: by 2002:a7b:cb46:0:b0:37b:dd79:e1c4 with SMTP id v6-20020a7bcb46000000b0037bdd79e1c4mr13618124wmj.39.1649361782271;
        Thu, 07 Apr 2022 13:03:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzddimnsAmF0jPIGaa3uK+oB4t/RezvERAcP6vteLSMkHFZ1dvuNZDvJ3lkXyuq9wVKp07AKg==
X-Received: by 2002:a7b:cb46:0:b0:37b:dd79:e1c4 with SMTP id v6-20020a7bcb46000000b0037bdd79e1c4mr13618110wmj.39.1649361782029;
        Thu, 07 Apr 2022 13:03:02 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b002078f74ccd2sm1048712wry.36.2022.04.07.13.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:03:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH 3/5] drm/solomon: Add ssd130x-i2c compatible strings without an -fb suffix
Date:   Thu,  7 Apr 2022 22:02:02 +0200
Message-Id: <20220407200205.28838-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407200205.28838-1-javierm@redhat.com>
References: <20220407200205.28838-1-javierm@redhat.com>
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

The current compatible strings for SSD130x I2C controllers contain an -fb
suffix, this seems to indicate that are for a fbdev driver. But the DT is
supposed to describe the hardware and not Linux implementation details.

Let's deprecate those compatible strings and add new ones that don't have
the -fb suffix. The old entries are still kept for backward compatibility.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x-i2c.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index d099b241dd3f..a469679548f8 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -91,6 +91,23 @@ static const struct of_device_id ssd130x_of_match[] = {
 		.compatible = "sinowealth,sh1106-i2c",
 		.data = &ssd130x_sh1106_deviceinfo,
 	},
+	{
+		.compatible = "solomon,ssd1305-i2c",
+		.data = &ssd130x_ssd1305_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1306-i2c",
+		.data = &ssd130x_ssd1306_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1307-i2c",
+		.data = &ssd130x_ssd1307_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1309-i2c",
+		.data = &ssd130x_ssd1309_deviceinfo,
+	},
+	/* Deprecated but remain for backward compatibility */
 	{
 		.compatible = "solomon,ssd1305fb-i2c",
 		.data = &ssd130x_ssd1305_deviceinfo,
-- 
2.35.1

