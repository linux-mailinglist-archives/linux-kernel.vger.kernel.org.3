Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567ED47501D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbhLOBCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238947AbhLOBBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0Qeg1XtrmMJ6I9FESbbvredwBDg/CTYfsGnS4MCcCE=;
        b=RVOmt5da3ryl46+H7ljFXhBQY5WUaDnj5RdyakLg+zmxJa7cGvZbtbB4qg5f8UHS73o/Mm
        Iojjydofd5IALnj7kRCRAheqZw760gGPDr7kBE8BgLEMw/3F4J6bhtk6tJw+KhDQYbG5xT
        Vqpq3AQF5Cg4h6ach0aq1btlQLM0so4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-_Sh6B1JkMUiE-7MnPitGag-1; Tue, 14 Dec 2021 20:01:22 -0500
X-MC-Unique: _Sh6B1JkMUiE-7MnPitGag-1
Received: by mail-wr1-f70.google.com with SMTP id h7-20020adfaa87000000b001885269a937so5416370wrc.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0Qeg1XtrmMJ6I9FESbbvredwBDg/CTYfsGnS4MCcCE=;
        b=jZFfgNHeKyqIP1Neh76qhK60qdhf4qisUOI22DnBmEFySm/otNEKoVKZ2GhMdxFRsI
         r+zHAw+so05XgStkmS3AhLNeU2bD/P/BiMrX5LYzMpX9Gc3Q//7ddc/Cxnl/ugSKe2Hk
         oXyy8WCiiXVv9Cwe+Y1iT4yfjOFs6vZ/28bBHnv8aZSUSH6g1mdfZM+1uQDGlci3aSOP
         w8PGCl0FpNM8lzOKSE77wfGvDiQfap90LrWQ9T7kAJX2G46T1pHe+PQEQawtQ5hWiflu
         2xH69ebi22IkKMxYU7+YQJvVd35CwKrH4H7hWNg5axYTPwH4Wu6y48Ou04C2U+TqKYso
         Vlag==
X-Gm-Message-State: AOAM531W/3vlihqS/CpAejQeKl9NTKn4EUkLg0ISEU2ik1csaCvFOw9l
        /W8yDxXVTUUfLVS7iyDw8yMW6aD8okkwz0UKgt74mfa4Bp2TJ9ewkZUdxACgl2wbZnFFmxsco+l
        6Nz2bVfIpXNzuqzC4R2i1nrnxS8sK5vX4Vf/IB/ZOED60FYwiVgDOUOAtZKmvpTx1vWPtDg6F3A
        4=
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr2288766wmq.122.1639530080762;
        Tue, 14 Dec 2021 17:01:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0M50lbmTt43Xk8dBfnzkCOnU7EwfJT3eiU1UsVtqhjtvQH7uYilHF22Y5O3T2RfEMLnQ4fQ==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr2288752wmq.122.1639530080544;
        Tue, 14 Dec 2021 17:01:20 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:20 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 35/60] drm/shmobile: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:43 +0100
Message-Id: <20211215010008.2545520-36-javierm@redhat.com>
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

 drivers/gpu/drm/shmobile/shmob_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
index 80078a9fd7f6..7011c659a921 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
@@ -195,6 +195,9 @@ static int shmob_drm_probe(struct platform_device *pdev)
 	unsigned int i;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "no platform data\n");
 		return -EINVAL;
-- 
2.33.1

