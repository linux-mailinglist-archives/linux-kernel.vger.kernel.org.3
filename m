Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C676475006
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhLOBBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238760AbhLOBBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQTCDPDBHdP0UJYByXzA6Uzoj2dEWXGaiTwokgt/R5E=;
        b=bxm0Aj78cufhc96rBMSnRTnb/EAeUPzJDgSlfOZPE+0oqdjrFgGQWCBVtVYrm5ZugHprif
        vyEY7xMCwG9KSnTiPDX69+LFOdsEOtMg1a/S135wTPUUNNFtPasitjMYl9jbe22oo1Ie12
        UUeYi4ldhHy4kLJj/LJEDspzRnmoQX0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-AXzG_RYeOcSl1o89K9Jdvw-1; Tue, 14 Dec 2021 20:01:02 -0500
X-MC-Unique: AXzG_RYeOcSl1o89K9Jdvw-1
Received: by mail-wr1-f71.google.com with SMTP id h7-20020adfaa87000000b001885269a937so5415934wrc.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQTCDPDBHdP0UJYByXzA6Uzoj2dEWXGaiTwokgt/R5E=;
        b=u0dhqIrxKMWctfGSsm+vNo7t4FDM7+e7F/QVNiGdd6nV0zuKsFfL7azEF93aQzIP5H
         PbU6tiQj+bi4JQwIIqHW/XFbzwxFhXCosX2sVfWtj3LJfRWIeyKU90ykl9BTmo8RHXfB
         Egy5P9K26ewVW9Sehj3wN6LTv/1HYYVDonERpmFK6nLWTgF93w13igz3yEwIsO2UZkAx
         +OAkJyQu0TWxvMCg9RaBfJ6WZOv8AyWzkAjt1cwVhmq8aWiUsojMLSG9WE6RNU5qNYox
         Pdd/QYjF9R634TultT9JntLWMWMfNBv8e9uKu5ehQXd9rPFZZRAdTlMTNNGxiCGV/F/i
         CDEQ==
X-Gm-Message-State: AOAM530HQUN9oR9I5fbm83GRID6ptXhjPL3ZTYiwsjv6OrEnO1rgFSnL
        LlxELW8cL/09eHxOPncBF2nbDMTEscDoaXAo3vIiOSIk6tg/jwWrZeVnEotgVLw1M9zv3DyilG9
        fQUFm2sms53ziK/I3t4qQrBJUCmBUgNRkQJixdWJQPCGCEkQXvPMn9uAJ6PYnD8docqNfbf/V62
        4=
X-Received: by 2002:a5d:64c4:: with SMTP id f4mr2273648wri.6.1639530061309;
        Tue, 14 Dec 2021 17:01:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhy2UBePDn0sBvMQOB1g4jRXeSL9+JYzQTE4Jd1KtFit6X1vewED3OTBsnEbs0L1aGf4sjlg==
X-Received: by 2002:a5d:64c4:: with SMTP id f4mr2273630wri.6.1639530061010;
        Tue, 14 Dec 2021 17:01:01 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:00 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>
Subject: [PATCH 13/60] drm/hisilicon/kirin: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:21 +0100
Message-Id: <20211215010008.2545520-14-javierm@redhat.com>
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

 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 98ae9a48f3fe..2f4c81dc8681 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -274,6 +274,9 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	struct device_node *remote;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	remote = of_graph_get_remote_node(np, 0, 0);
 	if (!remote)
 		return -ENODEV;
-- 
2.33.1

