Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F2F563338
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiGAMII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiGAMIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C16229B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656677285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B65LnvwVebM/Zu3VWd+syVDDl93qGF7mRqg6vAIs64g=;
        b=GZbCYArdUdFRbanybNCeeVcAUwKfJxMe6fyu8pvpYO/f//qj7C5k3WePF6xdsDkMDd68Pu
        3XUS31ksdQzJVG7dM5oYkPIgWQVeLiyR1snJu6Fj3TXoZ0KnCdn9zwssBJyjHjY3/R64Fb
        nVxI3wy39jtT4KNEwYVHgQk6mCmdaH8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-7gY5VGVzMMCwCGD6l1dRxA-1; Fri, 01 Jul 2022 08:08:04 -0400
X-MC-Unique: 7gY5VGVzMMCwCGD6l1dRxA-1
Received: by mail-wm1-f69.google.com with SMTP id be8-20020a05600c1e8800b003a069fe18ffso2947476wmb.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B65LnvwVebM/Zu3VWd+syVDDl93qGF7mRqg6vAIs64g=;
        b=FvI20AhMO4i0qxiLjChTAJDWHh0LRTKJjAnbuJ30srD8w0JmW3XBgD4l3JW2ibhHNi
         vidDhVEtZ96Qod3+MOkdxcAffZT1wA4MbgVYlsMzxUujzIWRA583m4clZUJ//W9eKMBU
         sY4Ez0796NJhphd+ydMMvBA0mKgX/GggF9ulmtpa4SSgGlRqsds/Z8W8PskDFl3qulV0
         i4Z8dOBr4jNh2lU3jxX9V3esWfUqaX8+lvpS5Tqp4tHCISKx2OF0qHAds/iGn9Pb3w6z
         ZXM9nIPs8kk2HqZKSDnsu+Ohvq5QR0bcjwhGRk/E20W3zPBLk5sdQHX/luzsQgY6jgj8
         JJrA==
X-Gm-Message-State: AJIora9gUO5bIvDjhRAQ/uIpjcC+MfyYv1WR38XYpCS+hQJM+aj2pDI4
        d65giH6wxN1RfYIxgo61mSSSFfVHLvZYkYGMuEmikSUmjtp+yj/FbO7/IiUKxpMYo6vCSPNKZM1
        qLkuwkv1Eh+s3DuS+BHJ0MWs80GDE8H7PO7dVKBMEuwVcKNwrPPz28Md97eeD9evxfH4a2Sm4nU
        w=
X-Received: by 2002:a5d:4251:0:b0:21b:885b:2fcc with SMTP id s17-20020a5d4251000000b0021b885b2fccmr13751032wrr.52.1656677282662;
        Fri, 01 Jul 2022 05:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sC9Tmd/ElcPrMcZ/REfD/aw5cCDOVahi1PhOsK1QGHWkyFQshHyOgr1yV8DRgNx5hGf1doqQ==
X-Received: by 2002:a5d:4251:0:b0:21b:885b:2fcc with SMTP id s17-20020a5d4251000000b0021b885b2fccmr13750991wrr.52.1656677282355;
        Fri, 01 Jul 2022 05:08:02 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v4-20020a7bcb44000000b0039746638d6esm9813160wmj.33.2022.07.01.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:08:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm: Use size_t type for len variable in drm_copy_field()
Date:   Fri,  1 Jul 2022 14:07:54 +0200
Message-Id: <20220701120755.2135100-2-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701120755.2135100-1-javierm@redhat.com>
References: <20220701120755.2135100-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reported-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

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

