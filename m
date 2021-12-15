Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8825E475023
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhLOBCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235223AbhLOBBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65UeodCdnbzrvXZ2QT+8bG67UPU5yAEJBkFAzKsuJLI=;
        b=MkK4S2X9S4sINQAwXupBhcpU/+3Nm49s2nXr8Ny2XI8LT5ZafBSz8Tl83KOxRy/i4gSW0t
        bLQHo3Z0zbdXFGRxviPLYme6vmlHSBVKIY3gSSULJBSMUJx5mR/7EQH5fpPii4Kvy/dbfc
        +fSGASpv8XceF2ZrTtqxMwJKhmjZwB0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-tROPK4ZpNPSFdSg8VzsRTg-1; Tue, 14 Dec 2021 20:01:28 -0500
X-MC-Unique: tROPK4ZpNPSFdSg8VzsRTg-1
Received: by mail-wr1-f71.google.com with SMTP id d3-20020adfa343000000b0018ed6dd4629so5379088wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65UeodCdnbzrvXZ2QT+8bG67UPU5yAEJBkFAzKsuJLI=;
        b=i8Qv/3XuSYRrTCfc7DY3MR7/4rqIs1zuDcjur4zbAsaWeRkhyCsH2LKDecuYMdiRvQ
         YE4VY35Y0Z6KccHy+x88FndA4kkrV5ChOm3P6/+IiDpXYqKRskchpqKZXtsEYyijP7Uz
         VpHozwHv6aSYWzBEqvhExKfNy3XqGd9EGBnhOeDShX2hozJGjz1PQYoNs1Rz62J8XI0y
         2qmwYsekQ8NbjThgMEQXnuIw5u/uoObM7rmAHiqi10a966pkK5oFhyc6mHZN5MDNmDvJ
         J8/Uto9NXUrZFzZsba156f+Mcq2Ly/AWL+tUunSankkGL3zzirWXNLihAZAl00kf/SgW
         c4PQ==
X-Gm-Message-State: AOAM531fAmimMhIOZOQTKka0Mo1SHm71tVT9CzySdZEYNXGMmQLM7fp3
        a0imdhuCEmiDwMv1CBgHbuUurVg/Rms+h/AoPQ/aAEmYUkKaJvCmfXHovSJ3DXqiQH5DzfT/W9p
        jGmf0hCglnUFWGG+HzVd8Nb5TKmQ83uwz64jnF7H1afQuLIPhPSpsc7Na7jyX0Wz8ziSuEDEWef
        8=
X-Received: by 2002:a05:600c:3505:: with SMTP id h5mr2414494wmq.22.1639530086324;
        Tue, 14 Dec 2021 17:01:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzA43rTPiBgr4JWptMpZJQkcZxYc3fV7j9EkNvVTW3WS0T0i+Aaq2nD8sJghIjjakqEUKoQ+g==
X-Received: by 2002:a05:600c:3505:: with SMTP id h5mr2414483wmq.22.1639530086058;
        Tue, 14 Dec 2021 17:01:26 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 41/60] drm/tdfx: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:49 +0100
Message-Id: <20211215010008.2545520-42-javierm@redhat.com>
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

 drivers/gpu/drm/tdfx/tdfx_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tdfx/tdfx_drv.c b/drivers/gpu/drm/tdfx/tdfx_drv.c
index 58c185c299f4..d0ae79ad437f 100644
--- a/drivers/gpu/drm/tdfx/tdfx_drv.c
+++ b/drivers/gpu/drm/tdfx/tdfx_drv.c
@@ -74,6 +74,9 @@ static struct pci_driver tdfx_pci_driver = {
 
 static int __init tdfx_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	return drm_legacy_pci_init(&driver, &tdfx_pci_driver);
 }
 
-- 
2.33.1

