Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6A5144A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350242AbiD2IrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355976AbiD2Iqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D265DC403B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTpQrVgtEus10W4LvCQhMZMxqMItEWJawYg8qRPBPlQ=;
        b=Te+alpM0gDDWP04g9Eb+CclTzn8Qbies7bjm78ugfy+9EVOiai0SdAavUPE/PtehsELW8c
        wsatFJq0u6xWzKtqjLdY61j6fqYhfs1D2CqZplxckogqI0rENeJU2mJjYudT+M+u/4S0c5
        YjvgJheOFMuoMGgSeNVQBdjQ2RwKp2M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-66_2LLDPPY628LoeRbkSxw-1; Fri, 29 Apr 2022 04:43:20 -0400
X-MC-Unique: 66_2LLDPPY628LoeRbkSxw-1
Received: by mail-wr1-f70.google.com with SMTP id n17-20020adfc611000000b0020a7e397ccaso2787792wrg.23
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTpQrVgtEus10W4LvCQhMZMxqMItEWJawYg8qRPBPlQ=;
        b=4FzMg2s6pksXfTI7pKLc7+TG9vUBg0HIeT+bjSoSKcfD/6cWOIdPmUXKNYCX2mV5HQ
         XPz5MgdW3+iZKJ17SD5bsteGLBr2RNbLK2aJH2L/9TLrcBUKIoeosrwtkOiPJcCqLOVk
         fltSFpOoMrRDHTFxg0i30AQ1bnlctaVKCaYB3aXtBeMGL5XHpYvr9aY8SosRGfFawWoC
         NoikXH8GnhWSHIQuyXzYiWUShFv2PUHc4v3xIxdb1W3CiOh4a9PibxFmQ5BqAtmDK56H
         VAIQveiTzf7gptMu3TL6lWqqn7RP7SubMx8w59aPadM1YBCxxCTXslzKlICXX3UC7JK5
         WQ9Q==
X-Gm-Message-State: AOAM531k8ghzn9Mdx6Ysae/6Ip/pVG48wFqNycdiQ52tBcbDao2W+zz4
        O57i7W1CrZIfQM/fpGB0IHcLuoz99J52hu5YpJqa6qBCC0njz0wjR+a4IZ5q65iWLsBce1Ue07o
        c50zU4xLIWGe5lxtxu/k0dOCL7idr2fQI8ZNdlWkBMmBgBc6nl9MJoPN6DDqsPVjO2xOFVi5ij/
        M=
X-Received: by 2002:a05:6000:c:b0:20a:df2e:2c38 with SMTP id h12-20020a056000000c00b0020adf2e2c38mr17608235wrx.481.1651221799589;
        Fri, 29 Apr 2022 01:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWrC4ya/rMI6HLQk7JSawGUTh/QcZs606nyrC5F9U2cmzfWUxtJf62tVPglLeePqo2GOHhKw==
X-Received: by 2002:a05:6000:c:b0:20a:df2e:2c38 with SMTP id h12-20020a056000000c00b0020adf2e2c38mr17608204wrx.481.1651221799301;
        Fri, 29 Apr 2022 01:43:19 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [RFC PATCH v4 09/11] drm: Fix race between sysfb and DRM devices registration
Date:   Fri, 29 Apr 2022 10:42:51 +0200
Message-Id: <20220429084253.1085911-10-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform devices registered by sysfb match with firmware-based DRM or
fbdev drivers, that are used to have early graphics using a framebuffer
provided by the system firmware.

DRM or fbdev drivers later are probed and remove all conflicting framebuffers,
leading to these platform devices for generic drivers to be unregistered.

But the current solution has a race, since the sysfb_init() function could
be called after a DRM driver is probed and requested to unregister devices
for drivers with conflicting framebuffes.

To prevent this, disable any future sysfb platform device registration by
calling sysfb_disable(), if either a framebuffer device or a DRM device is
registered. Since in that case a display will already be present.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v3)

Changes in v3:
- Call sysfb_disable() when a DRM device is registered rather than
  when conflicting framebuffers are removed (Thomas Zimmermann).

 drivers/gpu/drm/drm_drv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..e577c42861c6 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -34,6 +34,7 @@
 #include <linux/pseudo_fs.h>
 #include <linux/slab.h>
 #include <linux/srcu.h>
+#include <linux/sysfb.h>
 
 #include <drm/drm_cache.h>
 #include <drm/drm_client.h>
@@ -913,6 +914,17 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 out_unlock:
 	if (drm_dev_needs_global_mutex(dev))
 		mutex_unlock(&drm_global_mutex);
+
+	/*
+	 * If a driver registers a DRM device, then it can be assumed that a
+	 * display will be present and there is no need for a generic driver
+	 * using the firmware setup system framebuffer.
+	 *
+	 * Disable sysfb and prevent registering simple framebuffer devices.
+	 */
+	if (!drm_core_check_feature(dev, DRIVER_FIRMWARE))
+		sysfb_disable();
+
 	return ret;
 }
 EXPORT_SYMBOL(drm_dev_register);
-- 
2.35.1

