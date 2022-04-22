Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2250C945
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiDWKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiDWKcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:32:17 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09AC1BFC85
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:29:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23MI1ekR064962;
        Fri, 22 Apr 2022 13:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650650500;
        bh=iioj9dZNPxWBOuNiHxgIG3fFC7hgfus1/G3r1hCrOwg=;
        h=From:To:CC:Subject:Date;
        b=RU7ZgSLto1armfOWggIUaf1nEf27eGSu83XDccsMEo2eEzzi18NnnjAd5D7l9S32P
         tzX5viXE0pucYcFQjy94DBGvVh6qiMqVxuEDcWO4Gglm0/pR9YYZbBWnOC7HbdJBwd
         6NJ4z8MkXeZjlk6xBWDuVaUyr5np0H5qHWOJSjpI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23MI1eUw013714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 13:01:40 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 13:01:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 13:01:40 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23MI1dsn125884;
        Fri, 22 Apr 2022 13:01:39 -0500
From:   Andrew Davis <afd@ti.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] tee: remove tee_shm_va2pa() and tee_shm_pa2va()
Date:   Fri, 22 Apr 2022 13:01:38 -0500
Message-ID: <20220422180139.13447-1-afd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not need to index into SHMs based on absolute VA/PA.
These functions are not used and this kind of usage should not be
encouraged anyway. Remove these functions.

Signed-off-by: Andrew Davis <afd@ti.com>
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

