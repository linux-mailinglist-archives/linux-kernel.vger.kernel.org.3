Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60448475018
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbhLOBC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238926AbhLOBBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlYV5jujXPmrTef8VMng0tahS4lUJ8NEfoE2L3lNMRc=;
        b=SE76yGpHRy+/L5u2l9/1aQsdmfkYRWn7lK9RyA6WhmQUnHOLiEsu7yMIOLYoBhcqyabgaq
        darQDCf20zYA159gtvH6dtvdeodCSD3A5GTgaw5gE6DXsA2xMT9RxQO+Zy1Q/m2hFMSr7O
        schzl69qYhpKM0thMBKihyFJ6hJGveI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-c8PxlPNwMGOWLh1_AbBoSw-1; Tue, 14 Dec 2021 20:01:20 -0500
X-MC-Unique: c8PxlPNwMGOWLh1_AbBoSw-1
Received: by mail-wr1-f72.google.com with SMTP id d3-20020adfa343000000b0018ed6dd4629so5378945wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlYV5jujXPmrTef8VMng0tahS4lUJ8NEfoE2L3lNMRc=;
        b=58LI/6lROXsMQt+18ybzT45sdApoEPOgXQUD8Bb80lhye735yk9ZgnmVMGtAWdkjr+
         eh269Rycw/CPFH0HQMnZKMELO6Wix/JBc9+3PMMPMsv8NHYMm1XkIRwya8W8mYsqc2FJ
         svD/wpRoXTWJs47irXC42dR34Gz7rXktTVIE9eby0nKBYecV/mTPfC8jhdI/VLrD3F44
         oemJfi619VBWznCNKpK4LwJGr3GVoEMbpcVgja4gpDDXWnFEq3TA/RWMXOmHQ9jfT75L
         6XXmd5zUhaZMYHwHJ7dWMS6WQzledv3QQl6422x6vwRIItppH8pjGsz8OX61GsEV+GJa
         5ScQ==
X-Gm-Message-State: AOAM532rm8Lwf6w1nEprrKxpY2meUb4QKKpUiSEYPKuPfzv/LUT7FL43
        AJTxb6cKC/9HKX9iFcSJDOO4o06V7ktxh1Rl9y7KnkxROaoaRwt1Wi32lIyBocdmKAwrs9DN41i
        mvGN02fI8R9XVQ/QcboYvJLOG6qciT+L71RFS2kFsh5sn7tVrzSYN8XwSe82QcLOnHJUHHZsan2
        A=
X-Received: by 2002:a05:600c:4ca3:: with SMTP id g35mr4290wmp.54.1639530079249;
        Tue, 14 Dec 2021 17:01:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwbrE2P7uLd5gohyPv60Cvh2x5AK1c5Fb/dSoeBTKa1erFm5CYUANmoo1pNd8dydJLjKaDOg==
X-Received: by 2002:a05:600c:4ca3:: with SMTP id g35mr4272wmp.54.1639530078984;
        Tue, 14 Dec 2021 17:01:18 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:18 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>
Subject: [PATCH 33/60] drm/rockchip: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:41 +0100
Message-Id: <20211215010008.2545520-34-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215010008.2545520-1-javierm@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the systewm system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index bec207de4544..ac190e2b1f7a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -457,6 +457,9 @@ static int __init rockchip_drm_init(void)
 {
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	num_rockchip_sub_drivers = 0;
 	ADD_ROCKCHIP_SUB_DRIVER(vop_platform_driver, CONFIG_DRM_ROCKCHIP);
 	ADD_ROCKCHIP_SUB_DRIVER(rockchip_lvds_driver,
-- 
2.33.1

