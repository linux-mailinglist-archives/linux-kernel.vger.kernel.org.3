Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1D4FC62A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349980AbiDKUwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349974AbiDKUwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:52:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D601A070
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c64so7822693edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f8xCiZNmfAI5OEPxmdyklB/iaX4jfTxr8jmyXnOj6xs=;
        b=Qxc7VPeC+bs6eieMJp/A+InfP5E658cOVT1XGhpqizgnsp+PTsZYGeGTxMj5oOl7Li
         Re3UF20krZuF/ZkRoJRtbOUS4a+PmZT0jD4oKnsMF1n4N2Xcg2PqYh54Lv7mHcuMiiAH
         FkWpoCtwUiLChheGt8Gj0VnhWj1vhr2woAy5Nu/XbyiGxNQ/lKArEJjJM4A+T9hYhPbX
         Z+5sDN6WM5PjmzKUH1faeZe63WTsEpSfbyhWTZLEmqzuTo0NRRTe+2JzryqDjgkN3Upq
         gdkumNdbViVua8A+Eu0qChoajSe3ZKcVX3HSAm9Rc8D+8TkVjbNkMp5v8SlupoCHBDog
         EkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f8xCiZNmfAI5OEPxmdyklB/iaX4jfTxr8jmyXnOj6xs=;
        b=IUhPZnIv4GPl/mNLFaz3jiE491VqeiZDip9BUukCVq8l0F/eBEgSWgM1oacrlCa7rT
         CVQR0fei1bY+EfaZWkr98I3nI3x+mF13EDiEZMDUfQIY7lMvHH2fXDQ4hEgVu1r31LkO
         2hbPk/1eY43mv6fTuqdIaV98fx8lAvt+I+GGJ98mW2dIUrW0MC8nDc+c3onh3kmcQ/QK
         gKhe8RqtoYY2DuOVkGWT2SEHzWGcK8DyiuEG1ILoWGvBIJoiqOHfcx4NlFfstYb8Ykbj
         JwKjHUyYr4ss49C1HifRKZ8/fUcBvppoctglhz0xmiUiExnTRfp4QQrMmSjB7m+fiFN6
         Evlg==
X-Gm-Message-State: AOAM53039hUiZCNJgdvJ+oTALsAzK9zsRaZ8t/8AO2dewzYSjje1QAoh
        sqR+pIcyca563GBU/AEFiiA=
X-Google-Smtp-Source: ABdhPJwBpFvySAuIC5VFZDk2ZlorXY8+NuzkKg518ADJI8t6deRQZ4+7yjRcRNydRt0o6MZ4N8/+pw==
X-Received: by 2002:a05:6402:1909:b0:418:d876:3119 with SMTP id e9-20020a056402190900b00418d8763119mr36306196edz.266.1649710187147;
        Mon, 11 Apr 2022 13:49:47 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id yy18-20020a170906dc1200b006d6e5c75029sm12238609ejb.187.2022.04.11.13.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:49:46 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:49:45 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] staging: vt6655: Replace VNSvOutPortW with iowrite16
Message-ID: <d1b7e7262cb3d27e54278549894df9a734a749bb.1649706687.git.philipp.g.hortmann@gmail.com>
References: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvOutPortW with iowrite16.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

For constants from 0 to below 0x8000 the u16 cast was omitted.
For variables which are defined as unsigned short the u16 is omitted.

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Patch was not existing
V2 -> V3: Inserted patch that was before in a different way in
          "Rename macros VNSvOutPortB,W,D"
          This patch was part of 5/6 and is now 5/7
---
 drivers/staging/vt6655/card.c        | 29 ++++++++++------------------
 drivers/staging/vt6655/device_main.c |  3 +--
 drivers/staging/vt6655/mac.h         |  7 +++----
 drivers/staging/vt6655/power.c       |  4 ++--
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 6 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 62fda818022e..57b9ea385690 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -327,7 +327,7 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 
 	/* set HW beacon interval */
