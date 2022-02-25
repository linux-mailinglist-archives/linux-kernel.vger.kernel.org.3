Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87874C3ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiBYHRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiBYHRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:17:45 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE5F113D89;
        Thu, 24 Feb 2022 23:17:12 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K4gzd0rRkzdZS2;
        Fri, 25 Feb 2022 15:15:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 15:17:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Feb
 2022 15:17:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
CC:     <herbert@gondor.apana.org.au>, <hkalra@marvell.com>
Subject: [PATCH -next] crypto: octeontx2 - fix missing unlock
Date:   Fri, 25 Feb 2022 15:27:24 +0800
Message-ID: <20220225072724.82507-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from error path.

Fixes: 4363f3d3ce8f ("crypto: octeontx2 - add synchronization between mailbox accesses")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 4 +++-
 drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index 17a9dd20c8c3..a402ccfac557 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -143,8 +143,10 @@ static void cptpf_flr_wq_handler(struct work_struct *work)
 	mutex_lock(&pf->lock);
 	req = otx2_mbox_alloc_msg_rsp(mbox, 0, sizeof(*req),
 				      sizeof(struct msg_rsp));
-	if (!req)
+	if (!req) {
+		mutex_unlock(&pf->lock);
 		return;
+	}
 
 	req->sig = OTX2_MBOX_REQ_SIG;
 	req->id = MBOX_MSG_VF_FLR;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
index fee758b86d29..dee0aa60b698 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
@@ -20,8 +20,10 @@ static int forward_to_af(struct otx2_cptpf_dev *cptpf,
 
 	mutex_lock(&cptpf->lock);
 	msg = otx2_mbox_alloc_msg(&cptpf->afpf_mbox, 0, size);
-	if (msg == NULL)
+	if (msg == NULL) {
+		mutex_unlock(&cptpf->lock);
 		return -ENOMEM;
+	}
 
 	memcpy((uint8_t *)msg + sizeof(struct mbox_msghdr),
 	       (uint8_t *)req + sizeof(struct mbox_msghdr), size);
-- 
2.25.1

