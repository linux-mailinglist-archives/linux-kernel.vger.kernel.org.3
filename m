Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F00478176
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhLQAiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231184AbhLQAiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2i+a0Hx2N4MuSgyTPRig6ZtnqKsO/4+K9evEKBHNXQ4=;
        b=QbzSPk2Ew4x0bbpye4y8S3p8oBtF7NI3diEXFEfAgH6yIerTstVJhxzyjmfbeu6rRGdU+F
        SsW5CoPTaKEa4GIFoWh+dHJ3y11fS4CKUugI8yum7I7SpKaQnNpm7d5hVwlvxZsRWsYFg7
        FeIaHAacQitoWdoRh8Ic7DLZCjLsbkc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-NMY5-HASPreTWmaj9fvj4Q-1; Thu, 16 Dec 2021 19:38:09 -0500
X-MC-Unique: NMY5-HASPreTWmaj9fvj4Q-1
Received: by mail-wr1-f70.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so153703wrd.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2i+a0Hx2N4MuSgyTPRig6ZtnqKsO/4+K9evEKBHNXQ4=;
        b=r1xV9kmiXAATLwgMG40NszqgH787ZZQUoiphnapjkRlVivQ86QlXCtMiSswLXB/eU5
         oUvqS2ATJRwfqWqyfp5u8qgFOBIrHBitsGIGTtezXaKfasejExkv9YsyT3QUxZVmsGgM
         /1tg4Yc+1hGS1IFy3i4ep4W/d+6rKSLWQA6h3kUxDRygK6CH+y5iCcwzrChr8DNPkFb6
         brAjutRfgpO7A7Dstub1LVy9sFymNcPbiTftio5fWZ0QvfBXEpQvIKl1SxtIcrTSQUar
         L+RcUxBwXsE5JUD2rfNGV8U8I/AeU0puOv7IdFdm8IPS8o/84pgR+CnFW85sW8qkCjgr
         K1CQ==
X-Gm-Message-State: AOAM533g/ZmV7iwEk2lp24zHKXkGAO5UHhx48i/LjrqPChMKJwKPQ5Ao
        9NsXep2UmN8zxVVPm4RR5itb1sjF9k/8a1NZ42zd7sGIlutlLUO0usTvtk/ZIhXKfNN99v0Cul8
        Gw+/pm1jaoW6p/HOZJTmAC9D4FHM0wPzJqOLBxI39pRUL+CKJMq9n0JoYn0iiqg5vb7NKzgA8Jl
        A=
X-Received: by 2002:adf:ee47:: with SMTP id w7mr385092wro.368.1639701488405;
        Thu, 16 Dec 2021 16:38:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYVfZs5fU18IrDElvj2aJ/BiUWFslqZecT53FQv/BKzpw1z6c0hElAqSLMPto0t2VKeJh+zg==
X-Received: by 2002:adf:ee47:: with SMTP id w7mr385080wro.368.1639701488193;
        Thu, 16 Dec 2021 16:38:08 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:07 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Subject: [PATCH v2 10/37] drm/imx/dcss: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:25 +0100
Message-Id: <20211217003752.3946210-11-javierm@redhat.com>
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
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---

(no changes since v1)

 drivers/gpu/drm/imx/dcss/dcss-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-drv.c b/drivers/gpu/drm/imx/dcss/dcss-drv.c
index 8dc2f85c514b..f3d2bb07facb 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-drv.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-drv.c
@@ -131,7 +131,7 @@ static struct platform_driver dcss_platform_driver = {
 	},
 };
 
-module_platform_driver(dcss_platform_driver);
+drm_module_platform_driver(dcss_platform_driver);
 
 MODULE_AUTHOR("Laurentiu Palcu <laurentiu.palcu@nxp.com>");
 MODULE_DESCRIPTION("DCSS driver for i.MX8MQ");
-- 
2.33.1

