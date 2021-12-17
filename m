Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5347816C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhLQAiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231136AbhLQAiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZgKCXxMxXdMGFJR5lD736fmZZUs4WxcnzSatWsTV/s=;
        b=AfWbFgdrDD88/Z1IrU3WJjjSORf9Q7PWtc5tDxyG8FUxhPlJAYsQG2+uX3kIT8ln+19JcD
        o3tE2Iz78ZKocnWHBda78Kk035uXKA9CndzJ2vCYV46fzS22KF33pThfY9ecid6fueVY/3
        QdAXcy/7b56Wpyxx/v9sd7P8OLSazSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-Rg45KfhaNjGvCiuZNghXzQ-1; Thu, 16 Dec 2021 19:38:03 -0500
X-MC-Unique: Rg45KfhaNjGvCiuZNghXzQ-1
Received: by mail-wm1-f71.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso2065523wme.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZgKCXxMxXdMGFJR5lD736fmZZUs4WxcnzSatWsTV/s=;
        b=jhYaFJJSMyEFqPFXV3y5m5awoaRd9zT8tObjE/Nj1SsEUaKz75W0Ja+DS5ZyCVMXMJ
         yxjDvTM23akxxcVnLwFbn5B9GhNN6h+4dUOeUIpvRfbFe6aW7EYNNhxqMgc2PoajEhvK
         81Pmp3+NQoS1UVAYJz+dgL2bdt782zlERQHyPZ06Us9CuLFw/2VlU2pZf3oFi/fDP0NT
         3RRHA+NK3aS0AJx9ECzXEMN1eiemDAIS4kZvwJjXnm3Ka0WfXIYba+O3SiuyluVAzvLH
         L20u5yAWkuRBPyOyyLGJxjk0stW8G6XHUKsR27kzCLNrC3Q/9aOy1luFZMjuT34sz/2n
         4IpQ==
X-Gm-Message-State: AOAM53186X2PRp1VhZ+SgPh+vhd12XnZdhOVOM0C/tSMw+yJ5Jdi9tvf
        nLDO3IHbIcZMYHX0oI10FcbFcUJaJbi5YceOSz/DXs7YiRhfMBnBN8RQg7QOvWzWWtM/JSJYMLj
        O3dIkhBMMlfbrdylwSyE10m2hEbG03gyS/n3P7T6UsPyf12JTuaVKEpXkDMnvcxAb1JSqxvGzr+
        0=
X-Received: by 2002:adf:ec83:: with SMTP id z3mr380481wrn.165.1639701482575;
        Thu, 16 Dec 2021 16:38:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzN8V9+x9EQHK2tMJ2CUW6+VwGKoSxsEAxMur+xa4drpIb/8syBawi/xpAJhR/OiKojB/Izaw==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr380470wrn.165.1639701482382;
        Thu, 16 Dec 2021 16:38:02 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:02 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v2 04/37] drm/arm/hdlcd: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:19 +0100
Message-Id: <20211217003752.3946210-5-javierm@redhat.com>
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

 drivers/gpu/drm/arm/hdlcd_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 479c2422a2e0..1959ee7592c4 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -434,7 +434,7 @@ static struct platform_driver hdlcd_platform_driver = {
 	},
 };
 
-module_platform_driver(hdlcd_platform_driver);
+drm_module_platform_driver(hdlcd_platform_driver);
 
 MODULE_AUTHOR("Liviu Dudau");
 MODULE_DESCRIPTION("ARM HDLCD DRM driver");
-- 
2.33.1

