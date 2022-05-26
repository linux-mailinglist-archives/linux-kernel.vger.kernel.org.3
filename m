Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4AB5347E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbiEZBOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbiEZBOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:14:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0F495A08
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:14:49 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L7qhX0kVDzjX3m;
        Thu, 26 May 2022 09:14:04 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 09:14:47 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <f.fainelli@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH] soc: bcm: brcmstb: Fix refcount leak in brcmstb_pm_probe
Date:   Thu, 26 May 2022 01:09:48 +0000
Message-ID: <20220526010948.32211-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 0b741b8234c86 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index 3cbb165d6e30..70ad0f3dce28 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -783,6 +783,7 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
 	}
 
 	ret = brcmstb_init_sram(dn);
+	of_node_put(dn);
 	if (ret) {
 		pr_err("error setting up SRAM for PM\n");
 		return ret;
-- 
2.17.1

