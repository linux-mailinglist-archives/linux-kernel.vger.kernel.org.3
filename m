Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF834781AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhLQAjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231276AbhLQAig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mtq9hJy4L+ZVvskxJioJNZiL+dpEFQcWZvYjYc3YgGo=;
        b=ZRy5qQCpxQtX8Z7kPWIhNaMmFYQO10EjCZcFxF2TJAmd1RTR2rAxX7CC3vySi/8R0vcZSe
        8NzLSgHk5TeEmUz6wYE5cE6C2Ps5CYPHz735ePN55bGXPNzblQ8/bvcFGtJuX2RNE8bygF
        yTQAHWC5H9kENCFKSH4viYp3dLDFjbs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-vXH-RGarP5mG2_xvzzJkWg-1; Thu, 16 Dec 2021 19:38:35 -0500
X-MC-Unique: vXH-RGarP5mG2_xvzzJkWg-1
Received: by mail-wm1-f72.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso2066044wme.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mtq9hJy4L+ZVvskxJioJNZiL+dpEFQcWZvYjYc3YgGo=;
        b=4nDGJQTbjs74hrhQMTrRrA5IChiIBId7WiTLzEG+wHsYGIFUKZjVAYlkBxFv29ZjKJ
         +NW9NgzM63xhbkV32fd6ZKWafrPzYNvUXz7Xn5P17zXJdaytttnskNTQLEe1e2kmcz9m
         n6IWTj8EHj+rWDjXLOJE/OBrO1S904cclG4QRytyQPDzEncKXzn4h41X4Fhhn1tqJ63K
         oeBTkrwxTNBbyOcww5Yopx+Ocd2KFkYcpt6JHEpBBTLq1b4dZ/SdOwufkIUXwA50ZyBy
         +hgRAA64jtayiAFwCpg0y0T2veyep5yqxVa8yapTvK0zObZ8nWsJhOWPdz4gkhlw4VxG
         xxsA==
X-Gm-Message-State: AOAM5316umqqy4D7ZugR+P2T8aiXy6Y+iNmrpGHx32i9Hkl67KnTkpsM
        60YhICL8O4dB3WwywFB0DE7GN+iavyG66VlZM6gENnqY3InJUk35B7mKzKwykFRwhk9lRSLbA5n
        EdEq9N9prBlM6XzPlOkBypAp61vsu2GZTlnWEkO/dbl5kCh9lZgMnTLfTeV0hSpgy+k4SjXRXXp
        A=
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr376753wrt.117.1639701513729;
        Thu, 16 Dec 2021 16:38:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZtlDEMwB4C73UbqOCIrjZQR5w2AX4DwoBRjCTOcB54Y0M6HuUoIkYjDPgo1wzkOWj15okeg==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr376740wrt.117.1639701513444;
        Thu, 16 Dec 2021 16:38:33 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:33 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2 37/37] drm/xen: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:52 +0100
Message-Id: <20211217003752.3946210-38-javierm@redhat.com>
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
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---

(no changes since v1)

 drivers/gpu/drm/xen/xen_drm_front.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index e63088c2121d..0d8e6bd1ccbf 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -495,6 +495,9 @@ static int xen_drm_drv_init(struct xen_drm_front_info *front_info)
 	struct drm_device *drm_dev;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	DRM_INFO("Creating %s\n", xen_drm_driver.desc);
 
 	drm_info = kzalloc(sizeof(*drm_info), GFP_KERNEL);
-- 
2.33.1

