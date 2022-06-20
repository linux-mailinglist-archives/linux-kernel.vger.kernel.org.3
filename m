Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4068F551C72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbiFTNNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbiFTNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:09:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4E11AF15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26478B811A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD1DC3411B;
        Mon, 20 Jun 2022 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730286;
        bh=DwXafDeIgu51boCgcI30lD+RCbzk47DPP8hGZLfeELE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZOx9c8yEXhk80Yc+vPPt2rrp9YdlPzzFbVoWMXnbhJu82XBmyuijMcA78Uzhu83jf
         2HvyLaTq+5twAXrXqXioPADYKGlp7MT1+yXGvNn+yO/CO6AfWETT9qjmycul/DeC0M
         JWKOg32+xS8Kbwx+d35v0EzUN/9iFH4u9TI7UuGVM2qmrNiwkEmT3iGdQN+xAxyBsZ
         erDYdEp0+pn0Mdgm7KYp/lFxh8gYh6L7yaBzcfVTPANn1iC4QAVW0ql2MAF4FpUjJb
         ZWtZYlyGkX7YC/J8tH6LJQ5viRgTT2PgNauWPgeRK5SWxxlN7PlsXo+iNiz6Bs3FTa
         uTWeYVCYWXsZw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 07/17] habanalabs/gaudi: fix incorrect MME offset calculation
Date:   Mon, 20 Jun 2022 16:04:22 +0300
Message-Id: <20220620130432.1180451-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

Once FW raised an event following a MME2 QMAN error, the driver should
have gone to the corresponding status registers, trying to gather more
info on the error, yet it was accidentally accessing MME1 QMAN address
space.

Generally, we have x4 MMEs, while 0 & 2 are marked MASTER, and
1 & 3 are marked SLAVE. The former can be addressed, yet addressing
the latter is considered an access violation, and will result in a
hung system, which is what unintentionally happened above.
Note that this cannot happen in a secured system, since these registers
are protected with range registers.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b7460c30aa51..8b9ff7fa51ea 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -454,7 +454,7 @@ static const int gaudi_queue_id_to_engine_id[] = {
 	[GAUDI_QUEUE_ID_DMA_6_0...GAUDI_QUEUE_ID_DMA_6_3] = GAUDI_ENGINE_ID_DMA_6,
 	[GAUDI_QUEUE_ID_DMA_7_0...GAUDI_QUEUE_ID_DMA_7_3] = GAUDI_ENGINE_ID_DMA_7,
 	[GAUDI_QUEUE_ID_MME_0_0...GAUDI_QUEUE_ID_MME_0_3] = GAUDI_ENGINE_ID_MME_0,
-	[GAUDI_QUEUE_ID_MME_1_0...GAUDI_QUEUE_ID_MME_1_3] = GAUDI_ENGINE_ID_MME_1,
+	[GAUDI_QUEUE_ID_MME_1_0...GAUDI_QUEUE_ID_MME_1_3] = GAUDI_ENGINE_ID_MME_2,
 	[GAUDI_QUEUE_ID_TPC_0_0...GAUDI_QUEUE_ID_TPC_0_3] = GAUDI_ENGINE_ID_TPC_0,
 	[GAUDI_QUEUE_ID_TPC_1_0...GAUDI_QUEUE_ID_TPC_1_3] = GAUDI_ENGINE_ID_TPC_1,
 	[GAUDI_QUEUE_ID_TPC_2_0...GAUDI_QUEUE_ID_TPC_2_3] = GAUDI_ENGINE_ID_TPC_2,
@@ -7383,8 +7383,13 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *e
 		snprintf(desc, ARRAY_SIZE(desc), "%s%d", "TPC_QM", index);
 		break;
 	case GAUDI_EVENT_MME0_QM ... GAUDI_EVENT_MME2_QM:
-		index = event_type - GAUDI_EVENT_MME0_QM;
-		qid_base = GAUDI_QUEUE_ID_MME_0_0 + index * QMAN_STREAMS;
+		if (event_type == GAUDI_EVENT_MME0_QM) {
+			index = 0;
+			qid_base = GAUDI_QUEUE_ID_MME_0_0;
+		} else if (event_type == GAUDI_EVENT_MME2_QM) {
+			index = 2;
+			qid_base = GAUDI_QUEUE_ID_MME_1_0;
+		}
 		qman_base = mmMME0_QM_BASE + index * MME_QMAN_OFFSET;
 		snprintf(desc, ARRAY_SIZE(desc), "%s%d", "MME_QM", index);
 		break;
-- 
2.25.1

