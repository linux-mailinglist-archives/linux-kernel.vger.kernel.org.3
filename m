Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0974E51448F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356015AbiD2IrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355964AbiD2Iqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D57A63879C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/nkZHXCBB5ZrJnB24ro/1pCmNvdbhB1vwTZ80wJLns=;
        b=eETKrAnUtaKf3YNwNIkU0gjWjnir1lCPhqv2nHuZC4i11qP3ZZWMZkuocy8mkQtQ7BcT5l
        czLU8lU43hE/CNCpxq1hZ9qeupK0I3eHT71uHbTmVV6VdX18ZPT4+Zwsg4GLvckdJ5Cz2s
        49ceEQFfVrk7RjFzixtklAr+mwjVQq0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-iSx-TqE1PYyrizYWHZKHSg-1; Fri, 29 Apr 2022 04:43:19 -0400
X-MC-Unique: iSx-TqE1PYyrizYWHZKHSg-1
Received: by mail-wm1-f69.google.com with SMTP id m124-20020a1c2682000000b00393fcd2722dso2221519wmm.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/nkZHXCBB5ZrJnB24ro/1pCmNvdbhB1vwTZ80wJLns=;
        b=XaY2dPu/lFT6NMPZi5s+4KX4jmMSM270XPQx6bvj8HN+8yCMwKpgWcXo5Xwhmd62S/
         GCNV6TKUpWUXAXVcyGsayNxCqc3EqtX0NUn7o5NjGLPY7vyzuq4R5vmQZm3FVNfPkreJ
         Rj9qLbWxa8xszNvnBGI+G90MqUfXLGHKgWhqikajYdXx7SGqidXMSV6lSXQceigClkTr
         ott98xEfYwU6RrM2AA95Ij+ebn2muftFRRY4QDNtMVjnMncrBfIcmDChQCR/tnq+ARQp
         vvXkVmmVMwBUaQFmeUAGdXNGIr5xKrygDgugK8ehqm+O77q5B7V6KgIFdfGYlelkqYuv
         gXWw==
X-Gm-Message-State: AOAM532scbOI0Oj6pD6hbTLFslrUAuhzRoA7GKitLGKWjE+Yf0X62ZXV
        JqwtoAoEJWqpICgSOmtOMQ6D5t68V/9ZVZhioYg06ZpnxVSxgzn1nfszAxi9JXbRNKe+QuFckqe
        PETuaFkZtpbKzlms4cOrgv8nU3Hl+QTLdSxeKxnATT+o5Hh3nLG/XL+nDNMjSC8t/LFA5HMjDi+
        E=
X-Received: by 2002:adf:decb:0:b0:20a:c975:8eec with SMTP id i11-20020adfdecb000000b0020ac9758eecmr28946012wrn.438.1651221797515;
        Fri, 29 Apr 2022 01:43:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Bnodipm9XVNni3rYsFrTH34G/LMUhH0fq+PeE59BdcIE+fgw0hrkNZbBfqT2Hiuz7RWIbw==
X-Received: by 2002:adf:decb:0:b0:20a:c975:8eec with SMTP id i11-20020adfdecb000000b0020ac9758eecmr28945970wrn.438.1651221797201;
        Fri, 29 Apr 2022 01:43:17 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:16 -0700 (PDT)
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
Subject: [RFC PATCH v4 08/11] fbdev: Fix race between sysfb and framebuffer devices registration
Date:   Fri, 29 Apr 2022 10:42:50 +0200
Message-Id: <20220429084253.1085911-9-javierm@redhat.com>
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

The platform devices registered by sysfb match with firmware-based DRM or
fbdev drivers, that are used to have early graphics using a framebuffer
provided by the system firmware.

DRM or fbdev drivers later are probed and remove all conflicting framebuffers,
leading to these platform devices for generic drivers to be unregistered.

But the current solution has a race, since the sysfb_init() function could
be called after a DRM driver is probed and requested to unregister devices
for drivers with conflicting framebuffes.

To prevent this, disable any future sysfb platform device registration by
calling sysfb_disable(), if either a framebuffer device or a DRM device is
registered. Since in that case a display will already be present.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v3)

Changes in v3:
- Call sysfb_disable() when a fbdev framebuffer is registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
- Drop Daniel Vetter's Reviewed-by tag since patch changed a lot.

Changes in v2:
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).

 drivers/video/fbdev/core/fbmem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d6ae33990f40..7583296481b0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/slab.h>
+#include <linux/sysfb.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/vt.h>
@@ -1903,6 +1904,17 @@ register_framebuffer(struct fb_info *fb_info)
 	ret = do_register_framebuffer(fb_info);
 	mutex_unlock(&registration_lock);
 
+	/*
+	 * If a driver registers a framebuffer device, then it can be assumed
+	 * that a display will be present and there is no need for a generic
+	 * driver using the firmware setup system framebuffer.
+	 *
+	 * Disable sysfb and prevent registering simple framebuffer devices,
+	 * but only do it for framebuffers that are not provided by firmware.
+	 */
+	if (!(fb_info->flags & FBINFO_MISC_FIRMWARE))
+		sysfb_disable();
+
 	return ret;
 }
 EXPORT_SYMBOL(register_framebuffer);
-- 
2.35.1

