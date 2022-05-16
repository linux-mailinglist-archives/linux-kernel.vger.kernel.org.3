Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC65283E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiEPMJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiEPMJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:09:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F83625C69
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:09:23 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L1ybc0P3ZzCsYk;
        Mon, 16 May 2022 20:04:28 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 20:09:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <quic_srivasam@quicinc.com>,
        <quic_potturu@quicinc.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: codecs: lpass: Fix passing zero to 'PTR_ERR'
Date:   Mon, 16 May 2022 20:09:09 +0800
Message-ID: <20220516120909.36356-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/lpass-macro-common.c:28 lpass_macro_pds_init() warn: passing zero to 'PTR_ERR'
sound/soc/codecs/lpass-macro-common.c:38 lpass_macro_pds_init() warn: passing zero to 'PTR_ERR'
sound/soc/codecs/lpass-macro-common.c:54 lpass_macro_pds_init() warn: passing zero to 'ERR_PTR'

dev_pm_domain_attach_by_name() may return NULL, set 'ret' as
-ENODATA to fix this warning.

Fixes: 1a8ee4cf8418 ("ASoC: codecs: Fix error handling in power domain init and exit handlers")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/lpass-macro-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
index 3c661fd61173..1b9082d237c1 100644
--- a/sound/soc/codecs/lpass-macro-common.c
+++ b/sound/soc/codecs/lpass-macro-common.c
@@ -25,7 +25,7 @@ struct lpass_macro *lpass_macro_pds_init(struct device *dev)
 
 	l_pds->macro_pd = dev_pm_domain_attach_by_name(dev, "macro");
 	if (IS_ERR_OR_NULL(l_pds->macro_pd)) {
-		ret = PTR_ERR(l_pds->macro_pd);
+		ret = l_pds->macro_pd ? PTR_ERR(l_pds->macro_pd) : -ENODATA;
 		goto macro_err;
 	}
 
@@ -35,7 +35,7 @@ struct lpass_macro *lpass_macro_pds_init(struct device *dev)
 
 	l_pds->dcodec_pd = dev_pm_domain_attach_by_name(dev, "dcodec");
 	if (IS_ERR_OR_NULL(l_pds->dcodec_pd)) {
-		ret = PTR_ERR(l_pds->dcodec_pd);
+		ret = l_pds->dcodec_pd ? PTR_ERR(l_pds->dcodec_pd) : -ENODATA;
 		goto dcodec_err;
 	}
 
-- 
2.17.1

