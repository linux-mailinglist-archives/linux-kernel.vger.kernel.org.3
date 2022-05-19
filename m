Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C8452C9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiESCtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiESCtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:49:09 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A877AFB33;
        Wed, 18 May 2022 19:49:06 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 19 May
 2022 10:49:05 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 19 May
 2022 10:49:04 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: csiostor: take size of pointed value, not pointer
Date:   Thu, 19 May 2022 10:49:02 +0800
Message-ID: <1652928543-14940-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sizeof a pointer-typed expression returns the size of the pointer, not
that of the pointed data.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/scsi/csiostor/csio_mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_mb.c b/drivers/scsi/csiostor/csio_mb.c
index 94810b19e747..4df8a4df4408 100644
--- a/drivers/scsi/csiostor/csio_mb.c
+++ b/drivers/scsi/csiostor/csio_mb.c
@@ -1551,7 +1551,7 @@ csio_mb_isr_handler(struct csio_hw *hw)
 		 * Enqueue event to EventQ. Events processing happens
 		 * in Event worker thread context
 		 */
-		if (csio_enqueue_evt(hw, CSIO_EVT_MBX, mbp, sizeof(mbp)))
+		if (csio_enqueue_evt(hw, CSIO_EVT_MBX, mbp, sizeof(*mbp)))
 			CSIO_INC_STATS(hw, n_evt_drop);
 
 		return 0;
-- 
2.7.4

