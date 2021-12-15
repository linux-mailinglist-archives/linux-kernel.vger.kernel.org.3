Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B304475039
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhLOBDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239114AbhLOBBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXP/22XWDeSSfWdh8ZJFPAZdI4OlCsRGMDp7gB3zWDg=;
        b=jQ4tZ655kP2hpn68osO4IQriYxaA8rAEvavUSWCzrVV7MmZ2KLTq/LGCOpaXT1R5btkgCS
        i+HYzS9XPW33UYzsl5WFZzuPIbMS5yBTvfJOuYpejl+s7wirow/55OUNaAJJkV7yroQrkr
        c1OTtMIB5drIgG94AnUBhbH8uDx2yyw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-LpTr2L3QMhmv9DZX5OxLjg-1; Tue, 14 Dec 2021 20:01:38 -0500
X-MC-Unique: LpTr2L3QMhmv9DZX5OxLjg-1
Received: by mail-wr1-f70.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so617233wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXP/22XWDeSSfWdh8ZJFPAZdI4OlCsRGMDp7gB3zWDg=;
        b=LfYvBQlN4SJXvTOkqnyD+DWkqGXGeqjznEx4kFNqgj8h81hxzI/0F5eb88FdlTVpvW
         /Lf6iEDLeo1fEI9ZCiEMeO/2d+A9ESi53xajY3ocqTndmD7vICC1Qj0GcZ0Fx8fVk583
         10+xRTPSnwOnn4sJc3je0ts+oedvapBO4v6ruHVRPJ2jqomf2uDM5HNpKJ5m8cePqdMu
         oqWJdnfQ6qI12kC/tFdE9jGRfQj1JKeZ3k5dysNfEOJ5sG19Lu8VSrfpC35XMbwO2irC
         BRmiaMToTFxLOEkvIOmZe+sLGQeU7i0qFljwtL1s36pcWml0C77FkVyW74xftK8gpQUR
         ZPiA==
X-Gm-Message-State: AOAM532YrzOh+phhAgiOg2o+sJhCJ9qiwfyhUzUIntMfEyXYQzXNVtt/
        guScB/5dJHXTOjYQyre8XQcyKqTVkPLE2CI1LQXVbKkeHv9MDWu0/ML9BpmH9qXpSZ0EisREtEX
        Eg/rDdzkXJCFof3JXoaE1kMc1KAp59MsSGB0vb8NlADq5AS73SDfayFVB40ntklW/JP7zOIBdyJ
        A=
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr2219266wri.31.1639530096886;
        Tue, 14 Dec 2021 17:01:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2Y3r7Wrxo2s6F9TQGT0dP872Q0+eYRFhRtYHasJ27MOIxQF8D02kzkkE7A14By/sQgvIN1w==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr2219252wri.31.1639530096667;
        Tue, 14 Dec 2021 17:01:36 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:36 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Lechner <david@lechnology.com>
Subject: [PATCH 54/60] drm/st7586: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 02:00:02 +0100
Message-Id: <20211215010008.2545520-55-javierm@redhat.com>
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

 drivers/gpu/drm/tiny/st7586.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/st7586.c b/drivers/gpu/drm/tiny/st7586.c
index 51b9b9fb3ead..55bf695861c7 100644
--- a/drivers/gpu/drm/tiny/st7586.c
+++ b/drivers/gpu/drm/tiny/st7586.c
@@ -305,6 +305,9 @@ static int st7586_probe(struct spi_device *spi)
 	size_t bufsize;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	dbidev = devm_drm_dev_alloc(dev, &st7586_driver,
 				    struct mipi_dbi_dev, drm);
 	if (IS_ERR(dbidev))
-- 
2.33.1

