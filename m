Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2895348C412
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353184AbiALMdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:33:42 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46217 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353180AbiALMdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:33:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V1elThZ_1641990816;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V1elThZ_1641990816)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Jan 2022 20:33:37 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] drm/msm: Fix wrong size calculation
Date:   Wed, 12 Jan 2022 20:33:34 +0800
Message-Id: <20220112123334.749776-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For example, memory-region in .dts as below,
	reg = <0x0 0x50000000 0x0 0x20000000>

We can get below values,
struct resource r;
r.start = 0x50000000;
r.end	= 0x6fffffff;

So the size should be:
size = r.end - r.start + 1 = 0x20000000

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 892c04365..f04a2337d 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -466,7 +466,7 @@ static int msm_init_vram(struct drm_device *dev)
 		of_node_put(node);
 		if (ret)
 			return ret;
-		size = r.end - r.start;
+		size = r.end - r.start + 1;
 		DRM_INFO("using VRAM carveout: %lx@%pa\n", size, &r.start);
 
 		/* if we have no IOMMU, then we need to use carveout allocator.
-- 
2.17.1

