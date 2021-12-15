Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45D8475008
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbhLOBB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238780AbhLOBBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+msvf+qowHp1HRo12KuePWcAeO9dq4LBkUMGYiKJfs=;
        b=DQNW7v/D0ZyoyD3sxzJNWWg17x+KYDoWm8d208QRV+Pb0ma0XpzXBHLpcUQ3mEVDeUdIVG
        umBIfkkFiBMWS+Ggc46croah5k/e7GFYmIYyJzIaUJSJLwKbnH5vw2uxHTEj2JS9B8SfP6
        O0VB/luNOr3rgPHiFVuLinmegZ8WMvY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-Xm2O_k5lPAqfUBZlDG2sew-1; Tue, 14 Dec 2021 20:01:04 -0500
X-MC-Unique: Xm2O_k5lPAqfUBZlDG2sew-1
Received: by mail-wm1-f71.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso11911658wmd.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+msvf+qowHp1HRo12KuePWcAeO9dq4LBkUMGYiKJfs=;
        b=q294T+P7u5zyEFhLjAJjCGU/o61gvXGuTrdi3svcNe0zof5OQyVAPQY/e31sFYXE2x
         tVYb+5am50m/TX8RkVL5oFlEsG4V3+M9XoT56HW+F/D9YvNINuWpnNohLPshGKnw+HTe
         fmB7Bil52QGPjR9t93IaFH6cv8+RlZq/9B0wYtxaMoryXn8frrG9QbfNee+85u1PlJQI
         NDEMb5c/vSaJTBH6f8+8t1yW6CObevNRmNPHnZjIJAyX0N9rlvZEHgVLPocQXf5b1pk6
         QjfwcxZiTtOliF+kY9AR0a6J7DYpt+KHlpfTBd2ZyFvmlVDlrMRxZGlRVMiCKdvlordT
         rAPA==
X-Gm-Message-State: AOAM532B9mP9BZhjU5ZcjmmFibM+S6A+ZDWHMwe7Cv2yKy+V49NxkIxx
        +o3Y1dqrOcj8Sp+HevwO/mwhcxDL/Mg0oYmo5WYGCAOK6V09q6l049pXxAAcV5dNQu3HepybP3M
        D/yrB2uaCwjoO4xU1IuveVcVIGQHjdfrIqEoKu2p5BM5vhnfGDtcwOa5Wx4qwWlCQszaZe9g429
        s=
X-Received: by 2002:adf:c146:: with SMTP id w6mr2172872wre.541.1639530060242;
        Tue, 14 Dec 2021 17:01:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQIMVv6PwVt+SrjSfagS0OVwceAnaI9S7mGufWHm1b01W94NLSkOh0t/pBQ2zxQOuEt/WFYQ==
X-Received: by 2002:adf:c146:: with SMTP id w6mr2172856wre.541.1639530059982;
        Tue, 14 Dec 2021 17:00:59 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:59 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Xinliang Liu <xinliang.liu@linaro.org>
Subject: [PATCH 12/60] drm/hisilicon/hibmc: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:20 +0100
Message-Id: <20211215010008.2545520-13-javierm@redhat.com>
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
Patch-cc:Tian Tao <tiantao6@hisilicon.com>
---

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 610fc8e135f9..f66de93831c6 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -315,6 +315,9 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 	struct drm_device *dev;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &hibmc_driver);
 	if (ret)
 		return ret;
-- 
2.33.1

