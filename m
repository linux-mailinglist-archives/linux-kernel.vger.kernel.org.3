Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E2E50C40D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiDVWox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiDVWon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:44:43 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96AE30D85A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:39:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23MI1eGT108778;
        Fri, 22 Apr 2022 13:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650650501;
        bh=Kl1JWrgUFz6ayHAKznd+Y3h+PX7n0DydW4VC03n7x2c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ku76huh2hYibqAGm5CepUCDs/h2s/RpwGQJL5gCcP8AYURREUG4CGEo/Vttt489aK
         5uVlU9T5aBPNrn+Q1w4uUDhjOkwj6GqDyirtmEpRvDu03w77akpzvWyTILlGVS1mCU
         saoZ4R/JZcSMGP1zYqNMVshzHBKgA+uaqiM3Ki6g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23MI1eww117540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 13:01:40 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 13:01:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 13:01:40 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23MI1dso125884;
        Fri, 22 Apr 2022 13:01:40 -0500
From:   Andrew Davis <afd@ti.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and TEE_IOCTL_SHM_DMA_BUF
Date:   Fri, 22 Apr 2022 13:01:39 -0500
Message-ID: <20220422180139.13447-2-afd@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422180139.13447-1-afd@ti.com>
References: <20220422180139.13447-1-afd@ti.com>
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
 drivers/tee/tee_core.c   | 1 -
 include/uapi/linux/tee.h | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 8aa1a4836b92f..650dd87a38e77 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -339,7 +339,6 @@ tee_ioctl_shm_register(struct tee_context *ctx,
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

