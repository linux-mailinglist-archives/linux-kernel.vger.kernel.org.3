Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76580475007
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhLOBBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238775AbhLOBBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pR7Sz5c+7H0aNItZIWRk/wSlCNz3YF/2pbTouknMqsY=;
        b=VyBqfFzP55H7n9MgvfTBMiWDEgTOxxL3jrYt8FnlENdyKKFV5qRXqOWLPgGkpulXj6qFGi
        fS9RGU2Qpxkrgzs1es2mA3xcTBjBc51ZhE8UMYzCF9BdYpcKRp3VGu2EsYTt1ogbo+a38e
        rOWlVQ0fCaKBspkOr7L+bPOSlpWGuUU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-JWHOBLb1NyWQbWcIgUMjfg-1; Tue, 14 Dec 2021 20:01:03 -0500
X-MC-Unique: JWHOBLb1NyWQbWcIgUMjfg-1
Received: by mail-wr1-f70.google.com with SMTP id q7-20020adff507000000b0017d160d35a8so5377879wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pR7Sz5c+7H0aNItZIWRk/wSlCNz3YF/2pbTouknMqsY=;
        b=AGzVIs5FDWO7x/IYlo3rVRyWKt76Z9GWgsGuEzFnPt3jjmQqXdcYZnnQjgZXuxIDTz
         eGs1xJkePE9ttvcKf05GL9aKGWJgcGigKXsPM7Kzl5Z6NYsRUC6EAZyqdEY5teDoPjzS
         TO+Uafh9JQzm6G72CBCf3+AEZ3OeMB93Pbn2aeCMELuiNVCw0gWmTJsyAlGt77CR485i
         TvUwNUjdAxLafSp4ehgoeBVAYDBGn+1NNPbul00ZjN4GOklXc2GY3hjb1nWGF9ELWHnz
         dIWIrvssWWO7Dmlv6Wy2B4eHrC0vyRGWAR9shEKm36zQtfSg8IemAb0MaPdLS/EYmB3f
         qXKA==
X-Gm-Message-State: AOAM530p4ipoxCjaN7OhJ2A9yiLCbWs5w/EOK7luvpwiapEko29Grmvm
        Q44hg7MEzJv9KrTalk30xz0QJy7b/wF8mr++6udcdvPRA2zPsfe9Xrw6ehR4QYzatq0qpDqrXsu
        s5F1ZfozLNoVd3KMYv1wQZa6+JqNgkEaXIdYydKrDxJx8o5eD37QezIEnjZHD+HtKUdyXzah/xF
        Y=
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr2392229wmc.58.1639530062053;
        Tue, 14 Dec 2021 17:01:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWzXgozbP4N5LQ0gywcw2pd+ylli/oPGO+O0OYz0ShaNLqXeXCkilIUcr6Tt9DvW+vhXs09g==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr2392212wmc.58.1639530061803;
        Tue, 14 Dec 2021 17:01:01 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:01 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH 14/60] drm/hyperv: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:22 +0100
Message-Id: <20211215010008.2545520-15-javierm@redhat.com>
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

 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index cd818a629183..8401a43c4d49 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -288,6 +288,9 @@ static int __init hyperv_init(void)
 {
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = pci_register_driver(&hyperv_pci_driver);
 	if (ret != 0)
 		return ret;
-- 
2.33.1

