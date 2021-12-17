Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F328B478194
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhLQAiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231280AbhLQAiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMwC+6iV4pUIscAwY5CUqN9dmmZrwXUE328K64bB1gA=;
        b=dI0/FiwZ2qNdNyJhouh2pnvMfI+BJ0Pm+/0jQLUR3HHkrPDHi0+z6s4vuxqybbtouojNNr
        PJpDyBBVxGPKmBUM/auQk/VR+qwVCsSbN4VVWhyrvdbjAOyW9PXLcZqLOn8A9z6nwZqKTy
        nEVwjFpPYs6SX+k1zDq65cbeb1Zzbvs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-nElCI490NLicd80qzK4k8A-1; Thu, 16 Dec 2021 19:38:21 -0500
X-MC-Unique: nElCI490NLicd80qzK4k8A-1
Received: by mail-wr1-f71.google.com with SMTP id l13-20020adfbd8d000000b001a23a990dbfso148098wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMwC+6iV4pUIscAwY5CUqN9dmmZrwXUE328K64bB1gA=;
        b=4TtumHr/L1TPQJzkymSwsPU/vCHXXf5X2osSeCRmwJTbHASz496aH/7oQ1Yshps7w6
         kc7eaeI/9diJm/RTquERunlNHYqeV4F1N7rcT9MynXkM8ZcTwh6qi9zyd3sHQSzqEcCh
         iSYqNvrRSRXhTNAHfMNMAqR+rlwCq9meNt/oEzftLcbq4oiImGEgveaf1hRrQjdoqj/Q
         90Ra7PsXFN6m4eEptg58HYbkaj9PQoeyELMqs79JtC1fioE9AKVjmIUHwvkEd7m5YXmg
         VolL9ZLlEbHovBNB5GkzTYYwDTzud3otodSQ9vNn8uC0IHP1PsbsdqiFAx+4bUeWq0GW
         h3KA==
X-Gm-Message-State: AOAM533KPDsbFC5Sd6a4RnFE+dDVHJ5DmWW8k6QAtHbhPbvf9S28pK+n
        1hHGXlFA1TfeCHwiEnYwcAiFwNysCL4dc/U9usb5dzPuMy2g3gAlagNQoRz/8IoQSVUcUTkqyFV
        X7NggzZgW4JCNlz5ZBNacoVAtFkffaiakbGbRBD3sMRBqymP0DwpGKX3TBFydLlWLVDFbOLRlid
        E=
X-Received: by 2002:a1c:a517:: with SMTP id o23mr337567wme.189.1639701500399;
        Thu, 16 Dec 2021 16:38:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYxHnIt03QQb/BceGXRT0JLzIDcDwt9TqEVsGg9IYIen92gM74vnhF+uC/19itfmumxWnwxQ==
X-Received: by 2002:a1c:a517:: with SMTP id o23mr337549wme.189.1639701500125;
        Thu, 16 Dec 2021 16:38:20 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:19 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v2 22/37] drm/exynos: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:37 +0100
Message-Id: <20211217003752.3946210-23-javierm@redhat.com>
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

 drivers/gpu/drm/exynos/exynos_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index d8f1cf4d6b69..f9f10413a4f2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -464,6 +464,9 @@ static int exynos_drm_init(void)
 {
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = exynos_drm_register_devices();
 	if (ret)
 		return ret;
-- 
2.33.1

