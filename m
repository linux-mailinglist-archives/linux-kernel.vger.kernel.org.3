Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E94A46F9E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhLJEeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:34:08 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48663 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232860AbhLJEeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:34:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V-78H3N_1639110627;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-78H3N_1639110627)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 12:30:29 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rafael@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] cpuidle: add put_device() after of_find_device_by_node()
Date:   Fri, 10 Dec 2021 12:30:24 +0800
Message-Id: <20211210043024.80884-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was found by coccicheck:
./drivers/cpuidle/cpuidle-qcom-spm.c:129:1-7: ERROR: missing put_device;
call of_find_device_by_node on line 103, but without a corresponding
object release within this function.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 01e77913a414..3952ea600122 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -111,6 +111,7 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 		return -ENOMEM;
 
 	data->spm = dev_get_drvdata(&pdev->dev);
+	put_device(&pdev->dev);
 	if (!data->spm)
 		return -EINVAL;
 
-- 
2.20.1.7.g153144c

