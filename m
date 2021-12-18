Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98628479AA7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhLRMEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhLRMEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:04:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B0C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 04:04:48 -0800 (PST)
Received: from dslb-178-004-169-039.178.004.pools.vodafone-ip.de ([178.4.169.39] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1myYSC-0008I6-KJ; Sat, 18 Dec 2021 13:04:44 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/9] staging: r8188: antAveRSSI is set but not used
Date:   Sat, 18 Dec 2021 13:04:17 +0100
Message-Id: <20211218120423.29906-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211218120423.29906-1-martin@kaiser.cx>
References: <20211218120423.29906-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

antAveRSSI in struct fast_ant_train is set but not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c | 1 -
 drivers/staging/r8188eu/include/odm.h      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 837e5a850264..1be662b62e51 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -63,7 +63,6 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 		dm_fat_tbl->Bssid[i] = 0;
 		dm_fat_tbl->antSumRSSI[i] = 0;
 		dm_fat_tbl->antRSSIcnt[i] = 0;
-		dm_fat_tbl->antAveRSSI[i] = 0;
 	}
 	dm_fat_tbl->TrainIdx = 0;
 	dm_fat_tbl->FAT_State = FAT_NORMAL_STATE;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 69faf8b50996..c77c5c1fbe7f 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -414,7 +414,6 @@ struct fast_ant_train {
 	u8	antsel_rx_keep_2;
 	u32	antSumRSSI[7];
 	u32	antRSSIcnt[7];
-	u32	antAveRSSI[7];
 	u8	FAT_State;
 	u32	TrainIdx;
 	u8	antsel_a[ODM_ASSOCIATE_ENTRY_NUM];
-- 
2.20.1

