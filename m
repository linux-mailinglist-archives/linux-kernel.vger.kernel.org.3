Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF9C4781B1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhLQAj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhLQAif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lVDlvz5KshJ9xEp0fUDjyMKxN1Mip/awmP+ArPF4eY=;
        b=G7QXgDa/p6yM23A8XTm5ZPe6nc4zWqe8OptoTvQ3DsIMQZCTDzGTOgvCtw0v9kUwwzB8tZ
        5xgc/+VgN1JWpTy+IzRzTWNYSTPpbfBLiVAVH73sOmU3LRuHRjr75xmEQHnM95mLCne7Vy
        tDEsxyIDKpDq5aIRPDrMSm11VP1NAlM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-0LwZ5Wh8MCWek36dcK0anA-1; Thu, 16 Dec 2021 19:38:33 -0500
X-MC-Unique: 0LwZ5Wh8MCWek36dcK0anA-1
Received: by mail-wr1-f69.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so154173wrd.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1lVDlvz5KshJ9xEp0fUDjyMKxN1Mip/awmP+ArPF4eY=;
        b=3rLvujtnjoSwWg8GK0akxqX9xZG/34I+5wCEt7jAJACq+n9sStvKe7+CYNJ5Wyx0Wc
         yhTRhHm9mHmo8ikc65WpnofIOXuvzWHxzaPrYT4R0mAAbeNZjmZQfxokAWUTUG+LUQj/
         +NkyvHkUUbeypn8kl/AaaysTpUGPQihofux48oiTL9HNA+UdUH+nz50VhpO5ok7MAwcE
         RlTp+cb71O/y6J9sb5WdO03iw2CTbWRRSZD3FYRh0Zce6HNLrIAhEFvlNM14SVDEQCe1
         /CViovesuPMUlSLutX7CQ+iXYCvATcKM8gx+MKw0+VTNgl1ZZJTA0732Grgml7EfjI7k
         L6gw==
X-Gm-Message-State: AOAM531bWMUm+FC36e5S2HYdZiuSQaRMbyVrOG2bNzuLLxrGPMteE2K8
        3xuRKUKFv5NWb0jC9VxHMJ+gXeySsxfyer4MXCofsruOfbphzYIQYkNIgjY5Vdmln7p84Eyqi3X
        B4V/WOSgc5q3bEG0XlQFIWBQxY9vYWrAmApqBD5C3BMp14uGuy/VFQswidWJbw+oVXb4jX8ARA0
        g=
X-Received: by 2002:adf:e3d1:: with SMTP id k17mr386741wrm.610.1639701511929;
        Thu, 16 Dec 2021 16:38:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO3TK+zySPyHhr762oSVAORB7oktel0HxoAPED3eWuduaxPT05zJHBzakbWjfgQEb8xwaVDg==
X-Received: by 2002:adf:e3d1:: with SMTP id k17mr386729wrm.610.1639701511680;
        Thu, 16 Dec 2021 16:38:31 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:31 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 35/37] drm/tegra: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:50 +0100
Message-Id: <20211217003752.3946210-36-javierm@redhat.com>
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

