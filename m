Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1048947500E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhLOBB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238807AbhLOBBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSF+bUA3xEcjh8nPd72L5+uQRin3zrf91XKxVnjhqv4=;
        b=bQkgYvETIm5YcrOqObEsFXlLt4cTRdBnU4ckM9dRsaoUvb2cFNVoZ4El29TGZ79yqGV4gE
        8gudD2aocfgdCamJIOYceac06B1A74OlQL70r44UGXGgcFEGzoI0OprGIPhZ0s2Jb+B0VJ
        Hdy4pOL4FC/54L9zc5A2z6lVUCmf1pQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-OEXRrAhvOHSm3aNDtUVWrg-1; Tue, 14 Dec 2021 20:01:10 -0500
X-MC-Unique: OEXRrAhvOHSm3aNDtUVWrg-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso13872172wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSF+bUA3xEcjh8nPd72L5+uQRin3zrf91XKxVnjhqv4=;
        b=vpHIk81OY13odpLQHUClcWV6RZ3BrSNvQ4KU4wmee0pBkkXiptK0y5hJmcWLUkLVn0
         ZBKcUoniQdbY6awla5FrSmpDhKUoKSZY+T/rnf9bfQ1xpr9o0Z1izZLMWo7qMoiO2YKP
         PtVl7xYwf71DaQWnOPjNRAKjGvc1XvBOrVKNFut2xiV+JDYXUnU2RGw9JlMMRLAUc/Yp
         D2OKqZNSJzrsbaKaWbCPu5u8Kpe9/80H7jw6DPg8TUsKarQmE9RmNO7X8tQiw/xOn0/7
         j7fKZniQdniwVl3gUZzvKGVp6mM5x9VD+9rA7qvNT7MCEctcclD8c5S0SsUzW1xnt+lY
         mkaA==
X-Gm-Message-State: AOAM532ng0/rPdi+E76S+h1PUQCLeIhW2m/Kk9vcic3Dd7m/UaX7e/gP
        dV7Jz80LgrlPGJLLdfU9HLJP2j2p4vPHUF0QiqaKER+5nuGkSYU1bfrL8UtzQ3Q+Zc3H2bQ6ohF
        Jt9maWigR/mWNQB1c4l8UtykaU2etolq8h9Tjs+9BrGOSO+o94/QpXFJ+ZXPhy6QDOmJ8ZHBjny
        8=
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr2231150wrs.108.1639530068545;
        Tue, 14 Dec 2021 17:01:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQfTCAIZvlx0CmQk3/dYaY5cX1Eaezs09nRWU5iMWZDaBP6F2SM5tcdm4Jsn+zp6nQUJC+Qw==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr2231132wrs.108.1639530068266;
        Tue, 14 Dec 2021 17:01:08 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:08 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 21/60] drm/mcde: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:29 +0100
Message-Id: <20211215010008.2545520-22-javierm@redhat.com>
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

 drivers/gpu/drm/mcde/mcde_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 5b5afc6aaf8e..0b2910e69b42 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -491,6 +491,9 @@ static int __init mcde_drm_register(void)
 {
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = platform_register_drivers(component_drivers,
 					ARRAY_SIZE(component_drivers));
 	if (ret)
-- 
2.33.1

