Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B13478177
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhLQAiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbhLQAiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXr/HtZEESykJ0yrpvW6NmyfmIq7N8POdE+7OtjF+Dk=;
        b=O4RybxBIrdhFly/3I4JjjGQ13ShGHHTWE+8rCFzBsfMm8/nVyzLdeKMwYlxzGXgP30gj8s
        SJeHItAyjTHIGKV5GACAMrghZtkn5bUz286WDLsCyzHQ55cNG70mu0uE2xkH2F2WblKnYo
        i7G/kA8CVY4g42tioIMrCRpc8ietKEs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-Twhn0uQtNZCP70RbffAREQ-1; Thu, 16 Dec 2021 19:38:09 -0500
X-MC-Unique: Twhn0uQtNZCP70RbffAREQ-1
Received: by mail-wr1-f72.google.com with SMTP id r7-20020adfbb07000000b001a254645f13so89413wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXr/HtZEESykJ0yrpvW6NmyfmIq7N8POdE+7OtjF+Dk=;
        b=jQkSU4xZHoPPtI+QTfleRMmCrGVDd7rd8ryuq8kgeVC+ND+wmZA2qPZYlX2xjF3ZOf
         /cfFC2cx48tspU4/r2yuB8UMSRcRbWD3KIPRb3BGDYjeoUBpwUAIOdWI1uHVmBwNE5s2
         1wBh+GSCGX0JESMWxWF/gD0yOgj3y02w1XKKikqwmsl+b/RS1Wv3XvDVCgQ0EMhPvFXA
         uOtQNnv7bwG8kClrZcDyjHCnl/Ty+dy8nrp9/0JeC/+B5H638yJM3GyjThb0GfC9S4Tw
         KaNPtbHEFwC9dn9P4FDYcoHC/mxTI9J+nA6v3/6ISQAyYqVooUxob9pgtfPivPEI1CO5
         8Fcw==
X-Gm-Message-State: AOAM5335uE5mC8ixvYTODOViZbBOncjViSAuqfoj7705QcYKTiDGQePW
        kVa6KwrmTFPZuzbB8EbMnd61VuA8nWgqae/9+ofWAxsYY5i0rO7D34adFWRPw45+zCiZDOHCmja
        jpf/MDONrXCTmP6JStJULUf7EaPcOMMK1z+gZQpn36kQHEGaEsFlYnt0qlk1CABoPh5o263OPPs
        A=
X-Received: by 2002:adf:e3d1:: with SMTP id k17mr385872wrm.610.1639701487698;
        Thu, 16 Dec 2021 16:38:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL5lNujgVSFdCNn/5S3bABcjAD8WL3B8WlbuHybqLl5LcmMGybOejSQy/ignMv+b6T54BObQ==
X-Received: by 2002:adf:e3d1:: with SMTP id k17mr385851wrm.610.1639701487445;
        Thu, 16 Dec 2021 16:38:07 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:07 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>
Subject: [PATCH v2 09/37] drm/hisilicon/kirin: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:24 +0100
Message-Id: <20211217003752.3946210-10-javierm@redhat.com>
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

 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 98ae9a48f3fe..2ac125edb0a1 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -307,7 +307,7 @@ static struct platform_driver kirin_drm_platform_driver = {
 	},
 };
 
-module_platform_driver(kirin_drm_platform_driver);
+drm_module_platform_driver(kirin_drm_platform_driver);
 
 MODULE_AUTHOR("Xinliang Liu <xinliang.liu@linaro.org>");
 MODULE_AUTHOR("Xinliang Liu <z.liuxinliang@hisilicon.com>");
-- 
2.33.1

