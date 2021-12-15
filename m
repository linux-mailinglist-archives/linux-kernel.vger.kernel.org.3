Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CB9475015
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhLOBCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238898AbhLOBBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlXhVbsfFFxgoHg3qvWCKHkfx1XeF32ozdnXauwSHqw=;
        b=PNus+LFgLjH3gNnOG9BIRc1LxSPfqZwpzi1Wjbrl2UpKwlCulO0gxG8UY3urlmq1yF0+DS
        4OJpq0eOvAvG5aQERNOpZIBaTb6gC2CpM9IwOU2g2vSy4Dfo6Ju7VGdhPMnlo5nERJD5Wx
        rcbpJaT0FuQHpk7ZZCv+AQOkFXOt2EA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-3kJp6q61POaH9mGUF-uADA-1; Tue, 14 Dec 2021 20:01:18 -0500
X-MC-Unique: 3kJp6q61POaH9mGUF-uADA-1
Received: by mail-wr1-f69.google.com with SMTP id h7-20020adfaa87000000b001885269a937so5416285wrc.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlXhVbsfFFxgoHg3qvWCKHkfx1XeF32ozdnXauwSHqw=;
        b=N1jRgcdRvZsqvpvcKOdJik7IVKun+COPcoGNCrU2uNkHwsOEbq3V8OtSZdWm4FdFV5
         0EumPgP4XDEfXoRApA1W9gSlMzzATB1mK4KQvD8BgfV0/SRYbBMMf6oTkkp0SXUHzfWk
         MeTQdo0inzIbvtMuRqmDEYM+aHPd862Lywe36FttajEH5gsjLYPAhNC10kAz0Sk5s3y3
         pKYHQv0G4VsRLVU5sZ0GBbq5YePn3TqcdNqAGVe/wudGaWka2crvxRqf4aIkd9fwU+GU
         fcCWMLeV2MXqJ0v6gO/KXSgs3+KldTrWOKH5VMXdLELAA5NN362iA70VdS8+jDH2OSPP
         JvbA==
X-Gm-Message-State: AOAM531hH/nphN6yvlvzYcor7nzddshwHpG2fgBHsq5bkbxo0fhekd/8
        /1AKuaitRw5q55JfLp66m7rKZ6/ILUPND9B7VSlbscJSV9hKXZRz5PSgGqPrQHVFY3jdFpEEgVQ
        +alcWXxn1akHIyfXOFnPENQpg0JNF4XlkKymDpX0PSjWQKFkK6BDr5tBvrrO9bnCo1mN9rXBRtg
        U=
X-Received: by 2002:a5d:4690:: with SMTP id u16mr2172720wrq.321.1639530077206;
        Tue, 14 Dec 2021 17:01:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2IKpNthIDTb/vshueDRQ12ykgOf/dujkn+q+fTdpsbe6EplDJChKvNt9qYLcnXQr1MXPhhg==
X-Received: by 2002:a5d:4690:: with SMTP id u16mr2172699wrq.321.1639530076970;
        Tue, 14 Dec 2021 17:01:16 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:16 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 31/60] drm/r128: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:39 +0100
Message-Id: <20211215010008.2545520-32-javierm@redhat.com>
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

 drivers/gpu/drm/r128/r128_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/r128/r128_drv.c b/drivers/gpu/drm/r128/r128_drv.c
index e35a3a1449bd..e49db9692df9 100644
--- a/drivers/gpu/drm/r128/r128_drv.c
+++ b/drivers/gpu/drm/r128/r128_drv.c
@@ -98,6 +98,9 @@ static struct pci_driver r128_pci_driver = {
 
 static int __init r128_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	driver.num_ioctls = r128_max_ioctl;
 
 	return drm_legacy_pci_init(&driver, &r128_pci_driver);
-- 
2.33.1

