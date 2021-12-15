Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE3475037
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhLOBDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238884AbhLOBBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyO2deYlr84/xlhfJ3zeY84NwsLkiGhBAaun/MQyRLQ=;
        b=FOEKc2zTX4tCJ4uC6Hqg6xbTlCCmqXy+V+kOtmos2vTPfAxGNZ3YgzfFJE/IKo7sxCJxhR
        y6Bbig3wz4OgbR7L+PHih3hcpdcfsGSu0O85W3R+9rF1aUmEKjNMkxrro3ZoabKQ/St0R6
        0uU51eK1SWKRmQBEkSMCyiHFD/J80Qg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-sq2tUk0KNwmpofuGc1NQMg-1; Tue, 14 Dec 2021 20:01:40 -0500
X-MC-Unique: sq2tUk0KNwmpofuGc1NQMg-1
Received: by mail-wm1-f69.google.com with SMTP id j71-20020a1c234a000000b00342f418ae7cso13892344wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyO2deYlr84/xlhfJ3zeY84NwsLkiGhBAaun/MQyRLQ=;
        b=zs6nEW+p1v9k286FmhC66uZNvu1Vho49QIl4rbcYUJThmJWi9ySKYJWBZVJjSx6OhM
         D8QV6BwXOSZHVdvh2ii0ZI/mHoBOT1JAEBs15DqL14RlWU0yAXgHaEuL5wziSJg1KIGt
         zfQq1dRtA2wKaBsExoyb4hr7XfYy2tXCIa5unnN/TytmRNBT+oOPmbX1IZlaEx15Wo0e
         72ouFZ5RllqFLMT5An+Z1/cUZk8KODroRmwMdqi4hl4eli3/ihgEXpmIjdLa3vSQ9Rx5
         tSi5FGsdZTMDbXI4cmV7Vc1EslIgZXEnnERh0HqbpPztdK+uA7cMtMVXUMna3mY2wWgb
         HKMw==
X-Gm-Message-State: AOAM530QVvybxOYPj8hckbw5m7caV5EOXyKdgZw/jrLcjoB7XVDb6te+
        RKe17grkV+A/s4DbRWL1VWA1yUIOCOUW5zwtFxV/zB+iJCKxMHrEq1o3KYpfyoKNRW3FIacp4zh
        X12W8y0Lu/TnOkBPR586fVQtonQKH+qX2rokhicgejLkMkzDW3/iHKsS6bW45dhowWUVNzGI7TM
        Q=
X-Received: by 2002:adf:a386:: with SMTP id l6mr2089489wrb.505.1639530098456;
        Tue, 14 Dec 2021 17:01:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxES78Ax9TUHORCOd1YZlDTDrPCGFO9Dsc70eF+OA8IpoHaMUvJc5rcfzjDI5GIYaEKUDAXNg==
X-Received: by 2002:adf:a386:: with SMTP id l6mr2089478wrb.505.1639530098233;
        Tue, 14 Dec 2021 17:01:38 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:37 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 56/60] drm/tve200: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 02:00:04 +0100
Message-Id: <20211215010008.2545520-57-javierm@redhat.com>
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

 drivers/gpu/drm/tve200/tve200_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 7fa71c8bb828..afa3a2771650 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -158,6 +158,9 @@ static int tve200_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.33.1

