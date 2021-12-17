Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA8747819B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhLQAiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhLQAi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q91daTY2WtTyWMwxe7dlWper7f8gM/2aqRN6262ZYts=;
        b=VY6vYUF16/GiTLey/JSA6kzJtv4o7gp4PCQxpyJ4PSugfwUJnEKdcKL+DbYuJW2y78pU63
        9eLOOU0NIXCQ26hArPTFSyvhucRGIXi8j5eic1UTAdAF2+aQFjrk6T47v3ugnWEf7tgOgc
        POSsiA2CmM2cqQBNXtmuDMVnn6h57GI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-JR6MAXu6PLO4s5DrISvOtw-1; Thu, 16 Dec 2021 19:38:24 -0500
X-MC-Unique: JR6MAXu6PLO4s5DrISvOtw-1
Received: by mail-wr1-f71.google.com with SMTP id s23-20020adf9797000000b001a24674f0f7so146322wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q91daTY2WtTyWMwxe7dlWper7f8gM/2aqRN6262ZYts=;
        b=GF/zm6wbqBTQTmxE3Z1SoZ7fZ7OQWLKRkZvVskIKEvuo/AgaSnIbl9isKNCY4drx/3
         l2kGJY0umAwxliriWsOr/RxaQQdc9a56NV+ov7IqiT+2wVZ/iADlrqD4cheM7PZk+mK+
         I1lL4NWyt5RpwS94TY0lb20QBKgXEfNcNOblV7A7a6cYQSdHq9YS7sTMwH3Hv9+TiV8L
         fUjpjpm/Hrw5R0AYpb2L9YjFr4IgKhjNdZq5TJ+8T1n3JKURoPGetnKl/iaoMOa9nCEl
         9tEw+TldDhGuVW8iJDGduVvhf4ys1gWivoA1NFK9J7aUnsFO9Vvq4IGsrcuVT4M8q6m1
         CAuQ==
X-Gm-Message-State: AOAM530ajXR8bD21z73Fk/PkT+E0TY5joigididWZjIeYkhUqUc0tlMY
        gKy7r9Hw9WpfoziVcpmNvZRr5ZegrLKLPczfT4YLWaDs98bgW3JPOFT5QKbYVCVHaWgcnDd3Q/Q
        QFX+8yxe4hsReeHctSXFcwe6lmpLNcwYost4YVdE6FE4G949p/jNV/WYQEyD8DIGGlOXJ+6WB66
        o=
X-Received: by 2002:a7b:c306:: with SMTP id k6mr363067wmj.15.1639701503043;
        Thu, 16 Dec 2021 16:38:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvoXeGW2jrccEvR48MqZL+8tJylA7p6Q3ao3iqhCsaxM7OjBhKzQDvzh60KoN1/spon9TghQ==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr363045wmj.15.1639701502768;
        Thu, 16 Dec 2021 16:38:22 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:22 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 25/37] drm/imx: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:40 +0100
Message-Id: <20211217003752.3946210-26-javierm@redhat.com>
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

 drivers/gpu/drm/imx/imx-drm-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index cb685fe2039b..a57812ec36b1 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -341,6 +341,9 @@ static struct platform_driver * const drivers[] = {
 
 static int __init imx_drm_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
 }
 module_init(imx_drm_init);
-- 
2.33.1

