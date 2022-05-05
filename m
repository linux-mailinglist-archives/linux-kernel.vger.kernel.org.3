Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D989051B5D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiEECZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiEECZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:25:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4796549F08
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:22:17 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id a191so2592150pge.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ef+sybKBAkUjKLs8tlJYfzgpqHk/AEhKYaj2VVeifvg=;
        b=OG/lleGzbi4WRp3eEVn2Ky39PrCMOzoBfa81MHSat9WWdT6+lVMGwstvSB7TyQrK0O
         ekPuX5JS4wq+jTGfYLENqJFAo8PYJ0lOsTN+qpSxH0S50gN1dgHXfv5wKC7rXy9o+CHx
         o76liOhu+Mj7Pejjz3EZ6g0SV75SJazPqoOzQG5qTHicMLiqT8td7jtc+6D0Sv9GMq7L
         BvNSCf/V9NPNxftEg3HDXhsHd9MsG9sXVL1ckLWa/boFegB5JA0RjPq7bxzR2O2I+wiz
         xTel8KCWKQ8Wrz86uuQ/hrVRBvEzo21tlHd3jds4Hq7TejkqH2sb7A5t7AFv3bNIMnt3
         +GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ef+sybKBAkUjKLs8tlJYfzgpqHk/AEhKYaj2VVeifvg=;
        b=QoqRW2Xr6ABXelNgGWBcBfoKikwR8fe1UXAul4P6alrN9iO/vjogwg2jVWa54l9DWn
         u5YSUMeTzk+SUIPNiq/sM7fxJsouVEoLjzgC80rsDwUGF3OQO/2BsvCUFmKtMsfunXTn
         CAOKCfEOWB2k8GIkunhfaIQvxMtgTBHKjMwvoUd0MMosWrj8ofIgeNeAcvoocmlcPE/k
         oE25bCMI6ICSJ9PMxMq7iY3sD9lyY2jRc7SIRIZD0R1pOYf5tKUSBz0GdFozFTSW3i2L
         DtTSfonS39NfP7Bo/OQz+J0B90uIrU4yZp5NMNkziPDvFoLhI9lrWM6yR2s9E5Nl77v4
         x6jQ==
X-Gm-Message-State: AOAM531doxTzGm0ui4wlqOLx/vXfwjDGnlDj8paNplQjj9lzy/4+C+Hz
        4koCzcr50EUWj0OMtWFm0m0=
X-Google-Smtp-Source: ABdhPJxwgs2AzWqDhC4ZlkGGOfEWL9n90q8upIDnCzYEAp4SHXBb9BBiuNWmzfxRnFREFEVH6h+mqA==
X-Received: by 2002:a05:6a00:c83:b0:50e:eea:1b9 with SMTP id a3-20020a056a000c8300b0050e0eea01b9mr10598547pfv.47.1651717336875;
        Wed, 04 May 2022 19:22:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v29-20020aa799dd000000b0050dc7628152sm99911pfi.44.2022.05.04.19.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:22:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     airlied@redhat.com
Cc:     tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm: simplify the return expression of ast_drm_resume()
Date:   Thu,  5 May 2022 02:22:08 +0000
Message-Id: <20220505022208.57157-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/ast/ast_drv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 7465c4f0156a..760b27971557 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -159,15 +159,10 @@ static int ast_drm_thaw(struct drm_device *dev)
 
 static int ast_drm_resume(struct drm_device *dev)
 {
-	int ret;
-
 	if (pci_enable_device(to_pci_dev(dev->dev)))
 		return -EIO;
 
-	ret = ast_drm_thaw(dev);
-	if (ret)
-		return ret;
-	return 0;
+	return ast_drm_thaw(dev);
 }
 
 static int ast_pm_suspend(struct device *dev)
-- 
2.25.1


