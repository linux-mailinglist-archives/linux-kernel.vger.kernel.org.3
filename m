Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC04846C9CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhLHBHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLHBHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:07:08 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1443EC061574;
        Tue,  7 Dec 2021 17:03:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y7so489905plp.0;
        Tue, 07 Dec 2021 17:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wODOQzkVh9zeQYxZgNd/y4oFz1Y6sLQfoGixvntFcCA=;
        b=Lf2hx3I/SvE2sHOji9nxHNaQtgVWWL1zxDGhD7Ya18brrer+ZE5vYgqMK7DaBOTAoa
         PwTkgvmCFjKk0tz6Ypnk2GnKCa8qV+w8H1ffcAfHJKNOb/m9zEaIg6+aCawRrZzBvRvo
         qzEcy2rgdsk/9ypreMnVJV2HwNpvHrjiTv4Hb8Yi4cV3F4KY3mxjcg2h5Prjot5IMF7t
         qzbq5H9kWRhW95QVmFy3XbUgkRmL0V4bJ8BYyXz5PnOHS9WaHpzjmT6LTQXZPisyNQZR
         NmuqqH/WeMpzwokICTf6ibHS4KM2QyxL8jO7T0fNBgK2MNGd9v609ppwWMcUD6NYC9+G
         +45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wODOQzkVh9zeQYxZgNd/y4oFz1Y6sLQfoGixvntFcCA=;
        b=p+PvmrXbNMbI9vYZvIzY/z2d8mfCd/5paKQ8DNH7BdsrBJBoDH5ssj+XXNBSuPnZCb
         AljGdVkfER1C/3HXJCwgh9BuV6/zWHILzujHZu6qSLFxNDKJPSovFGmOT2wfv4KOXZwP
         oqd4zFmeQ/L1/Sc5UsJo9PRrjZoHay7azYv4pj+93po2dECLeicEj+IGI96d0L56WjUq
         QMiyyYywOBPjYOKU8sFFtOLKQksoq28yDBcXkk0R14wz1WKKD5BXnlIy35arvKkX6eIk
         IWaGrVI7Euceh022TFfRVWLKfynNzKWwllCbj/JEXsYZNeBNmYHiJY9faJ/hH/nVxNht
         qN/g==
X-Gm-Message-State: AOAM533QS4+N99nUXuMI7opUxzOb2LgWldRyLNMRhKx0getREP5cM9M1
        he9+400/8SB/aHSI6IJRTDs=
X-Google-Smtp-Source: ABdhPJzH0lW1WLXdtj1vSfMyFvfaeoThFV6rkXNWWx5Uz/1mg3AcNrzLx0TII9mIwkKubGompnNpBQ==
X-Received: by 2002:a17:90b:4c44:: with SMTP id np4mr3299329pjb.195.1638925417652;
        Tue, 07 Dec 2021 17:03:37 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id y25sm631911pgk.47.2021.12.07.17.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 17:03:37 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     agross@kernel.org
Cc:     davidcomponentone@gmail.com, bjorn.andersson@linaro.org,
        kishon@ti.com, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>,
        Yang Guang <yang.guang5@zte.com.cn>
Subject: [PATCH] pyh: qcom: fix the application of sizeof to pointer
Date:   Wed,  8 Dec 2021 09:03:21 +0800
Message-Id: <c74d05d5197fa4fba96c4bd1cd597cd644c694b6.1638924754.git.davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
./drivers/phy/qualcomm/phy-qcom-edp.c:574:31-37:
ERROR: application of sizeof to pointer

Using the real size to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 17d5653b661d..5fe4eab9cac1 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -571,7 +571,7 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 	struct clk_init_data init = { };
 	int ret;
 
-	data = devm_kzalloc(edp->dev, sizeof(data), GFP_KERNEL);
+	data = devm_kzalloc(edp->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
2.30.2

