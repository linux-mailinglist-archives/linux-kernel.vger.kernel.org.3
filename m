Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624124BB5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiBRJbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:31:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiBRJbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:31:01 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE425038B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:30:44 -0800 (PST)
Received: from dslb-178-004-174-047.178.004.pools.vodafone-ip.de ([178.4.174.47] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nKzb8-0005VT-8O; Fri, 18 Feb 2022 10:30:42 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] staging: r8188eu: NumQryPhyStatusCCK is set but not used
Date:   Fri, 18 Feb 2022 10:30:33 +0100
Message-Id: <20220218093034.854049-4-martin@kaiser.cx>
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

NumQryPhyStatusCCK in struct odm_phy_dbg_info is set but not used.
Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 1 -
 drivers/staging/r8188eu/include/odm.h      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 7d47ecd53757..833c8fd7fb0c 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -70,7 +70,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 	if (isCCKrate) {
 		u8 cck_agc_rpt;
 
-		dm_odm->PhyDbgInfo.NumQryPhyStatusCCK++;
 		/*  (1)Hardware does not provide RSSI for CCK */
 		/*  (2)PWDB, Average PWDB cacluated by hardware (for rate adaptive) */
 
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 9fb09e0a0df9..66b5413b6846 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -86,7 +86,6 @@ struct odm_phy_dbg_info {
 	/* ODM Write,debug info */
 	s8	RxSNRdB[MAX_PATH_NUM_92CS];
 	u64	NumQryPhyStatus;
-	u64	NumQryPhyStatusCCK;
 	u64	NumQryPhyStatusOFDM;
 	/* Others */
 	s32	RxEVM[MAX_PATH_NUM_92CS];
-- 
2.30.2

