Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B2B475024
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbhLOBC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238780AbhLOBBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmWmEvElNVU/qerAaDBsaq/QCWQ6SmxeNP67s/Zf/B0=;
        b=PJF5DmlunH5XuXceXQHcA7y4w20h+orJ5piiX4oQz+1wjUe4z4wglBjoQtW9+Wv0o6FL1f
        VjkujKFnL+ClYT5Ope4kW7uUHyYBa2TjemX3/rKQoZ77ENue9kZCokn7nQExhjtFh1TcDc
        s4GgOpfM7AYZkPxgOa899QDhkqeotdY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-ZxU5HcGgN9uPPQad4bukpg-1; Tue, 14 Dec 2021 20:01:28 -0500
X-MC-Unique: ZxU5HcGgN9uPPQad4bukpg-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so13898190wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmWmEvElNVU/qerAaDBsaq/QCWQ6SmxeNP67s/Zf/B0=;
        b=j9oGil3TgV6OBhn4AdXhhMWZxXyeXNVEKSV5P1XpigyFVgmYcoedf52y+gP/wVOx81
         9kxcE1y+1GdVmAHOtroUmxzpFHmN9KbnUiCPbaU2nVfJ1YH1GRLs5BoG/mtgOLsUuTjG
         XD3ew+1f3rYVOd+5iYK+2jfsd6pv7h4QVxUeXDbR0uNVCyPVsS5ceBKgBk/kUhJMnrvN
         ZLp2lhweI1PRNd7qEM9AUU6Z6+N4e9CWh8pLL3vvZzQi+yDOvxP7kvr5qZwgxV/0F2Q1
         D4trVn7gkezRs9HTDd2bgFpYKT9fdo4KjpYtM9gxC0WwHRxXcRrgY2uHukZEeZJTKnwN
         cMeA==
X-Gm-Message-State: AOAM531deOdfNCeSaJe5dNKmlHxkJ1q0JOBPuzIESlkrQLbeDJxxPrtX
        k5LmBBttSAPFD3dYwnKBg2MHQOZ38xwRaF8owUslF4ROihOXO8+sCI/3WXKmevAqJ+beh/SZDDM
        669Fr8ugnsslnzEMOY9hV6F9u0fv9VSJpm9Vx5/pVa7wsT4/cOvV48mxL0xsea53rZYGmIY5bgu
        A=
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr2246942wma.9.1639530087082;
        Tue, 14 Dec 2021 17:01:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBgBtQauXKwZ6LZc3kZFzJN4bmwEvjEhe5N89f7g7Te2cRZqCCXlTJoLce60PTPD/ZzfA6Tw==
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr2246928wma.9.1639530086871;
        Tue, 14 Dec 2021 17:01:26 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:26 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 42/60] drm/tegra: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:50 +0100
Message-Id: <20211215010008.2545520-43-javierm@redhat.com>
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

 drivers/gpu/drm/tegra/drm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 8d37d6b00562..48e35d686473 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1382,6 +1382,9 @@ static int __init host1x_drm_init(void)
 {
 	int err;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	err = host1x_driver_register(&host1x_drm_driver);
 	if (err < 0)
 		return err;
-- 
2.33.1

