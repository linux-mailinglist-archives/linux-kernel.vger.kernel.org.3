Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1817478182
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhLQAig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231209AbhLQAiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeEAGbUCQAagra5UKTXhHNdQiD7z7drBXuFqxobwP+4=;
        b=RyBK1CQyVTLMon6TGpkRvQ+YLNjZyA8ZwYUn807aC0BF8Ms99JMJHwi4WqCwRWK4VEzlYx
        ebyHOPJVpmGl29ahWj/fnVtOUC8vL5bXRecYiWtZdxw2swdUdH1gFZzHOLYwPaEJwQ2Ad2
        KWT140Wf8dJdXCK/wL5/720/SjCyisI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-MBz2-Sb-OviSWkzZ1AjyGQ-1; Thu, 16 Dec 2021 19:38:16 -0500
X-MC-Unique: MBz2-Sb-OviSWkzZ1AjyGQ-1
Received: by mail-wr1-f69.google.com with SMTP id q21-20020adfab15000000b001a24b36e47eso148480wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeEAGbUCQAagra5UKTXhHNdQiD7z7drBXuFqxobwP+4=;
        b=HHcszyFkN2n6nyjAqvS7WZfe3fZQEK8DUCDt2BlfiuBeMeubuU614JOxeElM9y7/Oj
         QF8Lp/ZJ9grAdE/6wmibe1F1owM0SWOqQXgkzERP2eDZVTQizHBrqqsGYbqOYdPY60bS
         1xSXtfqevvWE2X273JGjGYpG6iPLI6pFDpbFnB1Oz1B6wetI6mJpEAl5DFrCljpk0IEn
         c8CgXb3GnK0EbLodbgfFy+JxKcoDSHWZtBg71rdBobztAS8Vzt+OWLqh5lA+xj6w7Z9z
         JDMZ0NgZylMtAQRiuOoFwd6G0rPHKtu08vmFKMGRWoFlGZLb2vRX3bM03mw6lteFBwar
         usLg==
X-Gm-Message-State: AOAM530BBd/1jlCQLSOeS/VQX9H+eQ0d7ZRwsVMrcSZA4qe0agUxzrSu
        0l1HSJ8pkQnUWTCV+Fe8IIuK5SVJVnjOF9J05gTUxOv65rAbZai0HKUuMd68xnqIJecGvVH7KEl
        /nI+EM0nhw4atm8mXsw/Fsjnq1DTKZntu8fpEmxoN6x0xy+ycuktrdz27cMnZkZ4UQdJfc2KW/i
        M=
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr368961wmq.122.1639701495575;
        Thu, 16 Dec 2021 16:38:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzk/ca36+xMPaSJuWujk137KwR4n8yjHrZOssdyt6YhVcuIuvZitOhSJ5wHtWfLmwbHmAOEyA==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr368945wmq.122.1639701495384;
        Thu, 16 Dec 2021 16:38:15 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:15 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>
Subject: [PATCH v2 17/37] drm/tidss: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:32 +0100
Message-Id: <20211217003752.3946210-18-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro calls to a DRM specific platform driver init handler that checks
whether the driver is allowed to be registered or not.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/tidss/tidss_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 7c784e90e40e..121fd413a75e 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -251,7 +251,7 @@ static struct platform_driver tidss_platform_driver = {
 	},
 };
 
-module_platform_driver(tidss_platform_driver);
+drm_module_platform_driver(tidss_platform_driver);
 
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
 MODULE_DESCRIPTION("TI Keystone DSS Driver");
-- 
2.33.1

