Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652AB4A4FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378225AbiAaUMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:12:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378192AbiAaUMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643659962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMwMeY9OoKGLOudbA8SLCKYnBWFNuNdP5Adg3VOxotk=;
        b=C2kSIxH8y5lgl4o0876Ei7Su2bSCseSFbaRPSJqAWXnfOW6uhOq2kXfP+6cIQEzqxjEChl
        SNzUzwzdpW87b1lJJ+s5590QO3axGPfHuvfURjjEj9Hji6lxNXW19inQcI0P5MCAEI1Aao
        uUwnL2MMLI46ltbQKa/pWjoPMtnwGNY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-r1ievEFtOuCriTPRovFI9w-1; Mon, 31 Jan 2022 15:12:41 -0500
X-MC-Unique: r1ievEFtOuCriTPRovFI9w-1
Received: by mail-wm1-f70.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso78303wmb.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMwMeY9OoKGLOudbA8SLCKYnBWFNuNdP5Adg3VOxotk=;
        b=bHXY7PByIIZFzggxxl683WLRdMbAtcfI7MhY94VRjycwK+XpWBVJ7BLPEdNvbYEEW/
         ywLL/C+fGrz6decgXHbYHXH3FYmVDs9GqIagduq9+EZLBUVW5HvUPl+lpNClX0gZK2Jr
         W5lGJYOQzE2HsVno5p1LkZ5LxgimOf//cfg8XbHqvdy+YxiTyB1qTwsFGt/87M8gVxPS
         3xerwEJ3BdBGaPBFbBArXcWy9hhza2Yt4z/ziywAXD0pXHOVbpV3LItFqILy8jWBB7OA
         dguQms4FmXEKuXDabRL8dzggVpStYQrb5lwnIP93xbFOlLpmwDn57G53IveB91JFD4l4
         MQ4Q==
X-Gm-Message-State: AOAM532nY9B2+hWalOJ+n7JDDjXNT0+SBE2zLTLKGY/IqSt8wyjtV441
        YT/nxZanDL753EUJCy/3ygHsPc/V9yHvC6Umu9a6Ie2JwhmFdpFyC0KTdIJsmpzwgsxI8n1jTHW
        sIOcRye9ev+4uu2CuTeqHgkl4rSOvjsoyrAkNQRRsr5D1D+b2n9AZ+YxDCIAcH9Q4P022DUSGsg
        Q=
X-Received: by 2002:adf:fdc9:: with SMTP id i9mr9272914wrs.142.1643659959747;
        Mon, 31 Jan 2022 12:12:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLFCAwqF+47z3/CXQ1yVaeyTKTvJhusKYHuUgXJhivec2+bdBcovNbm/WasPrsQVybnZaQ+A==
X-Received: by 2002:adf:fdc9:: with SMTP id i9mr9272887wrs.142.1643659959514;
        Mon, 31 Jan 2022 12:12:39 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i9sm15124660wry.32.2022.01.31.12.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:12:39 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/4] drm: Add I2C connector type
Date:   Mon, 31 Jan 2022 21:12:21 +0100
Message-Id: <20220131201225.2324984-2-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131201225.2324984-1-javierm@redhat.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't a connector type for display controllers accesed through I2C,
most drivers use DRM_MODE_CONNECTOR_Unknown or DRM_MODE_CONNECTOR_VIRTUAL.

Add an I2C connector type to match the actual connector.

As Noralf Trønnes mentions in commit fc06bf1d76d6 ("drm: Add SPI connector
type"), user-space should be able to cope with a connector type that does
not yet understand.

Tested with `modetest -M ssd1307 -c` and shows the connector as unknown-1.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_connector.c | 1 +
 include/uapi/drm/drm_mode.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index a50c82bc2b2f..975a7525a508 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -105,6 +105,7 @@ static struct drm_conn_prop_enum_list drm_connector_enum_list[] = {
 	{ DRM_MODE_CONNECTOR_WRITEBACK, "Writeback" },
 	{ DRM_MODE_CONNECTOR_SPI, "SPI" },
 	{ DRM_MODE_CONNECTOR_USB, "USB" },
+	{ DRM_MODE_CONNECTOR_I2C, "I2C" },
 };
 
 void drm_connector_ida_init(void)
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index e1e351682872..d6d6288242db 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -421,6 +421,7 @@ enum drm_mode_subconnector {
 #define DRM_MODE_CONNECTOR_WRITEBACK	18
 #define DRM_MODE_CONNECTOR_SPI		19
 #define DRM_MODE_CONNECTOR_USB		20
+#define DRM_MODE_CONNECTOR_I2C		21
 
 /**
  * struct drm_mode_get_connector - Get connector metadata.
-- 
2.34.1

