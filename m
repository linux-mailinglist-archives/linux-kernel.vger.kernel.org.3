Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EFB47477B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhLNQSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbhLNQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:16:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E400C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso16600490wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9d00CQxtuLbmKfZQEqLshscWS8poY4p1Q3lozDp6W9U=;
        b=SbE3bx+f/5vebISeux3XOeD2/aNUqaQrcGjt3G0WBt07k4+KjXOXMkOj2WEuEH+E3M
         I5IKN+AWdv18rkV7KuY46s0BFTo3fL6X/+pFlAxpWAN0peeUcujLQm7JX9fflkV92lZE
         kQXHf6kIL3cIqybWH0JG7yJZ+6UCSUm/aTgP5xxizgpx04PhaXggF1yukYCBLH/jnbbp
         8i/cW9pTBL59dp3zusGeCLQQpMCABRwJ75FHqp+tg5so3vDe4QPPyIrM3kMqsNBAe1Fq
         ng9a5vfhSgSB4oJF3KbJQeCjRQwxD4nSDi/69hoPIKYynBsekIzz9+kLEd9TiMS3c9lj
         2XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9d00CQxtuLbmKfZQEqLshscWS8poY4p1Q3lozDp6W9U=;
        b=J2S7GsJivIKxecOtRCbi3GEa1MQj845sW8+p4nejWL6lZ4Ol5E51D9cbbxC5ug5seu
         RIVWjeYS3cyr9NoVNqlclNKTz7I+uloDoSpQWY+cX+Gtb5ytsFQC0DgJVGbrKJMWIL/K
         Mf4kAk3nsxdmETyJnPDrtknAM/YnyHvbhklQWzOYelPJ9OVjEk407lQkanhLZyCchlYg
         lzWnpXH2gpuHgXgbb1o1yYEmhlx2d6WGG9odBTvUcjXX/+y7OaGMmN8iL7t2RK/LKEk0
         yYLvnHl8Z3u/8YFjx/H4u2CAtcGMvfikdy/nHh9/qRNrJTNHAPmRazsCCBcFv/EPyTr1
         2KFg==
X-Gm-Message-State: AOAM5307+Rj/Q1Lj1nz7WBlb9PxI0uj72RYpO7y1cxXm1oIpuDJDzL2b
        KpNBVh0WyosJEGiLqonffG3CYw==
X-Google-Smtp-Source: ABdhPJxT+E9CvwN1wHLmBTZX39LG4/yvi+mSQhr8wnCEGOY+hEFTHWQf2InARJC78rU3psWOJsVn1g==
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr47607517wmq.26.1639498605740;
        Tue, 14 Dec 2021 08:16:45 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a9sm295116wrt.66.2021.12.14.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:16:45 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 05/18] staging: media: zoran: videocode: remove procfs
Date:   Tue, 14 Dec 2021 16:16:23 +0000
Message-Id: <20211214161636.1886900-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214161636.1886900-1-clabbe@baylibre.com>
References: <20211214161636.1886900-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have a debugfs, we can remove all PROCFS stuff.
We keep videocodec_debugfs_show(), it will be used later

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/videocodec.c | 24 +-----------------------
 drivers/staging/media/zoran/videocodec.h |  3 +++
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 31019b5f377e..5bab7ba56257 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -16,14 +16,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
-// kernel config is here (procfs flag)
-
-#ifdef CONFIG_PROC_FS
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/uaccess.h>
-#endif
-
 #include "videocodec.h"
 
 static int videocodec_debug;
@@ -265,8 +257,7 @@ int videocodec_unregister(const struct videocodec *codec)
 }
 EXPORT_SYMBOL(videocodec_unregister);
 
-#ifdef CONFIG_PROC_FS
-static int proc_videocodecs_show(struct seq_file *m, void *v)
+int videocodec_debugfs_show(struct seq_file *m)
 {
 	struct codec_list *h = codeclist_top;
 	struct attached_list *a;
@@ -293,32 +284,19 @@ static int proc_videocodecs_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-#endif
 
 /* ===================== */
 /* hook in driver module */
 /* ===================== */
 static int __init videocodec_init(void)
 {
-#ifdef CONFIG_PROC_FS
-	static struct proc_dir_entry *videocodec_proc_entry;
-#endif
-
 	pr_info("Linux video codec intermediate layer: %s\n", VIDEOCODEC_VERSION);
 
-#ifdef CONFIG_PROC_FS
-	videocodec_proc_entry = proc_create_single("videocodecs", 0, NULL, proc_videocodecs_show);
-	if (!videocodec_proc_entry)
-		pr_err("videocodec: can't init procfs.\n");
-#endif
 	return 0;
 }
 
 static void __exit videocodec_exit(void)
 {
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("videocodecs", NULL);
-#endif
 }
 
 module_init(videocodec_init);
diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
index 8a5003dda9f4..3a508d326049 100644
--- a/drivers/staging/media/zoran/videocodec.h
+++ b/drivers/staging/media/zoran/videocodec.h
@@ -123,6 +123,7 @@ M                       zr36055[1] 0001 0000c001 00000000 (zr36050[1])
 #ifndef __LINUX_VIDEOCODEC_H
 #define __LINUX_VIDEOCODEC_H
 
+#include <linux/debugfs.h>
 #include <linux/videodev2.h>
 
 #define CODEC_DO_COMPRESSION 0
@@ -305,4 +306,6 @@ extern int videocodec_unregister(const struct videocodec *);
 
 /* the other calls are directly done via the videocodec structure! */
 
+int videocodec_debugfs_show(struct seq_file *m);
+
 #endif				/*ifndef __LINUX_VIDEOCODEC_H */
-- 
2.32.0

