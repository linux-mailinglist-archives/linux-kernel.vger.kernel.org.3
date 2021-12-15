Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C74474FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbhLOBBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238706AbhLOBAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNRehPRvqbAz7jorwIu4ovYv1EOIx2oHB4aS1f6MxEE=;
        b=XZkNV/kafrMSwj4ps1DQfa7YZvUvDqXwI1oxklorXoC9EoW172TpKXyoRAT5HGGIRkT+ze
        Bi4vt1gU9zqUQA264KJTuvZmjZIrmLV7dFNbXlByozTu8QDf2yWGlAoqGCfd3v5Kh+t2bg
        7Lmpe3wTlYhScVpTzqTg0zW6YaN5mlE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-Iw9Y9wsRMRaHZ9Z3RFjoxw-1; Tue, 14 Dec 2021 20:00:53 -0500
X-MC-Unique: Iw9Y9wsRMRaHZ9Z3RFjoxw-1
Received: by mail-wr1-f72.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso5374670wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNRehPRvqbAz7jorwIu4ovYv1EOIx2oHB4aS1f6MxEE=;
        b=eP56B1rXCjDVG1xbd8cBYki4+QeQ1ucd6TQTdqzVenr/iLobP4g9tgSd65lc/ISs1y
         mcaaSQXHCf/Mm3DxN0V2wIUg92+v+1D9vvRpCC/VNniRH5JY4uj9Lss13MpGyOYIqtkZ
         yCwXP2lJ3jRwPwV436nqiZG9F10L6DyJWXeNtlEJbjRo1SSFv9TdrFIK7ZeDxjNgPG/3
         i0ag2CMOu7oA6g63TyQugDrgzH56Ge8oCB9rgWxb7tpctgJCXXqHOZ48zzgp3fh74jOr
         n7pKZ2QVPLeiUGuuAMzYmpkOjwofuTj8i+O8OIRRJIddMvTKBAG1Yuz1hywPltRTGGU8
         A7Jw==
X-Gm-Message-State: AOAM530b7It6AZGb6FfdPGm/GEaSo23u9LSfzAyNAzVptsh4RpssPlBl
        flvzZ6Jj5NmBzh4PV5puvCJJMz4WMeWFxdksDgW1UcwYJXAp8pfNnZPmEydPtWoMmvkXtdOmRHi
        5Mh+X9dcGEI8thKw9jHGpbkh/L6N/aSEs09cIGjHTpqiBEWfnIEo3Pv92f4DMQt745xnRDsDLMV
        g=
X-Received: by 2002:adf:fc83:: with SMTP id g3mr2136113wrr.255.1639530052441;
        Tue, 14 Dec 2021 17:00:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQGzn5u1nUIMfMkZ/o2AJOuWVcRC6vL1ASLIqC9o5/dw9qAm/FfLvnARA79g0K7ZXGpeMHQQ==
X-Received: by 2002:adf:fc83:: with SMTP id g3mr2136094wrr.255.1639530052195;
        Tue, 14 Dec 2021 17:00:52 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:51 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH 03/60] drm/malidp: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:11 +0100
Message-Id: <20211215010008.2545520-4-javierm@redhat.com>
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

 drivers/gpu/drm/arm/malidp_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 78d15b04b105..5da4168eb76d 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -938,6 +938,9 @@ static int malidp_platform_probe(struct platform_device *pdev)
 	struct device_node *port;
 	struct component_match *match = NULL;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
-- 
2.33.1

