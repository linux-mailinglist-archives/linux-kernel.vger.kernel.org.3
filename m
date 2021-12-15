Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A65947500F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbhLOBCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238799AbhLOBBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZKbEfyLV70l6XiSNVJ5RXCznhS05ggY7V8bDfhnT+U=;
        b=c2RXDEIULJpDKhti0ATM1crzo5subaU3S/T5kBLzRMxSJNCUVVkR1gj9h43bH/Y5zA7r7u
        fvvo36L8uC/SluOojQFBSQOL0tVwR6MUhWQ7w+zFGnfyjs3TVW+LelZ1uPoUbRq2ydubXF
        6mJk49XJxBrxXYGMW88fXYzTsNpQFCM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-y1RFg4H9OZWoe8LS1Lpt8A-1; Tue, 14 Dec 2021 20:01:08 -0500
X-MC-Unique: y1RFg4H9OZWoe8LS1Lpt8A-1
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so13897831wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZKbEfyLV70l6XiSNVJ5RXCznhS05ggY7V8bDfhnT+U=;
        b=qa3pEsQ05nSnSdOtNOZCec/epRSP7ahEqcxh0w6MTg5Ge4SO+5y3vhjHbnCEWHdsfL
         ItABuOTCiX++Aa0wJXkgiHdx6esRqy8zi5wwyQCLlTRi3aJNqCNLdVv9viVgLA8yOpAK
         ffJXq6WG/8yAyJmVUU7R+LXJ9Fz+JSMGAIZLGgkFcpFvw9GMhF3y5iFNy4o3qbm+dLTG
         HAZrMelPFJecYcAyruNLwOOgcZdgpByC6R5T32ZZ+czp/tfuOUR2uQlS0vAlp3vuX9Hi
         0F5i1msDy78zeyO9nf3CX7QkPmvWyQd42BQL0xXDCxP8NNaZAa+64avdsHhjsDND/iH+
         aW5g==
X-Gm-Message-State: AOAM5305zp1Nt0iLM/+Dah/PhHd5TlxQ1KMP4Gp3KwuSDmUdrIoDOzhU
        dlDf1IxA9HhKKRBHGSkLauhaAIUQeP4QOI1PvlCTBeSjk6ZN2tDxzs5jJ6jHx3fqS3NbPKK8R29
        iCSJ5fsIHMpfZ2BnNwGy6hC69r4Kz75Sxf0Le5Ne4o+xRLzKShUzhiNJ6JEfFu9Uh7G2bGunXFX
        I=
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr2041687wrw.591.1639530067447;
        Tue, 14 Dec 2021 17:01:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2OvVWw70d1Jz0nZ4EGB9SbUm1hrYOQZ8cVF6w98rG3WU5PwqQdwByDZI0o1AXmNIhJldlAg==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr2041675wrw.591.1639530067193;
        Tue, 14 Dec 2021 17:01:07 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:06 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 20/60] drm/lima: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:28 +0100
Message-Id: <20211215010008.2545520-21-javierm@redhat.com>
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

 drivers/gpu/drm/lima/lima_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 7b8d7178d09a..9255073162db 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -375,6 +375,9 @@ static int lima_pdev_probe(struct platform_device *pdev)
 	struct drm_device *ddev;
 	int err;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	err = lima_sched_slab_init();
 	if (err)
 		return err;
-- 
2.33.1

