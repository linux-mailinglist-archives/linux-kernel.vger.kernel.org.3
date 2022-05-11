Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3025231BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiEKLcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiEKLcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 281EF532DF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2kp5jYCNfGNB7HC1VHLTEN7JTAmf+2Dpd6yPG+mBtE=;
        b=Ecdsr7AeyDSTqFCvjXiC0AN5cMo3nw00K/ohBrxurtf7PB9IV1UVKK9FYVXCtWvSWRbWD6
        CvfsugkuU4dh/uqXECOywz3+bKFPi5qosrEsGqhQoqvXzEX6zS8NfRPyBGy5jYyEN8tyUE
        TVr54hEfKvG/3y4fG9eCykNhPj8W4vU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-keFY4OJCN66s44MnPOK7OQ-1; Wed, 11 May 2022 07:31:50 -0400
X-MC-Unique: keFY4OJCN66s44MnPOK7OQ-1
Received: by mail-wm1-f70.google.com with SMTP id 205-20020a1c02d6000000b003928cd3853aso2694355wmc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2kp5jYCNfGNB7HC1VHLTEN7JTAmf+2Dpd6yPG+mBtE=;
        b=Z3M/ApB8aTBFhLftPDBdewOWAWMBhsRj6zVU5D99ZSw0IdsowUGD8b7gGGQVRriC+S
         VT7VjXEZApsSmGum3T72c3Azs4W+78eZpRQNJxe0tP4o/TFDCtkUbK3z8KnsNR3hm5u7
         yFHT3AhPV6/jwXZe1iLHK0sXzXbXU5MAh0HH+x07tKU0XlZ1PORJAsowqvtDd/kdrXlL
         t7em4AAxUAk9FiC/n6HWJAEhljPceWpPu382bleIBN9hEN+vnBeZ/ZiSdbmNfQrLbbrY
         I76rofaZ20R0GeOvTdcDYQSDqBz9owZ4D/5lett2f8fmyydY9F28+A///WIF5oBKsTow
         co5A==
X-Gm-Message-State: AOAM532vkAhMzkKMoBbidbVbxUapNvNV/QXnAJxYDdB7pxZAGxhtkaFC
        MRt/dmVAQdUe8FAdpxr8THWj1/UNmdrzumi+ZviJcx86GSJPkA/gxIVjwC51BsZsQ0yrVOaxs3Z
        fcMUb7wisZsU3hn5r6+C1qHhnGEnkw0T4yoz1aT1tfQHEoe18QBruH/YLkhM3jqkosH7pXmTMDh
        s=
X-Received: by 2002:a1c:4d10:0:b0:394:788a:24d7 with SMTP id o16-20020a1c4d10000000b00394788a24d7mr4323377wmh.113.1652268709343;
        Wed, 11 May 2022 04:31:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVdOZ6jj+GkTcslb2h+9g+NLK3aby//uMM8giiBszt74nPvf6lrNJh9rn58+o3dxXtHD+dwg==
X-Received: by 2002:a1c:4d10:0:b0:394:788a:24d7 with SMTP id o16-20020a1c4d10000000b00394788a24d7mr4323344wmh.113.1652268709014;
        Wed, 11 May 2022 04:31:49 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5308000000b0020c5253d8c2sm1450213wrv.14.2022.05.11.04.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:31:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 5/7] fbdev: Disable sysfb device registration when removing conflicting FBs
Date:   Wed, 11 May 2022 13:31:44 +0200
Message-Id: <20220511113144.1252729-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511112438.1251024-1-javierm@redhat.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
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

The platform devices registered by sysfb match with firmware-based DRM or
fbdev drivers, that are used to have early graphics using a framebuffer
provided by the system firmware.

DRM or fbdev drivers later are probed and remove all conflicting framebuffers,
leading to these platform devices for generic drivers to be unregistered.

But the current solution has a race, since the sysfb_init() function could
be called after a DRM or fbdev driver is probed and request to unregister
the devices for drivers with conflicting framebuffes.

To prevent this, disable any future sysfb platform device registration by
calling sysfb_disable(), if a driver requests to remove the conflicting
framebuffers.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

Changes in v5:
- Move the sysfb_disable() call at conflicting framebuffers again to
  avoid the need of a DRIVER_FIRMWARE capability flag.
- Add Daniel Vetter's Reviewed-by tag again since reverted to the old
  patch that he already reviewed in v2.

Changes in v3:
- Call sysfb_disable() when a DRM dev and a fbdev are registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
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

 drivers/video/fbdev/core/fbmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 9b035ef4d552..265efa189bcc 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1789,6 +1789,17 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 	if (do_free)
 		kfree(a);
 
+	/*
+	 * If a driver asked to unregister a platform device registered by
+	 * sysfb, then can be assumed that this is a driver for a display
+	 * that is set up by the system firmware and has a generic driver.
+	 *
+	 * Drivers for devices that don't have a generic driver will never
+	 * ask for this, so let's assume that a real driver for the display
+	 * was already probed and prevent sysfb to register devices later.
+	 */
+	sysfb_disable();
+
 	return 0;
 }
 EXPORT_SYMBOL(remove_conflicting_framebuffers);
-- 
2.35.1

