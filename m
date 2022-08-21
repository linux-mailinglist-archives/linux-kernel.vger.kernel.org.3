Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C300459B33D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiHULRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 07:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHULRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 07:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9464A24F21
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661080664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AxRts5aJ3HNvwn7dKavqQBNSNcUCmP54o8Yv9Iyp9m8=;
        b=W28/KW19fVoLvXdzvx5EyRkGGeR0FoxbOCiMf20ag7X1+YvdIOmwmpJ9OneYkjKTNJHw/I
        JXyzSvZfCpIN8z8CI/4O+saB+2LHZT7QZBoQb8c+095+vUTKAAP+r7Nmj+ELMBvNo0SGLG
        tRYspS3MUg6BCtdbxWxdFqawtVujyPQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-509-MBcwq-XXPo-6VFKoJal1gA-1; Sun, 21 Aug 2022 07:17:41 -0400
X-MC-Unique: MBcwq-XXPo-6VFKoJal1gA-1
Received: by mail-pj1-f70.google.com with SMTP id t10-20020a17090a4e4a00b001fab2c791dcso4818824pjl.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 04:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=AxRts5aJ3HNvwn7dKavqQBNSNcUCmP54o8Yv9Iyp9m8=;
        b=KXKth31M4ON5BlsI6KQbPX20UoWF6vRwYCvsreUlM012EkKlq/QFLqfhKKEU4Mm6ok
         oH6vypZtz6Trpt5PR+84/+FbAmmnVimtRug9k3AUM5n/937N2/PLZ0SodkmheqEbX2o8
         kxP2TEedFHi5sYGujUUbd6BpcLCMFXl+aOjBgTry9XDwHxcQ7P9vW+WWgQ4dorOWu0I1
         RKlxDIib4FC1IhC6GhB+6t8g6wJ3wWb9+uSHyNMttzn5qRu2sU6PqDSblV2PXPqI+NRB
         oJEAKSVdvPPzxltkH12brO6/0H3PdoHKbXdmjS+kBC4UP29/zEFV5hlZRg2KxlB3abNH
         7dqw==
X-Gm-Message-State: ACgBeo2+Ss36/F2GOvRFOX6GvfLJpd4iHA7qcPZT+X3PoqE7yT9GzjZU
        b+m7qPljY+AnFOMvKyDd7JgzaalQwMMa6d1qkw0p6cG0OfqGWOatunQSchtPYOZiAlt65eKpC/c
        8i7+plcpJ5UyN05I+wPsWD0al
X-Received: by 2002:a17:90a:e586:b0:1fa:d28b:ab9b with SMTP id g6-20020a17090ae58600b001fad28bab9bmr16538357pjz.47.1661080660364;
        Sun, 21 Aug 2022 04:17:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4kgULb8Oe4M5i8Q1aOVIChTcGskCxiNDQX9B8sJq/7wZLjPKLFXM/9i4rUtW/O1NjahDdO7Q==
X-Received: by 2002:a17:90a:e586:b0:1fa:d28b:ab9b with SMTP id g6-20020a17090ae58600b001fad28bab9bmr16538337pjz.47.1661080660102;
        Sun, 21 Aug 2022 04:17:40 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id w128-20020a623086000000b00536463e3802sm2835382pfw.36.2022.08.21.04.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:17:39 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] fbcon: Destroy mutex on freeing struct fb_info
Date:   Sun, 21 Aug 2022 20:17:31 +0900
Message-Id: <20220821111731.247446-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's needed to destroy bl_curve_mutex on freeing struct fb_info since
the mutex is embedded in the structure and initialized when it's
allocated.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index c2a60b187467..4d7f63892dcc 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -84,6 +84,10 @@ void framebuffer_release(struct fb_info *info)
 	if (WARN_ON(refcount_read(&info->count)))
 		return;
 
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+	mutex_destroy(&info->bl_curve_mutex);
+#endif
+
 	kfree(info->apertures);
 	kfree(info);
 }
-- 
2.37.2

