Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2EB4781AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhLQAjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhLQAie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeORZoSkcXdXVuQBcvALim4uY06DBkHzDclu3qUpHK4=;
        b=YZzEH0bL8rmB9DLQDBt4SVy/Wal/rpj0Cg0YxR0FgiHxX545Fl3ylumnfMefV2gSV4xSzr
        UZwphC68VYsi3jbD9ZeYb+apRpFFKRtFGMx0hwSGp/81w44JCPBokomD3gxliZF3Zv8kE+
        CEcsUp4Cj//HiQmJDkCGqKgmjrdjfbA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-oWOWZCFqOK2-64qqL5Q1yg-1; Thu, 16 Dec 2021 19:38:32 -0500
X-MC-Unique: oWOWZCFqOK2-64qqL5Q1yg-1
Received: by mail-wm1-f71.google.com with SMTP id l34-20020a05600c1d2200b00344d34754e4so2071742wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CeORZoSkcXdXVuQBcvALim4uY06DBkHzDclu3qUpHK4=;
        b=wn6QyylLn8MaxhavClWlRbUOYtEGwDVteYQM07GaEuKE2XWWmEKmK6jX3pv4fqk7gr
         6bf6WrqGaDjsF2XcXZ2rqUlTy8+tQZK+FjYKIIMqZcbm9jO/nb3Mhn7/po2Xw6SgdJ3F
         nW57XAAR9sInX2iZoI5QDbp4q7UP0u67Pno4vP57x6T0nnxhHH9nrwsG7U+rptNp4B2w
         l3h5jO08GS0H4xgEuCsP3ohc4qBJ+WGv1W8sqDTHBnij/cmswqpPkkBAqOtfa4UIhgNw
         QNZZHOK8pCKxaoGJsWQDLLsEOz9SrfHjpTJWO0u7FobSe6YmjRIwKXH2uIghL8qZNHUL
         JZ4A==
X-Gm-Message-State: AOAM532IMQu/rz729laDzr55m0LYazj0erE08EjaP5oa9JGOfdv2tKo3
        5YUt8jlB8Uv71a8nOCEipRVQy/+cFjW69vaLIbbzDJvklH2gVGctUFUrgJ18x2XlGUYc0INq6BS
        DB1TSVBcjguIZvY1OquZj66kCB5IwZf7tL3nn8NIMKRJGXYRmwZneftOJnqF4izlZhGFB6AKpjr
        w=
X-Received: by 2002:a05:6000:186e:: with SMTP id d14mr368455wri.376.1639701510971;
        Thu, 16 Dec 2021 16:38:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1D7RXo46td0Fd0a+v7nDkc7NgSxUNrUxkXHkGgjRPzYWa/gOoBKI1QdjR+VcxaqotcSiL3A==
X-Received: by 2002:a05:6000:186e:: with SMTP id d14mr368442wri.376.1639701510619;
        Thu, 16 Dec 2021 16:38:30 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:30 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 34/37] drm/sti: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:49 +0100
Message-Id: <20211217003752.3946210-35-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/sti/sti_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index c7efb43b83ee..860b2230aa08 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -287,6 +287,9 @@ static struct platform_driver * const drivers[] = {
 
 static int sti_drm_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
 }
 module_init(sti_drm_init);
-- 
2.33.1

