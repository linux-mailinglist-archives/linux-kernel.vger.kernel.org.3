Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA447819F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhLQAjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231214AbhLQAi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wjBFg3uca0hr/RF0/NYN8McW8siJPGtew7BDMoZLdbk=;
        b=amFO0a4i++OStgqMJjKMP1g9ZsDmZhVCFkeQMgW4VleR+zwMOow+WcSNyCzRp/c5OjYDt6
        u6/FlCcQygp215snYL0DxfagJrgqKr4Fy6WNdChMRetkqGuqBlopfdkIZCYele69wT6MZq
        v6VIaHlya5cpcpUq7C0xKdc3SkBY7dw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-3yBJ9qbkNMObj1T70K_08w-1; Thu, 16 Dec 2021 19:38:27 -0500
X-MC-Unique: 3yBJ9qbkNMObj1T70K_08w-1
Received: by mail-wr1-f72.google.com with SMTP id l13-20020adfbd8d000000b001a23a990dbfso148216wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjBFg3uca0hr/RF0/NYN8McW8siJPGtew7BDMoZLdbk=;
        b=TN//1Y74sT7HauDnOOGAxhXzcCRdYFTXP9656g4LHR5BNp1YRUdBfiFKUL78mXFlbI
         X7HDptGMtiId43z193GvHbR5XB3WY7ngb6UCvttIsOWNnFu8VcD82azzZmUgqjxUtm9B
         VdNZNLG+8Yz7maQNlbTbQgcVRg8i70KLbPij0ww7/o9dn0zGU0QQaPjvcJSwsqJFyNlN
         uHJGSsrRzmklt1qWnUNWbNwdE66PXQxVa5YF6bPsMcF7Oq3XL4CuffW+m0ykKIVROZSl
         zyJL9/CSac9b/u2PRiR5bioA27e6xKvHSlUkPPfYUn2f/W0Isw03FZvXfCwILeCRRqNG
         bp/g==
X-Gm-Message-State: AOAM533kfuvMAgPlFGxo8F8Q6hvd2VC6lE4O1YClfrHlJPSg46i/wRCL
        yjVry+IVkcUd7sKCrjEX/HF3c3LRWjWc521X8tMcCaBIUe1BuJLNWzVR2QIuPWhlIO4fayJghe9
        7Pu60UIo76DN/HCSslNP8e+W5BS+Ck/LzOtf9Fl1+GDp2gfLUV8AqwMisd/mYVbTfrgYOv7OauM
        g=
X-Received: by 2002:a5d:648d:: with SMTP id o13mr349931wri.637.1639701506712;
        Thu, 16 Dec 2021 16:38:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeyzKTq5rHZsrWQHaePARPuD9O79wGdBTrc7g9E10h/hppontDey+ouzFKQJLSf7A4vCd2XQ==
X-Received: by 2002:a5d:648d:: with SMTP id o13mr349917wri.637.1639701506497;
        Thu, 16 Dec 2021 16:38:26 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:26 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Subject: [PATCH v2 29/37] drm/msm: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:44 +0100
Message-Id: <20211217003752.3946210-30-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/msm/msm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 892c04365239..8f30e68ae3b5 100644
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

