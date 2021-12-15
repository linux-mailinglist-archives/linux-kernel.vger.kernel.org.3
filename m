Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21D5475034
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbhLOBD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238749AbhLOBBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1f6yN37uKB7QatPNWpagTQrFh5Rh8VmN4GeGpHQpF0s=;
        b=UxRetGIewzWZ/UmbxbfYm24npqWUC699C6+yr1aA0rS5r1cf65a9NF3rfT+2QY/opkFNaT
        0NxoWEUxXrSLxFX24xF5Hy54QLqWw/cJm80MhJD45joEvyPUpqlsYxU+QARZQI0X+J6IXB
        XG9/BHyy2HmTnGT+ArTZf3uVLw1gybI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-IyI5IsYUOAusGngoT_Bsww-1; Tue, 14 Dec 2021 20:01:42 -0500
X-MC-Unique: IyI5IsYUOAusGngoT_Bsww-1
Received: by mail-wr1-f72.google.com with SMTP id o4-20020adfca04000000b0018f07ad171aso5388832wrh.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1f6yN37uKB7QatPNWpagTQrFh5Rh8VmN4GeGpHQpF0s=;
        b=uS1Jp/SALhwYZEaYgbGNlSLSb6eRP9cBs61wcmBUUXpRz0pVtc49FPIDsXAv420lr7
         59UzfVSsTPqm79ttwRl+0WyC0tKO1w0y0zbv5bwm+YKLvX7BPpNFj8YoDkRvy7mavPGe
         M0PX0hpHKf5/UXP2+b+md44ujqhqJxObRIhQ0+K23S86E+l4Txu/XNViv1Pw/zeRftfO
         jlZUMmsL8P7PnSbfKD4wO32JU8JCWcEOOvgVU5SLHTQuc8iQVEEQ4Vi3/X/O/L1PfbFK
         DOnwBQNGuQ2sZzb8HVGYTx2EQGYWoME+mSvACmEuY1PK2c61WW7L2+hI8sf6JTvNHPdY
         dtOA==
X-Gm-Message-State: AOAM533/bccpstQ2TBOVioNTQkQX7rjGb+Xs1OMGoiedfucpTaPHyp3m
        RUfLJDLkdPzveg/MAO1xzWGP/YccN8I7TgpkIwn6y0liwLk6RYZaddMyFKqSFaf2SmVZWHAl2X6
        i0PQlyRplCeCuiqeGW0UqL8JZ+y/pQG5xhjEGsRVaTv3GnzdHw6qElCOzyycVrxKS55OqvQ6aQI
        4=
X-Received: by 2002:a5d:5850:: with SMTP id i16mr2170317wrf.410.1639530101285;
        Tue, 14 Dec 2021 17:01:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7Pvcx740finhdlcrOo87Ams6/Q7ECZPB0YrWL/BMTa1OCBtHloVTPPpTU0kUuAQ6A/3Fibg==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr2170301wrf.410.1639530101097;
        Tue, 14 Dec 2021 17:01:41 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:40 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 60/60] drm/xlnx: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 02:00:08 +0100
Message-Id: <20211215010008.2545520-61-javierm@redhat.com>
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

 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index ac37053412a1..cca55b8a8cf1 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -191,6 +191,9 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	struct zynqmp_dpsub *dpsub;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	/* Allocate private data. */
 	dpsub = devm_drm_dev_alloc(&pdev->dev, &zynqmp_dpsub_drm_driver,
 				   struct zynqmp_dpsub, drm);
-- 
2.33.1

