Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC875475021
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhLOBCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238985AbhLOBB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYrw2xnMNhg0U7YDzpGkI2ybQK75rWuBPObQ2p32zAk=;
        b=fScvbo6vjxmm9nmbhBnHSdcfOb8WBRp7KgIz+3PnEVQHzYmgvELNpjrLXTZlilyWoxIvLY
        a7+qxXlGmyN4hiGHAQz7cnwf4lq7r2EmCLStHaMzlPpHE7HAnYuwsw2m0acghI1eZt35gm
        HHKG0wRChXssV12hJSha4YMxnU75y3s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-qjcuVcFjNAOpQiyDRAN3aw-1; Tue, 14 Dec 2021 20:01:26 -0500
X-MC-Unique: qjcuVcFjNAOpQiyDRAN3aw-1
Received: by mail-wr1-f71.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so616989wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYrw2xnMNhg0U7YDzpGkI2ybQK75rWuBPObQ2p32zAk=;
        b=d+PzUl+dYlkhdPrvkVVKGkx64DAvOsMssKY8scIYOAS3z23ULOR3m7BjsXsGzwYrfs
         mb5lybvtX4HOnS5u9R+zQgDz5hlNXcrDLVfCbQ8U592Nd9Kb3WSWG4xZOcRMeLL8oF4z
         INaaJfxmWRwYq0chl3rBdH4Q5kUNb7USC2xEkwungU79C0FcUp68PkQmDixSLD5za+yJ
         BXDdctOX+6ZP8C//wCeUByUgTPBUh6cH+nkmR7/NB1BN/W5mPfb0S8m0zFoIgfRs9jRd
         iNfpppVE0xyrFxihT+im5e+8FXeEL5B0eY6QQyGfxBOnJfvKvhn2E12xNGnP0W9mPaCW
         mF0Q==
X-Gm-Message-State: AOAM533R4SFCslWYL70Xpd505xDZEF5yttlTsWbWU8BnNMQJ8hlOUJ7P
        PU1sVLLpq3mmwam1m4kcQ865MbejBwQDazG2718tpiaC0oSYAOPPrRQLermhG1Cjc/KyU4x/Swt
        HJlLTbTNNqiFwXuen/uGs/N/IYDQLxvSsT46Kd2Uxhep3FNhh+Lju0Yb7tOFppALMO9CzTmnl/5
        Y=
X-Received: by 2002:a1c:1fd4:: with SMTP id f203mr2391808wmf.192.1639530084788;
        Tue, 14 Dec 2021 17:01:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyctY+3KAnMi+t5k8OWYKYcTTCahTecObLK7WAOymKI941Rw3uPqfUXzoeePmIpfuvR3py5w==
X-Received: by 2002:a1c:1fd4:: with SMTP id f203mr2391795wmf.192.1639530084593;
        Tue, 14 Dec 2021 17:01:24 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:24 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
Subject: [PATCH 39/60] drm/stm: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:47 +0100
Message-Id: <20211215010008.2545520-40-javierm@redhat.com>
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

 drivers/gpu/drm/stm/drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 222869b232ae..91ac5437fa40 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -183,6 +183,9 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
 
 	DRM_DEBUG("%s\n", __func__);
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 
 	ddev = drm_dev_alloc(&drv_driver, dev);
-- 
2.33.1

