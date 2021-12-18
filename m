Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814B2479AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhLRMFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhLRMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:04:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6290EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 04:04:51 -0800 (PST)
Received: from dslb-178-004-169-039.178.004.pools.vodafone-ip.de ([178.4.169.39] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1myYSF-0008I6-FM; Sat, 18 Dec 2021 13:04:47 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/9] staging: r8188: Bssid in struct fast_ant_train is set but not used
Date:   Sat, 18 Dec 2021 13:04:20 +0100
Message-Id: <20211218120423.29906-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211218120423.29906-1-martin@kaiser.cx>
References: <20211218120423.29906-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bssid in struct fast_ant_train is set but not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c | 5 +----
 drivers/staging/r8188eu/include/odm.h      | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index e55bb91b54ed..8af45c7535ea 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -56,12 +56,9 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 
 static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 {
-	u32	value32, i;
+	u32	value32;
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
 
-	for (i = 0; i < 6; i++)
-		dm_fat_tbl->Bssid[i] = 0;
-
 	dm_fat_tbl->TrainIdx = 0;
 	dm_fat_tbl->FAT_State = FAT_NORMAL_STATE;
 
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 3d12b03f2d58..b28294527ca7 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -408,7 +408,6 @@ struct odm_rf_cal {
 /*  ODM Dynamic common info value definition */
 
 struct fast_ant_train {
-	u8	Bssid[6];
 	u8	antsel_rx_keep_0;
 	u8	antsel_rx_keep_1;
 	u8	antsel_rx_keep_2;
-- 
2.20.1

