Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057864A7ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiBCFE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:04:28 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51456 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231772AbiBCFE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:04:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V3UBAbC_1643864663;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3UBAbC_1643864663)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Feb 2022 13:04:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     daniel@ffwll.ch
Cc:     airlied@linux.ie, Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amdkfd: Fix resource_size.cocci warning
Date:   Thu,  3 Feb 2022 13:04:21 +0800
Message-Id: <20220203050421.39285-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource_size function on resource object instead of explicit
computation.

Eliminate the following coccicheck warning:
./drivers/gpu/drm/amd/amdkfd/kfd_migrate.c:978:11-14: ERROR: Missing
resource_size with res

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8430f6475723..d4287a39be56 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -975,7 +975,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 		pgmap->type = 0;
 		if (pgmap->type == MEMORY_DEVICE_PRIVATE)
 			devm_release_mem_region(adev->dev, res->start,
-						res->end - res->start + 1);
+						resource_size(res));
 		return PTR_ERR(r);
 	}
 
-- 
2.20.1.7.g153144c

