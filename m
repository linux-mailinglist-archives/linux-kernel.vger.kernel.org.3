Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58111566746
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiGEKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGEKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDFE613E96
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657015358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sq1P6bjPwZGpMS6ut0qkpzOv+ePOi9aPiP7nYH2z6s0=;
        b=GVyZe242t9JoBVDlPdIJQIZ940fSpUQzr+AsY4kaYsRS8/7VQPbIc4GAexEj/haNwA5RSr
        Czf6hNSiJpncOvPxBC6cWOktAK0Bv2tl7PRYe5oheLaRR8t33sSSX2cZ5ANAFcZTMNyD4M
        tasPaFRXq348bGMVLqRJBcPE/1wjU0s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-3X3HCh6WO72H_DFVkzdeGQ-1; Tue, 05 Jul 2022 06:02:37 -0400
X-MC-Unique: 3X3HCh6WO72H_DFVkzdeGQ-1
Received: by mail-wr1-f72.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so1806427wrg.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sq1P6bjPwZGpMS6ut0qkpzOv+ePOi9aPiP7nYH2z6s0=;
        b=iIdiqS51J59YXb5umrLxQnO8pEfUjmtKxQqwU04nl4+PhiOtuYcSuhUGAQsflYhiFb
         2xLnqB+tskEGoI22k79+XyQ46ZVjUcEnq1OMC6qmAb/YVRnRFQb2f9ehoJG7FiGldOYQ
         PDpA1P5AYITFndlyk24TxZb7W4XHAxQzi1X+NsTS8mpHqhnLj9yp5LoDAQZXFkd8WEws
         bbywCFnM6m+OH/t7DlEzStWAjabk4MmESrU0rDlFq7xPHfEWSy6vozE4QtIiTWnfiKJM
         4rZlEJsZfClFAUjofxNi62g3JKilKarKEPvULTx5gx5fAuQvUzwsiQOjtmjWkwtnzeth
         e3XA==
X-Gm-Message-State: AJIora93xgef22LgjwEtA22qUR733QlGMl4xpITHtNLFKfqGt7DGOMDz
        JIBg5ZnFgHDGIM1L4cyeSQGR8WL/vbeaDOMRBRriQskVLovgiPcnzWYMXL9bnIhqUtHNqoPyaTs
        8gJ8RL3jJtuAhmg1+OqcBrsKQWzk1QbG1zK1CA1V4HNUoI/FDNbD9EKt9LjXkQB/oyrtbJHqaRZ
        Y=
X-Received: by 2002:adf:e889:0:b0:21d:6510:b750 with SMTP id d9-20020adfe889000000b0021d6510b750mr13203117wrm.498.1657015356468;
        Tue, 05 Jul 2022 03:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8SE6G4/Be28Rs7e4q8Eg7G3RpZqKHzTQ9mDJPsqfzMfDXb7eIz1ukYB668iijCdejuSh1Mw==
X-Received: by 2002:adf:e889:0:b0:21d:6510:b750 with SMTP id d9-20020adfe889000000b0021d6510b750mr13203083wrm.498.1657015356198;
        Tue, 05 Jul 2022 03:02:36 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a0560001b0700b0021d68e1fd42sm6255192wrz.89.2022.07.05.03.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 03:02:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm: Use size_t type for len variable in drm_copy_field()
Date:   Tue,  5 Jul 2022 12:02:13 +0200
Message-Id: <20220705100215.572498-2-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705100215.572498-1-javierm@redhat.com>
References: <20220705100215.572498-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlen() function returns a size_t which is an unsigned int on 32-bit
arches and an unsigned long on 64-bit arches. But in the drm_copy_field()
function, the strlen() return value is assigned to an 'int len' variable.

Later, the len variable is passed as copy_from_user() third argument that
is an unsigned long parameter as well.

In theory, this can lead to an integer overflow via type conversion. Since
the assignment happens to a signed int lvalue instead of a size_t lvalue.

In practice though, that's unlikely since the values copied are set by DRM
drivers and not controlled by userspace. But using a size_t for len is the
correct thing to do anyways.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

Changes in v2:
- Add Peter Robinson Tested-by and Thomas Zimmermann Reviewed-by tags.

 drivers/gpu/drm/drm_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 8faad23dc1d8..e1b9a03e619c 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -472,7 +472,7 @@ EXPORT_SYMBOL(drm_invalid_op);
  */
 static int drm_copy_field(char __user *buf, size_t *buf_len, const char *value)
 {
-	int len;
+	size_t len;
 
 	/* don't overflow userbuf */
 	len = strlen(value);
-- 
2.36.1

