Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D069475012
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbhLOBCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238872AbhLOBBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4v2Cdkkc86EoGFiSfZtWSuCTFtKbYEs+OLYgRjBvGt8=;
        b=Dobu0khGmgpvyhQvYeaQ4c1gVapeWeWVBySz5MD4M93SB9Q7uoDK9kqgTx1NPZo4mjJ1f2
        2IDxgysu69gCzuD9Cb605hSQcFJB7botQCn5ngUpBe/sg/JHVgq/zTOPYbyTuJnPlT+3jh
        lLmvhZkxWA5hMu7A/ZDWkwDhLyaYets=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-IpeBB37QOTOOLAIPlzOYqg-1; Tue, 14 Dec 2021 20:01:13 -0500
X-MC-Unique: IpeBB37QOTOOLAIPlzOYqg-1
Received: by mail-wr1-f71.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so616719wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4v2Cdkkc86EoGFiSfZtWSuCTFtKbYEs+OLYgRjBvGt8=;
        b=iP5LjqBXponyQi1FJhBH44vi8JgBgOw2sXb58niubT4MQQYqK/BcN3U324oG3jWcyx
         mWzJ0+aS1xH7PrmmSPt7LWsQ7AP+FyBrKL21+N92U6Vb9vuFLHL0Rgm2tSav98h3HKnh
         6HP7BmtbnjMIDblG2o8JSvD6YsDB9TwShspC04wcnGOpC1fpCAaLunVGvQmeWPZexG+/
         R4dwHSqcnUJ85lYfjOukOr4AxvAK6jhsgu+7gCzTB/5yaQdFVzSpnaB3k5zJb6Xetcs1
         269VEKx/cnYFWxbavJ0QQ6HAfTo4Bz4vnIYPo0oKUAFfJRH89phwTO8gpIKS0Tnl8k5P
         Okkw==
X-Gm-Message-State: AOAM533dB3r9FwC5EmZAO7e9+G8PFIYGesoaZFUPBr7H1jJcJmmanZvE
        KatkDP9jbwerVaT2qzvHbzfL88T11OVOS931TS63xbY4qw6eWWz5YGgKuomeX1EQ9d5prP1sw91
        bQ8S/Sx45dMhX3d+Umo60zm400d//exuK9KQUF4o9DoIDD7xzfhNz3dqFQjkWAklK2RGJqI9eNo
        s=
X-Received: by 2002:a05:600c:4fc3:: with SMTP id o3mr2180605wmq.147.1639530071892;
        Tue, 14 Dec 2021 17:01:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRgo4oee72DiQIAzT8vtMRiCvnx6s1mV/IDHw6fAFur1PTySFdTzwVNjAp/rnPgigfO3wCxw==
X-Received: by 2002:a05:600c:4fc3:: with SMTP id o3mr2180582wmq.147.1639530071585;
        Tue, 14 Dec 2021 17:01:11 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:11 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Subject: [PATCH 25/60] drm/msm: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:33 +0100
Message-Id: <20211215010008.2545520-26-javierm@redhat.com>
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

 drivers/gpu/drm/msm/msm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 7936e8d498dd..eb098475224b 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -518,6 +518,9 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	struct msm_mdss *mdss;
 	int ret, i;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ddev = drm_dev_alloc(drv, dev);
 	if (IS_ERR(ddev)) {
 		DRM_DEV_ERROR(dev, "failed to allocate drm_device\n");
-- 
2.33.1

