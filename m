Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B472A5305A3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350606AbiEVTts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350487AbiEVTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:49:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CC23A1B7
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id wh22so24626361ejb.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nyTXQUynFitMTZztMwbVG0yiiDkfYZKbTZKsjCCO8+Y=;
        b=J7Se2oJcuIqEeYEPX4zYNEG6bNiwMK4EaU59QgULXWQTiStYqj9yZK7sbl9Ui9Jymo
         NqmuFRfRfljaJuvOnZgz5tbkanR35v6ZfCEA2ronxZuW7+LNKnWrsRsdLSb2ynO2hRRq
         OflrEP6yOP+/coEpsy+jp4aQb6uI3DuS1OQRVzbahPMqN7+iFFQ+AkAD8xClSpsxaSwP
         CC3dKzSLiciir+lKyhBLJvZYyqfn9qTHTo8RxlHgKNVumz6U8Evs/dKDf5X6fNmywd/d
         WSuOIRhzlsWasAEMgOw418fr2A8307qOrGe/6mANZwjYlgJzuAz6diV3SEDozcHFuY0K
         xzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nyTXQUynFitMTZztMwbVG0yiiDkfYZKbTZKsjCCO8+Y=;
        b=PAAF6olTw5rcZ9oJUJgsWg3I0rACEwlOJewHwp/rwQ+cCJCaL9NHfcOFeviKEOVzw0
         4Cbh4ydYHC2ccQkIYfD4ZMnHwKOYojvpS1Q58SP+6julqZrAIDO8vRFg84ggMTMm+pxY
         i5aW2OQWPNqgu42ME5tZ+E6hv+MkroTUI2MeUS9tcLm6+qtLJDuC6PC54j6HqcV7u/zw
         iVl4aOeh2Ue/7Fy4ldtbUcmKNd57twuzc2UaH71EmlN0kqnk+YnLzJvbnZAvGNs+0OkD
         At5bXrUYYbL9assFyNeyFdQSfH1Y74EI4wQ3E42W7j8yqNwjveKh+P6C6Agn2TUEBYYT
         vY3Q==
X-Gm-Message-State: AOAM530UDzcumLN4f5Aq0RNK+uqotEeEsFcLLPLBazTY2v2nYVdkiG0x
        clTEmZQZvf62sWvTyl0wEP4=
X-Google-Smtp-Source: ABdhPJxoegm4xFuVuDIy3dkIRAvNSJfm91e1YQX6T9v9PXOOxg9Sn//CRO0clQ85jmkEhiAzTeLZGg==
X-Received: by 2002:a17:907:162a:b0:6fe:c691:47f5 with SMTP id hb42-20020a170907162a00b006fec69147f5mr4807587ejc.289.1653248966361;
        Sun, 22 May 2022 12:49:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935774.dip0.t-ipconnect.de. [87.147.87.116])
        by smtp.gmail.com with ESMTPSA id i17-20020a170906115100b006fecf23fecdsm992741eja.127.2022.05.22.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:49:26 -0700 (PDT)
Date:   Sun, 22 May 2022 21:49:24 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] staging: vt6655: Replace VNSvOutPortD with iowrite32
Message-ID: <03b6ff0250aa797f45a855ff2fc76f8013f73dc0.1653203927.git.philipp.g.hortmann@gmail.com>
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

Replace macro VNSvOutPortD with iowrite32 because it replaces
just one line.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/baseband.c    |  2 +-
 drivers/staging/vt6655/card.c        | 33 +++++++++++++---------------
 drivers/staging/vt6655/device_main.c | 22 ++++++++-----------
 drivers/staging/vt6655/mac.c         |  2 +-
 drivers/staging/vt6655/mac.h         | 26 +++++++++++-----------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/rxtx.c        |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 8 files changed, 41 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 577a38fae369..a5412ca0ea68 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2013,7 +2013,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 					byVT3253B0_AGC4_RFMD2959[ii][0],
 					byVT3253B0_AGC4_RFMD2959[ii][1]);
 
-			VNSvOutPortD(iobase + MAC_REG_ITRTMSET, 0x23);
+			iowrite32(0x23, iobase + MAC_REG_ITRTMSET);
 			MACvRegBitsOn(iobase, MAC_REG_PAPEDELAY, BIT(0));
 		}
 		priv->abyBBVGA[0] = 0x18;
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 57ed2120dbc1..7a4a8b3f164e 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -293,10 +293,8 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
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
@@ -329,9 +327,8 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
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
@@ -411,7 +408,7 @@ void CARDvSafeResetTx(struct vnt_private *priv)
 	MACvSetCurrTXDescAddr(TYPE_AC0DMA, priv, priv->td1_pool_dma);
 
 	/* set MAC Beacon TX pointer */
