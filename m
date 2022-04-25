Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477650E2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbiDYOTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiDYOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:19:25 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6811EAC5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:16:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23PEGI4d010824;
        Mon, 25 Apr 2022 09:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650896178;
        bh=AuEsjx7xWt7vjtQJfTCObI5PEP1ZQJh+mLBcUDtY/ZU=;
        h=From:To:CC:Subject:Date;
        b=IA+dM4qCJusLwDfw6jFtvJNmEw0iLTB+VKn4j9QNnD7ItRUVptRqbm6PxKyAkBDAi
         Hr6zO4fJvqBA7kbA5uVZ++i13NQRv1ocxSorEDolvWP1X5al02KXDVxjYX99ZLUlNN
         yp9N+8vfz7ywDdq0lbTyZe8M4dc/O9fCeKMpRLjU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23PEGIaA108280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 09:16:18 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 09:16:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 09:16:18 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23PEGH7l023455;
        Mon, 25 Apr 2022 09:16:18 -0500
From:   Andrew Davis <afd@ti.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/2] tee: remove tee_shm_va2pa() and tee_shm_pa2va()
Date:   Mon, 25 Apr 2022 09:16:16 -0500
Message-ID: <20220425141617.23925-1-afd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not need to index into SHMs based on absolute VA/PA.
These functions are not used and this kind of usage should not be
encouraged anyway. Remove these functions.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_shm.c   | 50 -----------------------------------------
 include/linux/tee_drv.h | 18 ---------------
 2 files changed, 68 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index f31e29e8f1cac..b0c6d553d3a70 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -414,56 +414,6 @@ void tee_shm_free(struct tee_shm *shm)
 }
 EXPORT_SYMBOL_GPL(tee_shm_free);
 
-/**
- * tee_shm_va2pa() - Get physical address of a virtual address
- * @shm:	Shared memory handle
- * @va:		Virtual address to tranlsate
- * @pa:		Returned physical address
- * @returns 0 on success and < 0 on failure
- */
-int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
-{
-	if (!shm->kaddr)
-		return -EINVAL;
-	/* Check that we're in the range of the shm */
-	if ((char *)va < (char *)shm->kaddr)
-		return -EINVAL;
-	if ((char *)va >= ((char *)shm->kaddr + shm->size))
-		return -EINVAL;
-
-	return tee_shm_get_pa(
-			shm, (unsigned long)va - (unsigned long)shm->kaddr, pa);
-}
-EXPORT_SYMBOL_GPL(tee_shm_va2pa);
-
-/**
- * tee_shm_pa2va() - Get virtual address of a physical address
- * @shm:	Shared memory handle
- * @pa:		Physical address to tranlsate
- * @va:		Returned virtual address
- * @returns 0 on success and < 0 on failure
- */
-int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
-{
-	if (!shm->kaddr)
-		return -EINVAL;
-	/* Check that we're in the range of the shm */
-	if (pa < shm->paddr)
-		return -EINVAL;
-	if (pa >= (shm->paddr + shm->size))
-		return -EINVAL;
-
-	if (va) {
-		void *v = tee_shm_get_va(shm, pa - shm->paddr);
-
-		if (IS_ERR(v))
-			return PTR_ERR(v);
-		*va = v;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tee_shm_pa2va);
-
 /**
  * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
  * @shm:	Shared memory handle
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 911cad324acc7..17eb1c5205d34 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -298,24 +298,6 @@ void tee_shm_free(struct tee_shm *shm);
  */
 void tee_shm_put(struct tee_shm *shm);
 
-/**
- * tee_shm_va2pa() - Get physical address of a virtual address
- * @shm:	Shared memory handle
- * @va:		Virtual address to tranlsate
- * @pa:		Returned physical address
- * @returns 0 on success and < 0 on failure
- */
-int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa);
-
-/**
- * tee_shm_pa2va() - Get virtual address of a physical address
- * @shm:	Shared memory handle
- * @pa:		Physical address to tranlsate
- * @va:		Returned virtual address
- * @returns 0 on success and < 0 on failure
- */
-int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va);
-
 /**
  * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
  * @shm:	Shared memory handle
-- 
2.17.1

