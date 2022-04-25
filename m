Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB8050E2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbiDYOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbiDYOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:19:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2391EC7C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:16:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23PEGIGK122089;
        Mon, 25 Apr 2022 09:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650896178;
        bh=RsAwMsQX9cI5h27kf4k/9o/lmmAnxIJZqtDI8sjqLAE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TBP+A9Q/7yQ27BiMgpFk2sQR10F1X+iNY3k+dh90MUG2wgYR8QpPwSOn3U2X+3glE
         Cy0SJrz5d3Ptxrvnn3izQWDMgnanLqTdgJ2EUQPljApyFPKl4/1i56cDOmHL69Pha5
         Va6vtDFGLnk5sJkrlm627UYPKonoycc7YZtyDVw0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23PEGIC6057159
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 09:16:18 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 09:16:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 09:16:18 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23PEGH7m023455;
        Mon, 25 Apr 2022 09:16:18 -0500
From:   Andrew Davis <afd@ti.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and TEE_IOCTL_SHM_DMA_BUF
Date:   Mon, 25 Apr 2022 09:16:17 -0500
Message-ID: <20220425141617.23925-2-afd@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220425141617.23925-1-afd@ti.com>
References: <20220425141617.23925-1-afd@ti.com>
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

These look to be leftover from an early edition of this driver. Userspace
does not need this information. Checking all users of this that I have
access to I have verified no one is using them.

They leak internal use flags out to userspace. Even more they are not
correct anymore after a45ea4efa358. Lets drop these flags before
someone does try to use them for something and they become ABI.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1:
 - Removed flags return from tee_ioctl_shm_alloc()

 drivers/tee/tee_core.c   | 2 --
 include/uapi/linux/tee.h | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 8aa1a4836b92f..af0f7c603fa46 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -302,7 +302,6 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
 		return PTR_ERR(shm);
 
 	data.id = shm->id;
-	data.flags = shm->flags;
 	data.size = shm->size;
 
 	if (copy_to_user(udata, &data, sizeof(data)))
@@ -339,7 +338,6 @@ tee_ioctl_shm_register(struct tee_context *ctx,
 		return PTR_ERR(shm);
 
 	data.id = shm->id;
-	data.flags = shm->flags;
 	data.length = shm->size;
 
 	if (copy_to_user(udata, &data, sizeof(data)))
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 25a6c534beb1b..23e57164693c4 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -42,10 +42,6 @@
 #define TEE_IOC_MAGIC	0xa4
 #define TEE_IOC_BASE	0
 
-/* Flags relating to shared memory */
-#define TEE_IOCTL_SHM_MAPPED	0x1	/* memory mapped in normal world */
-#define TEE_IOCTL_SHM_DMA_BUF	0x2	/* dma-buf handle on shared memory */
-
 #define TEE_MAX_ARG_SIZE	1024
 
 #define TEE_GEN_CAP_GP		(1 << 0)/* GlobalPlatform compliant TEE */
-- 
2.17.1

