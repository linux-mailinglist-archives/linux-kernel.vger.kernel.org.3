Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A63597EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbiHRHAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiHRHAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:00:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D147868B8;
        Thu, 18 Aug 2022 00:00:44 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M7bM90WjFznTX6;
        Thu, 18 Aug 2022 14:58:29 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 15:00:40 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <narmstrong@baylibre.com>, <mchehab@kernel.org>,
        <gregkh@linuxfoundation.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <mjourdan@baylibre.com>, <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <weiyongjun1@huawei.com>, <xuqiang36@huawei.com>
Subject: [PATCH -next] media: meson: vdec: add missing clk_disable_unprepare on error in vdec_hevc_start()
Date:   Thu, 18 Aug 2022 06:57:53 +0000
Message-ID: <20220818065753.104050-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing clk_disable_unprepare() before return
from vdec_hevc_start() in the error handling case.

Fixes: 823a7300340e (“media: meson: vdec: add common HEVC decoder support”)
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 drivers/staging/media/meson/vdec/vdec_hevc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/meson/vdec/vdec_hevc.c b/drivers/staging/media/meson/vdec/vdec_hevc.c
index 9530e580e57a..afced435c907 100644
--- a/drivers/staging/media/meson/vdec/vdec_hevc.c
+++ b/drivers/staging/media/meson/vdec/vdec_hevc.c
@@ -167,8 +167,12 @@ static int vdec_hevc_start(struct amvdec_session *sess)
 
 	clk_set_rate(core->vdec_hevc_clk, 666666666);
 	ret = clk_prepare_enable(core->vdec_hevc_clk);
-	if (ret)
+	if (ret) {
+		if (core->platform->revision == VDEC_REVISION_G12A ||
+		    core->platform->revision == VDEC_REVISION_SM1)
+			clk_disable_unprepare(core->vdec_hevcf_clk);
 		return ret;
+	}
 
 	if (core->platform->revision == VDEC_REVISION_SM1)
 		regmap_update_bits(core->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
-- 
2.17.1

