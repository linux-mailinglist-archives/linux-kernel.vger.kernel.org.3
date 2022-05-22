Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DBC530585
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiEVTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350287AbiEVTtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:49:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF5238D99
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:48:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so24739876ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GQBG72Umvxbor3m/gsK6TvVWuWrjeEpDqxp7epo9DKM=;
        b=XDW311sIMxWEL5sWKDGU116vuUoGIiofSD1sHIEHluh/4t1ATrrYnJ8+ouaMm9n3xr
         Y2sxF0Rh7NQPdkZ8D8Te5uzQHyQen7lkPNMvsiVfTlftIqLrF0vbAYwqnPi4vAUrLAdd
         H84YyxK5nknkgFS4mdhEXLR4gXSDZ7AWWACOIPyKyrm3ib/3RqkRl6e3ZEqr5yeqtkLC
         SWTQ8L7woKzzBa1uTEOoawH+7ypBBWN9TogPd5/4k29IMPWA4qL0WQjh/XWONBz7Yc5T
         qClj6519NHbeOfzdiBh+EM/Alq1bzqBr9MZBDbFnq4acesqqoRoILm/zxHGcOsLJobYZ
         OCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQBG72Umvxbor3m/gsK6TvVWuWrjeEpDqxp7epo9DKM=;
        b=AaETW8r/depa8L/du4gMA/H2l7T1l2NXQbUTxaHoMELBFgCNAs909+c4Wslhy3oAS8
         NURs1VhCFZZ4N7XcPMc7z3LEbrfq38d/1XVb5K5qDQ195kV0RcezMYuVGPAGwEJQykX7
         H+HD0smtKSJKdYqrSYd9xvm8n+SIdRZezFGwg3JBJefFW7RXkofuzdN7wJWE4RW7vvYA
         N4k2+zef6s/+HY8C3v8bdyQ1mLRbizV+x2TAhM3MtkaQOd9cnYxthoJS9aLOcnd/i8Ma
         EevFZDOwODCBwDTU4qiO2GkAaBr3Bd2umpPW9sTKPRzZojNx4rQSX1JXTkXMCUBx4FSx
         Xcyw==
X-Gm-Message-State: AOAM53393W0h6AC3mLDQvTjORqZ3pCEF0/CPIbqRTvCT7PVVWYAHU/oO
        BEHWiHAtd044x8/QC3yCa0Wa4ruySZs=
X-Google-Smtp-Source: ABdhPJwDGUy6O/FfVOZRpv8vepm7g7+eaYLMyLM00OOoljCea9/uvOi+rKzfnOi1W4pOZveCSHliHw==
X-Received: by 2002:a17:907:d22:b0:6f4:8766:2042 with SMTP id gn34-20020a1709070d2200b006f487662042mr16654389ejc.259.1653248932492;
        Sun, 22 May 2022 12:48:52 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935774.dip0.t-ipconnect.de. [87.147.87.116])
        by smtp.gmail.com with ESMTPSA id kt1-20020a170906aac100b006fecb577060sm1130600ejb.119.2022.05.22.12.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:48:52 -0700 (PDT)
Date:   Sun, 22 May 2022 21:48:49 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: vt6655: Replace VNSvOutPortW with iowrite16
Message-ID: <ded437e27cffb040865d4afe47e447c2d0d6f0b8.1653203927.git.philipp.g.hortmann@gmail.com>
References: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvOutPortW with iowrite16 because it replaces
just one line.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c        | 29 ++++++++++------------------
 drivers/staging/vt6655/device_main.c |  3 +--
 drivers/staging/vt6655/mac.h         |  4 ++--
 drivers/staging/vt6655/power.c       |  4 ++--
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/rxtx.c        |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 7 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 2cde0082fc03..72043a29b543 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -326,7 +326,7 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 
 	/* set HW beacon interval */
-	VNSvOutPortW(priv->port_offset + MAC_REG_BI, wBeaconInterval);
+	iowrite16(wBeaconInterval, priv->port_offset + MAC_REG_BI);
 	priv->wBeaconInterval = wBeaconInterval;
 	/* Set NextTBTT */
 	VNSvOutPortD(priv->port_offset + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
@@ -587,68 +587,59 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
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
index afaf331fe125..5f28d9ea4232 100644
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
index 23ebae99e0ae..ebadf527a911 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -548,7 +548,7 @@ do {									\
 do {									\
 	unsigned short wData;						\
 	wData = ioread16(iobase + byRegOfs);				\
-	VNSvOutPortW(iobase + byRegOfs, wData | (wBits));		\
+	iowrite16(wData | (wBits), iobase + byRegOfs);			\
 } while (0)
 
 #define MACvRegBitsOff(iobase, byRegOfs, byBits)			\
@@ -562,7 +562,7 @@ do {									\
 do {									\
 	unsigned short wData;						\
 	wData = ioread16(iobase + byRegOfs);				\
-	VNSvOutPortW(iobase + byRegOfs, wData & ~(wBits));		\
+	iowrite16(wData & ~(wBits), iobase + byRegOfs);			\
 } while (0)
 
 /* set the chip with current BCN tx descriptor address */
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
index ee5e2e0d9a8c..ff6f654df2d2 100644
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
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 54b0556f500f..390b27b02562 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1422,7 +1422,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 
 	MACvSetCurrBCNTxDescAddr(priv->port_offset, priv->tx_beacon_dma);
 
-	VNSvOutPortW(priv->port_offset + MAC_REG_BCNDMACTL + 2, priv->wBCNBufLen);
+	iowrite16(priv->wBCNBufLen, priv->port_offset + MAC_REG_BCNDMACTL + 2);
 	/* Set auto Transmit on */
 	MACvRegBitsOn(priv->port_offset, MAC_REG_TCR, TCR_AUTOBCNTX);
 	/* Poll Transmit the adapter */
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 2a47f5782b71..0f2f7df00b3a 100644
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

