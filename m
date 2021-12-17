Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159254781AA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhLQAjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231436AbhLQAic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESJ36qtFFPcXimyUN/SOrGqyDLoHG8BfmtKA3r/j+kA=;
        b=Bva+e/YKgnvU5l2aigVGqQ9bKeaLNlak2UrcMxo4A7jdC9SFawr6KK6DD1K1wtxlCMkq9X
        ZXg6tV6N/uIW8Yx5B6VUQSv7yS5ZgUqNqELXEVBl2LsfeN/RHSThPByQlmSHH3dy5qe2GH
        bxGBH8bH4Ufcnrw0GNiRYoe3mrFUVPM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-klaaay71OXm97JNDV7v2KA-1; Thu, 16 Dec 2021 19:38:30 -0500
X-MC-Unique: klaaay71OXm97JNDV7v2KA-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so2086352wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESJ36qtFFPcXimyUN/SOrGqyDLoHG8BfmtKA3r/j+kA=;
        b=BdDJGrmFbWgAX+fIZnXZ9ToqzD2ZP+dKG2wF1bu8WHSIRTz3d2WLvLbBu69/y6wTE0
         wFrSfula3468CT1/PeC+6bPlezj0HDrTFKl/Upwa9o1s53Cn47zotiRobRycN0K5GH98
         xGJPfG4DNfysEJIl5Wf/PXRDOqWwxFgv1PDojaMGOtwuX+VVvQWg8GU/q+FONUFgTD8d
         GJWfMHt8p13VSw0zPxZTBs+VWU2mguRsFweScjcF04lPRTGIDNpWUb8G2FewPTiKs6mN
         Z5BjHnIRLrJrKvt2Mb/4W7NkEJsdhHW62znrDJHFOfR99m4Av+Hk0PoWRstcr+XPRiF3
         6jAg==
X-Gm-Message-State: AOAM533FL93ZefrPa4qjr97HSUqyapb2NURfmHYivOrWPmSjAFiZAZee
        jKSLOLEYVhqe7ISdgiAZX1hFjRTZLJsQWkeIE/Z9yzIj3pGPXYcGQI7c5eBp9IQEZWoRhM4Tk7I
        dcoigoN9lOnYdd1gpkWakuErAVf7VJXiTsnkbb3PH+8wQCJxViG5rMTSSU/4zpDvBV6CYzcGysC
        4=
X-Received: by 2002:a05:6000:168e:: with SMTP id y14mr385049wrd.178.1639701509368;
        Thu, 16 Dec 2021 16:38:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxK7FfN8kb8HttL9YlqdACI1cpfVlOFD/S7iG8wfvRdAbI0Ii6+du5UWJPfTYJ2I/kou4QLew==
X-Received: by 2002:a05:6000:168e:: with SMTP id y14mr385032wrd.178.1639701509146;
        Thu, 16 Dec 2021 16:38:29 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>
Subject: [PATCH v2 32/37] drm/rockchip: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:47 +0100
Message-Id: <20211217003752.3946210-33-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

