Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8B5B2609
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiIHSn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiIHSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:43:57 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEA89B2DAF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VLk+4
        dXxapQmWBdTRbZy57Jgwx0nYoiESWlgu108ej0=; b=jcifshi5YglJz/5vXVt6N
        75pxlzlIRif1JAU0hC6K7tLgA15nmBNnyf3JtEYSaZ2LgIUwIU4upzjTJ2Tdpar0
        O6JiJGURah7lrEWQnZlCts9FuPAuI7Dqpyqc5EVSEQhCtvk1XsGp31HShjE9HhEQ
        deKOCYGnUY9Eu+YNpYykT8=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp14 (Coremail) with SMTP id EsCowACnZQJWNxpjnWENEg--.58041S4;
        Fri, 09 Sep 2022 02:41:34 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] drm: remove unnecessary conditionals
Date:   Fri,  9 Sep 2022 02:41:22 +0800
Message-Id: <20220908184122.76272-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACnZQJWNxpjnWENEg--.58041S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWfAF1kGr1fuF1fKFWDXFb_yoW3Crb_G3
        W8XrWqqr4Du3yqvrsxAF13ZFyjya1Dur4fWryqqasIyrnrXrnrZr9rXrykZw1UGa17CF9x
        u3WxJr1fAFn2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRib11tUUUUU==
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbBaR52F1Xly449FAAAsK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iput() has already handled null and non-null parameter, so it is no
need to use if().

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/drm_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..beec45a89ca5 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -530,10 +530,8 @@ static struct inode *drm_fs_inode_new(void)
 
 static void drm_fs_inode_free(struct inode *inode)
 {
-	if (inode) {
-		iput(inode);
-		simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
-	}
+	iput(inode);
+	simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
 }
 
 /**

base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
-- 
2.34.1

