Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AA9475019
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbhLOBCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238912AbhLOBBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dn9hvS/hE+6Q3aeifiJb08PIGBHJHXd+uPexu/tsonU=;
        b=LDWz2lZCqhEhKhYstAbzsPZYXnfqKHZQY09ck3H/apPkY7EO7KkwLGrUczB7U/ubTePDWW
        aZvVc+kffYUyrybvoBcrqb09IoKFrEja7AeVe6RhmgzmJE2Gk1MhQkEPc/wwe+Dj8iOeJG
        4c4uOlntcQUwoFt1iBj9Zh4egQBYu5I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-Ob6FKhrUOBeg1ym0-zon3g-1; Tue, 14 Dec 2021 20:01:19 -0500
X-MC-Unique: Ob6FKhrUOBeg1ym0-zon3g-1
Received: by mail-wm1-f71.google.com with SMTP id a85-20020a1c7f58000000b0033ddc0eacc8so13866198wmd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dn9hvS/hE+6Q3aeifiJb08PIGBHJHXd+uPexu/tsonU=;
        b=NogkPa5Q+4F3Dw+GiU6KmgmV9Fy8AHvQWF7wijtO1CF6eyZoZhRj48TAhHMa2lE3Ty
         ccFfvpYiOMrn3q1ebX64J5X2H3p1JoV8vIoS1F49XmTzsyVBVTclQ8AI97/JVs3zzmIX
         yZjTuVAquodEZMq9arbx/NUS4cNVgGrEaJA0qzzoOwec/CPbhiCVvwp87u/8MApbaYba
         V3J1g96OsC9tozC0+CY9nFMqFPwgH8B0gVQBzrxHZH9gqegDuLZXiax0MEg8YLZoaqdF
         T9RR5InytuZ3W+1hNGRw0wpt4YsjuDMyOoAZoqAGDrN6Ha3wVkHQyBEVf1rCAywqgboM
         Gfmg==
X-Gm-Message-State: AOAM533s5lLspoW8f61U8mu7uHPQUXg74NLhtch7+H2D73n0zhLupC4P
        S97pbp4HVfG6aWQzFY+ByanfRYsu7fpKkBJg/CIjULuS6H4s+cE2nNawlblS4hG6CsogpqRLSbg
        w9F8ya9fp5PYh/0Qh8aMzdrQ56rG5LxMeEFPpA4JvK1Ldikp9m4aAckahBzID7o/8Mupp8JCcHH
        c=
X-Received: by 2002:adf:c5d1:: with SMTP id v17mr2041318wrg.571.1639530078252;
        Tue, 14 Dec 2021 17:01:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycZee8IeEpnSGxw0fK7crCXAu04SYEjusDcgnk8vStLkhcKO3lv7vCppnlF58OqBmYIZJQ0A==
X-Received: by 2002:adf:c5d1:: with SMTP id v17mr2041301wrg.571.1639530078013;
        Tue, 14 Dec 2021 17:01:18 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:17 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 32/60] drm: rcar-du: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:40 +0100
Message-Id: <20211215010008.2545520-33-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215010008.2545520-1-javierm@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
MIME-Version: 1.0
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

 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 5612a9e7a905..7b676b2f0f06 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -699,6 +699,9 @@ static struct platform_driver rcar_du_platform_driver = {
 
 static int __init rcar_du_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	rcar_du_of_init(rcar_du_of_table);
 
 	return platform_driver_register(&rcar_du_platform_driver);
-- 
2.33.1