-	VNSvOutPortD(priv->port_offset + MAC_REG_BCNDMAPTR, priv->tx_beacon_dma);
+	iowrite32((u32)priv->tx_beacon_dma, priv->port_offset + MAC_REG_BCNDMAPTR);
 }
 
 /*
@@ -452,8 +449,8 @@ void CARDvSafeResetRx(struct vnt_private *priv)
 	}
 
 	/* set perPkt mode */
-	VNSvOutPortD(priv->port_offset + MAC_REG_RXDMACTL0, RX_PERPKT);
-	VNSvOutPortD(priv->port_offset + MAC_REG_RXDMACTL1, RX_PERPKT);
+	iowrite32(RX_PERPKT, priv->port_offset + MAC_REG_RXDMACTL0);
+	iowrite32(RX_PERPKT, priv->port_offset + MAC_REG_RXDMACTL1);
 	/* set MAC RD pointer */
 	MACvSetCurrRx0DescAddr(priv, priv->rd0_pool_dma);
 
@@ -552,7 +549,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	 /* swap over to get correct write order */
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_1, phy.field_write);
+	iowrite32(phy.field_write, priv->port_offset + MAC_REG_RSPINF_B_1);
 
 	/* RSPINF_b_2 */
 	vnt_get_phy_field(priv, 14,
@@ -561,7 +558,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_2, phy.field_write);
+	iowrite32(phy.field_write, priv->port_offset + MAC_REG_RSPINF_B_2);
 
 	/* RSPINF_b_5 */
 	vnt_get_phy_field(priv, 14,
@@ -570,7 +567,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_5, phy.field_write);
+	iowrite32(phy.field_write, priv->port_offset + MAC_REG_RSPINF_B_5);
 
 	/* RSPINF_b_11 */
 	vnt_get_phy_field(priv, 14,
@@ -579,7 +576,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_11, phy.field_write);
+	iowrite32(phy.field_write, priv->port_offset + MAC_REG_RSPINF_B_11);
 
 	/* RSPINF_a_6 */
 	s_vCalculateOFDMRParameter(RATE_6M,
@@ -798,8 +795,8 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 	/* Set NextTBTT */
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT + 4, (u32)(qwNextTBTT >> 32));
+	iowrite32((u32)qwNextTBTT, iobase + MAC_REG_NEXTTBTT);
+	iowrite32((u32)(qwNextTBTT >> 32), iobase + MAC_REG_NEXTTBTT + 4);
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 }
 
@@ -824,8 +821,8 @@ void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 
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
index 29ee0fd893cc..c32c0328b602 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1055,7 +1055,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	 * update ISR counter
 	 */
 	while (isr && priv->vif) {
-		VNSvOutPortD(priv->port_offset + MAC_REG_ISR, isr);
+		iowrite32(isr, priv->port_offset + MAC_REG_ISR);
 
 		if (isr & ISR_FETALERR) {
 			pr_debug(" ISR_FETALERR\n");
@@ -1134,7 +1134,7 @@ static void vnt_interrupt_work(struct work_struct *work)
 	if (priv->vif)
 		vnt_interrupt_process(priv);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_IMR, IMR_MASK_VALUE);
+	iowrite32(IMR_MASK_VALUE, priv->port_offset + MAC_REG_IMR);
 }
 
 static irqreturn_t vnt_interrupt(int irq,  void *arg)
@@ -1143,7 +1143,7 @@ static irqreturn_t vnt_interrupt(int irq,  void *arg)
 
 	schedule_work(&priv->interrupt_work);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_IMR, 0);
+	iowrite32(0, priv->port_offset + MAC_REG_IMR);
 
 	return IRQ_HANDLED;
 }
@@ -1253,7 +1253,7 @@ static int vnt_start(struct ieee80211_hw *hw)
 	device_init_registers(priv);
 
 	dev_dbg(&priv->pcid->dev, "enable MAC interrupt\n");
-	VNSvOutPortD(priv->port_offset + MAC_REG_IMR, IMR_MASK_VALUE);
+	iowrite32(IMR_MASK_VALUE, priv->port_offset + MAC_REG_IMR);
 
 	ieee80211_wake_queues(hw);
 
