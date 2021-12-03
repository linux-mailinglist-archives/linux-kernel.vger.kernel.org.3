Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675D84670CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348654AbhLCDkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:40:25 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34250 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236430AbhLCDkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:40:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UzDkkD3_1638502617;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UzDkkD3_1638502617)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Dec 2021 11:36:58 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm: remove node from list before freeing the node
Date:   Fri,  3 Dec 2021 11:36:52 +0800
Message-Id: <1638502612-113708-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following smatch warning:
drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1675 dpu_plane_init() warn:
'&pdpu->mplane_list' not removed from list

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index ca190d9..aad238b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1672,6 +1672,7 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
 	if (pdpu && pdpu->pipe_hw)
 		dpu_hw_sspp_destroy(pdpu->pipe_hw);
 clean_plane:
+	list_del(&pdpu->mplane_list);
 	kfree(pdpu);
 	return ERR_PTR(ret);
 }
-- 
1.8.3.1

