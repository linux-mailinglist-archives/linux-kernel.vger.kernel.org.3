Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B36357B52D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiGTLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiGTLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E387C1D32A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 836A461CC7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A0AC341C7;
        Wed, 20 Jul 2022 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658315735;
        bh=LSpm+8rd/nK3fM0rM+69gstqhzzZ+9ZDExHP/9e7ANA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uw4y13jOLXs8g/aLOyUKgHtrEQEm2e1muSDEDKk19PS3TMu/8t4QJwJMxYYujfObv
         fi1vCaYhbM63tj+5H+qpfRJbgXl/d7ZBEbsaXnRlbePGNgVsw/8OAmfBZtwItm2HUi
         yvq719ZSfEhN3IFf9F13F9vJUMqoL0UMwAfeoOOaqtYaL9tvo6Rlawmj77gtxGksBO
         DmHerXXd9X57Vyn9GUPv4f6zC2SGLJdd/zvOAHWHldWmKUH0115eCe7BQo+uVCKJM/
         O7pJvqc1IoKP9vuwaa00T43klg//M3MADzkF7VQgwoqSNwSX6yg5oBivg46i41wshL
         nG+fHennYMwxw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 6/9] habanalabs/gaudi2: remove old interrupt mappings
Date:   Wed, 20 Jul 2022 14:15:20 +0300
Message-Id: <20220720111523.4069830-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720111523.4069830-1-ogabbay@kernel.org>
References: <20220720111523.4069830-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Interrupt enumration has changed some time ago but the old mapping
was accidentally left in the driver.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2P.h      |  3 -
 .../include/gaudi2/gaudi2_async_virt_events.h | 57 -------------------
 2 files changed, 60 deletions(-)
 delete mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_virt_events.h

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2P.h b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
index e4bc4009f05b..5110574a650e 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
@@ -15,7 +15,6 @@
 #include "../include/gaudi2/gaudi2_packets.h"
 #include "../include/gaudi2/gaudi2_fw_if.h"
 #include "../include/gaudi2/gaudi2_async_events.h"
-#include "../include/gaudi2/gaudi2_async_virt_events.h"
 
 #define GAUDI2_LINUX_FW_FILE	"habanalabs/gaudi2/gaudi2-fit.itb"
 #define GAUDI2_BOOT_FIT_FILE	"habanalabs/gaudi2/gaudi2-boot-fit.itb"
@@ -511,8 +510,6 @@ struct dup_block_ctx {
  * @hbm_cfg: HBM subsystem settings
  * @hw_queues_lock_mutex: used by simulator instead of hw_queues_lock.
  * @kdma_lock_mutex: used by simulator instead of kdma_lock.
- * @use_deprecated_event_mappings: use old event mappings which are about to be
- *                                 deprecated
  */
 struct gaudi2_device {
 	int (*cpucp_info_get)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_virt_events.h b/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_virt_events.h
deleted file mode 100644
index 6d6ed7838a64..000000000000
--- a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_virt_events.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright 2022 HabanaLabs, Ltd.
- * All Rights Reserved.
- *
- */
-
-#ifndef __GAUDI2_ASYNC_VIRT_EVENTS_H_
-#define __GAUDI2_ASYNC_VIRT_EVENTS_H_
-
-enum gaudi2_async_virt_event_id {
-	GAUDI2_EVENT_NIC3_QM1_OLD = 1206,
-	GAUDI2_EVENT_NIC4_QM0_OLD = 1207,
-	GAUDI2_EVENT_NIC4_QM1_OLD = 1208,
-	GAUDI2_EVENT_NIC5_QM0_OLD = 1209,
-	GAUDI2_EVENT_NIC5_QM1_OLD = 1210,
-	GAUDI2_EVENT_NIC6_QM0_OLD = 1211,
-	GAUDI2_EVENT_NIC6_QM1_OLD = 1212,
-	GAUDI2_EVENT_NIC7_QM0_OLD = 1213,
-	GAUDI2_EVENT_NIC7_QM1_OLD = 1214,
-	GAUDI2_EVENT_NIC8_QM0_OLD = 1215,
-	GAUDI2_EVENT_NIC8_QM1_OLD = 1216,
-	GAUDI2_EVENT_NIC9_QM0_OLD = 1217,
-	GAUDI2_EVENT_NIC9_QM1_OLD = 1218,
-	GAUDI2_EVENT_NIC10_QM0_OLD = 1219,
-	GAUDI2_EVENT_NIC10_QM1_OLD = 1220,
-	GAUDI2_EVENT_NIC11_QM0_OLD = 1221,
-	GAUDI2_EVENT_NIC11_QM1_OLD = 1222,
-	GAUDI2_EVENT_CPU_PKT_SANITY_FAILED_OLD = 1223,
-	GAUDI2_EVENT_CPU0_STATUS_NIC0_ENG0_OLD = 1224,
-	GAUDI2_EVENT_CPU0_STATUS_NIC0_ENG1_OLD = 1225,
-	GAUDI2_EVENT_CPU1_STATUS_NIC1_ENG0_OLD = 1226,
-	GAUDI2_EVENT_CPU1_STATUS_NIC1_ENG1_OLD = 1227,
-	GAUDI2_EVENT_CPU2_STATUS_NIC2_ENG0_OLD = 1228,
-	GAUDI2_EVENT_CPU2_STATUS_NIC2_ENG1_OLD = 1229,
-	GAUDI2_EVENT_CPU3_STATUS_NIC3_ENG0_OLD = 1230,
-	GAUDI2_EVENT_CPU3_STATUS_NIC3_ENG1_OLD = 1231,
-	GAUDI2_EVENT_CPU4_STATUS_NIC4_ENG0_OLD = 1232,
-	GAUDI2_EVENT_CPU4_STATUS_NIC4_ENG1_OLD = 1233,
-	GAUDI2_EVENT_CPU5_STATUS_NIC5_ENG0_OLD = 1234,
-	GAUDI2_EVENT_CPU5_STATUS_NIC5_ENG1_OLD = 1235,
-	GAUDI2_EVENT_CPU6_STATUS_NIC6_ENG0_OLD = 1236,
-	GAUDI2_EVENT_CPU6_STATUS_NIC6_ENG1_OLD = 1237,
-	GAUDI2_EVENT_CPU7_STATUS_NIC7_ENG0_OLD = 1238,
-	GAUDI2_EVENT_CPU7_STATUS_NIC7_ENG1_OLD = 1239,
-	GAUDI2_EVENT_CPU8_STATUS_NIC8_ENG0_OLD = 1240,
-	GAUDI2_EVENT_CPU8_STATUS_NIC8_ENG1_OLD = 1241,
-	GAUDI2_EVENT_CPU9_STATUS_NIC9_ENG0_OLD = 1242,
-	GAUDI2_EVENT_CPU9_STATUS_NIC9_ENG1_OLD = 1243,
-	GAUDI2_EVENT_CPU10_STATUS_NIC10_ENG0_OLD = 1244,
-	GAUDI2_EVENT_CPU10_STATUS_NIC10_ENG1_OLD = 1245,
-	GAUDI2_EVENT_CPU11_STATUS_NIC11_ENG0_OLD = 1246,
-	GAUDI2_EVENT_CPU11_STATUS_NIC11_ENG1_OLD = 1247,
-	GAUDI2_EVENT_ARC_DCCM_FULL_OLD = 1248,
-};
-
-#endif /* __GAUDI2_ASYNC_VIRT_EVENTS_H_ */
-- 
2.25.1

