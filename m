Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971A7474FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhLOBBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238737AbhLOBA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJpjtumWdUbVBjBY4BM1leidlI8M/LKSk6OTs3RZ9AU=;
        b=KvFoJORf8gmUN63Mov4v//3BYRgDMI+enZ99u39AemQf69v/lwkZoRO+Q8fBLlPcJdWFgh
        fU2FZvQTy0E67eg7j8Cx+44qKQoQdBkLRyD5eLaFe4aFXjdN6xCmNLfEZcMbMYS/OSkIw5
        Nq+mU96Cdlfq6Qy/4rZq2smeLoySpj4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-E-3TIk8UOCa6kbyUzebd5w-1; Tue, 14 Dec 2021 20:00:55 -0500
X-MC-Unique: E-3TIk8UOCa6kbyUzebd5w-1
Received: by mail-wm1-f72.google.com with SMTP id 138-20020a1c0090000000b00338bb803204so11939595wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJpjtumWdUbVBjBY4BM1leidlI8M/LKSk6OTs3RZ9AU=;
        b=k4oidc8m14l2nOK6OE9xUALtLM09SstXQtFFkU+6/0N41qdqQoXvhxgH5WECNh9BXU
         Yu/qn7/9aSvSrD/jE52jZGX1sCzWtxwjYLHpPMp7GTEER3zLlpTyINGZIQX56HLuTC21
         hSlMMjHoAQFT0cngswm2J6b5dAMneXEJxLT2uod9Co+n/ZdAIAqkpzqnlLQabBDWq0X3
         8eofZ1aWvrPqT/wczIn1Fl16SPhwkI7/clZGjfzZc/WfU1bHWhJDyTwysgVxyPhwlYpN
         WEhVvKmFrIkRt9h8OZgGuXWSNp9XTdZC5s99RCOQ88grTfgH1ZOtg2bU/L/5RQ7j2zI8
         pS5g==
X-Gm-Message-State: AOAM5332txiuDeQc6F5WvjKeTH8OziKaZBjsRha/sTrdwatjsyiAIQRL
        B8HrhTUL41scQx1NXetuft6k2NIAtyqBh7EXK380vRSgMEMM+9iaU9o2t8iy8zy59G6qEH48P/n
        aloU1VvqgOUiHQLrunWOmXEL34W1/cBxM6MjlVjDfhY/QmkwEqA5Ga/z7pr0WIYDvSTCC8/6XWI
        A=
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr2450323wmq.68.1639530054134;
        Tue, 14 Dec 2021 17:00:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzw19sHakCMRq7/L4DbYc0FVTXl+HZZmxN/MLKnD/o1EVP/xi6T4zBHdo9JAGXjXp5J4PjGlA==
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr2450306wmq.68.1639530053890;
        Tue, 14 Dec 2021 17:00:53 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:53 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 05/60] drm/aspeed: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:13 +0100
Message-Id: <20211215010008.2545520-6-javierm@redhat.com>
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

 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index b53fee6f1c17..c70d8f046816 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -310,6 +310,9 @@ static int aspeed_gfx_probe(struct platform_device *pdev)
 	struct aspeed_gfx *priv;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	priv = devm_drm_dev_alloc(&pdev->dev, &aspeed_gfx_driver,
 				  struct aspeed_gfx, drm);
 	if (IS_ERR(priv))
-- 
2.33.1

