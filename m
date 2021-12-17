Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029214781A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhLQAjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231143AbhLQAia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ugd+51eNvxC0ydxh+YebU1HBCy2BdAa3vMMEqbj60C4=;
        b=c7hrqbRUqTxmS0wKsopFGYzUDtFc+7M2kb1qXNbLT/coL0g6yX4V+oBvucOvKNU45OuBGy
        /Ydmv1kg9InyGMJHvoPs+xto+HheJTw9cmxQvI3npbYONAiOecl3FZSB9AIcmCaKei+pNs
        9BF5PC39Nc+BI+NZbXz2WxbTwbVPesw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-oXZTxuzaO6eDJ5p9vQ-BwQ-1; Thu, 16 Dec 2021 19:38:28 -0500
X-MC-Unique: oXZTxuzaO6eDJ5p9vQ-BwQ-1
Received: by mail-wm1-f71.google.com with SMTP id 138-20020a1c0090000000b00338bb803204so399168wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ugd+51eNvxC0ydxh+YebU1HBCy2BdAa3vMMEqbj60C4=;
        b=57TRXJs4rhvojeQW77KvjWT71cJZCyhbCiUFKM4ZQsI4IUS+2VFWaTFgnWVF6dQ06m
         5iOrjUhS9IUdqQ1ba5ifMf01tNDBYURatx0G0eGLtAKul707D7zNPdOuX9l6gROyabtf
         ryVLFpRyr9ZcPKeHelxmhJQn2Ocewhp+isZzj8I4vZzFAOg02JITOSwyHwLtH7kPiq7O
         Jtgwl6x0vMI4s6VjWuokko8xiZ9/YezuwVlAUmruGSW/x2a+26CMHsrNEKtYl3KPAdGt
         GwHr0cUMNcxHmFEyC7exVHLkHhu8u0BJqmezjjWLGx/d5kdXWBR2w62nH5DR4wb1OsRP
         rnOg==
X-Gm-Message-State: AOAM5303e0cv8sLFIKaFDbs1VkF+jU9fIjSb/KwErvG0PnAh7cpanHlh
        H0sW0gw3AvPfAeHQfmuRFdn1nfDne1s7LqPdKV3nCt9pcaJkVlmc8c3MdpXTKPHJ2BKSFJzaGZe
        v65yAYOLcVVyS4zTVBsLRFNX6vQ43b21i6du+YS3ia+Y2GBTVlDoLLX3yX204ylwwZnu40YcVC3
        U=
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr7501446wmj.179.1639701507493;
        Thu, 16 Dec 2021 16:38:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaCwfJ1i3EmC7S5+5ejEYmoi30WtsMES0GQaL98ew1O0+BZXpFHuoy2ECOZSInnfTcE9rjGQ==
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr7501434wmj.179.1639701507277;
        Thu, 16 Dec 2021 16:38:27 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:27 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Tomi Valkeinen <tomba@kernel.org>
Subject: [PATCH v2 30/37] drm/omap: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:45 +0100
Message-Id: <20211217003752.3946210-31-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/omapdrm/omap_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 2720a58ccd90..eaf67b9e5f12 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -727,6 +727,9 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
 
 	DBG("%s", dev_name(dev));
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	/* Allocate and initialize the DRM device. */
 	ddev = drm_dev_alloc(&omap_drm_driver, dev);
 	if (IS_ERR(ddev))
-- 
2.33.1

