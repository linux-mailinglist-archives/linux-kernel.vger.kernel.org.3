Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65F478197
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhLQAit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231220AbhLQAiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eAdAcCeoSy3NAZTLDXklszelhKuqQBcBNDx2eEIibYo=;
        b=Hmy6rHWymw2/IKbbjgpGK3bCGTJVMUZ5FTi29jotKwy9P5sVqlEHF5zCbVv5YoXpMwU9bp
        OglyRKMESANBB5Kb+ExVFeM/AbtBWXZCtmeEI3YPMszLW8Dg66I1fb2w4wFPknboSHF1Lj
        UXnb0AisBvR0yfeQDLGJZMbrtFGPdJw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-DPsCsa71PkeArP9wnUgn7g-1; Thu, 16 Dec 2021 19:38:13 -0500
X-MC-Unique: DPsCsa71PkeArP9wnUgn7g-1
Received: by mail-wr1-f72.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so145267wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAdAcCeoSy3NAZTLDXklszelhKuqQBcBNDx2eEIibYo=;
        b=vfvvMqERJvigaNGE0SbZmYYm8B9L6aWfSQ4IgWBfOv7aTBt0bzLFSgFYgDBs3GkP2a
         VFiqrH6gEqRtaCw1HVzuGZr1RA0gPODKP/c6ARdUJ51FL/4UK7wDTWxrNCUdasFIiE4T
         KbpES5U/+CVv6Lr0qsMFywMw7TM3mw34OLCxQMjopUu7h4wLiMFDfwoJKQrTudpTeAnl
         HzhU5SpdaPfvXhpcJA+Ofd/50/DzKUQ4VtgVpsRYJ+jMLELQ5SuyoYOrDLfedEHkurNS
         j8aXKJVfzkqJqcU7zCykMoRhrCXZlALjnfYlAfvi0swTqhzi/xAmtqDnpYro/xE3QM82
         nxBg==
X-Gm-Message-State: AOAM531P0eJKOdOQ4fF6XXBsBXhOEnNoz9J7TJjvSfxXUzJk7DlV+NyS
        abwCd1TMV9BjXGYv2d7BsoHdHm9oiIwWdN6KXCTew60xdRKStYQ1c2BtL/8QWM/bczGR7E/EPnV
        hlExCMw0HoFblWn6h6KBcr/fpad9mDy+jdAmmy2ZzeaN2GBcXqzop8mbmd/FifmM8U5zPXNHCAD
        Y=
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr379317wrz.79.1639701492655;
        Thu, 16 Dec 2021 16:38:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywLWSjt+RUifQYBu2U1bixIZxEL7Wi1XcY4KBKbw1G3UnPe6EtY442LWhvo4FfaT2BgUqDDQ==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr379301wrz.79.1639701492412;
        Thu, 16 Dec 2021 16:38:12 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:12 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 14/37] drm/shmobile: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:29 +0100
Message-Id: <20211217003752.3946210-15-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro calls to a DRM specific platform driver init handler that checks
whether the driver is allowed to be registered or not.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/shmobile/shmob_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
index 80078a9fd7f6..c99adb8e74ce 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
@@ -295,7 +295,7 @@ static struct platform_driver shmob_drm_platform_driver = {
 	},
 };
 
-module_platform_driver(shmob_drm_platform_driver);
+drm_module_platform_driver(shmob_drm_platform_driver);
 
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
 MODULE_DESCRIPTION("Renesas SH Mobile DRM Driver");
-- 
2.33.1

