Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F72347816A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhLQAiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230520AbhLQAiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9k5RFn1PoMDkgn4F1QHrlqrR77m7NFK/gG62GZbS1Vg=;
        b=CAYNDOPuVoktffgs8VcPGYuabBLiDhkI9h9RaOKplq76fObUZrYugDEaPSNjpxyzVadGDl
        bflx1TX37bPerz9sVx4QXHOA5qDOKtPl/TKJkfXiUjSgoiWXTf7MQGmnJ31xeKUQrraSPL
        Bmjm2+/e8GPXbxNGTTw3v8wYBf5IM9w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-Sn0kbMDKO9-BjLCaRjei7A-1; Thu, 16 Dec 2021 19:38:01 -0500
X-MC-Unique: Sn0kbMDKO9-BjLCaRjei7A-1
Received: by mail-wr1-f70.google.com with SMTP id k11-20020adfc70b000000b001a2333d9406so148221wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9k5RFn1PoMDkgn4F1QHrlqrR77m7NFK/gG62GZbS1Vg=;
        b=eInxG2J/8NIy/NQMn5INgupYUxprdYCOzX62LJ3wk+/NKwbO4m3gMNnzerJPkPo8Wc
         Bj9ruqQBStMF4yaMkoPWXba3Ka9kcHa9za8eyAMdkhKb2Y0pXLpwMI/zLXtoYr0Yptfs
         LfQxVVdMdkGDsHifkD4PhbSccNYnJ4WIT5PUr3nyJMBJzBTmQ3Zoh2wMn2Z45Tlh11a/
         UH8UKWO2f8TXxdSvmrFIYTWi3Y13IX/+ut2svAoaDJJd/lVsW+0rTOsZYFAiupLR3UUo
         ugM09G6HVsbcOl/VYg7YPtEbHi0Lxa1GldSmduC3GUlZljnJyZbTGcPfUkjTsWyVOul1
         DfiA==
X-Gm-Message-State: AOAM532YkHfG12iaupydR1tNfitEhWfwo6qRDVEUJJXGTKnTLFFSIH2b
        SBbpew6gwODbXaS/Pw/Q6Lrs2ZXIqifTXazJs4v9+7UrJ3IcDDglHwyrX10tPqCTumnytZi7G6Y
        6kTZTpssfQZa7P9n87FRy9iI9Ig0yJgwggBUj3eWV56X/LOddQwOKh73wCfVW3x0iEDX5avg7k0
        Q=
X-Received: by 2002:a05:600c:21cd:: with SMTP id x13mr7475466wmj.52.1639701480540;
        Thu, 16 Dec 2021 16:38:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxl7JSlYctIcRUyr9mug90h1tfRpQTUD44VB9IztGLdau2eaDdgRI0Bprrb6lO/xjVPBo2W7Q==
X-Received: by 2002:a05:600c:21cd:: with SMTP id x13mr7475454wmj.52.1639701480334;
        Thu, 16 Dec 2021 16:38:00 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:00 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>
Subject: [PATCH v2 02/37] drm/hisilicon/hibmc: Use drm_module_pci_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:17 +0100
Message-Id: <20211217003752.3946210-3-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro calls to a DRM specific PCI driver init handler that checks
whether the driver is allowed to be registered or not.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 610fc8e135f9..398a68b1a08c 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -379,7 +379,7 @@ static struct pci_driver hibmc_pci_driver = {
 	.driver.pm =    &hibmc_pm_ops,
 };
 
-module_pci_driver(hibmc_pci_driver);
+drm_module_pci_driver(hibmc_pci_driver);
 
 MODULE_DEVICE_TABLE(pci, hibmc_pci_table);
 MODULE_AUTHOR("RongrongZou <zourongrong@huawei.com>");
-- 
2.33.1

