Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB6475027
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhLOBDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239047AbhLOBBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gOuukOAYo/9Fq5Zf9aKVAFzejCB/DyaHkq29KfK2LNA=;
        b=Pwo1vZblHlshDtuaXB4WdgpM2NbeOo33vcmaUlYmeqk7gl/sjyjfh6yHdVitbGXxZGwTQo
        cj8oI7QvDrVVEmxlq+wL+dSB3fZfB+aCV/CCVV2aETmv0Sm76W1ZV77L8nrgMdfdz6ab8x
        EqXdAA+KYm2dZ6mFs8OAjC7QSNytCvI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-OefEd9aMNnmH0aCayJ8DTA-1; Tue, 14 Dec 2021 20:01:32 -0500
X-MC-Unique: OefEd9aMNnmH0aCayJ8DTA-1
Received: by mail-wr1-f72.google.com with SMTP id h12-20020adfa4cc000000b001a22dceda69so94478wrb.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOuukOAYo/9Fq5Zf9aKVAFzejCB/DyaHkq29KfK2LNA=;
        b=c2YiMxjix4psB8N9pqhD6d3DczDEXlZ//ivhpxVskQ+jXc+llUAJVw4sNjLwt+Pfw5
         4u2OG2NXLNsVgjuk7K1qLkwpZCJOInTMwLZ3cySXNyKNWy9CxkkoKulokW7Ii37YZgaY
         XWv+bCHlqzKMvwmc8eI71kFBbGZbNhLVVWPO4z+tSnJgBxNCCDuceupAKMvqeH5Czb1v
         m9igjYld/mfdf8zhUWMsMg1N/UO/Whcb9bv3yLwI4wXa/LdWvUaaumyqm3mlFi5X1SlQ
         mSh8KIoTt2RIFaXE2+J90tR37Bwq21nbH0zq5AR2rD8BXdQ5ZFPwNoO8WfixkGIB/N34
         a8eQ==
X-Gm-Message-State: AOAM531kQuvgJGOWQwewEvzJR1k2kK1sPYQYiM49PYZtDN+8wqYpyxBE
        KIggg2kb8/p6rf/xwtgRJgh/duzw4B0/J8QA9DsBZFTLWDT8lUu0mVNoSDQYvMUGUe8u7ikT6B7
        ceypVlWwmhFFz60lMH4rPjjUp9a7fN5dZwqw2IycO7pcLMeXxG2mNBVO5UfU/CeVOUuUmEETBg5
        w=
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr2199057wrd.114.1639530091130;
        Tue, 14 Dec 2021 17:01:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1wKaiOdPNLNK0v10PP7r3KQYSTvMZUUy+yrt6yG7y1500iVykBIHnCKM9OMeKD7ixr4ck5A==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr2199046wrd.114.1639530090970;
        Tue, 14 Dec 2021 17:01:30 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:30 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Emma Anholt <emma@anholt.net>
Subject: [PATCH 47/60] drm/hx8357d: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:55 +0100
Message-Id: <20211215010008.2545520-48-javierm@redhat.com>
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

 drivers/gpu/drm/tiny/hx8357d.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index 9b33c05732aa..fd788d36efdd 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -225,6 +225,9 @@ static int hx8357d_probe(struct spi_device *spi)
 	u32 rotation = 0;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	dbidev = devm_drm_dev_alloc(dev, &hx8357d_driver,
 				    struct mipi_dbi_dev, drm);
 	if (IS_ERR(dbidev))
-- 
2.33.1

