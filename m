Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC20B48928C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbiAJHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbiAJHfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:35:54 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90EDC028BF2
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 23:31:08 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t32so10433244pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 23:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ocO6AD5IZFEF2fcpwCjlmCykPdbWqPQxRpQgFoAA8Yw=;
        b=AmTZGJScRDz3Z4ic1Kk2L/U1nJgZT8wshUfZ8ZKYhUMsfN7lcL+GqftGlit40Tb7T8
         I6DiWwMI4JgBK25/vj5rSXVPuOyzYf6XxiRNxTYtz1qJooWE3e0NLEgOLO0gLGIN9iTK
         eWP+DDsjuJu9P2aqqrSLP0ZPG74KmNNioUjqR5YISeBKtOmgtdYnyYCaBOStESd5XNbm
         uJBg088HVO+P8gdBmCG3dtccuj+D4Akjfi7DyAKDilu7kEkBxc2UTzW7dQd2MMWq32iu
         i29akqFcm6TOLCSOKsmwd4uxhnHYIQ8JQykggsZI2N3so+DuMwQIp9F4o6tsattnq3xY
         FYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ocO6AD5IZFEF2fcpwCjlmCykPdbWqPQxRpQgFoAA8Yw=;
        b=pme0aeXpItJ5KBjeeUcwJpaFTcK+l/war0A8Yy4acjhcqWD58XoJzZSS+uywKSZUtk
         MbqOlo77oa4Ph8Lipn4qZ/0ZM1UrxIiNsbQMytZ8GlGXrWkB3lXFYjdGA0v86iNUlmQQ
         WotGdRHwTnGzft5irKs+n88LQrXPpd5tj2ShvWBaU4Ax8KByK+WXoEaCZ7scKgQhKSaG
         cv15Brw2jbj8SMxcdpXUv+wIeY/W12haOLezZVbvWBzMm0gGcQi5kQkdFlBS/fi+OxCf
         9mgi54jZJuPOZbI6gaood+bxWqJLVVz68yGYIRzEFzKDC9vdK5k3xvRgEkNjyAniIj+o
         J9Dw==
X-Gm-Message-State: AOAM531xZjhVbQ66Of82zfyl3I29pPS6H9isfukcRKWaVfPEL5VDYj/s
        hBIEo0U3svXD3CKJspHSu+U=
X-Google-Smtp-Source: ABdhPJwNd99kMRjYeM+oFG8pgS4dz7JV4lfXvkTzZatdQflIwOFGgDZfZMi9isMQUl4DMGnaRzF6+Q==
X-Received: by 2002:a63:741c:: with SMTP id p28mr1818794pgc.277.1641799868416;
        Sun, 09 Jan 2022 23:31:08 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id w2sm4604589pgt.93.2022.01.09.23.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 23:31:08 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: syscfg: Fix memleak on registration failure in cscfg_create_device
Date:   Mon, 10 Jan 2022 07:31:00 +0000
Message-Id: <20220110073100.15497-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() calls device_initialize(),
according to doc of device_initialize:

    Use put_device() to give up your reference instead of freeing
    * @dev directly once you have called this function.

To prevent potential memleak, use put_device() instead call kfree
directly.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/hwtracing/coresight/coresight-syscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 43054568430f..007fa1c761a7 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -764,7 +764,7 @@ struct device *cscfg_device(void)
 /* Must have a release function or the kernel will complain on module unload */
 static void cscfg_dev_release(struct device *dev)
 {
-	kfree(cscfg_mgr);
+	put_device(dev);
 	cscfg_mgr = NULL;
 }
 
-- 
2.17.1

