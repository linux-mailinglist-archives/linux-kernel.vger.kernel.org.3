Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3604CAB28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbiCBRJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiCBRJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:09:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56C72A24D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:09:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h16-20020a056902009000b00628a70584b2so1499366ybs.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZMpzNEO4OPsp548pYzGhk7wZS3nBzSDrcI4nxyW6tZM=;
        b=aiIy58X8kGzp5JdrFAHj8izY/rdF4BudQOUeB5/s3q4lshKXZ8omiY5VgIxx1xhf4Q
         dL4vmHW8ZXhN7rL9CYSUcnfn6JmdPeZOm0gq2PBtrVRbSuGpUhOtGZG3N2eKrLAKmSAR
         wWhWGgSCdOTafxyzWhmfnjnvO5aWcs15wKB4QVsUrdYVnaa9lYECPBmn9dahI2ohVyBw
         JZx+NG4w2d7VMBIOlTGPDcJSKtUIJaQ06z7RksYPil+b27jX2AhwrL6zQ9HN8f5XxQDF
         miXmPk/SGZHevMAarSD1RaPCIAyT8S2Pb1IC+5hY6XVK2bINUpvFjJjMymgqXMaFtds1
         obUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZMpzNEO4OPsp548pYzGhk7wZS3nBzSDrcI4nxyW6tZM=;
        b=tqC+tm/iMVp3RJ9onOOlAARwgc46ZpTKGA2mUjytvFgO4qBPkTlhmOgBULN7f61laV
         muf2hsetu5NPTCtdCAZLkIPoDLHuUYyt5D98MJ/6zotejmSrEMWUUlSBgZ3Wx5BOeKeH
         fI3bY7wLGwRAoNzIvIw764t9SY89iyCPyiA/rQcyB+dm55r/xRHOZGkqQPrSE5geOofb
         OondjRQd9HHDm/ipl4cj3XykkqAh9y8gVox+vjmEE3EUEfzpO/cIizUIyZa8BOofJzTC
         1nierndZW//0iHD72cSdQ7xs3ingFR/Zl9bGjNrkbBoO4AX6E2IeTl2wEtPXHMBJbHUC
         jdyg==
X-Gm-Message-State: AOAM532Owozn3eo5/mewVBPldzGhkXbkCymYs+XdnXx/+ZhjY3kzfamd
        /+d/v98kZtW5izHjib1HcQoVHGGjaXtP
X-Google-Smtp-Source: ABdhPJyL7D59S0c7J3/2Op0q9aw5Wnve+xXjWrrlV45CTNX4k/0oMEztpE6wC4lT9bO6+BQsyODILO5P7lBB
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a25:35c2:0:b0:60f:c5d8:99ff with SMTP id
 c185-20020a2535c2000000b0060fc5d899ffmr29221573yba.380.1646240948002; Wed, 02
 Mar 2022 09:09:08 -0800 (PST)
Date:   Wed,  2 Mar 2022 22:39:02 +0530
Message-Id: <20220302170902.752687-1-shraash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] drm: Fix no previous prototype error in drm_nomodeset.c
From:   Aashish Sharma <shraash@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        groeck@chromium.org, dri-devel@lists.freedesktop.org
Cc:     Aashish Sharma <shraash@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this kernel test robot error:

drivers/gpu/drm/drm_nomodeset.c:8:6: error:
no previous prototype for 'drm_firmware_drivers_only'

Including drm_drv.h in drm_nomodeset.c which contains
drm_firmware_drivers_only's declaration.

Signed-off-by: Aashish Sharma <shraash@google.com>
---
 drivers/gpu/drm/drm_nomodeset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_nomodeset.c b/drivers/gpu/drm/drm_nomodeset.c
index f3978d5bd3a1..9402deb4985f 100644
--- a/drivers/gpu/drm/drm_nomodeset.c
+++ b/drivers/gpu/drm/drm_nomodeset.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <drm/drm_drv.h>
 
 static bool drm_nomodeset;
 
-- 
2.35.1.574.g5d30c73bfb-goog

