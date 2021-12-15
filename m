Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE23475001
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhLOBBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238747AbhLOBA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPwbQSjTLtGQ2bSf5dJaXmd35YFe+1ZNVqX51ENv6p4=;
        b=STiP70aHoVcLPOoeK4S4XlOn0VDHrWeCMMc8GJAjMYGFjm4kTpGThGnYUw4iiqk+/Bq0w/
        r/IsA4X4z5a9E63Qyxtv6sQB5iS4aCQi3KwaArqhGnvhlf0gRlUUvEhr66kuGBHSGpAXEi
        5aRwg9st/ZDhSAzURdkNIAvCXRHINXE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-yIBVDDsEPrG0DBGK5p4z5w-1; Tue, 14 Dec 2021 20:00:57 -0500
X-MC-Unique: yIBVDDsEPrG0DBGK5p4z5w-1
Received: by mail-wm1-f71.google.com with SMTP id j23-20020a05600c1c1700b0033283ea5facso263773wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPwbQSjTLtGQ2bSf5dJaXmd35YFe+1ZNVqX51ENv6p4=;
        b=br+WdwN2xlRwS3quI+X40hUP/xtCm7xps4TkceW34NwaSemEhXSNjfRKCUvM/qGa/2
         Mb8tTgcGAbLcSp5NBls5xrujDG3Y9Cpzahr6RmFAqjmr8sF2c5kUa3IEzRIV3coVU8dc
         IzGtOys9uyIPuwlUYEPsJSKGgpz/hF8B8lgq/cW+WMdKdipwmw1aRUgqoBr+xJz9t/PT
         K0/mvTn5gstqBF3k2wOIyM9UPZP1DWzuLyI70xchqMrai34WkNRzgIod8Etr69ONGZMl
         R1yGfthKEjGULjJdHQjl4k6ipCk8Iz01vWrU9TdSqE19seHEinj4NFPr6sy4pb91Qqzp
         oPkg==
X-Gm-Message-State: AOAM532yG/SNv9Uys+ToPeWnzM+ZCoX2Niu1IC/YT/pndh4YpBOlzuBM
        /Jmu8QCxY458do2CRD6TKxKHFuu9JWl+ayub4ntrSQFtqGwpvI2PaKm1gJJ07NL6Huq5QhQkRKb
        j1RqoZ2JPEOanUROgG+ZCUHdD+zkxonBaXqs9cvrIjm3iY2VpqV8ml2zDzjbkXEnaImp2jbBIap
        w=
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr2328318wmb.14.1639530056132;
        Tue, 14 Dec 2021 17:00:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzb0sf26Iq2p48wbNys/WmtOwDWHzEtvhQlwIT5GTeLf4E/dLNHCaaWeJfxWgYit2n/LHRiWg==
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr2328297wmb.14.1639530055884;
        Tue, 14 Dec 2021 17:00:55 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:55 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Subject: [PATCH 07/60] drm/etnaviv: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:15 +0100
Message-Id: <20211215010008.2545520-8-javierm@redhat.com>
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

 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 7dcc6392792d..58b092248f7b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -635,6 +635,9 @@ static int __init etnaviv_init(void)
 	int ret;
 	struct device_node *np;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	etnaviv_validate_init();
 
 	ret = platform_driver_register(&etnaviv_gpu_driver);
-- 
2.33.1

