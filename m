Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30737475032
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhLOBDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239017AbhLOBBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g13vgTwK95Nb9J+XqBfe3e0QnKLA1jpSXKM4Gkznqus=;
        b=IJEfesgajijNcoHo1hGBVJkoaHxsigm+zh/f9ZSJ21iW8EkDkKoxneOnAixDP7DU2DyN4z
        HXzS6U0and4wJD0d5jakM/SOdurxSlyd0DMxdiJrnQePztsnp3YlvIawHaM7uWY1drKupp
        Dp2CkvHit8rgDkNrsOgFdmsVjJ8j23U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446--M9IAQQGPheahDcuo91R8w-1; Tue, 14 Dec 2021 20:01:30 -0500
X-MC-Unique: -M9IAQQGPheahDcuo91R8w-1
Received: by mail-wr1-f69.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so5368738wro.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g13vgTwK95Nb9J+XqBfe3e0QnKLA1jpSXKM4Gkznqus=;
        b=xpy52T15yulkv+cjQ3RM51AUOWSgmz9UwUK5C7U4QssNh7WNUxOyhKC/U/1+F+ytLv
         Jc20jyq+kfvcwrHOv8t7c8Kyre6SxNjGRr4WnYyRgtFl1KqYn95W1BuUCTeo5T0q+uM3
         b25fL6XJpdaiXqyQA4WuXFf8QaZXruEXR3/0ZlC7G+SkBnc16DMp7twWo+rzzIlX8Z8K
         cKkoZk8xSst3P61aF4jE7aFaDsX6ijFD1NL99PAJJyTmR6muGjmagSzH5isTdYwuRNmf
         BcH4LPamfCmtvB3bB8PbelNWzMwKmvGJ9DgB4Y35gJWsS9XqY46wstNzWmP8CcEl+sAH
         28MA==
X-Gm-Message-State: AOAM533gDfCm7LccubgSlRV2b2y7t539f2L1KG0Hmh/9x7LHJmmkzmes
        cYz1izcDeOic/S2f7EV295FpV6t+4WmaCghmZxCKXkJ+l0CVAS+fZ+CORzmE5vETDaKKk4exYdY
        5DPf4Fnghm6TdXkUAdk/Geun83wzj5KQKGguPbzNclfmrhQVara00mA5upgB399Joh2dSTechSp
        A=
X-Received: by 2002:a7b:c017:: with SMTP id c23mr2231908wmb.137.1639530088820;
        Tue, 14 Dec 2021 17:01:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLWnkY7t73UpAMyPZvCL+/ruSdaxpZrBS5KHfSm4lVNH+Ia9HiiZZrXZTRnuFK3moIMpLfYA==
X-Received: by 2002:a7b:c017:: with SMTP id c23mr2231893wmb.137.1639530088576;
        Tue, 14 Dec 2021 17:01:28 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>
Subject: [PATCH 44/60] drm/tilcdc: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:52 +0100
Message-Id: <20211215010008.2545520-45-javierm@redhat.com>
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

 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 3ddb7c710a3d..25fe1f8de6bd 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -606,6 +606,9 @@ static struct platform_driver tilcdc_platform_driver = {
 
 static int __init tilcdc_drm_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	DBG("init");
 	tilcdc_panel_init();
 	return platform_driver_register(&tilcdc_platform_driver);
-- 
2.33.1

