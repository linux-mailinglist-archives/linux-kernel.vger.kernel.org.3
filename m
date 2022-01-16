Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3648FC94
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiAPMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiAPMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:17:13 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D33C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:17:13 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s15so725566pgs.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7lHHDE7DULw2iuAGng68Tx7RluE3YCYjYU45KpHja5M=;
        b=Dw+4IGYoB2O2A7GfZrTCEv7rd5/kz1dz83exENanYGkvT+WU0oTrng5PPLbjx8tDju
         VfBD1saC0FlIdj7RzKKHDyv+zTb5G3A7vHoB0FEe1rjaKt48ryXYuhNEbsbM4Yp05olv
         +Tsj3Ip71oHRYyzK8q9+UqqqKtD7tKAijSrwHuhmjPzjAgKbwizexzgtI+XtOlArHJu+
         w0iDEBOot7u4KeruTgOz4F/OyVwI+GTXcFtF1W/Y1P40hw5KeC/g7eNF38YmVs5AkxSC
         fkdt3UthhSy4W+YAP058uWG6PLVxfbDzxs7yfsiIyC+IWbNXbMbhgh/CnpWO27DpdXf9
         feBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7lHHDE7DULw2iuAGng68Tx7RluE3YCYjYU45KpHja5M=;
        b=57MKRWG5kea6FBPxd3qjClc6f3kTI2KsB5hD6wrktZ0PFtxCkxU4C7CZ7bvmTh4Vwl
         7zLhWIfemgNjqYovMmEfknNEht92AbPMsqefHC3TBWVHuroK3uq3CehyniA2u5vXbzKG
         nySyfXvw1OnTv3AhPXbp7c9etGXmhBGGbqxFMaIa/B9CoD0poLbVY5oUXhIkfbYzALZV
         Ravjvjk+jv+bXLukBcaYINgYJHEtB4IvC5W7vzfthoFMqtISL864tkAOzlL85YyM9S3t
         /40rlcyX0MeGsrdRrySUSx3QWYofCQyeWaXSLyqZpjYYav4fkbrjY+CiuFDvAtuDbqKo
         jrsg==
X-Gm-Message-State: AOAM532/2vIhaQ5TJVG55dJoPo6FTmk6WsomsBafc0tAzj3YGUEppiVK
        29lkv8XfaSgJvheMhBsen1U=
X-Google-Smtp-Source: ABdhPJyaZfzHYFYwTW9RagAmwxf+w3WxNxDT+WTUWEh7xjoEvvJu2pNjVqbPqayYkjvtMFmFb+i79g==
X-Received: by 2002:a63:d245:: with SMTP id t5mr2713419pgi.215.1642335433011;
        Sun, 16 Jan 2022 04:17:13 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id w23sm16697484pjy.2.2022.01.16.04.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 04:17:12 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     javierm@redhat.com
Cc:     bp@suse.de, daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        linmq006@gmail.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
Subject: [PATCH v2] drivers/firmware: Add missing platform_device_put() in sysfb_create_simplefb
Date:   Sun, 16 Jan 2022 12:16:54 +0000
Message-Id: <20220116121654.7730-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <735d2b47-227f-f09d-ddd6-28bc82a066a5@redhat.com>
References: <735d2b47-227f-f09d-ddd6-28bc82a066a5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_device_put() before return from
sysfb_create_simplefb() in the error handling case.

Fixes: 8633ef8 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- Use goto label to avoid duplicating the error code logic.
---
 drivers/firmware/sysfb_simplefb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index b86761904949..46d776c29174 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -114,11 +114,15 @@ __init int sysfb_create_simplefb(const struct screen_info *si,
 
 	ret = platform_device_add_resources(pd, &res, 1);
 	if (ret)
-		return ret;
+		goto pdev_put;
 
 	ret = platform_device_add_data(pd, mode, sizeof(*mode));
 	if (ret)
-		return ret;
+		goto pdev_put;
 
 	return platform_device_add(pd);
+
+pdev_put:
+	platform_device_put(pd);
+	return ret;
 }
-- 
2.17.1

