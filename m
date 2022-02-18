Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557F84BB5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiBRJbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:31:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiBRJbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:31:01 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B7B253BD9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:30:45 -0800 (PST)
Received: from dslb-178-004-174-047.178.004.pools.vodafone-ip.de ([178.4.174.47] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nKzb6-0005VT-Ef; Fri, 18 Feb 2022 10:30:40 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] staging: r8188eu: RxMIMOSignalQuality is set but not used
Date:   Fri, 18 Feb 2022 10:30:31 +0100
Message-Id: <20220218093034.854049-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218093034.854049-1-martin@kaiser.cx>
References: <20220218093034.854049-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RxMIMOSignalQuality array in struct signal_stat is set but
not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 6 ------
 drivers/staging/r8188eu/include/rtw_recv.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index dcc38b036280..8ebcd3050892 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -67,9 +67,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
 
-	pPhyInfo->RxMIMOSignalQuality[RF_PATH_A] = -1;
-	pPhyInfo->RxMIMOSignalQuality[RF_PATH_B] = -1;
-
 	if (isCCKrate) {
 		u8 cck_agc_rpt;
 
@@ -150,8 +147,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 					SQ = ((64 - SQ_rpt) * 100) / 44;
 			}
 			pPhyInfo->SignalQuality = SQ;
-			pPhyInfo->RxMIMOSignalQuality[RF_PATH_A] = SQ;
-			pPhyInfo->RxMIMOSignalQuality[RF_PATH_B] = -1;
 		}
 	} else { /* is OFDM rate */
 		dm_odm->PhyDbgInfo.NumQryPhyStatusOFDM++;
@@ -203,7 +198,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			if (pPktinfo->bPacketMatchBSSID) {
 				if (i == RF_PATH_A) /*  Fill value in RFD, Get the first spatial stream only */
 					pPhyInfo->SignalQuality = (u8)(EVM & 0xff);
-				pPhyInfo->RxMIMOSignalQuality[i] = (u8)(EVM & 0xff);
 			}
 		}
 	}
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 920f33235e00..f82a26a675c0 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -72,7 +72,6 @@ struct signal_stat {
 struct phy_info {
 	u8	RxPWDBAll;
 	u8	SignalQuality;	 /*  in 0-100 index. */
-	u8	RxMIMOSignalQuality[MAX_PATH_NUM_92CS]; /* EVM */
 	u8	RxMIMOSignalStrength[MAX_PATH_NUM_92CS];/*  in 0~100 index */
 	s8	RxPower; /*  in dBm Translate from PWdB */
 /*  Real power in dBm for this packet, no beautification and aggregation.
-- 
2.30.2

