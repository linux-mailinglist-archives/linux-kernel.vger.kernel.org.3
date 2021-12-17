Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038824781AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhLQAjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbhLQAid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xe2qqsqY1ZDRJ/iB0UyKPDWNzmIrG10ufhDSRl4JpQE=;
        b=DGibm+RI2izpdyu0qegUs31Lznt3UbHjXhjx4e0V6dhHwHLEEiIn2thGzjardRTFnXYMFz
        PKnBnxHujkOZDxfpcn81KQ/M4Y8eTQ7SexHG4fvFOHpQhyHCSO1S1hAU79A5oCoWkx8UiI
        b+KRwuIjfPWsCgGyoumbrOV4ee5g5q4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-pqhPZx8YMgu34eUcM6W7HQ-1; Thu, 16 Dec 2021 19:38:31 -0500
X-MC-Unique: pqhPZx8YMgu34eUcM6W7HQ-1
Received: by mail-wr1-f71.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so145581wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xe2qqsqY1ZDRJ/iB0UyKPDWNzmIrG10ufhDSRl4JpQE=;
        b=dgItZ1qvilGJIMZxy1x4B+9CEwELH798IHs48vlhToFgfwE6tIUNhCaMQsRsmPdi8U
         OZv/mLADu+R794UHKNPm+YttHVotHD2lR1j1S0NBL2zfNfRptsT4bH64wsUrDAp4GJvR
         hxub9ILrMW0bmjzAzC5AoYzjJiPfBxkhxXMThYDXl9tpJY3bTeYe/Q9jzRP96kVgF5vN
         WAxkJiZK7MpaEQEXspySXRP+CspymW4sJF+NgJYrpqBaHnILv+nCt+yye89imtFoqbQp
         uD/arM0ZefJtpV3kb7Xj7/YZKCqDbKd2SpVggilSvgbbA1m8y1D3Z9NFhXvbH43HBwE4
         qAIA==
X-Gm-Message-State: AOAM530E/yGt06fSgCv1Zcf91TFeQyNGe4cf/Msrchn3UJO6LmdJrzKg
        nPDq30Y1rGe0k9MgcsfKz+95a7Ql3w4BLd3nDF4q6eRPqvqkg1ES5RVfreS334norLjZKMM7KGw
        9t2G1bDyiuK4a33rQP9TePIpx/1MQAUIcI3WcQS5IVy8s2pP8JEgsJZ5uXldLurpKQIEjR08tjo
        g=
X-Received: by 2002:a5d:6d03:: with SMTP id e3mr399273wrq.176.1639701510071;
        Thu, 16 Dec 2021 16:38:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGrQvoqRHrC7aR+ydwAfgOe/UZRHJ4+qDtY7BSAxnq7B8kg7+cb55gpicV4DAOi/vzOzzUxg==
X-Received: by 2002:a5d:6d03:: with SMTP id e3mr399266wrq.176.1639701509861;
        Thu, 16 Dec 2021 16:38:29 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:29 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 33/37] drm/sprd: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:48 +0100
Message-Id: <20211217003752.3946210-34-javierm@redhat.com>
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

 drivers/gpu/drm/sprd/sprd_drm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index a077e2d4d721..dd7e3de780f3 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -186,6 +186,9 @@ static struct platform_driver *sprd_drm_drivers[]  = {
 
 static int __init sprd_drm_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	return platform_register_drivers(sprd_drm_drivers,
 					ARRAY_SIZE(sprd_drm_drivers));
 }
-- 
2.33.1

