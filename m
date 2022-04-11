Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69374FC629
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349976AbiDKUwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349990AbiDKUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:52:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D41EEE6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bg10so33361721ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5RRsAeFHsJE/GG1PmX2Yi6Rfzr2T/OETCmslgZ6usKo=;
        b=hdT5Q4f4J3Q7ETL65mCZlahW1T/iCapOTW8OEGSX77f8wiortJYgzrCoaVSmhjmzut
         rrFzLAZk2jxvaQosxuRG5kWQ0OrraT/6c4kBFzEg+M/is00nmXcSNsBJRUaod4/H6IxC
         dZdps1UPAxmDI60/KFnPeELyjC6MweqMV/U+FwP6Tcb56TcyK+CTlnY39cLlrK3Rmely
         NTujmBhvD5ymlJ32RAOjl4ogF8YxW6zJJsRmSzs0ujWmUdAZ/Y3UkYKjQ2Pj4xy0uWCR
         LW1hQvoleqAhUIRLOAQmgwpRmMMwDrcwp4GrjoELAY+2CYhoNHkiWwXsI7ZTVW/diQZH
         aKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5RRsAeFHsJE/GG1PmX2Yi6Rfzr2T/OETCmslgZ6usKo=;
        b=X2ZgBbyMqcptS3gR5GRipLSZ4UXZCBCVtpWSN8t/aRP0X1bw6nXN7Ez6X49O/fP46B
         AVmFKQbW50fSr7xkjl9eNxWGSVPT9/Vs3O9A2I1qS+mJzaEMllI66ZJH3VTFfcGuDIRN
         JE0ErS9joMLg/EO2VF3M3vODjOuLPzmCLIpUgrHSlo/ZTVD1kedOVC6s06V5w4fcybOq
         BKr/YuGpZYCOgan1KemyVGWFISyGgluALm+l29ZNrUDIMY51z8ciMDOm8U/0qrMhk9Vu
         ikxGrPpGd5/IeJuEGrJR8JqdaxNJv+3PNNF4HCeXisAUXylauPIlY9rTSjIwckqULWdu
         FtVw==
X-Gm-Message-State: AOAM533Y9pTSYqILtwpIT0a4Fr6dyVaZnd1knLz0EHt0fxbME25nGnIp
        8cpfHr23CZTZSsMsIrcJQxs=
X-Google-Smtp-Source: ABdhPJzjy0x3c/tX1VotMsvfHQG9+DXzsn5v/WGTuH0nqXXRNAuR5G/dTLQ/N5B0Ss2FsBHE6U4jew==
X-Received: by 2002:a17:907:7b8a:b0:6e7:7c12:b06d with SMTP id ne10-20020a1709077b8a00b006e77c12b06dmr15367018ejc.594.1649710192050;
        Mon, 11 Apr 2022 13:49:52 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b006da6436819dsm12313957eje.173.2022.04.11.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:49:51 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:49:49 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] staging: vt6655: Replace VNSvOutPortD with iowrite32
Message-ID: <b35fece0361e21dde865969d3ef930da783f26c4.1649706687.git.philipp.g.hortmann@gmail.com>
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

Replace macro VNSvOutPortD with iowrite32.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

For constants from 0 to below 0x80000000 the u32 cast was omitted.
For variables which are defined as unsigned long the u32 is omitted.

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Patch was not existing
V2 -> V3: Inserted patch that was before in a different way in
          "Rename macros VNSvOutPortB,W,D"
          This patch was part of 5/6 and is now 6/7
---
 drivers/staging/vt6655/baseband.c    |  2 +-
 drivers/staging/vt6655/card.c        | 27 +++++++++----------
 drivers/staging/vt6655/device_main.c | 14 ++++------
 drivers/staging/vt6655/mac.h         | 39 ++++++++++++++--------------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 6 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 4f1c44127e03..3b3211d0077a 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2014,7 +2014,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 					byVT3253B0_AGC4_RFMD2959[ii][0],
 					byVT3253B0_AGC4_RFMD2959[ii][1]);
 
-			VNSvOutPortD(iobase + MAC_REG_ITRTMSET, 0x23);
+			iowrite32(0x23, iobase + MAC_REG_ITRTMSET);
 			MACvRegBitsOn(iobase, MAC_REG_PAPEDELAY, BIT(0));
 		}
 		priv->abyBBVGA[0] = 0x18;
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 57b9ea385690..8701a3a6b46f 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -294,10 +294,8 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
 						local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
-		VNSvOutPortD(priv->port_offset + MAC_REG_TSFOFST,
-			     (u32)qwTSFOffset);
-		VNSvOutPortD(priv->port_offset + MAC_REG_TSFOFST + 4,
-			     (u32)(qwTSFOffset >> 32));
+		iowrite32((u32)qwTSFOffset, priv->port_offset + MAC_REG_TSFOFST);
+		iowrite32((u32)(qwTSFOffset >> 32), priv->port_offset + MAC_REG_TSFOFST + 4);
 		MACvRegBitsOn(priv->port_offset, MAC_REG_TFTCTL,
 			      TFTCTL_TSFSYNCEN);
 	}
