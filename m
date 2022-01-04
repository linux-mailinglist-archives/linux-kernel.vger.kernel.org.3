Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BFA4840EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiADLeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiADLeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:34:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FC6C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 03:34:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id co15so31097571pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 03:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=os4z6bAoAuQKiwKAzgAwsavJk4dN+Zde+NS6z/SAMnI=;
        b=RPru+VuQQVViF2DnoPqu6NVjGrYcanVddPf4WLGTPaGRgAGCgJ90o3btI8Zuo8TSqE
         QE64zzKKzlYKw/DmK0U+RhCC/cluyTrZm4i+LY9BRTJzHHTN5hS54nHfqhtr5dvl4rRq
         lbjjv+XbnKHMHsX4YKm2abJWmmJFGN6p4+C/X1dpoxWkk4Sq32X46eXKvSHhR2LARBMV
         LfEWFgju4EUIulJoiavk5D9qKAZRCNyceybN7FJVhEmoQFncYlJ4Xl5D2HJliPES5FUf
         eSUHTuqYuy3h9g3l3dHUEblvVcooOzwT45oKTFknef4v8eGtoXv2FQEqGw8/jOs/sUl/
         va1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=os4z6bAoAuQKiwKAzgAwsavJk4dN+Zde+NS6z/SAMnI=;
        b=BSqiz6Of/DmpYQi3zXLdoAJbQtjK3Jf6rzOHH/clIOj6Qt1NAlgmjaKHAq0RvszuzD
         Su70ny1BKPDCNkVG1nX1RV0bGkttJVQzZ3hUDuztE8cYSFIs5X50w6+qNSzwEURvmcA6
         WpeROsG8LWA3lRi7LY8HzWqpD5AeXGvfNF5cvlCscVw2/TnllA7Ex++K1j6KhU0t9RqE
         uFgOXUus/46o9Lv7ampKLbmTKSh80qCbZWa3yxC6HRqO73yIzx57BpPP/hhhhOBwX+qf
         XSbZLIR7GoW4W9qW/ZMsiZya8IBf/E0fpygCPlLrjxpDPReDXYwxedOTrio4skpNjFlD
         4SzQ==
X-Gm-Message-State: AOAM530DFUe9lMbEUaVQGz8cFt8ARZbZbIwkPSC4D+l9qc1xyqSEwrR6
        YMZdFCztE6JA0P+M3eisP/0=
X-Google-Smtp-Source: ABdhPJw+63F1t3GbeXY6Pbow54ZweJVNngUmuRBNlf9YsxtCV+XVIuxW6ADrOez21humGNcv1PAASQ==
X-Received: by 2002:a17:902:dcd4:b0:148:b4c7:c608 with SMTP id t20-20020a170902dcd400b00148b4c7c608mr49532119pll.149.1641296058923;
        Tue, 04 Jan 2022 03:34:18 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d3sm43980545pfv.192.2022.01.04.03.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 03:34:18 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     ogabbay@kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, ynudelman@habana.ai,
        obitton@habana.ai, osharabi@habana.ai, chi.minghao@zte.com.cn,
        fkassabri@habana.ai, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH misc-next] drivers/misc: remove redundant rc variable
Date:   Tue,  4 Jan 2022 11:34:11 +0000
Message-Id: <20220104113411.602094-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from ocxl_context_attach() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/misc/ocxl/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index e70525eedaae..d881f5e40ad9 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -74,7 +74,6 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
 {
 	struct ocxl_ioctl_attach arg;
 	u64 amr = 0;
-	int rc;
 
 	pr_debug("%s for context %d\n", __func__, ctx->pasid);
 
@@ -86,8 +85,7 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
 		return -EINVAL;
 
 	amr = arg.amr & mfspr(SPRN_UAMOR);
-	rc = ocxl_context_attach(ctx, amr, current->mm);
-	return rc;
+	return ocxl_context_attach(ctx, amr, current->mm);
 }
 
 static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
-- 
2.25.1

