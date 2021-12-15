Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D4475009
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbhLOBBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238788AbhLOBBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5taMeHi+WZ03jn0R5MLOtTfk5pnEnWUxaNLqRe+t+dY=;
        b=Iok7azdWVJvdVW4zc1JuZG2OVWBlXpmS3RiBBK6E1n6BR6+Zv84vRh9/0J4MOWmWkZ13T7
        NSWiiCrK2L/PnGTrB1tLq3jKBi/Cps7HUZJKTg8Mc2DD/OuuEGpMXe5MRGxPkkFdrflupu
        wUgaU/uVvnBn4Yza6J+MrDB0lSFZ/zM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-TVSPyOyjNu-oF2Nq1xswLg-1; Tue, 14 Dec 2021 20:01:05 -0500
X-MC-Unique: TVSPyOyjNu-oF2Nq1xswLg-1
Received: by mail-wm1-f72.google.com with SMTP id j71-20020a1c234a000000b00342f418ae7cso13891746wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5taMeHi+WZ03jn0R5MLOtTfk5pnEnWUxaNLqRe+t+dY=;
        b=YVuzcvcbP9bLiZqDhM1385EEFHEKFG5HFZZQ28pa7cMdkx63bnLatv6ywW/K2vLJQ/
         HjHAp2pcF8aRG1RFU+CxScEoOeUrKRv67K0CPu2uUW8D512cIWc9dSUaHVO5Zkr5lvrG
         8EfCzw9xK0cf3a/ejnL4j+TfxcvCnLPgSzBLD8HXEULg4eOH4VxDlgxYzIdzaCzj77iM
         muddAlQGCRplpD0hf7COU4mRxzLRBQ/75YZ7U544kWibc0FRnj9qynp5uI3sVBU5Xq+c
         zMJWedeYMvMQxmcCZaMRfU3ZJiQRxw1/lmLESjFcDr8JkoMpc9n2MoBqhIhsb/WSEx8e
         HEDQ==
X-Gm-Message-State: AOAM530q8dkA4RnAfLbFgC6FjAyMohOfyMCTYHGGdw/VpsTmqVIrRwP0
        LAU45ioK9Is1SPmCYaCFzw1bm7KmtVZaliDG7H6ogrF/cl10l7VfHCr8io3X8vGU1bI8ZdNw3H/
        dJOzDc9t74s082q7+hNWgO4cfXdKOaMcu1RNpP0wgOGsPRvOoyGiin8MDQmhDJ4t2GBX7BT7zRY
        E=
X-Received: by 2002:adf:9e49:: with SMTP id v9mr2082504wre.469.1639530063820;
        Tue, 14 Dec 2021 17:01:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygOR/3zg1Gr6Uj0q1vAoqhAOvJOXCRLk4ZM8F11F7wFVnfUa2K8r9XAYPyOMZCxd3XENI2ow==
X-Received: by 2002:adf:9e49:: with SMTP id v9mr2082488wre.469.1639530063576;
        Tue, 14 Dec 2021 17:01:03 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:03 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 16/60] drm/imx/dcss: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:24 +0100
Message-Id: <20211215010008.2545520-17-javierm@redhat.com>
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

 drivers/gpu/drm/imx/dcss/dcss-drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-drv.c b/drivers/gpu/drm/imx/dcss/dcss-drv.c
index 8dc2f85c514b..5be591da7389 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-drv.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-drv.c
@@ -38,6 +38,9 @@ static int dcss_drv_platform_probe(struct platform_device *pdev)
 	int err = 0;
 	bool hdmi_output = true;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	if (!dev->of_node)
 		return -ENODEV;
 
-- 
2.33.1

