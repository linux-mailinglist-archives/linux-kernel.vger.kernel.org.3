Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC247687E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhLPDLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:11:10 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50959 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233223AbhLPDLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:11:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V-m4t3W_1639624265;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-m4t3W_1639624265)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Dec 2021 11:11:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/msm: remove variable set but not used
Date:   Thu, 16 Dec 2021 11:11:03 +0800
Message-Id: <20211216031103.34146-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code that uses variable mdss has been removed, So the declaration 
and assignment of the variable can be removed.

Eliminate the following clang warning:
drivers/gpu/drm/msm/msm_drv.c:513:19: warning: variable 'mdss' set but
not used [-Wunused-but-set-variable]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 2027e5b3413d ("drm/msm: Initialize MDSS irq domain at probe time")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ad35a5d94053..59e30192cdf6 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -510,7 +510,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	struct msm_drm_private *priv = dev_get_drvdata(dev);
 	struct drm_device *ddev;
 	struct msm_kms *kms;
-	struct msm_mdss *mdss;
 	int ret, i;
 
 	ddev = drm_dev_alloc(drv, dev);
@@ -521,8 +520,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	ddev->dev_private = priv;
 	priv->dev = ddev;
 
-	mdss = priv->mdss;
-
 	priv->wq = alloc_ordered_workqueue("msm", 0);
 	priv->hangcheck_period = DRM_MSM_HANGCHECK_DEFAULT_PERIOD;
 
-- 
2.20.1.7.g153144c

