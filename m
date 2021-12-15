Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA6475013
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhLOBCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238867AbhLOBBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gP2m6jmqgIQcw7zXtRCVCnQPh4wC0dksG5Pq+7K01/U=;
        b=Zhdgj2ePIC3bSKq0aVEaRnnxmLesivUcMVzMES8rR09qTcn8YXr1v33UHHc5NCDLonklsm
        sMOP+/kZRsWNLX5W2kE1aLTxlEcnPy/s/edakAHxDPxXO4JacNbvj3UEf0uU8AI+UdPA8T
        kZQ6R70y59CU05w9f0DRJ2Sqb0aLXe8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-3qmF1r1ZO72VUOesc2jFDQ-1; Tue, 14 Dec 2021 20:01:15 -0500
X-MC-Unique: 3qmF1r1ZO72VUOesc2jFDQ-1
Received: by mail-wm1-f69.google.com with SMTP id j71-20020a1c234a000000b00342f418ae7cso13891893wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gP2m6jmqgIQcw7zXtRCVCnQPh4wC0dksG5Pq+7K01/U=;
        b=k38sq2ueyA421hVFgXP7y69EmU7W6DLQrTTS87Uam1xkp6XPM+jC9VBvOQx5W7H+iE
         jM54alu1UgBkcXqdpIhRt+HiptJ1WFTXO4RwAsNrjmNBjb7cKYASp2D5FHe/rxXhCjwR
         2h2Xj4u9ElDuVKtEKFcs7f7NNqp3XnOgScBz7Yzxwjnpb7hNzrnfzrLqKvSU51yQgrYe
         C2iYs3a1jBZ1/V8cCpCif/rlD9mw4hFOKZtzM+hNdNSvCMOfXtzgno/u7tCwYC1M0Q9O
         uSVINkEKY0Z6Mwzp0hrDM5Cxs254u3gTISUlsM8Tx4vkrsKEubzzQ0fQxG1O5W3ZK+il
         aQyQ==
X-Gm-Message-State: AOAM530enFlWyVuez88YOMfTHMeRgyq5arLam92j0LWEhLHbu2l/0OYV
        d72x+HuLnoyFMstvkNKW6D2PPwT7cmKtqHKvtSpUjMcuk4/1HRhWTlWEzcTKQ2TIfFXCFp0jQ+L
        dYprHXehc0KQtFWSeDiuk9yV1u1FSkdsY+Jcpxmyik/dOTFaAYVD8G+rs4WGtxw1cRGfwndqWdV
        A=
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr2134436wri.435.1639530074395;
        Tue, 14 Dec 2021 17:01:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/kD5oC1p1xgGsSZP32xaQGOGfLOxfEpCuwFsE2jsSpZ2HpZu822Wo3A/No2TIXrrU/tkX+w==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr2134418wri.435.1639530074153;
        Tue, 14 Dec 2021 17:01:14 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:13 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 28/60] drm/panel: ilitek-ili9341: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:36 +0100
Message-Id: <20211215010008.2545520-29-javierm@redhat.com>
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

 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 2c3378a259b1..707c5a7bf256 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -611,6 +611,9 @@ static int ili9341_dbi_probe(struct spi_device *spi, struct gpio_desc *dc,
 	u32 rotation = 0;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	vcc = devm_regulator_get_optional(dev, "vcc");
 	if (IS_ERR(vcc))
 		dev_err(dev, "get optional vcc failed\n");
-- 
2.33.1

