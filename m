Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9285047E9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiDQNcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 09:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 09:32:22 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15E7A2B2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8xdy1
        otSXW1cwfTIsLN61K8o+NtLtYS2/7RspgGPkFc=; b=WaktQzaNvApyYYQ3HqeLE
        oJrH0VHDXzUSk9eqn4Sweu6M+/U73QAridWyhEm6N/T0iXbkI+sUQ8QSllnR4GQg
        E/Jeajtx7eTWfW2a870TFPqO9WUEvL11ILiolkVp6FO2c3OotRVKDIyffplOIUZg
        YGuspDxGJxTDLZyj84pgak=
Received: from carlis (unknown [120.229.91.35])
        by smtp9 (Coremail) with SMTP id DcCowABHu14vFlxikyJyBw--.4076S2;
        Sun, 17 Apr 2022 21:29:20 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] drm/malidp: convert sysfs snprintf to sysfs_emit
Date:   Sun, 17 Apr 2022 13:29:18 +0000
Message-Id: <20220417132918.135795-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABHu14vFlxikyJyBw--.4076S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWfXF1UWrWfGr1xZw1kZrb_yoWfWFb_CF
        10qrsrZrs2yF97uw1xCF4fZryIkayF9FZ5XrW8ta4fZrsFvrsrZ3s29ryvqryUJF47AF9r
        Aa1kuF15J3ZrCjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnpWlPUUUUU==
X-Originating-IP: [120.229.91.35]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiQwjlhVc7Yte1mgABsc
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
drivers/gpu/drm/arm/malidp_drv.c:658:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index d5aef21426cf..b1ffd5ba27d9 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -655,7 +655,7 @@ static ssize_t core_id_show(struct device *dev, struct device_attribute *attr,
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm->dev_private;
 
-	return snprintf(buf, PAGE_SIZE, "%08x\n", malidp->core_id);
+	return sysfs_emit(buf, "%08x\n", malidp->core_id);
 }
 
 static DEVICE_ATTR_RO(core_id);
-- 
2.25.1

