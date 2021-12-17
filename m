Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB74478175
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhLQAiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231156AbhLQAiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjSPCkabpBJdylyAzsXsZ678mzFYTORqarlksLIyBUc=;
        b=XMv3gZVn6d2ufj+pfZZr72cZs7ZTWDuaVdkAz0GWNUREdoiegeZWLUE1vDbgASALvwovFj
        16HMKSxupemFCnEKVpAkGuFrh+iB8/21zIiyu4P26lEkrcteVy0SQioL9LValngqfuBuwq
        izBox6P2rdpechdWKHr4TlpA5Jc+rhA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-sRn5Pv10MTqlLhWQiusnGw-1; Thu, 16 Dec 2021 19:38:08 -0500
X-MC-Unique: sRn5Pv10MTqlLhWQiusnGw-1
Received: by mail-wr1-f69.google.com with SMTP id j26-20020adfb31a000000b001a2356afd4fso139492wrd.21
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjSPCkabpBJdylyAzsXsZ678mzFYTORqarlksLIyBUc=;
        b=1yKeOisM0X9vuU5myz0NipxrGqvfgTTRy/DypL0yaSngHXtdrTONNzyOhuuGeKEBCS
         duWJM9ihAkIUcuZRPeN4KpSoHQ7k2Hy9E05t9cPqfFHXN0r/2RKBmbgMrwt0IF7OiU8e
         QYu837QSVeEjgrslwCj6nGuTD4AVHiX9MK93/EJ/iHjauGZOBg1KoAXoli8m5TDTwS0+
         OxQlVnvd04tJ7W+VLz7FI3MW3/0q1XfFN2c9lRw6QTs00qeosCiZ4vnwmf2CmC/g7wlx
         eHp3DxtdrVeGgFwhCUVhCE7AZcpqseGJsbIgZtQuMfSXuH33/FFrP32f64ShBMbrktLB
         /HHg==
X-Gm-Message-State: AOAM533gwHZS1yclb4uzpTPwr03nUMD+bBNAC15OqDsWwUrinKaBjpTC
        DDuzbzFKA3HduXHQLyaoddD8KZodwprwQnO/zczZkTS++YEtXnEY9aW8vbhaqupzFLREgYhrIYT
        rC+LmG2UFkIAo+q9kEKwKAhF8eVilACdMGHQCVoHswFg6JdHRoNcR6AG4yz0UgIx32+X3kp1bQX
        Y=
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr380235wrv.371.1639701486698;
        Thu, 16 Dec 2021 16:38:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzV0faymaogyu1Cxq+hBi0+XoYVAsqf6T3xAeGgzAF9pGm4bakxsL0yZU74Co8dJ+wx1cPcxg==
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr380219wrv.371.1639701486464;
        Thu, 16 Dec 2021 16:38:06 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:06 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Alison Wang <alison.wang@nxp.com>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 08/37] drm/fsl-dcu: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:23 +0100
Message-Id: <20211217003752.3946210-9-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro calls to a DRM specific platform driver init handler that checks
whether the driver is allowed to be registered or not.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 660fe573db96..b24265f69523 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -368,7 +368,7 @@ static struct platform_driver fsl_dcu_drm_platform_driver = {
 	},
 };
 
-module_platform_driver(fsl_dcu_drm_platform_driver);
+drm_module_platform_driver(fsl_dcu_drm_platform_driver);
 
 MODULE_DESCRIPTION("Freescale DCU DRM Driver");
 MODULE_LICENSE("GPL");
-- 
2.33.1

