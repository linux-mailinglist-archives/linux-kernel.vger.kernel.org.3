Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7048FE69
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 19:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiAPSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 13:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiAPSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 13:18:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB29C061574;
        Sun, 16 Jan 2022 10:18:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso19112691wmc.3;
        Sun, 16 Jan 2022 10:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OLj2L5VWyVdOGJLMSf56SLM7Vb7QMt0sfGUe7E+PMH4=;
        b=jRakOnSgyncQcbqCpsBMCzFRPbyC5q5F1x1gV+Fz1VCWtNW6s7Dk28Ndtpv4j0pnH5
         WFI+1JfDG3ZlWK88iMvyrPh0iB5NqtC8pKw3wQNv4eFCrr82rVltFwYPu7lMiTRbi6+a
         MOQ9fB29u1KOMm6vjpEUURATLxjS0tJrmK4HcB/zxXa+h5HoQS0qG2aSuJRA28IpNLLq
         FaNduFspAXsEYfpP47Xx/XOlwItZk6EkWyFxbKdTlb7nU88B+x0z5R7psZLTEDazouSN
         zniT8VDufVCLzm6Rv0i+xUCFaN6j8lKCfh78NTwJ35fpfurbYgV9h/ReGO6yRkFCEXIR
         C2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OLj2L5VWyVdOGJLMSf56SLM7Vb7QMt0sfGUe7E+PMH4=;
        b=Aebd54sqBRk+xV0Grst6gk2X1mS3aRwwWkWtz1kj2iG2Nor+jkz4LwK62YC0ZFMij6
         fuEbDv4L+nH+uMGrErjsY88POvUMV4P7R+udyNS+zftoOfeixZt6Pcu92sQOMh2JC3xL
         MUARSgs1iqYzW1fBkj1LAVnekpuoVca4ynRHTR5LonyygPfxL63LrFv0BQlua7KNPWzZ
         ZgjpfhJwEBZiSe2cjQ7AVd6Hm4uDA1VC5Ga5vhWmyZKCpbUgItCJCzYW6LaFk7UKc49R
         eF7CebhS5fDkZV4BniScG7PUCFNJaq9uuBIEvPO3OlmlDr2OsNjGhT7Q65SYVq/54iP+
         0Pbw==
X-Gm-Message-State: AOAM53159pN1yrJQ/lsTt6mAGs0REEl2ThoKP/I2UAHRJluQJS769zOp
        3YmREJnGS3q8vDdHry5wJEnvpEO0NX2L2Q==
X-Google-Smtp-Source: ABdhPJzTfTrZbeYRdTwd3jGkTbjCInOqQZojBFH9tyRmM+gfinOFNR3IHyqEGi7J4eRXBbu1zN/+XA==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr16163005wrb.664.1642357130069;
        Sun, 16 Jan 2022 10:18:50 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id g12sm11603839wrm.109.2022.01.16.10.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 10:18:49 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     hali@codeaurora.org
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, dmitry.baryshkov@linaro.org,
        abhinavk@codeaurora.org, rajeevny@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/msm/dsi: invalid parameter check in msm_dsi_phy_enable
Date:   Sun, 16 Jan 2022 19:18:44 +0100
Message-Id: <20220116181844.7400-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function performs a check on the "phy" input parameter, however, it
is used before the check.

Initialize the "dev" variable after the sanity check to avoid a possible
NULL pointer dereference.

Fixes: 5c8290284402b ("drm/msm/dsi: Split PHY drivers to separate files")
Addresses-Coverity-ID: 1493860 ("Null pointer dereference")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 9842e04b5858..baa6af0c3bcc 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -808,12 +808,14 @@ int msm_dsi_phy_enable(struct msm_dsi_phy *phy,
 			struct msm_dsi_phy_clk_request *clk_req,
 			struct msm_dsi_phy_shared_timings *shared_timings)
 {
-	struct device *dev = &phy->pdev->dev;
+	struct device *dev;
 	int ret;
 
 	if (!phy || !phy->cfg->ops.enable)
 		return -EINVAL;
 
+	dev = &phy->pdev->dev;
+
 	ret = dsi_phy_enable_resource(phy);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "%s: resource enable failed, %d\n",
-- 
2.25.1

