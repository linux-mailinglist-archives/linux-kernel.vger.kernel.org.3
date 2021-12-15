Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC4475014
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbhLOBCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238892AbhLOBBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awWrf5B9PoquDrlINejpUk1+b8WRbMbhOZjQU0GR1bs=;
        b=YUeuYe27248MIDj5twz8GwC40z9t+oKZGy/onGthuVUvRo9wP1E0RL6wuLWezIMYS7FAY7
        FVcpbsltnFuLaftPST8Gn7WRWVMmXskVzC+F4fiJr8N3khHj0R3M0ilojEfLlZZSUwgnRJ
        /x6kEjByBbh8jSvvEGCM5Jc6gKdhHPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-WojoYo-ePf6TSo_h_79-Ow-1; Tue, 14 Dec 2021 20:01:17 -0500
X-MC-Unique: WojoYo-ePf6TSo_h_79-Ow-1
Received: by mail-wr1-f69.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso5426823wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awWrf5B9PoquDrlINejpUk1+b8WRbMbhOZjQU0GR1bs=;
        b=pWjeQP2E2FUZcVkh8A/N8+kZKtB+XMdXbYXkqQYvmuzh0d6ChUy5IeMYVpjRvLZK7s
         o4KbrzDLWNMQyyEj4xD7ERco6MMGwT10l5dXhJewwScdnDDduOElU8CdTdgCJ/rHWoVV
         dxvyBMRARFkVK/D0L6ugxrrG6vikCjl2IgjIl8lE+iomxoXjBXCdJmy21HGftVZk6pYu
         AvtCOHjbBhrjU0erYy6BBBXE+/fNRIu0orTFXrCfjTi2/G/DSKCoZ6/HlHOIKxxstMGs
         jlvjYMy0rDNbHNJ2hudY3J9HwzxGPQUzi5PlMrSu/V+5WuQRzZu6lUBKKWyn8pXylPXf
         OvIA==
X-Gm-Message-State: AOAM5324odMefm85jA5sTNkEqB/B8KgBpemu+6Av+uyHBlLWfPn7Zpaw
        IQWGn+KGO5BJCJmMnq1FiMsK7eGKk95SuaqOm/uWAkwFZt9Bq0rE+20PvbcBRXb9u7A44DD7RWj
        eQojEn+t0UwuN/acLe2jKJGxFRmP82kLEbIjh6sFh2z3oQNw4MXQzLm9E3R8JHYL1yR01SrYXa5
        8=
X-Received: by 2002:a5d:460d:: with SMTP id t13mr2257169wrq.44.1639530076405;
        Tue, 14 Dec 2021 17:01:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5wNkadaSy1vz0hiZk0VMttTMI7udJznYgz7W4Y3vai/pifl1KFc2uvgkFngUslis2OSFA+w==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr2257151wrq.44.1639530076169;
        Tue, 14 Dec 2021 17:01:16 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:15 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Emma Anholt <emma@anholt.net>
Subject: [PATCH 30/60] drm/pl111: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:38 +0100
Message-Id: <20211215010008.2545520-31-javierm@redhat.com>
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

 drivers/gpu/drm/pl111/pl111_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 520301b405f1..7a316c8d8301 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -243,6 +243,9 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	struct drm_device *drm;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.33.1

