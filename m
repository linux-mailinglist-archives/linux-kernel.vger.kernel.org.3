Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB0475033
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbhLOBD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232948AbhLOBBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g5qQcI/Amlwg4a9ar7DdVwzPkc7DjrNDla/ZRcRYeiA=;
        b=TqMVGNcwuAiZ5Gx4EFgYbc/rVjsfCWnt26lEZvH25uv6DEpqKc1aD48pbibvAMDDce9J6C
        65Q2orb3TuZt+ADANtApUdLX0pDLxK5pzAl3/ab4mWRjkECyqR1wfcWzgLWQW/EuK0qeMz
        EzabODAp3raGRsA8pN9gPxg/EdZatsA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-Hta45WbWP827FLpC2Z0Eog-1; Tue, 14 Dec 2021 20:01:41 -0500
X-MC-Unique: Hta45WbWP827FLpC2Z0Eog-1
Received: by mail-wm1-f72.google.com with SMTP id l34-20020a05600c1d2200b00344d34754e4so1155266wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5qQcI/Amlwg4a9ar7DdVwzPkc7DjrNDla/ZRcRYeiA=;
        b=lFJDqY6j4tuEsCZFY2uQLRTp9f/mDla0jt0N3BV8YbIUTyMFOvP7k32Lt9p5RaSQzA
         X8iyFIzULj/IZ41NRIyn6P+7lRvAXEy+mLprQvXtlvuDYLXkyanBuyWHdikCDZxZEuyg
         jAaG9vRJNO5CphijMZU0HM8M6ONHoBwOqm58y/967PuJp2pk3ZsLn8J8dB51DOYe7ng1
         r7jseo67grYA/UWeCL4zmdvyfy0eObQo1N5xdWHn3YiXXrX8OQYUY7jOCrSl7bOr3Tnj
         e5ka34TfxIteC8fmyVzNoWPztVw8OWYMPMtSRFVTZfaeAlFTkmlAS39ryaWt7eA60cJc
         0aMw==
X-Gm-Message-State: AOAM530JF9C+uYMlpl1NC/Cj3/RnweWf8/CMCuJNN29Pf9JmxM2Okbx5
        jv8c0AHxTgnPgeL1kVB3pE7SuCXIrTyD+TNL6hyOgQcF5mo37MYTshSMNg+mEpG2U1O/YH7E2k0
        dvcQUM2GAZNyAtUtqwfRljltUU253Z7kTsijGjmy+JZVrw/Fs5nGqNv5/TejJ2mcw1HZPPUtW7y
        k=
X-Received: by 2002:a05:600c:4fc3:: with SMTP id o3mr2424142wmq.74.1639530100471;
        Tue, 14 Dec 2021 17:01:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjZ53iWgnqPlE6QmrgnZNvFZDIVV8vQx3xga5emLEBubaer5+ZmoznUGdlBfeRiCEM69QnBA==
X-Received: by 2002:a05:600c:4fc3:: with SMTP id o3mr2424129wmq.74.1639530100289;
        Tue, 14 Dec 2021 17:01:40 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:40 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 59/60] drm/xen: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 02:00:07 +0100
Message-Id: <20211215010008.2545520-60-javierm@redhat.com>
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

 drivers/gpu/drm/xen/xen_drm_front.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 434064c820e8..20d11ea79e0f 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -495,6 +495,9 @@ static int xen_drm_drv_init(struct xen_drm_front_info *front_info)
 	struct drm_device *drm_dev;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	DRM_INFO("Creating %s\n", xen_drm_driver.desc);
 
 	drm_info = kzalloc(sizeof(*drm_info), GFP_KERNEL);
-- 
2.33.1

