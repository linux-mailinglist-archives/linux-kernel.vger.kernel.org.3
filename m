Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3525475011
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhLOBCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238879AbhLOBBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gTwIkh2ZuZS1nX/41ZAGZ6k/Lw+a1aTbRjkqw0aNCs=;
        b=BEtAuszUU4END1nH2wn4miMnEK3cFMCqt//QWtjvkTo0/pdh6ju0ntFv9obkbP3Ehpt5DZ
        ldjspS2iaPLsFJeQGHEfyiWEAep5yXZg/H2CmZzM8z7cGpsYz8KgsdY6f0Z2x0G+pjcwLs
        wKL9ZXLl3jPwkMajqSfzmGtRRjrWvYE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-vkRdHq1QOeu1Ov_IOMfV6Q-1; Tue, 14 Dec 2021 20:01:16 -0500
X-MC-Unique: vkRdHq1QOeu1Ov_IOMfV6Q-1
Received: by mail-wr1-f72.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so616791wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gTwIkh2ZuZS1nX/41ZAGZ6k/Lw+a1aTbRjkqw0aNCs=;
        b=hfEXUG3NydD5ONuEXcgbhnJj7vRw2MtlXd4Ghh91UTj3t2E42L2VvuslRhBt57MOQA
         KoU8lzlMj6xUkmFXU6cp3TtQVOFclBt+tOqf8Bt2hm2HabBcAzu2Q7CqW0BxFtfk5A6Q
         Zwwwo/8zK+4gsxTlHrrhePmqv1U6fxhrOQ+IIqOFixe/fm5N/5nJp3MUcvTD1jA6WzJj
         qYYJQJvQRjR03ETwWxni1ijAt1JAJyWXJjTKtzWZujqQtUF2WugHOB1NCw0NZ+i4R4MI
         5KdTFoJrC/Tng5vNmmLuzBPw2b5EtTf8ujJ17dbwBtZr36Q2V0OvsuY3r5WAKO5LBsEy
         lOdQ==
X-Gm-Message-State: AOAM5333oi3fgt9SK5tjjQYW4XkCZ4Rq/J0xZqB7MOg3T8W/ObU4HSap
        nQlGaPVj3+lapEPQEzq2sl3eLaxkBpBfIGu+gLtB9rl2VobCabasnap/iOmyZzXV1xwyKW0pOEB
        FrlmQgvWnciAbfJTTogvl7PyxzuYmoRhDo7SSEIYcQsz/TSzddXJKGfwAMki5mw+6QKjSA/VVi9
        w=
X-Received: by 2002:adf:90e3:: with SMTP id i90mr2176166wri.538.1639530075180;
        Tue, 14 Dec 2021 17:01:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNT4JHrGcYWKcPf6mie4fxx896i0OJDy7gnUPceKUoQdhHkSfafwi8ej3qiKkMZPyDBBLopg==
X-Received: by 2002:adf:90e3:: with SMTP id i90mr2176156wri.538.1639530074981;
        Tue, 14 Dec 2021 17:01:14 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:14 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH 29/60] drm/panfrost: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:37 +0100
Message-Id: <20211215010008.2545520-30-javierm@redhat.com>
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

 drivers/gpu/drm/panfrost/panfrost_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 96bb5a465627..6effe1fdc893 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -547,6 +547,9 @@ static int panfrost_probe(struct platform_device *pdev)
 	struct drm_device *ddev;
 	int err;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	pfdev = devm_kzalloc(&pdev->dev, sizeof(*pfdev), GFP_KERNEL);
 	if (!pfdev)
 		return -ENOMEM;
-- 
2.33.1

