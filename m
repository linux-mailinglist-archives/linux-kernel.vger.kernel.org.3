Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F29475026
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhLOBDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239060AbhLOBBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIYkHiSTjfhXv2pUWjyeDGgCpLdVz7zm4+9MWiGa2k4=;
        b=JMfUdX7gXLx0fdLtsoeMD/HS7kVQRVgOFdAbixGssNlaIt67ksOBlP2hfzrfWDp6KybFoO
        KtNVnaGZ1IrKT4/MaAo0pFakruCpt1Sf93/2KOfCi61U1ZWIJNZVH5Iy+weuMeCvrwONu/
        aNGHSL3kJCUYu9BH7+Ce+KEX0Nb3Lc4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-VlM2S1stMemPSmVHr11YLQ-1; Tue, 14 Dec 2021 20:01:33 -0500
X-MC-Unique: VlM2S1stMemPSmVHr11YLQ-1
Received: by mail-wm1-f70.google.com with SMTP id 187-20020a1c02c4000000b003335872db8dso11939853wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIYkHiSTjfhXv2pUWjyeDGgCpLdVz7zm4+9MWiGa2k4=;
        b=5nBA5jcFiVBGFRawZPrZJMzkbq0bWaG18Quh6q235gdc4/ofr9sHRX9mmjKkIr9Mh0
         Q6Jr6+YW+ARo1F82AMU975RgAoy1AXxEpawil/6Fx0+SJI+Z8g9bvwCc/+lgyzQEXGNv
         K3CAhIgTJE0EpGiS3SayR083UH+WDEk2Qp8yCiIgnNRDMAS39/u7pD5YEBqF5QhD3aw2
         vgoQlP3ITFScqXsUcOL8Vpmr8k+LYac180nKnBmqVwQc9qEDEaWmplmu9T/81SOX93YO
         WrtE60i7R3Grucu2eLOkh8Pt435rdV02bUoSxBoKRrvNWgq7Ze/iror/MJoc658py7O+
         l+6Q==
X-Gm-Message-State: AOAM5315BFHmhp6rfJFoXtm9LQ1+BnHaxn1o4yTDoYHylmQBVKEfWwri
        q9DoDSflT3LFCJplyQaFLAxFoyS8A1MQK9t/L35TT+oZjlwS7xMr38bOXlUoehqyC/Mtm+0Ye7l
        +qBEgfQsx2istrdWK7yO0K9uY+sx8t/HaemQDf0HZa9VJUzXAu4GpiQRe6cZNM0TXMHsKKD8XH6
        k=
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr2159125wri.153.1639530092010;
        Tue, 14 Dec 2021 17:01:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwy/epZ93yoUm9eoPI9zLu3yNWRqx4ws0GAVPuEp1j1Ipc62W1reNu7+9aTyjB6ATRboMKlAw==
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr2159112wri.153.1639530091764;
        Tue, 14 Dec 2021 17:01:31 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:31 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 48/60] drm/ili9163: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:56 +0100
Message-Id: <20211215010008.2545520-49-javierm@redhat.com>
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

 drivers/gpu/drm/tiny/ili9163.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/ili9163.c b/drivers/gpu/drm/tiny/ili9163.c
index bcc181351236..60afabc6bb35 100644
--- a/drivers/gpu/drm/tiny/ili9163.c
+++ b/drivers/gpu/drm/tiny/ili9163.c
@@ -146,6 +146,9 @@ static int ili9163_probe(struct spi_device *spi)
 	u32 rotation = 0;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	dbidev = devm_drm_dev_alloc(dev, &ili9163_driver,
 				    struct mipi_dbi_dev, drm);
 	if (IS_ERR(dbidev))
-- 
2.33.1

