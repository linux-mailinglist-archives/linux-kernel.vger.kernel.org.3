Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2E496D00
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 18:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiAVRGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 12:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiAVRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:06:02 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE40C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 09:06:02 -0800 (PST)
Received: from dslb-188-097-041-028.188.097.pools.vodafone-ip.de ([188.97.41.28] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nBJps-0002IN-Ne; Sat, 22 Jan 2022 18:05:56 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] staging: r8188eu: EntryMaxUndecoratedSmoothedPWDB is set but not used
Date:   Sat, 22 Jan 2022 18:05:44 +0100
Message-Id: <20220122170547.68378-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220122170547.68378-1-martin@kaiser.cx>
References: <20220122170547.68378-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable EntryMaxUndecoratedSmoothedPWDB in struct dm_priv
is set but not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c             | 5 -----
 drivers/staging/r8188eu/include/rtl8188e_dm.h | 3 +--
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 8156e4acaa09..7de0f458d788 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -494,11 +494,6 @@ static void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
 		}
 	}
 
-	if (tmpEntryMaxPWDB != 0)	/*  If associated entry is found */
-		pdmpriv->EntryMaxUndecoratedSmoothedPWDB = tmpEntryMaxPWDB;
-	else
-		pdmpriv->EntryMaxUndecoratedSmoothedPWDB = 0;
-
 	if (tmpEntryMinPWDB != 0xff) /*  If associated entry is found */
 		pdmpriv->EntryMinUndecoratedSmoothedPWDB = tmpEntryMinPWDB;
 	else
diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
index 0b3a9a1a4e5c..d62cdfc2db20 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
@@ -12,9 +12,8 @@ enum{
 struct	dm_priv {
 	u32	InitODMFlag;
 
-	/*  Upper and Lower Signal threshold for Rate Adaptive*/
+	/* Lower Signal threshold for Rate Adaptive */
 	int	EntryMinUndecoratedSmoothedPWDB;
-	int	EntryMaxUndecoratedSmoothedPWDB;
 	int	MinUndecoratedPWDBForDM;
 };
 
-- 
2.30.2

