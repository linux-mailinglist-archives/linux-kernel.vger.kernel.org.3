Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A469475025
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbhLOBC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239005AbhLOBBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DjrFVfXcl13gsqHz0jlu5PwI7gXEaTj3y59F9LJzTf4=;
        b=AFFZTVfdXiS3bg7yhqYhl4l9ZIdWVU96DJeSKvygCBmDfNOLT/BaxzGOGAqUJ3jShqmx5X
        OQ910wCIvGyHWQXojfK7BCfKjVc9NI5UcrU7wc47RAJG/0/So53l/hULa4cgeXyKibjWt0
        GnKkaMqal41MXa9/FY1044QSW1vMdQk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-OGdCgX5bMWqtEfnlWLDnbQ-1; Tue, 14 Dec 2021 20:01:29 -0500
X-MC-Unique: OGdCgX5bMWqtEfnlWLDnbQ-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso13872473wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjrFVfXcl13gsqHz0jlu5PwI7gXEaTj3y59F9LJzTf4=;
        b=X0JP7lCsQVOyHk4mRu/muW9jh+2K5nu91POtvJk6TXkjP+cxitE1Tpp5KR2HIJOvCo
         E/ZYXzoP6pP9nrEo/SFNcCbNrYR3aEHA5MI4Ved5TIb8IJGBkrfX7dtkg791bQk7BQXO
         Z2USJ+4mGZMFZR1ch+r6USHWBk84s1QyVklVUHX7fnfZImnl2vVrbOpo4rKSh2txveof
         QVBwtF44mk1BPKquIeHgGPS95JO+qyOoP6VGncda+jSPQ0DGdgqIRNTxUhxwHqh6WIMF
         Ws/EfSgGyXgE/K+ouVx6UDmGtqCOjVZRSY9gvFLkmQHpPelNVhotvewLGnb7wqQUBTJe
         m+rw==
X-Gm-Message-State: AOAM531iqR3IPGpCyn4E95Ueezr1GcUHlSvzDEdgjM2Ngy262oFnxND1
        HucSlz2U1Rs5T1BeEa3qY73DGCEFpoIxW6RHcFFfGYt+EtJiCSEoGy5Jd+jvq07mAbozrTF9Vht
        HcrTT72W25LZLNZGD6Ho5FH/GWzbKV5XzFp8moa39U1RiJYglm0Ik6rL2ykfN86KSKkaQAkmoVM
        8=
X-Received: by 2002:a05:600c:19cc:: with SMTP id u12mr2469225wmq.24.1639530087962;
        Tue, 14 Dec 2021 17:01:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVhwmKE9m9aIxWzeCddXz7W3+Vdj/kFC/plUVVUcsEZaD3joZtzHOhk4gtl6MIZWnvxHMnRQ==
X-Received: by 2002:a05:600c:19cc:: with SMTP id u12mr2469205wmq.24.1639530087658;
        Tue, 14 Dec 2021 17:01:27 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:27 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>
Subject: [PATCH 43/60] drm/tidss: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:51 +0100
Message-Id: <20211215010008.2545520-44-javierm@redhat.com>
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

 drivers/gpu/drm/tidss/tidss_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 7c784e90e40e..5a6ff5af6d26 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -124,6 +124,9 @@ static int tidss_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "%s\n", __func__);
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	tidss = devm_drm_dev_alloc(&pdev->dev, &tidss_driver,
 				   struct tidss_device, ddev);
 	if (IS_ERR(tidss))
-- 
2.33.1

