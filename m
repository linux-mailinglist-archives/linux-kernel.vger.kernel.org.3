Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135B4D435C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbiCJJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiCJJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:22:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C43139814
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:21:42 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KDk7461J1zfYpp;
        Thu, 10 Mar 2022 17:20:16 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Mar
 2022 17:21:39 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>,
        <festevam@gmail.com>, <shengjiu.wang@gmail.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <linux-imx@nxp.com>, <xobs@kosagi.com>,
        <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH -next] ASoC: imx-es8328: Fix error return code in imx_es8328_probe()
Date:   Thu, 10 Mar 2022 09:19:02 +0000
Message-ID: <20220310091902.129299-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Fixes: 7e7292dba215 ("ASoC: fsl: add imx-es8328 machine driver")
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 sound/soc/fsl/imx-es8328.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 09c674ee79f1..168973035e35 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -87,6 +87,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	if (int_port > MUX_PORT_MAX || int_port == 0) {
 		dev_err(dev, "mux-int-port: hardware only has %d mux ports\n",
 			MUX_PORT_MAX);
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.17.1

