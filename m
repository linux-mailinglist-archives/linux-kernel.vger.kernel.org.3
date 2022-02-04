Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F84A9A39
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358987AbiBDNoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358644AbiBDNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643982240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1G5ufPFCDyg3xao5Sw4eo8sGKGFiB4HM9GwjLkAtDY=;
        b=gPpUDvlRfrqKEwgs1pocLtwg1DFuRlSHvvcXYhMW5wChfUNU7906x3YC8L/7d3NzqmFHur
        lGNzsW2Q8RPyZKfGOJv2PgNUH0ItY3nNwc3dnf06lMPwusKnpw3L8RZ6pvhAaUdc8cYUKv
        UbA2nr/eQWIMBhf9h3D6sjVdvafgCTA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-xKkMh6DLMsqFASJMZAxWCg-1; Fri, 04 Feb 2022 08:43:59 -0500
X-MC-Unique: xKkMh6DLMsqFASJMZAxWCg-1
Received: by mail-wm1-f70.google.com with SMTP id l16-20020a7bcf10000000b0034ffdd81e7aso2404229wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1G5ufPFCDyg3xao5Sw4eo8sGKGFiB4HM9GwjLkAtDY=;
        b=T9yrsspd8mUknpIT/wHS1Q/FKiohfFZTVvs59icgedLORMXwoKUF7PowUAg5bpS9lm
         J1mb8As6VPvHRyyxiBmgxrcyOPuSvCStK521D7Y20DPKCdmAeawa+hBn/A9OIo35yaz2
         D+Ey8ks2RfKLJhtNosiCTJi+bKrziRnCcGdvqCpUlMWz7YG3jLI6YYFgI+Sxs8jeO5xs
         qQXMijoS/nKJJclBERqsRYdXY40spoD2NpriQ2yflpSNoS+VQstmv9lmCtpnbu59BOym
         f1+jlAW+FqNx+N6LTzipBd74Pt9LPxp7hRF7/F3gf9m0gnqJ8gFfUvrT+geFVY7DpkZd
         arOQ==
X-Gm-Message-State: AOAM530p9i/tAwQDRiTFHzxg24sUufx2gSKsf1g0PP10BKzDBt4idoMf
        rCtwHd08VcdS0ffU8hDVSFNynoAwRn4UrGt2h4E/Bl7QipuKE8vuTr0naH/dJmu5R/wi8e+H6Ey
        JSA28V1GCTLQWHi8gpobeTMoD9NttnfWiQ6EwJiOXVp0ifY2sYe4SgIol/slZIv5lwnJTRavnht
        8=
X-Received: by 2002:adf:e54e:: with SMTP id z14mr2605829wrm.490.1643982238375;
        Fri, 04 Feb 2022 05:43:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+QSl2du9O4I/8+CrVvIgvDAYN5ik3pP+2eWE6GqWbaie7alsXVW5weyc4o2n22Zxaig+5Rg==
X-Received: by 2002:adf:e54e:: with SMTP id z14mr2605798wrm.490.1643982238073;
        Fri, 04 Feb 2022 05:43:58 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r3sm1871692wrt.102.2022.02.04.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:43:57 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 3/4] MAINTAINERS: Add entry for Solomon SSD130X OLED displays DRM driver
Date:   Fri,  4 Feb 2022 14:43:46 +0100
Message-Id: <20220204134347.1187749-4-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204134347.1187749-1-javierm@redhat.com>
References: <20220204134347.1187749-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make sure that tools like the get_maintainer.pl script will suggest
to Cc me if patches are posted for this driver.

Also include the Device Tree binding for the old ssd1307fb fbdev driver
since the new DRM driver was made compatible with the existing binding.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

(no changes since v1)

 MAINTAINERS                         | 7 +++++++
 drivers/gpu/drm/drm_format_helper.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d03ad8da1f36..9061488a4113 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6102,6 +6102,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/repaper.txt
 F:	drivers/gpu/drm/tiny/repaper.c
 
+DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
+M:	Javier Martinez Canillas <javierm@redhat.com>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+F:	drivers/gpu/drm/tiny/ssd130x.c
+
 DRM DRIVER FOR QEMU'S CIRRUS DEVICE
 M:	Dave Airlie <airlied@redhat.com>
 M:	Gerd Hoffmann <kraxel@redhat.com>
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index cdce4b7c25d9..c3c1372fb771 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -661,6 +661,6 @@ void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const v
 		dst_pitch = drm_rect_width(clip);
 
 	drm_fb_xrgb8888_to_gray8(dst, dst_pitch, src, fb, clip);
-	drm_fb_gray8_to_mono_reversed(dst, dst_pitch, dst, fb, clip);
+	drm_fb_gray8_to_mono_reversed(dst, dst_pitch, dst, clip);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono_reversed);
-- 
2.34.1

