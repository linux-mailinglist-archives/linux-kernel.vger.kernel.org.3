Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABB8475031
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbhLOBDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239021AbhLOBBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wSvFByRHA7mdMXNWg0+rWl0zHdpArwZl/4sB+8Rm7M=;
        b=HZ+QuUqlSirmsamC1acWFWY1fzX6qV+TATkEWSE5CSHi7v73jAOgbMKlFVZyqfnBx/JJkJ
        NnRjNWt7rdua39Gwl1vgZH8sGSjY7rO0ivkVkd0xR41J7OX9TuUPqyFhZZ1x7SP1kadtKD
        bJjF+kd6+f3tGL1KiN24I2kjrucbsK8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-7NxUu3XIMqGRtWcix_agmA-1; Tue, 14 Dec 2021 20:01:30 -0500
X-MC-Unique: 7NxUu3XIMqGRtWcix_agmA-1
Received: by mail-wr1-f72.google.com with SMTP id k15-20020adfe8cf000000b00198d48342f9so5384075wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wSvFByRHA7mdMXNWg0+rWl0zHdpArwZl/4sB+8Rm7M=;
        b=HT/eVfQdtvRKDQBb5kEDiPut7Wg7ZLiUBAeUzVnnjDuSreLkYKz+0xV5CBLAczjOW9
         P5WQqM0vBdQeHzaADW9CATqbB8N6ji9l4mAADkz56TKnNPymlvIOfOitX7L7/JF2a1O6
         1Q+VwEbk4FMO3trikAbJ2ye4wolQ+Vt2z7D8PjZIoWNKMmqVAUex4481QCgKOlStszdG
         34omDy/bUxAE9Ns1y2/FUFhIXb5gP0CSltu+3MSIGRlBxR4zJPoAAutGIt32AtcTZsXY
         zQNB3khF1Yf1BdAQ8JiRIWPa1Q9uDfrSOAGMC5W1B4xHEcFNMIJOrtdiLQaJST9wSTHM
         LHJA==
X-Gm-Message-State: AOAM532ErSyQTCkLpRc9EzkyzC/W+NoWdQmv7Gxx2O21g9j/dPm0Gi72
        VlkYP8MEPt41KLVzILLhQXRIxnuao1p3+8NY6HyeSqHZdavX8BjJ6uVG6CDKzTeCdUbrxVBoNoJ
        n+C5i8l8vmm+Q9kbUtPSC6pxtToFf1lygmw5++pUlU9lCD5bfI4Aa36lNAZqK8NoPdbFdP3ldq3
        0=
X-Received: by 2002:adf:d18f:: with SMTP id v15mr2111127wrc.447.1639530089561;
        Tue, 14 Dec 2021 17:01:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuCfXaHLyh9K/QHLylx3U3fIkF0HSV1BFRcwBmozG70OTGMjET9bu4twVT9d0H4VhRixbh+Q==
X-Received: by 2002:adf:d18f:: with SMTP id v15mr2111115wrc.447.1639530089377;
        Tue, 14 Dec 2021 17:01:29 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:29 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Alexey Brodkin <abrodkin@synopsys.com>
Subject: [PATCH 45/60] drm/arc: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:53 +0100
Message-Id: <20211215010008.2545520-46-javierm@redhat.com>
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

 drivers/gpu/drm/tiny/arcpgu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index f8531c50a072..9268f37762c8 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -378,6 +378,9 @@ static int arcpgu_probe(struct platform_device *pdev)
 	struct arcpgu_drm_private *arcpgu;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	arcpgu = devm_drm_dev_alloc(&pdev->dev, &arcpgu_drm_driver,
 				    struct arcpgu_drm_private, drm);
 	if (IS_ERR(arcpgu))
-- 
2.33.1