@@ -330,9 +328,8 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 	iowrite16(wBeaconInterval, priv->port_offset + MAC_REG_BI);
 	priv->wBeaconInterval = wBeaconInterval;
 	/* Set NextTBTT */
-	VNSvOutPortD(priv->port_offset + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
-	VNSvOutPortD(priv->port_offset + MAC_REG_NEXTTBTT + 4,
-		     (u32)(qwNextTBTT >> 32));
+	iowrite32((u32)qwNextTBTT, priv->port_offset + MAC_REG_NEXTTBTT);
+	iowrite32((u32)(qwNextTBTT >> 32), priv->port_offset + MAC_REG_NEXTTBTT + 4);
 	MACvRegBitsOn(priv->port_offset, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 
 	return true;
@@ -554,7 +551,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	 /* swap over to get correct write order */
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_1, phy.field_write);
+	iowrite32(phy.field_write, priv->port_offset + MAC_REG_RSPINF_B_1);
 
 	/* RSPINF_b_2 */
 	vnt_get_phy_field(priv, 14,
@@ -563,7 +560,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_2, phy.field_write);
+	iowrite32(phy.field_write, priv->port_offset + MAC_REG_RSPINF_B_2);
 
 	/* RSPINF_b_5 */
 	vnt_get_phy_field(priv, 14,
@@ -572,7 +569,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_5, phy.field_write);
+	iowrite32(phy.field_write, priv->port_offset + MAC_REG_RSPINF_B_5);
 
 	/* RSPINF_b_11 */
 	vnt_get_phy_field(priv, 14,
@@ -581,7 +578,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_11, phy.field_write);
+	iowrite32(phy.field_write, priv->port_offset + MAC_REG_RSPINF_B_11);
 
 	/* RSPINF_a_6 */
 	s_vCalculateOFDMRParameter(RATE_6M,
@@ -800,8 +797,8 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 	/* Set NextTBTT */
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT + 4, (u32)(qwNextTBTT >> 32));
+	iowrite32((u32)qwNextTBTT, iobase + MAC_REG_NEXTTBTT);
+	iowrite32((u32)(qwNextTBTT >> 32), iobase + MAC_REG_NEXTTBTT + 4);
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 }
 
@@ -826,8 +823,8 @@ void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 
 	qwTSF = CARDqGetNextTBTT(qwTSF, wBeaconInterval);
 	/* Set NextTBTT */
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT, (u32)qwTSF);
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT + 4, (u32)(qwTSF >> 32));
+	iowrite32((u32)qwTSF, iobase + MAC_REG_NEXTTBTT);
+	iowrite32((u32)(qwTSF >> 32), iobase + MAC_REG_NEXTTBTT + 4);
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 	pr_debug("Card:Update Next TBTT[%8llx]\n", qwTSF);
 }
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index bd97e3b9bc98..8de225701ca1 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1522,20 +1522,16 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			if (priv->mc_list_count > 2) {
 				MACvSelectPage1(priv->port_offset);
 
-				VNSvOutPortD(priv->port_offset +
-					     MAC_REG_MAR0, 0xffffffff);
-				VNSvOutPortD(priv->port_offset +
-					    MAC_REG_MAR0 + 4, 0xffffffff);
+				iowrite32((u32)0xffffffff, priv->port_offset + MAC_REG_MAR0);
+				iowrite32((u32)0xffffffff, priv->port_offset + MAC_REG_MAR0 + 4);
 
 				MACvSelectPage0(priv->port_offset);
 			} else {
 				MACvSelectPage1(priv->port_offset);
 
-				VNSvOutPortD(priv->port_offset +
-					     MAC_REG_MAR0, (u32)multicast);
-				VNSvOutPortD(priv->port_offset +
-					     MAC_REG_MAR0 + 4,
-					     (u32)(multicast >> 32));
+				iowrite32((u32)multicast, priv->port_offset + MAC_REG_MAR0);
+				iowrite32((u32)(multicast >> 32),
+					  priv->port_offset + MAC_REG_MAR0 + 4);
 
 				MACvSelectPage0(priv->port_offset);
 			}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 9e8f7e1f1655..4827f370b5ad 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -568,8 +568,7 @@ do {									\
 
 /* set the chip with current BCN tx descriptor address */
 #define MACvSetCurrBCNTxDescAddr(iobase, dwCurrDescAddr)	\
-	VNSvOutPortD(iobase + MAC_REG_BCNDMAPTR,		\
-		     dwCurrDescAddr)
+	iowrite32((u32)(dwCurrDescAddr), iobase + MAC_REG_BCNDMAPTR)
 
 /* set the chip with current BCN length */
 #define MACvSetCurrBCNLength(iobase, wCurrBCNLength)		\
@@ -603,19 +602,19 @@ do {								\
 	iowrite8(HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON, iobase + MAC_REG_HOSTCR)
 
 #define MACvRx0PerPktMode(iobase)					\
-	VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, RX_PERPKT)
+	iowrite32(RX_PERPKT, iobase + MAC_REG_RXDMACTL0)
 
 #define MACvRx1PerPktMode(iobase)					\
-	VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, RX_PERPKT)
+	iowrite32(RX_PERPKT, iobase + MAC_REG_RXDMACTL1)
 
 #define MACvReceive0(iobase)						\
 do {									\
 	unsigned long dwData;						\
 	dwData = ioread32(iobase + MAC_REG_RXDMACTL0);		\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, DMACTL_WAKE); \
