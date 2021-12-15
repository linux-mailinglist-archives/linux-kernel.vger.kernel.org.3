Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14665475017
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbhLOBCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238817AbhLOBBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egd8kr8D5VITAG77xs5mGgXddS6XZa0CNEo6AVoMvtE=;
        b=gqZG+VK5vyRspDcBUTnJn152sRvAk/wlJgvNgCYKLb52oPNSR6hiGLXiiIxxpN42R73BbQ
        pJbc5AHDuUGFTI7yKwDnfi8uQ0B2KXz0eSHyMHAEx846pmgVEoG9pkOubXfrU6pN21LJ5W
        +gbfMo2vLdFlwrUZUzn8lYhkym4S/1E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-O3uD3R22Oi-CXkbVbNq6bw-1; Tue, 14 Dec 2021 20:01:14 -0500
X-MC-Unique: O3uD3R22Oi-CXkbVbNq6bw-1
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so13897899wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egd8kr8D5VITAG77xs5mGgXddS6XZa0CNEo6AVoMvtE=;
        b=4unNViZAZxKtlvYKUR8CsnrhhGjv9YXqbiKCHlMjtjRnazodcZSs2ih9xCrYMrgwPx
         cOVOxwGnUVy9K3VHqzN9NpPtWpRmtUHBj56AkI+tBo+GCcclknRgCd8EgLlXBFOKZ6Ql
         SGojtL6rQp/nKiW6jasUd6JZJRerUjPwN1q/lXThNkHv1Bwbi4rQ2ScxqgNw0T1BqeGh
         aBOsa+OS/8siH79CV0FwEQI/ZAz/10N5WYZufsQqY2ggC2Mt1ifAqpOUCXVJiYY1azlM
         /vuUb8SK/KqNL5nNCnAhQ+7on0VDgh6L0dwgRn8/sPa+y2B1DuKi39o82irJAm+0+2AY
         WZFw==
X-Gm-Message-State: AOAM532dup9wBC9D0svq8OPUE1XmMsuNgekleLQSs4mlNzjjTlkYamvM
        vk10UFJg4yqIox3jP01LBLEBVYCsgTj7dFECRfoTyPPTarF/RCOz23USWOFa+aMbfCvsz5d77sn
        w/QbaGdF8JQsPG6KRLt+jZnZq9hTYoNaD3zq8hNehql5gf1C/i5jaJJnqhzpQ2w5To1wnc9NenY
        c=
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr2078115wrt.327.1639530072805;
        Tue, 14 Dec 2021 17:01:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9M4WdmFvo/zg8Ix3tcksV20w3c47J2dT2pX0KN0YMYhw/R4HIWcodbzHQHCqkqo3USOkChA==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr2078097wrt.327.1639530072490;
        Tue, 14 Dec 2021 17:01:12 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:12 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 26/60] drm: mxsfb: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:34 +0100
Message-Id: <20211215010008.2545520-27-javierm@redhat.com>
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

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 86d78634a979..1359fc99c6f0 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -342,6 +342,9 @@ static int mxsfb_probe(struct platform_device *pdev)
 			of_match_device(mxsfb_dt_ids, &pdev->dev);
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
-- 
2.33.1

