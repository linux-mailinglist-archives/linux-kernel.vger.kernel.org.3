Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B37478173
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhLQAiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231143AbhLQAiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfDBXAA9BkPVham66rHOLKsVZavytvwmbodEgKt27t4=;
        b=i73OXfYluT0qf//xW+2tghI8nfJwX/EEL86zAdqEQ64DsKQNVHvoIH3WNiIQD0emb0JoZy
        uay5rz/CmP+1hPb51Rthq7X30W+OyNNWa7jtbyJ2xtRDdXxpi6YSgtj653WfLSKOLXkA3w
        xZW/Eu6SF4klmeTgOsgigzhXt2IF15k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-AGBjAHT1O4mslNQRzZy35w-1; Thu, 16 Dec 2021 19:38:05 -0500
X-MC-Unique: AGBjAHT1O4mslNQRzZy35w-1
Received: by mail-wm1-f72.google.com with SMTP id a203-20020a1c7fd4000000b0034574187420so1155315wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfDBXAA9BkPVham66rHOLKsVZavytvwmbodEgKt27t4=;
        b=4b4EjGAA7GDRQLb1z6w1/QuICiTjBwtXzq3scdbWz/kRz70IJfye0TIoVZ72BSFvkf
         spw+32Q2pY/Re/uw3ai0/6fb859R5kncLEeuECtJn7Fh7bffIq/n7LtnEN+x+N70uJDi
         E8iUTPcT6u/dJ6UvoQY6Kmd10KH1XUumsbrmRpZvIQ41pRmCNIdObT+mp+8hx1Q0NR/U
         eMXhUqm7KgJD49sMnnQuHwViiSfQalVPvae7qb8Q2/5zf/3AIS+nVEOwOpKKw99/Plmq
         pD9MUR4/r++aGFQuKG2zYaURkdBm/FZ4X+2jZ4O8Fbw8ong+w4b19/EPJj5S1MAGk9zH
         IbZw==
X-Gm-Message-State: AOAM531Dzh7dq4n5uQcoGsrZEmmtoLEPj2mBLtNCW/DN4WNuXA9H3TCA
        nQykR/8yMzYO5Nyry+5JTxarztye06A/+LvxUHdE9P8cfDla3JNaLaHea7yHgFKlg5Wwxw4NHhX
        mMFUIYnyvZ3wxBQJjRuQ12SIOEaxkBupJRYM/Bm3lThWQSMOYWjoZBLzvDLewPsGHjqYD8JBymH
        k=
X-Received: by 2002:a5d:6d03:: with SMTP id e3mr398360wrq.176.1639701484497;
        Thu, 16 Dec 2021 16:38:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9fjAZ2cu0VDYOxdjOj2IqyYWM52ZCvJI5skCO4Q9msxOV8Sw0gq8g6tzBPdTpOvtW06/YXQ==
X-Received: by 2002:a5d:6d03:: with SMTP id e3mr398345wrq.176.1639701484199;
        Thu, 16 Dec 2021 16:38:04 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:03 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 06/37] drm/aspeed: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:21 +0100
Message-Id: <20211217003752.3946210-7-javierm@redhat.com>
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

 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 65f172807a0d..383799378c97 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -359,7 +359,7 @@ static struct platform_driver aspeed_gfx_platform_driver = {
 	},
 };
 
-module_platform_driver(aspeed_gfx_platform_driver);
+drm_module_platform_driver(aspeed_gfx_platform_driver);
 
 MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
 MODULE_DESCRIPTION("ASPEED BMC DRM/KMS driver");
-- 
2.33.1

