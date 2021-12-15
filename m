Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36EF47501E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbhLOBCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238961AbhLOBBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmzxQsYusvcUk2QF1uoXFK3UYSPveOrXaut2p31GcTU=;
        b=F/uE3GLOEHeqOANl5UBk+2eRRmGkY2tD/zS5zocUt5t+2l26wKlccuZMFJQV2PoliY3zjI
        3PFEqR1UXF4N5GuxEJzdPMT7kHM36zhA6dOQRR3+VOZgy2ec59eAItzhwPP19Ok27Lv+Yh
        bOdsrtITJr5JG/zFVYieSBw/9Dxhw9g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-0AKWPyD9OjeNWk4N_mWF0Q-1; Tue, 14 Dec 2021 20:01:23 -0500
X-MC-Unique: 0AKWPyD9OjeNWk4N_mWF0Q-1
Received: by mail-wm1-f71.google.com with SMTP id n21-20020a05600c3b9500b00344f78681b1so1088235wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmzxQsYusvcUk2QF1uoXFK3UYSPveOrXaut2p31GcTU=;
        b=F4WIoWXjCNpBCk94NjmEZHj5d73PcvzAMNpt/72Qk+avIV52LF+mhmIZWlFpRUtHUq
         YW2wNZK2CzYl/zVj4PZR2PYZcjLQqlhKIBYyL1qf4pZPD3xTkRtz5RQKw1BuQAAV746Z
         rGzEWNM/e069S2EBJc5v+kX0oM61HY9CJGAO/ZAj5mHbjK3vg3SzEW3Sz6vabWYIhUmc
         plF9veyhWJ7rwX/HNQKGsyzFTi1zkAvuORS3ETYAa4G9hKkkdDSQbQV3HeWBgYT4g5Pm
         FAB0NNoKUQJBOSMfExzjftkSAXK4u2XAe9qgqJ0bGb75+lqw7j3vhmahZNGbFyb0vl3d
         2UsQ==
X-Gm-Message-State: AOAM532zIAJKboUVNs9nCVA0OYdukBGjT7nz59EzQ61AOhodcRLegiGP
        NJ0d8BBMP6avwRfAYlE4rPOzJzNKVWwXkkRANzp2axsRwBAZo9ogtlOChdIfLoH/XmIpXE779J2
        n1+1vYR37tOWmO3Dtsd02FiZpVFbsihWE7Hw0i2vs5GyORS13Ki1rnykWQfU9k1UHiVaGGL/cKl
        4=
X-Received: by 2002:adf:ea51:: with SMTP id j17mr2155355wrn.421.1639530081901;
        Tue, 14 Dec 2021 17:01:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMiMKZ+qKZg7zwxbLxevSi3s2DzFDWSa7D2MkJcQiC4wd6pda23MO7PbLjrqadFQauIEizFA==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr2155335wrn.421.1639530081646;
        Tue, 14 Dec 2021 17:01:21 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:20 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 36/60] drm/sis: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:44 +0100
Message-Id: <20211215010008.2545520-37-javierm@redhat.com>
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

 drivers/gpu/drm/sis/sis_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sis/sis_drv.c b/drivers/gpu/drm/sis/sis_drv.c
index e35e719cf315..d592af70e8be 100644
--- a/drivers/gpu/drm/sis/sis_drv.c
+++ b/drivers/gpu/drm/sis/sis_drv.c
@@ -126,6 +126,9 @@ static struct pci_driver sis_pci_driver = {
 
 static int __init sis_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	driver.num_ioctls = sis_max_ioctl;
 	return drm_legacy_pci_init(&driver, &sis_pci_driver);
 }
-- 
2.33.1

