Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D70475010
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbhLOBCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238821AbhLOBBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0c98FUmzZ3jUKVD5DuVrEWMpnPkezkHOas2PJOy3Zk=;
        b=IKwHNIBUw1jrNcZlUJ3mC4TTyGIKYmWUuamNmllZdIBrLafkpRZLBv63LxZsbWoElB+UQP
        ZxQNlAXMCxw5xYavTNFBRqD9dxZn1HQB/XwkSjQdtzFYTYLTMIWip9cA+682aXnVPBWZ3l
        oksW8kaMDBF0zNcEEM8MVL55AQwcybk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-RwGjp6PEOQmCCEzct4JzRw-1; Tue, 14 Dec 2021 20:01:10 -0500
X-MC-Unique: RwGjp6PEOQmCCEzct4JzRw-1
Received: by mail-wm1-f70.google.com with SMTP id j23-20020a05600c1c1700b0033283ea5facso263917wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0c98FUmzZ3jUKVD5DuVrEWMpnPkezkHOas2PJOy3Zk=;
        b=CZOBe1QpY+DfzwnXp5uRCRSyT/eCrue2C7kPtAHyJb0ucujG2nNyw5gU2PCVjZW8ux
         Ue0EilhmRCBn0/pf9sbmV11QIcWZKmhRdt/zCU3NagkEjB/KIuAHmoRFyPiD4oDri6qg
         iwZeRl+4QN2X51y7ZLs8CK4Jz8YjY39KXXqTVAgtVxsoJlQ6P40drkP5se/h7ce+dBKn
         X6AzTWWp/dccxDg11Iw6cmwTks+Z5K+Eg08/SVAc2ZrNP8AypAYG7VbmKtF78IsreEQn
         q4XWSGUK+9V5JhFsCrqJXTPE2fT/Gb8/CHgKHyQH0dSbKM+lIrG2MpAAYuCuHtj7MuaI
         E22g==
X-Gm-Message-State: AOAM531bdRYCXAkGWIEyl+UtjJ4TkQz2Sp1sp6R9z/plZZZzeMj+YQbc
        dve0NOWa6wOrh7lOnyjN070siMINWP7jP0zCl2COUm+XYkOx3t6z7hSLHwtB0W/j9MPtiZE3nJ6
        CgfRbbRjgx7Eq6AvchfbOmwpGozTmnY1mgD/P/Cd9tR1RNFmK65OOk5+yG+CLvGbFGXjuU7nIh4
        o=
X-Received: by 2002:adf:a386:: with SMTP id l6mr2088187wrb.505.1639530069373;
        Tue, 14 Dec 2021 17:01:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUdw+6hFb6bAKvCZiXPJTU8S/eHCzIks+l31gbEogB1i2JCupJbK69RZm8jq89jgVfPqsgSA==
X-Received: by 2002:adf:a386:: with SMTP id l6mr2088172wrb.505.1639530069114;
        Tue, 14 Dec 2021 17:01:09 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:08 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 22/60] drm/mediatek: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:30 +0100
Message-Id: <20211215010008.2545520-23-javierm@redhat.com>
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

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index aec39724ebeb..e336358fee20 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -210,6 +210,9 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	struct device *dma_dev;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	if (!iommu_present(&platform_bus_type))
 		return -EPROBE_DEFER;
 
-- 
2.33.1

