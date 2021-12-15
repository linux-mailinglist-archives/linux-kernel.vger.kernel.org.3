Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECDD475030
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbhLOBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239084AbhLOBBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOtZ+bYPZ85Ndp3GY6tG92tfrUooMt4dIjEoAv+Ez9E=;
        b=MX4PxgAJs346UbAGT7LHRHXCpH/g4h5o4857sUgy1gmfpGyJ8qjgRNOW63Ayj1zgmp/OFN
        JEnX+hgk+Ay/bnFwNJfWF1NFDwNIR6hEcFxF+EO/QOzypjoH9wznZ7b/Wxi/w9kEge7AZ5
        ZZdMv0B0ap+sMAVagNBWdZQHgp0dk1U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-nHXbAneRMhebhaujKKF0QQ-1; Tue, 14 Dec 2021 20:01:34 -0500
X-MC-Unique: nHXbAneRMhebhaujKKF0QQ-1
Received: by mail-wm1-f72.google.com with SMTP id l34-20020a05600c1d2200b00344d34754e4so1155160wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOtZ+bYPZ85Ndp3GY6tG92tfrUooMt4dIjEoAv+Ez9E=;
        b=S0RNVcp4ZI+tv8kvWxx6ATHcmQ8hV8YcI4Oiwzf3R1PDgRVCPSEZ+V4Jo5dsO7hMmw
         DPft6AXOP+4p3CG2GUY9OeK6ocpkTWfdYshgEZdP2J6vUMdhnTgC1ybY10jnGsljI2BX
         AdB6AtXocm7rtGdfr4MR1wYPAi7BEFQ4dnLQ4LQ1JsTHJga3SBbbHwn/bIjG0WayZqcU
         o2RAusGkCEBCJqCSEsRIgNDkXduU5AvOyk8bxs7BM1cKQPBR9tNl5LpjlXLs6Q6hrfcl
         KBuuFSFl+Bclsc/46cWNKF/IJO179MfLX9ikdRdafoyP9GUozt7SdqYjrQE4PAHhdTLg
         0vjw==
X-Gm-Message-State: AOAM533GSWLT1Ia1ensO/ZDpIQ2d15ZRhCsztbPax8WLqRjVKZ+uLB3V
        L9WtfDGCBiGlOt7cyMlkBdLWIZRD5/LSLT0o3+0J1FW0Nfz8d9cIE2gyo/7s+xlZrRoElFO/xMa
        63cLIM13NhUyOb4r8d8pVAMNBxFrEU1jM9r3oqaPBGjkJnnpQClz186YuzOPNKiWOEzwrWQmUD4
        4=
X-Received: by 2002:a1c:8015:: with SMTP id b21mr2303289wmd.161.1639530092779;
        Tue, 14 Dec 2021 17:01:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzveMGrtxph4ddQdlxUDnyj51OmE02XvM99tsD2+tFvlfaGlDPT926wMkCcW/6wT3QYGuYXxQ==
X-Received: by 2002:a1c:8015:: with SMTP id b21mr2303272wmd.161.1639530092549;
        Tue, 14 Dec 2021 17:01:32 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:32 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Lechner <david@lechnology.com>
Subject: [PATCH 49/60] drm/ili9225: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:57 +0100
Message-Id: <20211215010008.2545520-50-javierm@redhat.com>
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

 drivers/gpu/drm/tiny/ili9225.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
index 976d3209f164..1d193c534318 100644
--- a/drivers/gpu/drm/tiny/ili9225.c
+++ b/drivers/gpu/drm/tiny/ili9225.c
@@ -369,6 +369,9 @@ static int ili9225_probe(struct spi_device *spi)
 	u32 rotation = 0;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	dbidev = devm_drm_dev_alloc(dev, &ili9225_driver,
 				    struct mipi_dbi_dev, drm);
 	if (IS_ERR(dbidev))
-- 
2.33.1

