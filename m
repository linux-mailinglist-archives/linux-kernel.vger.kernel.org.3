Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33A647CE42
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbhLVI27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243356AbhLVI2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3N2KnVsfLEPnGk4GM83SnUnjHj7nisH0v3Qa0ml2DP8=;
        b=hyJy47EKur+p9ZsyS0oNsNJMFzf+otvJHzaR+brSXATmZVpOctEBEcNyvz9+PK/RTLfwcj
        cVivPwNjvMXzmYGZb0KBrTDeSWz4N1T34nfyZARYMKnch+8hRuZWC1Zztp8X/ir5j9YLHM
        0drndDd/PEXIHQieBkxW06E0jr0d4GA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-ldYxJOr3NkmuFDqQpn_M4g-1; Wed, 22 Dec 2021 03:28:49 -0500
X-MC-Unique: ldYxJOr3NkmuFDqQpn_M4g-1
Received: by mail-wr1-f69.google.com with SMTP id t30-20020adfa2de000000b001a24004e1fbso522070wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3N2KnVsfLEPnGk4GM83SnUnjHj7nisH0v3Qa0ml2DP8=;
        b=Mn6GVqfPJp/SIBcs/z4ikJYa9SN07IJXmgIUH2fetVIZuhNmeief5jzrsfA6PiHi/e
         ibPXMDB9u9HiythF/tfFxGVdL6oH+0mCOtDvLYKCJMHTGLivS26Ir4HDbZN+CRwC41fA
         P/V/FJVeFE6xD1Sacef4HcEWFt4saelolyGnXZ82JljsXwOB+pE2XSpOuJIi7O/jsH03
         24srjux0Qh63EUS6cwKLpT9PgxAxKUcqTtV7Te1uZvXGv1EFMAzBFST93kDIoX9PSFhJ
         aOh69LTXRVcq3Qm6iwm7ySGb7FToTr7eNYxwFescBV+g21qziU3jbGPsAddnVFlJ9847
         dkJA==
X-Gm-Message-State: AOAM532QRuHVdrJtFGFTQSCiDWaugHaF1OcG8rchM1luTpmfvRFq6sEZ
        jeoq/0ehChD5fbbt07SLahgA8AGzg8SoJD5uzKIN+++A55W7h3EDzA4LF5GX+QzSoOE7rT9IKkc
        ++PDUMMRS78+AEzwSEi5NBXSaVXCKVuPnPavFxsvz5nie9Z0S4VH37P4UDb2/fmpyrgf5oqjWdY
        o=
X-Received: by 2002:a05:600c:2119:: with SMTP id u25mr97763wml.93.1640161728617;
        Wed, 22 Dec 2021 00:28:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyclg3C9m1lfpdHzwWRKr1jtDWrqzNKG6YD/sARAOTo22q6Tb8b2/EF4W39n16Lc2X5xTgEsA==
X-Received: by 2002:a05:600c:2119:: with SMTP id u25mr97738wml.93.1640161728427;
        Wed, 22 Dec 2021 00:28:48 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:48 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 07/10] drm/imx/dcss: Replace module initialization with DRM helpers
Date:   Wed, 22 Dec 2021 09:28:28 +0100
Message-Id: <20211222082831.196562-8-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
References: <20211222082831.196562-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace module_platform_driver() with drm_module_platform_driver(). The
DRM macro respects drm_firmware_drivers_only() and fails if the flag has
been set.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---

(no changes since v1)

 drivers/gpu/drm/imx/dcss/dcss-drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-drv.c b/drivers/gpu/drm/imx/dcss/dcss-drv.c
index 8dc2f85c514b..24147ee7080e 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-drv.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-drv.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <drm/drm_module.h>
 #include <drm/drm_of.h>
 
 #include "dcss-dev.h"
@@ -131,7 +132,7 @@ static struct platform_driver dcss_platform_driver = {
 	},
 };
 
-module_platform_driver(dcss_platform_driver);
+drm_module_platform_driver(dcss_platform_driver);
 
 MODULE_AUTHOR("Laurentiu Palcu <laurentiu.palcu@nxp.com>");
 MODULE_DESCRIPTION("DCSS driver for i.MX8MQ");
-- 
2.33.1

