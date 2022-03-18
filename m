Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAD04DD36C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiCRDEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiCRDEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:04:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659E189A2B;
        Thu, 17 Mar 2022 20:03:18 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKTNM3kBzzcbDC;
        Fri, 18 Mar 2022 11:03:15 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 11:03:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ming.qian@nxp.com>, <shijie.qin@nxp.com>, <eagle.zhou@nxp.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] media: platform: amphion: Fix build error without MAILBOX
Date:   Fri, 18 Mar 2022 11:03:05 +0800
Message-ID: <20220318030305.39120-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while COMPILE_TEST is y and MAILBOX is n, build fails:

ERROR: modpost: "mbox_request_channel_byname" [drivers/media/platform/amphion/amphion-vpu.ko] undefined!
ERROR: modpost: "mbox_free_channel" [drivers/media/platform/amphion/amphion-vpu.ko] undefined!
ERROR: modpost: "mbox_send_message" [drivers/media/platform/amphion/amphion-vpu.ko] undefined!

Adding a MAILBOX dependency in VIDEO_AMPHION_VPU to fix this.

Fixes: 52b3a219dd4a ("media: platform: amphion: move config to its own file")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/media/platform/amphion/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/Kconfig b/drivers/media/platform/amphion/Kconfig
index 6eea97b7063a..4a363e07ccc9 100644
--- a/drivers/media/platform/amphion/Kconfig
+++ b/drivers/media/platform/amphion/Kconfig
@@ -7,7 +7,7 @@ config VIDEO_AMPHION_VPU
 	depends on V4L_MEM2MEM_DRIVERS
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on MEDIA_SUPPORT
-	depends on VIDEO_DEV
+	depends on VIDEO_DEV && MAILBOX
 	select MEDIA_CONTROLLER
 	select V4L2_MEM2MEM_DEV
 	select VIDEOBUF2_DMA_CONTIG
-- 
2.17.1

