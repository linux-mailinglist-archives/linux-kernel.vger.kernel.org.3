Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E73C475036
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhLOBDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238881AbhLOBBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01UyAOvBbQsdYZuo/97O6H7o+O610gyZBThBA0LMVHg=;
        b=eUWYVunikzj+cHtLCd5EOEd+zbiQydjnagyR/9IyiBV1FZAZ9l+FlC/w64ekNV5rpsK0mA
        CyQAP2GEcfGZLsRQ5vMDR9VF3+RkoDH90h57V5NTVrmvpaoxdukZW5WOoq9osPoDGQXLN1
        avrQU0mYgpm5ul+y5QMHdtik9K3oAiU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-iI-ls6V8OqeVYRTryHwJUw-1; Tue, 14 Dec 2021 20:01:40 -0500
X-MC-Unique: iI-ls6V8OqeVYRTryHwJUw-1
Received: by mail-wr1-f72.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so2589620wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01UyAOvBbQsdYZuo/97O6H7o+O610gyZBThBA0LMVHg=;
        b=Zr2F3VKYLBz7lN42T6omBNwzLXxQSAF3hbvIkOiGyFsKiWoXklGBs6rVCtkTKbUEBm
         oPXCBXv34DT2CpufaImGZGkOuz9V+ghzzhUL7cWWcdyhnavHaIPXG94Ou5uC+7DvrUAY
         pB/UXe62VZl3pLE3SJh9B0OkHdZLqHiIkbXq1UJQBLwZ3DLTP5C1SBCM1bN5kYDHf4IG
         QoTAHoHUeJTJXb7mjFxSEQSXvuRu1aYAxzdCwjUBgtkOKXelYCwxbvcjK5SmtO9KWW1T
         pxJL0k+dxzcxKiM88ahBJeMqvKC+uZJ9sJ+zKdpnJpsUULrs+eYYzOBxCWukxF8kaEwh
         XYOA==
X-Gm-Message-State: AOAM532PA2ffpVnC2Kx0On2XFicmuLKaQEb3hm3xCmqnxoXW58AaEKoM
        I/7g0PPXPNQAOn0Qnjle9Ecd9SMLm4sDFSGi2wi0mSZOlyvc1vxkNrlVMa84IGw0N/9+4uS/4Gn
        ja/UT2e5P9ToSCEB8SEp1UjaL4m7NCalXepf8uLdC/D7KVpdZxggIAfsfbpAuJO1OUKrFaTd5Ds
        0=
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr2393883wmc.58.1639530099273;
        Tue, 14 Dec 2021 17:01:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqoSLRJJ02so1Qq0JhojYRNJZ9AVkb2q/OhzN866shbb5MPKeNaZ6+meUDDnZw5935EtqRvQ==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr2393869wmc.58.1639530099075;
        Tue, 14 Dec 2021 17:01:39 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:38 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 57/60] drm/udl: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 02:00:05 +0100
Message-Id: <20211215010008.2545520-58-javierm@redhat.com>
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

 drivers/gpu/drm/udl/udl_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 5703277c6f52..d5a0aa762ec8 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -91,6 +91,9 @@ static int udl_usb_probe(struct usb_interface *interface,
 	int r;
 	struct udl_device *udl;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	udl = udl_driver_create(interface);
 	if (IS_ERR(udl))
 		return PTR_ERR(udl);
-- 
2.33.1