+		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL0); \
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, DMACTL_RUN); \
+		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL0); \
 } while (0)
 
 #define MACvReceive1(iobase)						\
@@ -623,9 +622,9 @@ do {									\
 	unsigned long dwData;						\
 	dwData = ioread32(iobase + MAC_REG_RXDMACTL1);		\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_WAKE); \
+		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL1); \
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_RUN); \
+		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL1); \
 } while (0)
 
 #define MACvTransmit0(iobase)						\
@@ -633,9 +632,9 @@ do {									\
 	unsigned long dwData;						\
 	dwData = ioread32(iobase + MAC_REG_TXDMACTL0);		\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_TXDMACTL0, DMACTL_WAKE); \
+		iowrite32(DMACTL_WAKE, iobase + MAC_REG_TXDMACTL0); \
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_TXDMACTL0, DMACTL_RUN); \
+		iowrite32(DMACTL_RUN, iobase + MAC_REG_TXDMACTL0); \
 } while (0)
 
 #define MACvTransmitAC0(iobase)					\
@@ -643,9 +642,9 @@ do {									\
 	unsigned long dwData;						\
 	dwData = ioread32(iobase + MAC_REG_AC0DMACTL);		\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_WAKE); \
+		iowrite32(DMACTL_WAKE, iobase + MAC_REG_AC0DMACTL); \
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_RUN); \
+		iowrite32(DMACTL_RUN, iobase + MAC_REG_AC0DMACTL); \
 } while (0)
 
 #define MACvTransmitBCN(iobase)					\
@@ -663,13 +662,13 @@ do {									\
 	*(pdwValue) = ioread32(iobase + MAC_REG_ISR)
 
 #define MACvWriteISR(iobase, dwValue)				\
-	VNSvOutPortD(iobase + MAC_REG_ISR, dwValue)
+	iowrite32((u32)(dwValue), iobase + MAC_REG_ISR)
 
 #define MACvIntEnable(iobase, dwMask)				\
-	VNSvOutPortD(iobase + MAC_REG_IMR, dwMask)
+	iowrite32((u32)(dwMask), iobase + MAC_REG_IMR)
 
 #define MACvIntDisable(iobase)				\
-	VNSvOutPortD(iobase + MAC_REG_IMR, 0)
+	iowrite32(0, iobase + MAC_REG_IMR)
 
 #define MACvSelectPage0(iobase)				\
 		iowrite8(0, iobase + MAC_REG_PAGE1SEL)
@@ -685,7 +684,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);		\
 	dwOrgValue = dwOrgValue | ENCFG_PROTECTMD;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)(dwOrgValue), iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvDisableProtectMD(iobase)					\
@@ -693,7 +692,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);		\
 	dwOrgValue = dwOrgValue & ~ENCFG_PROTECTMD;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)(dwOrgValue), iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvEnableBarkerPreambleMd(iobase)				\
@@ -701,7 +700,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);		\
 	dwOrgValue = dwOrgValue | ENCFG_BARKERPREAM;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)(dwOrgValue), iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvDisableBarkerPreambleMd(iobase)				\
@@ -709,7 +708,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);		\
 	dwOrgValue = dwOrgValue & ~ENCFG_BARKERPREAM;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)(dwOrgValue), iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvSetBBType(iobase, byTyp)					\
@@ -718,7 +717,7 @@ do {									\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);		\
 	dwOrgValue = dwOrgValue & ~ENCFG_BBTYPE_MASK;			\
 	dwOrgValue = dwOrgValue | (unsigned long)byTyp;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)(dwOrgValue), iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvGPIOIn(iobase, pbyValue)					\
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 76c651d4da31..fbbf2ce80120 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -171,7 +171,7 @@ bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData)
 	unsigned short ww;
 	unsigned long dwValue;
 
-	VNSvOutPortD(iobase + MAC_REG_IFREGCTL, dwData);
+	iowrite32(dwData, iobase + MAC_REG_IFREGCTL);
 
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index c14b4d98c466..904a299cccb5 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,9 +20,6 @@
 
 /* For memory mapped IO */
 
-#define VNSvOutPortD(dwIOAddress, dwData) \
-	iowrite32((u32)(dwData), dwIOAddress)
-
 #define PCAvDelayByIO(uDelayUnit)				\
 do {								\
 	unsigned char __maybe_unused byData;			\
-- 
2.25.1

