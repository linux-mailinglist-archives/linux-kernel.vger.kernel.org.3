Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A42514490
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356005AbiD2IrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355954AbiD2Iqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDAEBC4021
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=32BFmTqPr/eVAc9kmYw/jW8gg2xRyq+gsg/BzILupkI=;
        b=efbbGifaKziD950peZYu0dwFaHcRfwOKCs1tcdZC8enxFfH3OXTOkfbGoJf0IPWhqFRiDQ
        +w6f7Oa/D0Dm+kB5AI2iHgwC8GM98x8LvgpvSdAecO5wT4IdK8x5xltXWNdtLYGkadl//g
        scsBjwqwxZ/xJMj750B2yTnjLvrAay0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-hwRgAhOoMNuC614M36AGBA-1; Fri, 29 Apr 2022 04:43:17 -0400
X-MC-Unique: hwRgAhOoMNuC614M36AGBA-1
Received: by mail-wr1-f71.google.com with SMTP id n17-20020adfc611000000b0020a7e397ccaso2787756wrg.23
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32BFmTqPr/eVAc9kmYw/jW8gg2xRyq+gsg/BzILupkI=;
        b=WH9yE7/fMDnps2hxGYLgZmdZ/7PAn8b+prws4YsEHfKo+sMb6RIbDl0BoPjiuF20Uj
         My1Zf1zRYfGLEjZYfQRcUsT9GM4kdRXY/QghkVv/EzoJs1y8oNHs6u5I+/PP8ft3FnLs
         aW5Wgx4uqG7Z+gAMjAJIkCbwl7HTu7poCKHH5m3ZYjLz2Wgo5iGpniF0qxH5Xwtp6O87
         ikcDU0YxfgKsPKyy856KKaujpUTnFh/9tZRV+7FAfwHptmP2z1Md/CB7tt4fMk3SvdNz
         EtoEXeEpMyUqum6zHyOm6Gh+rxSDAeNYOzBPzIjb8aiSXuqvgzWD0n1i7ny9bYk4LqZg
         gDRg==
X-Gm-Message-State: AOAM530PtNfAm090E1HLszcrgnMI4QqQ2bTuSVwNqHStrUkqbcgkiSan
        9H++yOIzSek1qyTnbPKj1fPzr8oZruFR1H8oUUWAYHvdMR6X7G5vC1EGmWdfzoVoSrDz3qkYI8N
        cvYIIWc8cQ+3QhUXz47QBP+XGY+wjXjJ/focVo3JvrcRKuI5FqYmMOsT/4XIbVo7hmK+Y/Zebqp
        U=
X-Received: by 2002:a05:600c:29c4:b0:393:fdfa:9baf with SMTP id s4-20020a05600c29c400b00393fdfa9bafmr2106710wmd.26.1651221796345;
        Fri, 29 Apr 2022 01:43:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpb9GJOon/VWE7cLIvn3hOO2k4R3a9ThVl9BjzphxKGmE7ttlSfqH3kxxBUwJ+8zmSamy6eA==
X-Received: by 2002:a05:600c:29c4:b0:393:fdfa:9baf with SMTP id s4-20020a05600c29c400b00393fdfa9bafmr2106674wmd.26.1651221795966;
        Fri, 29 Apr 2022 01:43:15 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:15 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [RFC PATCH v4 07/11] fbdev: Make sysfb to unregister its own registered devices
Date:   Fri, 29 Apr 2022 10:42:49 +0200
Message-Id: <20220429084253.1085911-8-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform devices registered in sysfb match with a firmware-based fbdev
or DRM driver, that are used to have early graphics using framebuffers set
up by the system firmware.

Real DRM drivers later are probed and remove all conflicting framebuffers,
leading to these platform devices for generic drivers to be unregistered.

But the current solution has the problem that sysfb doesn't know when the
device that registered is unregistered. This means that is not able to do
any cleanup if needed since the device pointer may not be valid anymore.

Not all platforms use sysfb to register the simple framebuffer devices,
so an unregistration has to be forced by fbmem if sysfb_try_unregister()
does not succeed at unregister the device.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

---

Changes in v4:
- Drop call to sysfb_disable() in fbmem since is done in other places now.

Changes in v2:
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).

 drivers/video/fbdev/core/fbmem.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0bb459258df3..d6ae33990f40 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1585,18 +1585,35 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			if (!device) {
 				pr_warn("fb%d: no device set\n", i);
 				do_unregister_framebuffer(registered_fb[i]);
-			} else if (dev_is_platform(device)) {
+			} else {
 				/*
 				 * Drop the lock because if the device is unregistered, its
 				 * driver will call to unregister_framebuffer(), that takes
 				 * this lock.
 				 */
 				mutex_unlock(&registration_lock);
-				platform_device_unregister(to_platform_device(device));
+				/*
+				 * First attempt the device to be unregistered by sysfb.
+				 */
+				if (!sysfb_try_unregister(device)) {
+					if (dev_is_platform(device)) {
+						/*
+						 * FIXME: sysfb didn't register this device, the platform
+						 * device was registered in other platform code.
+						 */
+						platform_device_unregister(to_platform_device(device));
+					} else {
+						/*
+						 * If is not a platform device, at least print a warning. A
+						 * fix would add to make the code that registered the device
+						 * to also unregister it.
+						 */
+						pr_warn("fb%d: cannot remove device\n", i);
+						/* call unregister_framebuffer() since the lock was dropped */
+						unregister_framebuffer(registered_fb[i]);
+					}
+				}
 				mutex_lock(&registration_lock);
-			} else {
-				pr_warn("fb%d: cannot remove device\n", i);
-				do_unregister_framebuffer(registered_fb[i]);
 			}
 			/*
 			 * Restart the removal loop now that the device has been
-- 
2.35.1

