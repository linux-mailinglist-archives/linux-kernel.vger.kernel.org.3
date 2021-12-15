Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B57475016
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbhLOBCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238864AbhLOBBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ft2fXSAgvOZV7IJVmAiQYpq+OlEAfY5PyKMyCzSqF+M=;
        b=fi/MHfdIbzVNDvIwc+Ps43lwZe5u0oDYRoHnEiKDWP3DIE95/QCUQ0lSznwagbJx0JfgEu
        uQnXYHTgmjfhLRFG8nA9MMmJ5wUdUAmHTltRigTUd1ocwSW1LxTaVCM0i6gwPtlwAV9ThT
        YNMSdAlgEMA1G1J284Gz+gLuN3okHxk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160--Jn0lfeOP_ywAH-oShRpRg-1; Tue, 14 Dec 2021 20:01:14 -0500
X-MC-Unique: -Jn0lfeOP_ywAH-oShRpRg-1
Received: by mail-wr1-f71.google.com with SMTP id o4-20020adfca04000000b0018f07ad171aso5388280wrh.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ft2fXSAgvOZV7IJVmAiQYpq+OlEAfY5PyKMyCzSqF+M=;
        b=0hwI9gEk9mLQOQIMv94x7fa1WWAjEFmkjURGoawVFzi4+MqU6XuLGIudPq0/N9EyEG
         EQrH5RnjwR//mlMArJsOYqNqjRis8RQlVQ23cpZvUoGxawlHMeBOJj/VTBGtbh+8CQ3C
         WYTGnS609iadyEJyQjQV6R2L+FuYpx9mmwniSfjGp8+7rgX8qrkke4OmfHQCMilWhL8p
         lQVXLF6xrQDYKZTnKB1zjDElui7RKMP1BsgZx1agtLLgU3HThytPxubHmAVvESi0bkjO
         AyM5IueDBa2WHNt2lx8vpxMptAhvgrdaZKnOMTZR8jeU8kivOB8ow4khcMEhb+EMY+Np
         TxZA==
X-Gm-Message-State: AOAM533pQDbcc6ZI/TkTX1+yj7MFivydpAC2Mf8fn0CBlJIgFlD7fSNJ
        dLtqzcnF7pzy7bPcZbyJnosyghcJuehW3ztFrdB9GbAy3RueBuLXpdEu0Q0GCctVV7XLi4o7cQN
        Z5bMnUpUG4AriwNaL+B8Se+hf0cXkzD6YZXJd/y/n3EkSjqVSG1oyAF7cmwRL//akPQ99yuEqRY
        Y=
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr2261189wmj.166.1639530073513;
        Tue, 14 Dec 2021 17:01:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPvTXOhrJZdB/gQ5iTFxqHIA8mAQjLVS7EzgHjDkOE9skFP2lDxbVMNReZ0NK+OIXg971fkg==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr2261176wmj.166.1639530073290;
        Tue, 14 Dec 2021 17:01:13 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:12 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Tomi Valkeinen <tomba@kernel.org>
Subject: [PATCH 27/60] drm/omap: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:35 +0100
Message-Id: <20211215010008.2545520-28-javierm@redhat.com>
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

