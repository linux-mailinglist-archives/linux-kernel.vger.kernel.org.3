Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8447500B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhLOBBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238789AbhLOBBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGTIhgk3Nk7+6Si7STv7J04XeA+V7br+Ro7B0SjyNKM=;
        b=ZjBrHumr0XuPCaWqueQByZEMdva7ucI/68Jwx6V6jMuaf2CGyV0HpTu3Wj0N5XJ89y0O1H
        bYnfAj+yhsHzw9M/rDN2wHR0tLV/8Sb51Mi1k7JjAveTt7k0FEyv/Q6EdZYw+/PEi8i2yV
        2qDvcvf7n2hMlIOI+H6wvf+U7U9HG4g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423--zjhEjShMUKzoowrt4wREw-1; Tue, 14 Dec 2021 20:01:06 -0500
X-MC-Unique: -zjhEjShMUKzoowrt4wREw-1
Received: by mail-wr1-f69.google.com with SMTP id d3-20020adfa343000000b0018ed6dd4629so5378655wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGTIhgk3Nk7+6Si7STv7J04XeA+V7br+Ro7B0SjyNKM=;
        b=Z78E0BlFRhNUunaBmlJEPQpA9f1sR1rp8Mhj4Y2tvURUYFTLz+wYgfc7nkg6XDOKJa
         26s3exVPRtyrnBLttNtMkDKo9nNqcDbz+nLZE2mE5RUNzHzReg7mAEwAeUjhu/PWksJi
         hClHSnwb3KXmni3jVhplyHojJgMIXWONBbckVWQXR4JfVHJzCgqurBvlFSxPEo+aXWAk
         r7rOKEgWXTYIrp4JDbuUanwy9jNfvpbPdf8JCoqqFZDiIhlKYUa1zqnScKCZWeyhVZI7
         4lXk+C5rSEwpE0LuXhnZ/ZU0WjlFBqcFfsbGG4pUxSaBwsEqXXMlvTfGN5tVrx/k3ign
         kJmw==
X-Gm-Message-State: AOAM532ybS5mTNUuoZ79SvrQpbXarFmbf4HZw4vSSJpR7jb5XFBD9085
        3rSX6e7ldFAMDY9pSY4t/I1kp5YKczJvJ1HUUPBczRJSmPiyVQc+YDSHPnlJJUw6IRQyXTJbt4M
        NaeLfKW2UzO4yKz9W6jmIesK0QNNNFJR9+xNbWFyzNrY3oCobRBOpSSdjyyVdTeaiK2BpC1Bvcv
        A=
X-Received: by 2002:a7b:c306:: with SMTP id k6mr2286481wmj.15.1639530064888;
        Tue, 14 Dec 2021 17:01:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLH34X5QqMkkKlKq8+U5eGGqpS6ask7gBEx/Kuxzk6vtNcXskqKxuZyjCx/2YEQmErgYtEWg==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr2286467wmj.15.1639530064637;
        Tue, 14 Dec 2021 17:01:04 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:03 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 17/60] drm/imx: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:25 +0100
Message-Id: <20211215010008.2545520-18-javierm@redhat.com>
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

