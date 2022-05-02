Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3851700D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385185AbiEBNNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385171AbiEBNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 066E0192BC
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651497009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jDUUd5wUXo34iLbUpw6jbiGIGpSLkimligm8emfXD8=;
        b=fmuM8T/JCLPWRDaPoaJMCJyz44l67WXmQGWtyb/uqAQSHi60cynzTyNc6XOH0WVoW9d7vj
        BZM0TpnN2vHaG1sfrEHdE4sC3qbaArWotfJG1Ct24/IjLKQLZfzdv61a/Oa1Ah8lzKigte
        whxre7DC76nhUwOdfYpcgDakokBIs9c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-blPzQCvuPB6LQjjxUkOG5Q-1; Mon, 02 May 2022 09:10:05 -0400
X-MC-Unique: blPzQCvuPB6LQjjxUkOG5Q-1
Received: by mail-wm1-f70.google.com with SMTP id g14-20020a1c4e0e000000b0039425ef54d6so2184233wmh.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jDUUd5wUXo34iLbUpw6jbiGIGpSLkimligm8emfXD8=;
        b=wRL++o91R7e+LRZsDeDK74JzC9DGCmlaUT/7+54qWNZQgXoUD4drnFAb+h40YNinbH
         hRQ6zz6o2NfTYI/ef713Ej1ZKxuXiHgmmElCMCsEh1xtl13Olj2JarH6c/6vcR2ahwcp
         1DRdK+M42HHmyVtCzCz+yIWCfO397UzF72pWDoe41lhYXAmOJHiCWm28AiNQfes2nYsM
         iRFd6onubjpyRS2eMtI2KlEKq5hR3jU2fyTyzwXwbFGHgXB7DBwiuerunO+O//Lcc+q8
         3K0CpmUV4A8szlWYHT1RdG833D8kvHBGvGl2MvDWCyWpz+EuaxNUywNPQWmoeVlXG6Ki
         lK5A==
X-Gm-Message-State: AOAM5338u3bwPTRlxfq+LqOA/A02/t8APrQGcjHAh+Gfu8at5AWMXsIy
        PSxbs2h2GVkwB6NxTxj6OwkZ1gqxcjituqCqPmCJaKsahP+W5RKMzV8X36mm8AQ3HmbrP9nSvIY
        4XNMDG4yM8KcxHkGPskHTl2ojbRGJfS1sGx3VGLYttmvzAJAhip3PpUxVoqV32mTCuOT8QDrxMJ
        8=
X-Received: by 2002:adf:d1c9:0:b0:203:c225:d042 with SMTP id b9-20020adfd1c9000000b00203c225d042mr9246079wrd.630.1651497001669;
        Mon, 02 May 2022 06:10:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOkTguHAtECK69/s/1UYa4VaS8/fQLKinHt0F/MRa24f9/shVWIWvvemP/4uJ44EqjTVqlaQ==
X-Received: by 2002:adf:d1c9:0:b0:203:c225:d042 with SMTP id b9-20020adfd1c9000000b00203c225d042mr9246054wrd.630.1651497001394;
        Mon, 02 May 2022 06:10:01 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y16-20020adfc7d0000000b0020adc114136sm9302081wrg.0.2022.05.02.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:10:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was unregistered
Date:   Mon,  2 May 2022 15:09:44 +0200
Message-Id: <20220502130944.363776-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502130944.363776-1-javierm@redhat.com>
References: <20220502130944.363776-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A reference to the framebuffer device struct fb_info is stored in the file
private data, but this reference could no longer be valid and must not be
accessed directly. Instead, the file_fb_info() accessor function must be
used since it does sanity checking to make sure that the fb_info is valid.

This can happen for example if the fbdev driver was one that is using a
framebuffer provided by the system firmware. In that case, the fbdev core
could unregister the framebuffer device if a real video driver is probed.

Reported-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 20d8929df79f..d68097105f93 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1439,7 +1439,10 @@ fb_release(struct inode *inode, struct file *file)
 __acquires(&info->lock)
 __releases(&info->lock)
 {
-	struct fb_info * const info = file->private_data;
+	struct fb_info * const info = file_fb_info(file);
+
+	if (!info)
+		return -ENODEV;
 
 	lock_fb_info(info);
 	if (info->fbops->fb_release)
-- 
2.35.1