@@ -1522,20 +1522,16 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			if (priv->mc_list_count > 2) {
 				MACvSelectPage1(priv->port_offset);
 
-				VNSvOutPortD(priv->port_offset +
-					     MAC_REG_MAR0, 0xffffffff);
-				VNSvOutPortD(priv->port_offset +
-					    MAC_REG_MAR0 + 4, 0xffffffff);
+				iowrite32(0xffffffff, priv->port_offset + MAC_REG_MAR0);
+				iowrite32(0xffffffff, priv->port_offset + MAC_REG_MAR0 + 4);
 
 				MACvSelectPage0(priv->port_offset);
 			} else {
 				MACvSelectPage1(priv->port_offset);
 
-				VNSvOutPortD(priv->port_offset +
-					     MAC_REG_MAR0, (u32)multicast);
-				VNSvOutPortD(priv->port_offset +
-					     MAC_REG_MAR0 + 4,
-					     (u32)(multicast >> 32));
+				iowrite32((u32)multicast, priv->port_offset +  MAC_REG_MAR0);
+				iowrite32((u32)(multicast >> 32),
+					  priv->port_offset + MAC_REG_MAR0 + 4);
 
 				MACvSelectPage0(priv->port_offset);
 			}
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 24eab18972d2..8e789ce055cd 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -458,7 +458,7 @@ bool MACbShutdown(struct vnt_private *priv)
 {
 	void __iomem *io_base = priv->port_offset;
 	/* disable MAC IMR */
-	VNSvOutPortD(io_base + MAC_REG_IMR, 0);
+	iowrite32(0, io_base + MAC_REG_IMR);
 	MACvSetLoopbackMode(priv, MAC_LB_INTERNAL);
 	/* stop the adapter */
 	if (!MACbSafeStop(priv)) {
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b68e21c62d2b..71de3aa7e7c5 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -594,9 +594,9 @@ do {									\
 	unsigned long dwData;						\
 	dwData = ioread32(iobase + MAC_REG_RXDMACTL0);			\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, DMACTL_WAKE); \
+		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL0);	\
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, DMACTL_RUN); \
+		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL0);	\
 } while (0)
 
 #define MACvReceive1(iobase)						\
@@ -604,9 +604,9 @@ do {									\
 	unsigned long dwData;						\
 	dwData = ioread32(iobase + MAC_REG_RXDMACTL1);			\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_WAKE); \
+		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL1);	\
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_RUN); \
+		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL1);	\
 } while (0)
 
 #define MACvTransmit0(iobase)						\
@@ -614,9 +614,9 @@ do {									\
 	unsigned long dwData;						\
 	dwData = ioread32(iobase + MAC_REG_TXDMACTL0);			\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_TXDMACTL0, DMACTL_WAKE); \
+		iowrite32(DMACTL_WAKE, iobase + MAC_REG_TXDMACTL0);	\
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_TXDMACTL0, DMACTL_RUN); \
+		iowrite32(DMACTL_RUN, iobase + MAC_REG_TXDMACTL0);	\
 } while (0)
 
 #define MACvTransmitAC0(iobase)					\
@@ -624,9 +624,9 @@ do {									\
 	unsigned long dwData;						\
 	dwData = ioread32(iobase + MAC_REG_AC0DMACTL);			\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_WAKE); \
+		iowrite32(DMACTL_WAKE, iobase + MAC_REG_AC0DMACTL);	\
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_RUN); \
+		iowrite32(DMACTL_RUN, iobase + MAC_REG_AC0DMACTL);	\
 } while (0)
 
 #define MACvClearStckDS(iobase)					\
@@ -648,7 +648,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue | ENCFG_PROTECTMD;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvDisableProtectMD(iobase)					\
@@ -656,7 +656,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue & ~ENCFG_PROTECTMD;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvEnableBarkerPreambleMd(iobase)				\
@@ -664,7 +664,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue | ENCFG_BARKERPREAM;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvDisableBarkerPreambleMd(iobase)				\
@@ -672,7 +672,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue & ~ENCFG_BARKERPREAM;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvSetBBType(iobase, byTyp)					\
@@ -681,7 +681,7 @@ do {									\
 	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue & ~ENCFG_BBTYPE_MASK;			\
 	dwOrgValue = dwOrgValue | (unsigned long)byTyp;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
 } while (0)
 
 #define MACvSetRFLE_LatchBase(iobase)                                 \
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index ff6f654df2d2..99850367293a 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -171,7 +171,7 @@ bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData)
 	unsigned short ww;
 	unsigned long dwValue;
 
-	VNSvOutPortD(iobase + MAC_REG_IFREGCTL, dwData);
+	iowrite32((u32)dwData, iobase + MAC_REG_IFREGCTL);
 
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 03c2ab8489fa..736681274296 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1420,7 +1420,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 
 	priv->wBCNBufLen = sizeof(*short_head) + skb->len;
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_BCNDMAPTR, priv->tx_beacon_dma);
+	iowrite32((u32)priv->tx_beacon_dma, priv->port_offset + MAC_REG_BCNDMAPTR);
 
 	iowrite16(priv->wBCNBufLen, priv->port_offset + MAC_REG_BCNDMACTL + 2);
 	/* Set auto Transmit on */
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 0f2f7df00b3a..c7966a638fde 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,9 +20,6 @@
 
 /* For memory mapped IO */
 
-#define VNSvOutPortD(dwIOAddress, dwData) \
-	iowrite32((u32)(dwData), dwIOAddress)
-
 /*---------------------  Export Classes  ----------------------------*/
 
 /*---------------------  Export Variables  --------------------------*/
-- 
2.25.1

