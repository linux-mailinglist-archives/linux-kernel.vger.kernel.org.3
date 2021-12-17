Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41707478172
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhLQAiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231146AbhLQAiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o9bq9vvV2NBJllKyCK/gDa1JTgmxSu2CIS04ZfQDYl4=;
        b=hz8rwIOta7C4bZ7KOIC9vDaBL+AGI0dYGKtPKn5gqq04ahXpX65DmJXYJXWBgYyZlVLZYI
        iU+5N5zA4Nx0dbnZCtfDw4gJGGp4f4I+/YfhVE7i18xhPJa1S8SYdTWZh+m69aJJRvOiOX
        3F+ahzd/90WA9mhhl+VZspPMVn4oiDQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-iSNDecSGO0y7Qgfm_mRzIg-1; Thu, 16 Dec 2021 19:38:05 -0500
X-MC-Unique: iSNDecSGO0y7Qgfm_mRzIg-1
Received: by mail-wm1-f69.google.com with SMTP id z200-20020a1c7ed1000000b0034574ef8356so386417wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9bq9vvV2NBJllKyCK/gDa1JTgmxSu2CIS04ZfQDYl4=;
        b=zd2mOcFZaptXQHm3yPzJtyIM45klWRui1F/6Y73UqOHL2N2QF2Vr3pBDCZhkGmtlse
         tvnLk8zM6wCaOrg3KG5u7EEZN6o06QkdWQCN8ctPySiO5SCXKRIUwLbQM/VIFbhTwIzp
         IFIICpcKZNef7hsqSCyp55F4Q6P51tgmbIkSvMM1E+8u96a/cW5tQK0Jx5a0jDvPONv0
         WyA+PRAiwE5GJIMDMHPzXfK2E9O06E7a9xjSA2SynL4Z7Cjgfrc7h0jrjt0SfvfNaZRF
         aXka7nT1YBfjQtRoCDEDLiTbPdD3h5Ux/MYlyEVxz4lt5wBYAgsLoiivi5mg9ekW4Gan
         rAWQ==
X-Gm-Message-State: AOAM5318xIuwC3DRIgcMLYzrRlJvPKdu2x4qjhRxjNXZZkBsNv77CKyy
        tWsMfkeQuIlLwFzIRNn1bR4wmWL1f3fur/PUN38W9BBqDM6VaIfNcMx7nKRKBLY+sQK5K6dRNfE
        UCCJUvaIIqSlFZHUNbaJOssEB0zoHfE+dfy2VOrrOM4JGRnNUEwFKHtZs33nzxroOLmVZPaQZOJ
        8=
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr378539wrx.601.1639701483731;
        Thu, 16 Dec 2021 16:38:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi2FMgQ4xi2dwXnV1vvgkYz9NP1Vg1YCFodvuBQTMKjm2z7LrLCKuJf11GSfz2vZ5K5fNJDw==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr378520wrx.601.1639701483471;
        Thu, 16 Dec 2021 16:38:03 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:03 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v2 05/37] drm/malidp: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:20 +0100
Message-Id: <20211217003752.3946210-6-javierm@redhat.com>
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

 drivers/gpu/drm/arm/malidp_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 78d15b04b105..fe3215ec39c4 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -1008,7 +1008,7 @@ static struct platform_driver malidp_platform_driver = {
 	},
 };
 
-module_platform_driver(malidp_platform_driver);
+drm_module_platform_driver(malidp_platform_driver);
 
 MODULE_AUTHOR("Liviu Dudau <Liviu.Dudau@arm.com>");
 MODULE_DESCRIPTION("ARM Mali DP DRM driver");
-- 
2.33.1

