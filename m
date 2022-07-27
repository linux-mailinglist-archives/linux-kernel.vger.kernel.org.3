Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70555820B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiG0HJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiG0HJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:09:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5321D3135D;
        Wed, 27 Jul 2022 00:09:29 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lt4bs0kdHzmVBH;
        Wed, 27 Jul 2022 15:07:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Jul
 2022 15:09:26 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] scsi: be2iscsi: fix null-ptr-deref in beiscsi_alloc_mem
Date:   Wed, 27 Jul 2022 15:21:32 +0800
Message-ID: <20220727072132.3906922-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccicheck report follow issue:
./drivers/scsi/be2iscsi/be_main.c:2561:37-41: ERROR: mem_descr -> mem_array is NULL but dereferenced.
./drivers/scsi/be2iscsi/be_main.c:2563:9-24: ERROR: mem_descr -> mem_array is NULL but dereferenced.
./drivers/scsi/be2iscsi/be_main.c:2566:9-20: ERROR: mem_descr -> mem_array is NULL but dereferenced.

If goto free_mem, that's mean last "mem_descr->mem_array" is NULL. However,
to avoid resource there will set "mem_descr->num_elements" with "j" which
maybe non-zero. Then will lead to null-ptr-deref when free dma resource.

To solved above issue set "mem_descr->mem_array" with "mem_arr_orig"
when free memory.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/be2iscsi/be_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 50a577ac3bb4..08f856447b4a 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2540,13 +2540,13 @@ static int beiscsi_alloc_mem(struct beiscsi_hba *phba)
 				mem_arr++;
 			}
 		} while (alloc_size);
-		mem_descr->num_elements = j;
-		mem_descr->size_in_bytes = phba->mem_req[i];
 		mem_descr->mem_array = kmalloc_array(j, sizeof(*mem_arr),
 						     GFP_KERNEL);
 		if (!mem_descr->mem_array)
 			goto free_mem;
 
+		mem_descr->num_elements = j;
+		mem_descr->size_in_bytes = phba->mem_req[i];
 		memcpy(mem_descr->mem_array, mem_arr_orig,
 		       sizeof(struct mem_array) * j);
 		mem_descr++;
@@ -2554,7 +2554,11 @@ static int beiscsi_alloc_mem(struct beiscsi_hba *phba)
 	kfree(mem_arr_orig);
 	return 0;
 free_mem:
-	mem_descr->num_elements = j;
+	if (j) {
+		mem_descr->num_elements = j;
+		mem_descr->mem_array = mem_arr_orig;
+		mem_arr_orig = NULL;
+	}
 	while ((i) || (j)) {
 		for (j = mem_descr->num_elements; j > 0; j--) {
 			dma_free_coherent(&phba->pcidev->dev,
-- 
2.31.1

