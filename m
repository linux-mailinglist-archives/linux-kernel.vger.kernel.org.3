Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65D559D01A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbiHWEem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiHWEej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:34:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C14E63A;
        Mon, 22 Aug 2022 21:34:37 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBbrq15q7zkWMF;
        Tue, 23 Aug 2022 12:31:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 12:34:35 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 12:34:35 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>
CC:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>
Subject: [PATCH -next v2] scsi: lpfc: add missing destroy_workqueue() on error path in lpfc_sli4_driver_resource_setup()
Date:   Tue, 23 Aug 2022 12:42:37 +0800
Message-ID: <20220823044237.285643-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing destroy_workqueue() before return from
lpfc_sli4_driver_resource_setup() in error path.

Fixes: 3cee98db2610 ("scsi: lpfc: Fix crash on driver unload in wq free")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  correct label spelling error
---
 drivers/scsi/lpfc/lpfc_init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index c69c5a0979ec..55a1ad6eed03 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8053,7 +8053,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	/* Allocate device driver memory */
 	rc = lpfc_mem_alloc(phba, SGL_ALIGN_SZ);
 	if (rc)
-		return -ENOMEM;
+		goto out_destroy_workqueue;
 
 	/* IF Type 2 ports get initialized now. */
 	if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) >=
@@ -8481,6 +8481,9 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	lpfc_destroy_bootstrap_mbox(phba);
 out_free_mem:
 	lpfc_mem_free(phba);
+out_destroy_workqueue:
+	destroy_workqueue(phba->wq);
+	phba->wq = NULL;
 	return rc;
 }
 
-- 
2.25.1

