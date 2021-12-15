Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9381747503C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhLOBDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239102AbhLOBBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaOcQFceqoFhjW3mPUFT3x9iy33WyNhYEbrViQakyfg=;
        b=VIHCOVzts8awTXY0UNQRmdbwcfxTUAgag9jiFPUNHN6QmtMQ/17DAYVKoA+rPr2XPC4+0L
        D3H8NGqKNNcnrimEOAfG3VBn+C6qS8CHqsXXWYoznxv0frY0dE/V31VZlN0gE25uoNuPZN
        X+oPqWOFUiNVLAeklub+GajmVhJ8rrQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-wPpdAXzDOR28DnTazRNnkw-1; Tue, 14 Dec 2021 20:01:35 -0500
X-MC-Unique: wPpdAXzDOR28DnTazRNnkw-1
Received: by mail-wr1-f69.google.com with SMTP id h7-20020adfaa87000000b001885269a937so5416635wrc.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaOcQFceqoFhjW3mPUFT3x9iy33WyNhYEbrViQakyfg=;
        b=ZNzOkdNw/xWBMAqGW1ZU7faWNzYtfa66eOjY7IXY7s60R5TvUUwGVwofLYRIuK54f4
         D4iB1dgK7xDGZYAP8aYMBxraIu0Tm8ixIjj2Z5imGOXn5NacLgetC61KgZk3CUImZ9LJ
         T8+gVunvZiahBBTqzpRIRh90miaDaOB4O3IxfWXQxCxawdYHOhIC6WhQS/JDdjLRC4yY
         ++Ufx4n4bjzwH2t79RjYvHF7DhQ9utyJK3Ww5TteR1+frMeLdrWaVe1WQDYIS0zBQOIh
         lS1BxiY1NJjxuUmwjTqnpRZDvtmrROk7v/Eayg01Xg8Go/TylCI3i+sjIxe9yoN9Kini
         rVSA==
X-Gm-Message-State: AOAM532DNfX2wdQDUOV7JPk1kBJfUFasHf1J/aP59wmMwO+b+WX5iKen
        ZFxHm50v7QGQ4xGBh0W5clLPtYT0zjFXQdMoQ8473IVqJQQU9nZ6B11a9i0RBpYzkuVEGUIs0IR
        H98dquxtiatxKg8IbOpwH8JOOqdP0s2sRHzjXkGuH0tOxQdQINc9izzGLIDzE45e1raE5fz9QRM
        s=
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr2042861wrw.591.1639530094371;
        Tue, 14 Dec 2021 17:01:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwi4UYgQtki5bNwT8+AkNXkDy6aOra2gVR5vfoINAlB7OnscPSeivm7KWqYB6rmeeIF4sb06g==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr2042852wrw.591.1639530094176;
        Tue, 14 Dec 2021 17:01:34 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:33 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Subject: [PATCH 51/60] drm/ili9486: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:59 +0100
Message-Id: <20211215010008.2545520-52-javierm@redhat.com>
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

 drivers/gpu/drm/tiny/ili9486.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index e9a63f4b2993..8e46420e1a87 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -196,6 +196,9 @@ static int ili9486_probe(struct spi_device *spi)
 	u32 rotation = 0;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	dbidev = devm_drm_dev_alloc(dev, &ili9486_driver,
 				    struct mipi_dbi_dev, drm);
 	if (IS_ERR(dbidev))
-- 
2.33.1

