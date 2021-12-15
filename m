Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F82475038
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbhLOBDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239124AbhLOBBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MqjWG1xfqU7ex1w07duXfO7CAxtpTTEsAHmOGPxr88=;
        b=VZC9QVWtDlb+ppa0TdWvsZssFKb7ySKKv0zKf9NtVSXH/NUvm92yhY7C0fVkHpDBoe2Urq
        25CbkZ3c0MDuNBFf4Ur1J5PWQo8kK/gSxgzjq/1sNWuA1svoW7dZn/5XwaMOgNPBJ3CUcB
        MmCtNT1wvnyd3QAY2BwazK9oKHqaB9o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-fSPV4YV1PrmNg13bPHuDXg-1; Tue, 14 Dec 2021 20:01:38 -0500
X-MC-Unique: fSPV4YV1PrmNg13bPHuDXg-1
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so13898364wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MqjWG1xfqU7ex1w07duXfO7CAxtpTTEsAHmOGPxr88=;
        b=M9g0yYnqi7y0gb6iTBAMKxLtJdqgqNIUAkyZ7u5zhw/0DxWInSqzHMffPa0WFqLVXs
         S/KLig1ME8UQgWGlBy7geDRlDwGbbHS62hdMbRCy88TWwZohR1a20q/vBKMAagRN2qgA
         1JGC+S3G6DX7cpR0aOHawG8rK0aCEfyprwiT0xyv0diRGHT8s8X6lxc1Ub4wA1b1Jy6M
         SL2AX3CKIwOhsRoVxqPyge687wfqEB21+Fh+EwP0+Eq3GWdj7b1dHV3tBOIcDIbAON2K
         bWxBHHvDuw9FuEzsI39YP/3fezFWzGYTuokAN+jnKF17xgwBjeA7HLapoBlNfXKfGxG/
         3n4w==
X-Gm-Message-State: AOAM531FDCohFw9ZWI7U4j2VlRBMuZO9KyZuDJzZGYVxr9fTFcZ8ZDFL
        c2TwU5V0X/jOL0mtnP4YCydvZV3a5zwephPbxkKvCj+bHRTqSjCa1UkHiMBdO2W+4/fJVcClgei
        0Dwu0F2b6N6/ZeTDMY94FEOa82SC62+ZFlgMuleSoX3T8IN8RUOXxhshMzNevzIinHfxTPDOoBH
        U=
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr2269520wmq.120.1639530097669;
        Tue, 14 Dec 2021 17:01:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCl+Ug9yU5uFjldGykl05Hl7w6RRr/ctye85ysOcS+o7yaZs9fd51nyFO6kfPtOoS57jVVNQ==
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr2269509wmq.120.1639530097440;
        Tue, 14 Dec 2021 17:01:37 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:37 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Lechner <david@lechnology.com>
Subject: [PATCH 55/60] drm/st7735r: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 02:00:03 +0100
Message-Id: <20211215010008.2545520-56-javierm@redhat.com>
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

 drivers/gpu/drm/tiny/st7735r.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/st7735r.c b/drivers/gpu/drm/tiny/st7735r.c
index fc40dd10efa8..841ec1c7bb93 100644
--- a/drivers/gpu/drm/tiny/st7735r.c
+++ b/drivers/gpu/drm/tiny/st7735r.c
@@ -190,6 +190,9 @@ static int st7735r_probe(struct spi_device *spi)
 	u32 rotation = 0;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	cfg = device_get_match_data(&spi->dev);
 	if (!cfg)
 		cfg = (void *)spi_get_device_id(spi)->driver_data;
-- 
2.33.1

