Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CFA475022
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhLOBCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238990AbhLOBB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPWP8E8vlF3j/9zyVbEBgLJAnHOMG05UNKEMPCeGQek=;
        b=U1kX/pEE/zHnK5+/ys0J2bN7z8ZS7JsLu0J4gXMmER0nnqftIjyEfXs7YCYN91MNUzhOr+
        wthXGsqZRDgeN91Jpx+f8xafS8d3h20YPXVWQnhSJ0L/EWZskY4t3YokGc2PL7BgkOR/vD
        mBn+1vWnd8hFSNWUEkXSVUjNQPei17M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-cnP_Hjb5N4aQxOT3MeO07A-1; Tue, 14 Dec 2021 20:01:26 -0500
X-MC-Unique: cnP_Hjb5N4aQxOT3MeO07A-1
Received: by mail-wm1-f69.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso13857921wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPWP8E8vlF3j/9zyVbEBgLJAnHOMG05UNKEMPCeGQek=;
        b=4xwqa6HxxQ6Yk1NfFlgfMa9xvQbI6eoN/eM0Q1Vijt9jAZlJmmyTbxG0Xa1Z8DBoM+
         uSGmQwBITYBjk/mpIC6YYegDSXev23mf8bb1RxBITLBeaOTBIxqD0fe/I3FL6/V03VX2
         XZ8hxQUGKNLUoBLMaVpuv2DrwSQRzv+W3ffONm8hmUl3fhOA1lpe28fOEx8oS7sflJXp
         Lp7x/VTU76ZPUJW8YoF1i9G2n+5Nfu3ymw5FNzsbNoGWNqABsNjsXVDMCyE/iTN+yQ8K
         M2ueF0TdCRslezV6fDDObjFP3Mg8yyvqPKjHcUwjD8v+PWe6WtYFtA7Z1zLUyOyAd0O3
         KCOw==
X-Gm-Message-State: AOAM532KWkZ1R2bqxXj8NF+kCDYumWLiEJf9KInDYm+Fw3bU3J3kuf7B
        ZTvf3frdK3qVAj4tB9GNVit4IWIXwRS/k/e5GWk43Mh0QqhheYz9pH/xPNiXaCwxZflEMyQ5cjm
        wCqhSPYz3mL/i1mWSGdsEp7PDprNkO26qtbH/9Ghi1Wk3zqj8GgFQToEojGd6t7Iyg7D8RUHOGZ
        w=
X-Received: by 2002:a1c:5445:: with SMTP id p5mr951348wmi.137.1639530085535;
        Tue, 14 Dec 2021 17:01:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwC2ib/uK2QIaWxvvQGfp9Zjg+MQWGESUHnyWTmgIVwzTH0X6VAxVfSCQZ5EAlMy02Zo9Ve3g==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr951333wmi.137.1639530085314;
        Tue, 14 Dec 2021 17:01:25 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 40/60] drm/sun4i: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:48 +0100
Message-Id: <20211215010008.2545520-41-javierm@redhat.com>
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

 drivers/gpu/drm/sun4i/sun4i_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index b630614b3d72..174d3d7790e6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -373,6 +373,9 @@ static int sun4i_drv_probe(struct platform_device *pdev)
 	struct endpoint_list list;
 	int i, ret, count = 0;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	INIT_KFIFO(list.fifo);
 
 	for (i = 0;; i++) {
-- 
2.33.1

