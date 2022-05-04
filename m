Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A76A519D58
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348291AbiEDKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbiEDKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2A9022BE9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651661510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NJbghp3+LJBmX5DLTTjlRaPAzEhF/Td/rezzenPMwDw=;
        b=Sx7+P8Yfn5aRo9SAuikjdcSjMpfmrg61kYl6mvsG3T5qA4kPsXWm5Fe5m68xqpR9HPQxzN
        KwUohBUlpzm6gLhoQ447q9o5Qr+wr7OUbDrINLHWleY2OBX6xwLWA4z4hye5G4ozgIlfpU
        Cj1ZHHiBR/PY6P/uVRQ1FjHbf9gWhdE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-zOV74m11MKCFhmS4QqvNyQ-1; Wed, 04 May 2022 06:51:49 -0400
X-MC-Unique: zOV74m11MKCFhmS4QqvNyQ-1
Received: by mail-wr1-f71.google.com with SMTP id j21-20020adfa555000000b0020adb9ac14fso251416wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJbghp3+LJBmX5DLTTjlRaPAzEhF/Td/rezzenPMwDw=;
        b=QPmeuZsRQRe87lTvlj4x47opLWECJ9Q708zoCjtnTJzbPTOio4dkHry+m5OESZgkWV
         sb/DGbB+qb/HQyNoBEhL377zRIgbv9AE09BM/e01p7oc+HEMl/1N8CItRQ9kFgbwn77N
         Z7p9MBzmPPFI7+R9rQM4lL2JdBzvDg2Hm1BnL7s13Rw7Yl66P99ZkwuSMnGbsaj8cOIf
         sxhqLPqN+WEVoGG6/uABtbtyLZMvdg/s3l8XCZ3ScEyMcRDV8bJWLYovNDg8s2byQVZl
         LIrx1kwx5ol5NcStYh74lCTCVxhA7D0fwx9Qpalq9/xfjPKYmKlGkSPqCpI3DBV3rNsq
         8NKw==
X-Gm-Message-State: AOAM532p3JjgNVkNiwp5GKMxXYtTB0rjW/D4GLe54elbVR4MRZyM9AeC
        aKi4QKqJFkk8if8L/ElA0oqsHrwtbMF2RFhcaZLul4+sJira8Uy/5SCtjl4LXxPviCjVdy+qQVr
        YdH66L4zGM66d93SjwyRuBPhTTbYGZi/arFuYoY1oXg89uG8pPvJDSJhWH3XfLRLgbm3H97WTIF
        8=
X-Received: by 2002:a05:600c:3b93:b0:394:57c8:5901 with SMTP id n19-20020a05600c3b9300b0039457c85901mr2728283wms.77.1651661508194;
        Wed, 04 May 2022 03:51:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHwZYfl8uqgIw+kp7JWSBmK2205DO05PCu90DnmuLlXgv2vl2YCs3ySMEP+CKrlNnqkYViRw==
X-Received: by 2002:a05:600c:3b93:b0:394:57c8:5901 with SMTP id n19-20020a05600c3b9300b0039457c85901mr2728247wms.77.1651661507884;
        Wed, 04 May 2022 03:51:47 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n14-20020adfc60e000000b0020c6a524fd5sm6700603wrg.99.2022.05.04.03.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:51:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] Revert "fbdev: Make fb_release() return -ENODEV if fbdev was unregistered"
Date:   Wed,  4 May 2022 12:51:40 +0200
Message-Id: <20220504105140.746344-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
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

This reverts commit aafa025c76dcc7d1a8c8f0bdefcbe4eb480b2f6a. That commit
attempted to fix a NULL pointer dereference, caused by the struct fb_info
associated with a framebuffer device to not longer be valid when the file
descriptor was closed.

But the solution was wrong since it was just papering over the issue, and
also would leak any resources that might be reference counted in fb_open.

Instead, the fbdev drivers that are releasing the fb_info too soon should
be fixed to prevent this situation to happen.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 97eb0dee411c..a6bb0e438216 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1434,10 +1434,7 @@ fb_release(struct inode *inode, struct file *file)
 __acquires(&info->lock)
 __releases(&info->lock)
 {
-	struct fb_info * const info = file_fb_info(file);
-
-	if (!info)
-		return -ENODEV;
+	struct fb_info * const info = file->private_data;
 
 	lock_fb_info(info);
 	if (info->fbops->fb_release)
-- 
2.35.1

