Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF0475002
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbhLOBBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238765AbhLOBBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfozKiCl9i5b6Wjh+/WfnlZcF51aFpSAEpGxrbt9SHg=;
        b=Tp0WaLNrWgUKp0PwUWWipitYRNVs6gYhWa0oWblgDcxje7grqvnJW/i5PVlVcb+BQY+Bok
        kYe3cqPYDcYz7dhWYvPssXs2eSqqnFB9W9xF9mbW//cpaR5N8VCduugFCR/W1w9NzgmTLq
        Zvgxdtc/mvNTyqDYhloG1H7ZyGXNhs0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-tTStEcRdODe6TzoHocJYHA-1; Tue, 14 Dec 2021 20:01:00 -0500
X-MC-Unique: tTStEcRdODe6TzoHocJYHA-1
Received: by mail-wr1-f72.google.com with SMTP id c4-20020adfed84000000b00185ca4eba36so5371241wro.21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfozKiCl9i5b6Wjh+/WfnlZcF51aFpSAEpGxrbt9SHg=;
        b=sKfoKgzaskd2m0gj401vUQvIFEDCgh5QYgRQqxWAwtuPizQiIjDiI9KUHtWyDkqtyt
         GYtyZA1TKQIN63DIX9vALxiyyT0lyURJTSX+XyjLO29ozTR/GpgMDjxkpPIrUwTMVISG
         iFFe+QeVM63k7p/n/7Ien+Yj7kB4GeKTq1L8BVxdIBMeYHVDHt83JXf8eh1sGwZ1Zs4e
         XVm7Tve+7L5tAjETvdIkAJ464wzxyu7gCEbtB+PkhnKo7Y4xoX3TQT9SgfrjF1zHKFL6
         TY1g+viNRhSjTEz+kRsM4H2CAdgfPtVGNa5R9xf5dM5eivFqZj8DjeCHz2HcmAVNM9oQ
         XuMg==
X-Gm-Message-State: AOAM5306K600gMeR3kbth8ysANuUwkdKCyP1GfmGzM8cwDCR2SaccqXV
        m0NauWuZ6NMhlGYRUYThmMlW7Ti+nXDX8xIe988+2goUXgjpdiDwjwBqv//T7ONu6XRLPMjcSO5
        MHZ0ZW7GuBPVB4qfxsYJrCHVem4PktxZZs5cdrtv81kXuTrxzzvtZi9hjUDqnOoaK8za0cKj1le
        Y=
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr2267788wmq.120.1639530059163;
        Tue, 14 Dec 2021 17:00:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycF0xIVdPZqekNhrMVePm4bcOD/E2H+0Br7VxiwcZsdiBitbJa4ePZ5blk/QLmIBgqU4Wg3w==
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr2267775wmq.120.1639530058937;
        Tue, 14 Dec 2021 17:00:58 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:58 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 11/60] drm/gud: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:19 +0100
Message-Id: <20211215010008.2545520-12-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215010008.2545520-1-javierm@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 drivers/gpu/drm/gud/gud_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 3f9d4b9a1e3d..4d253d249512 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -446,6 +446,9 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	u32 *formats;
 	int ret, i;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = usb_find_bulk_out_endpoint(intf->cur_altsetting, &bulk_out);
 	if (ret)
 		return ret;
-- 
2.33.1

