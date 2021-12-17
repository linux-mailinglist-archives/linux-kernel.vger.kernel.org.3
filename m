Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E99478186
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhLQAin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhLQAiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahyuAZOmdFY2VC9vEMo81WUIOHBO2hembXo6sdu/X5c=;
        b=H7BMaqkYz9iGPkVbW7ziWLj6K73Gt5wiQqeVEz8M2Mw16oRHChjdNlEMtEtI3gcVJ0TnqV
        8MEclTcoyFMb//Dwnh8m7dIaRumYYpIM8c8yycoRfnAH7EfPD62rbRFqfqYpkRISl+m2Pt
        6D9LTDDi/qQ4otUebyDE7mofYimDo1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-c1eyM-aAOF2sHCph0qsdkw-1; Thu, 16 Dec 2021 19:38:20 -0500
X-MC-Unique: c1eyM-aAOF2sHCph0qsdkw-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so2086181wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahyuAZOmdFY2VC9vEMo81WUIOHBO2hembXo6sdu/X5c=;
        b=wktF9MOfMMOllKGSL5usfSPpBDK2ttZ3pmuwWDF9T3lEN4pI0nLXoGA7c7H9TcYHn3
         UxNzSgY0rfQJaHeW1J/T39NdbP/J6usu0czVlM0bXYv269APy/4ROp96gJk3GvS0ovVw
         UiDxwzkOHO/GpXUfyhfF47UJbqgK/7hSF90b7H9Tq4t6eE0kmufD7iD02p3NGZv8/08R
         vxMQYz6tKtCC6fX9PsuKbcnBZGPAzdUNhVaL6doWSaAqJHbNpCw5jy9lR5rkKNOQ1kJR
         OeaeBH03HAaUFQUHJmLthud+McYM0EfeIMOfkNDz/clgASNs9xWktH0jCElJPZL5yZmy
         NfGQ==
X-Gm-Message-State: AOAM532NHPKiGvRMUA426ZMOB5VLOvDUQ3gM2++ukwsrnST/Mf+6+ADU
        QvgDeypHKaga0B9n7P4ETgIyzEhLS2xLZN8CBpnldGjNgTUrnByD/8RrX4946YPI2psjDvvbR64
        h4Yac0++cK1V7r6eJRlPrcUO0U2hQIVgNsSShEu8wHpQzADzaP5SqXj8LEgZXVwHKV6TfnetWxn
        M=
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr359375wml.21.1639701499495;
        Thu, 16 Dec 2021 16:38:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTSRmEv5AHQGNtBrGU4dWrsLog9QRAEtcHtdNw5mn1tItTrVq0e8y+xK7lY+butph+c2lFnA==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr359361wml.21.1639701499217;
        Thu, 16 Dec 2021 16:38:19 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:18 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 21/37] drm/armada: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:36 +0100
Message-Id: <20211217003752.3946210-22-javierm@redhat.com>
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

 drivers/gpu/drm/armada/armada_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 8e3e98f13db4..4f9b0a9f13e3 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -273,6 +273,9 @@ static int __init armada_drm_init(void)
 {
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = platform_driver_register(&armada_lcd_platform_driver);
 	if (ret)
 		return ret;
-- 
2.33.1