-	VNSvOutPortW(priv->port_offset + MAC_REG_BI, wBeaconInterval);
+	iowrite16(wBeaconInterval, priv->port_offset + MAC_REG_BI);
 	priv->wBeaconInterval = wBeaconInterval;
 	/* Set NextTBTT */
 	VNSvOutPortD(priv->port_offset + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
@@ -588,68 +588,59 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_6,
-		     MAKEWORD(byTxRate, byRsvTime));
+	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_6);
 	/* RSPINF_a_9 */
 	s_vCalculateOFDMRParameter(RATE_9M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_9,
-		     MAKEWORD(byTxRate, byRsvTime));
+	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_9);
 	/* RSPINF_a_12 */
 	s_vCalculateOFDMRParameter(RATE_12M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_12,
-		     MAKEWORD(byTxRate, byRsvTime));
+	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_12);
 	/* RSPINF_a_18 */
 	s_vCalculateOFDMRParameter(RATE_18M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_18,
-		     MAKEWORD(byTxRate, byRsvTime));
+	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_18);
 	/* RSPINF_a_24 */
 	s_vCalculateOFDMRParameter(RATE_24M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_24,
-		     MAKEWORD(byTxRate, byRsvTime));
+	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_24);
 	/* RSPINF_a_36 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_36M),
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_36,
-		     MAKEWORD(byTxRate, byRsvTime));
+	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_36);
 	/* RSPINF_a_48 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_48M),
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_48,
-		     MAKEWORD(byTxRate, byRsvTime));
+	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_48);
 	/* RSPINF_a_54 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_54M),
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_54,
-		     MAKEWORD(byTxRate, byRsvTime));
+	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_54);
 	/* RSPINF_a_72 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_54M),
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_72,
-		     MAKEWORD(byTxRate, byRsvTime));
+	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_72);
 	/* Set to Page0 */
 	MACvSelectPage0(priv->port_offset);
 
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 1bfccaa08c45..bd97e3b9bc98 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1060,8 +1060,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 		if (isr & ISR_FETALERR) {
 			pr_debug(" ISR_FETALERR\n");
 			iowrite8(0, priv->port_offset + MAC_REG_SOFTPWRCTL);
-			VNSvOutPortW(priv->port_offset +
-				     MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPECTI);
+			iowrite16(SOFTPWRCTL_SWPECTI, priv->port_offset + MAC_REG_SOFTPWRCTL);
 			device_error(priv, isr);
 		}
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 1017236e3117..9e8f7e1f1655 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -549,7 +549,7 @@ do {									\
 do {									\
 	unsigned short wData;						\
 	wData = ioread16(iobase + byRegOfs);			\
-	VNSvOutPortW(iobase + byRegOfs, wData | (wBits));		\
+	iowrite16((u16)(wData | (wBits)), iobase + byRegOfs);		\
 } while (0)
 
 #define MACvRegBitsOff(iobase, byRegOfs, byBits)			\
@@ -563,7 +563,7 @@ do {									\
 do {									\
 	unsigned short wData;						\
 	wData = ioread16(iobase + byRegOfs);			\
-	VNSvOutPortW(iobase + byRegOfs, wData & ~(wBits));		\
+	iowrite16((u16)(wData & ~(wBits)), iobase + byRegOfs);		\
 } while (0)
 
 /* set the chip with current BCN tx descriptor address */
@@ -573,8 +573,7 @@ do {									\
 
 /* set the chip with current BCN length */
 #define MACvSetCurrBCNLength(iobase, wCurrBCNLength)		\
-	VNSvOutPortW(iobase + MAC_REG_BCNDMACTL + 2,		\
-		     wCurrBCNLength)
+	iowrite16((u16)(wCurrBCNLength), iobase + MAC_REG_BCNDMACTL + 2)
 
 #define MACvWriteBSSIDAddress(iobase, pbyEtherAddr)		\
 do {								\
diff --git a/drivers/staging/vt6655/power.c b/drivers/staging/vt6655/power.c
index 06066fa56dd5..0bd2ddc61648 100644
--- a/drivers/staging/vt6655/power.c
+++ b/drivers/staging/vt6655/power.c
@@ -52,10 +52,10 @@ void PSvEnablePowerSaving(struct vnt_private *priv,
 	u16 wAID = priv->current_aid | BIT(14) | BIT(15);
 
 	/* set period of power up before TBTT */
-	VNSvOutPortW(priv->port_offset + MAC_REG_PWBT, C_PWBT);
+	iowrite16(C_PWBT, priv->port_offset + MAC_REG_PWBT);
 	if (priv->op_mode != NL80211_IFTYPE_ADHOC) {
 		/* set AID */
-		VNSvOutPortW(priv->port_offset + MAC_REG_AIDATIM, wAID);
+		iowrite16(wAID, priv->port_offset + MAC_REG_AIDATIM);
 	}
 
 	/* Set AutoSleep */
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index d4db0a0b702c..76c651d4da31 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -350,7 +350,7 @@ bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
 	unsigned char sleep_count = 0;
 	unsigned short idx = MISCFIFO_SYNDATA_IDX;
 
-	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
+	iowrite16(0, iobase + MAC_REG_MISCFFNDEX);
 	switch (rf_type) {
 	case RF_AIROHA:
 	case RF_AL2230S:
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 2a6d9cd1b42d..c14b4d98c466 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,9 +20,6 @@
 
 /* For memory mapped IO */
 
-#define VNSvOutPortW(dwIOAddress, wData) \
-	iowrite16((u16)(wData), dwIOAddress)
-
 #define VNSvOutPortD(dwIOAddress, dwData) \
 	iowrite32((u32)(dwData), dwIOAddress)
 
-- 
2.25.1

