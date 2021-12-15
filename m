Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8854475005
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhLOBBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238751AbhLOBA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBTKxPeGB31tYrcCVudga0Xd94MnfSm4hqMjeexwQ7g=;
        b=P5WFcZ5JOF+OKOcWSB0ksjYvYeQQtGJKlL8kdfaa+2Aipb7NhcuCLmjHhGHYIgZb08642Y
        CgVJzC/KYx4SIv6fbA5UmB7G6OQo+YxOIe7zNc6ZqBPBeyz6T8PwE1DN5NwfYno1VKP4hM
        8B8nhZLNWguODDfg2hftZUktJTs8cEg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-loB_khSMMXyWoQsee0nO4g-1; Tue, 14 Dec 2021 20:00:58 -0500
X-MC-Unique: loB_khSMMXyWoQsee0nO4g-1
Received: by mail-wr1-f71.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so5368084wro.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBTKxPeGB31tYrcCVudga0Xd94MnfSm4hqMjeexwQ7g=;
        b=UUNhMp7vpwxFCfWDbXVry8h00OpRBfR6kpR88R8oY1KWYvxvHpUIs4XJjEbnLbymvR
         8sf1Y3SKcAN92t3RuXCXxvb0yJbPoT/vtQPWJLjvAglPCuBzGzAMzvHGtUiqAqTVB7Fk
         ZZjJxlNRBLr1t5RIp67TdZxC7xduBt7YY+OfU14Ct41XLt4PqGIBpzlU4FcvLJU55rxc
         S8P3Zq3fSHofxOJFu8fhdz0csnXNgH1Jr4ZOY+0Eew4khQGdg5jIoNi7DhOcfQTJ2QlQ
         Q83hbZSyc8Te3TfhvHxZ35rw/Dt2k4H6b7Zy3W7HxjEmruA7PIT2KXSJPNhBmu4y9r/s
         ZYIA==
X-Gm-Message-State: AOAM53380O7yfrYhdR54GDvKFgttRq/n12SzS2Os0PKnefmPtxJ2d/Ow
        VZCLg45djphMSb8k93kRN35093UAVoMR50hq5ntJ4OjHzfy3acsFBrpMPDfks7rOY/ML7q/cLv/
        Jta+YaqhDV1IaakoVyEAfMM5XRQl/Ey6AEqrF2QI1HDT6GQzJ4EI7Hm42HOUuqkFlFOvGiVASae
        8=
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr1419949wrq.295.1639530056917;
        Tue, 14 Dec 2021 17:00:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyItXA3rJrb3rM7E1UOBx0yrgeihNb1i2VAfL998yRE15d9H9HahBJ3qU8bKTePTqUW7O/9TA==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr1419939wrq.295.1639530056729;
        Tue, 14 Dec 2021 17:00:56 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:56 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 08/60] drm/exynos: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:16 +0100
Message-Id: <20211215010008.2545520-9-javierm@redhat.com>
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

 drivers/gpu/drm/exynos/exynos_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index d8f1cf4d6b69..f9f10413a4f2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -464,6 +464,9 @@ static int exynos_drm_init(void)
 {
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = exynos_drm_register_devices();
 	if (ret)
 		return ret;
-- 
2.33.1

