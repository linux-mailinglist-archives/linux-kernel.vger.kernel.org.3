Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553AD4FC627
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349969AbiDKUwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349960AbiDKUv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:51:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E313DE6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b24so19950352edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cRYEcs3fW7Hqu+tQ57lziHYgZW2DW5fdnO18X1QNnyE=;
        b=gcWt3cP2FTKL72gkCRmx0j+gKjk+FXXCvaAiwXKxxaBVVVriFZ8M/cWjby/NqilZ+N
         oI1u5T5N3PsADbXoZU/NzIrUffK8771lN/hEh54ZdHT9SVxdz2vDw3pPteP3oZ5Icsy8
         j4FcxbdnpU6Z1op0oXHV67Lbcme09UgA/8brP1ac9oWuhb4vXrungEbZ1sxNW9dzvRQV
         HilFlDuVDxUdE713GoFaeHZKsuMCeVt7Jvu5aTZlIk8tWKI/RgyAVQy4/PdP/lmMGHIC
         EmXF3jkvEAOD2HIPzbuvLVO/3BpXL2DGfBJMRi8GyHF/cbz78FeIrZoFgPk16G4JWqt4
         EBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cRYEcs3fW7Hqu+tQ57lziHYgZW2DW5fdnO18X1QNnyE=;
        b=pCDeIU/KwDXqTjBfF0R4hy0Oh66DBHaz/lJJjiGxwKt1dvE8Fi1gizEZzjFp1tP0nM
         M29BaY5lNe48xq9XUI13M9HSor/J78zUYXvgSE8P2G93Ct8ytqkHREnUYkFwmdT2+Ef8
         BSQw2IOnjAga4eE1yTwgILkDRvtQG+qOJkYXyOk2DY+oKhC5ssnj/1oijZBcd7MgUjLt
         XXkc+SnkPpCTVmpjE4TEalEeWxaCuKC/lNVoSgTSNlE9NMLDW2zNqMyNo7A5cX8C6oY2
         bus5BAk8A23QLOCXwN/bE956McnkLcwh4EIuhanbeup36xx9iUHt1YMjZjxb8lgp1bFE
         F6dQ==
X-Gm-Message-State: AOAM532xMPctQvS4ZvinVDP+whSpLcETTE75rswWBjKy0oJFwTUWuB5X
        ot6D3aVa89/TqbQ6s0NXoOU=
X-Google-Smtp-Source: ABdhPJw+YB6daRudQ/VozEa/hVEiEa+aXevolaJsOhl0hGsqNXs3abHnYtXC01vRJFgsdrx9yuHa1w==
X-Received: by 2002:aa7:db0f:0:b0:41d:7b44:2613 with SMTP id t15-20020aa7db0f000000b0041d7b442613mr6872263eds.126.1649710181299;
        Mon, 11 Apr 2022 13:49:41 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id j8-20020aa7c0c8000000b0041934547989sm15764510edp.55.2022.04.11.13.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:49:40 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:49:39 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] staging: vt6655: Replace VNSvOutPortB with iowrite8
Message-ID: <3cac1ca7000a56e82b390ea0ddbab5aa549ee7ec.1649706687.git.philipp.g.hortmann@gmail.com>
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

Replace macro VNSvOutPortB with iowrite8.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

For constants from 0 to below 0x80 the u8 cast was omitted.
For variables which are defined as unsigned char the u8 is omitted.

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: This patch was 6/7 and is now 5/6
V2 -> V3: Changed from
          "Rename macros VNSvOutPortB,W,D" to
          Replace VNSvOutPortB with iowrite8
          This patch was part of 5/6 and is now 4/7
---
 drivers/staging/vt6655/baseband.c    |  8 +++---
 drivers/staging/vt6655/card.c        | 11 ++++----
 drivers/staging/vt6655/channel.c     |  6 ++--
 drivers/staging/vt6655/device_main.c | 19 ++++++-------
 drivers/staging/vt6655/mac.h         | 41 ++++++++++++----------------
 drivers/staging/vt6655/rf.c          |  8 +++---
 drivers/staging/vt6655/rxtx.c        |  4 +--
 drivers/staging/vt6655/srom.c        | 10 +++----
 drivers/staging/vt6655/upc.h         |  3 --
 9 files changed, 47 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index decb55e96f02..4f1c44127e03 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1910,7 +1910,7 @@ bool bb_read_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	unsigned char by_value;
 
 	/* BB reg offset */
-	VNSvOutPortB(iobase + MAC_REG_BBREGADR, by_bb_addr);
+	iowrite8(by_bb_addr, iobase + MAC_REG_BBREGADR);
 
 	/* turn on REGR */
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGR);
@@ -1953,9 +1953,9 @@ bool bb_write_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	unsigned char by_value;
 
 	/* BB reg offset */
-	VNSvOutPortB(iobase + MAC_REG_BBREGADR, by_bb_addr);
+	iowrite8(by_bb_addr, iobase + MAC_REG_BBREGADR);
 	/* set BB data */
-	VNSvOutPortB(iobase + MAC_REG_BBREGDATA, by_data);
+	iowrite8(by_data, iobase + MAC_REG_BBREGDATA);
 
 	/* turn on BBREGCTL_REGW */
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGW);
@@ -2054,7 +2054,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 				byVT3253B0_AGC[ii][0],
 				byVT3253B0_AGC[ii][1]);
 
-		VNSvOutPortB(iobase + MAC_REG_ITRTMSET, 0x23);
+		iowrite8(0x23, iobase + MAC_REG_ITRTMSET);
 		MACvRegBitsOn(iobase, MAC_REG_PAPEDELAY, BIT(0));
 
 		priv->abyBBVGA[0] = 0x14;
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index f6d2a7fadc18..62fda818022e 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -239,26 +239,25 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 
 	if (priv->bySIFS != bySIFS) {
 		priv->bySIFS = bySIFS;
-		VNSvOutPortB(priv->port_offset + MAC_REG_SIFS, priv->bySIFS);
+		iowrite8(priv->bySIFS, priv->port_offset + MAC_REG_SIFS);
 	}
 	if (priv->byDIFS != byDIFS) {
 		priv->byDIFS = byDIFS;
-		VNSvOutPortB(priv->port_offset + MAC_REG_DIFS, priv->byDIFS);
+		iowrite8(priv->byDIFS, priv->port_offset + MAC_REG_DIFS);
 	}
 	if (priv->byEIFS != C_EIFS) {
 		priv->byEIFS = C_EIFS;
-		VNSvOutPortB(priv->port_offset + MAC_REG_EIFS, priv->byEIFS);
+		iowrite8(priv->byEIFS, priv->port_offset + MAC_REG_EIFS);
 	}
 	if (priv->bySlot != bySlot) {
 		priv->bySlot = bySlot;
-		VNSvOutPortB(priv->port_offset + MAC_REG_SLOT, priv->bySlot);
+		iowrite8(priv->bySlot, priv->port_offset + MAC_REG_SLOT);
 
 		bb_set_short_slot_time(priv);
 	}
 	if (priv->byCWMaxMin != byCWMaxMin) {
 		priv->byCWMaxMin = byCWMaxMin;
-		VNSvOutPortB(priv->port_offset + MAC_REG_CWMAXMIN0,
-			     priv->byCWMaxMin);
+		iowrite8(priv->byCWMaxMin, priv->port_offset + MAC_REG_CWMAXMIN0);
 	}
 
 	priv->byPacketType = CARDbyGetPktType(priv);
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index abe867814dc8..652dcaf61169 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -118,11 +118,9 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		/* set HW default power register */
 		MACvSelectPage1(priv->port_offset);
 		RFbSetPower(priv, RATE_1M, priv->byCurrentCh);
-		VNSvOutPortB(priv->port_offset + MAC_REG_PWRCCK,
-			     priv->byCurPwr);
+		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
 		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
-		VNSvOutPortB(priv->port_offset + MAC_REG_PWROFDM,
-			     priv->byCurPwr);
+		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
 		MACvSelectPage0(priv->port_offset);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 16b031c31925..1bfccaa08c45 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -334,8 +334,7 @@ static void device_init_registers(struct vnt_private *priv)
 	if (priv->local_id > REV_ID_VT3253_B1) {
 		MACvSelectPage1(priv->port_offset);
 
-		VNSvOutPortB(priv->port_offset + MAC_REG_MSRCTL + 1,
-			     (MSRCTL1_TXPWR | MSRCTL1_CSAPAREN));
+		iowrite8(MSRCTL1_TXPWR | MSRCTL1_CSAPAREN, priv->port_offset + MAC_REG_MSRCTL + 1);
 
 		MACvSelectPage0(priv->port_offset);
 	}
@@ -349,9 +348,9 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvSetLongRetryLimit(priv, priv->byLongRetryLimit);
 
 	/* reset TSF counter */
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	iowrite8(TFTCTL_TSFCNTRST, priv->port_offset + MAC_REG_TFTCTL);
 	/* enable TSF counter */
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
+	iowrite8(TFTCTL_TSFCNTREN, priv->port_offset + MAC_REG_TFTCTL);
 
 	/* initialize BBP registers */
 	bb_vt3253_init(priv);
@@ -1060,7 +1059,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 
 		if (isr & ISR_FETALERR) {
 			pr_debug(" ISR_FETALERR\n");
-			VNSvOutPortB(priv->port_offset + MAC_REG_SOFTPWRCTL, 0);
+			iowrite8(0, priv->port_offset + MAC_REG_SOFTPWRCTL);
 			VNSvOutPortW(priv->port_offset +
 				     MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPECTI);
 			device_error(priv, isr);
@@ -1477,10 +1476,8 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 			CARDvSetFirstNextTBTT(priv, conf->beacon_int);
 		} else {
-			VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL,
-				     TFTCTL_TSFCNTRST);
-			VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL,
-				     TFTCTL_TSFCNTREN);
+			iowrite8(TFTCTL_TSFCNTRST, priv->port_offset + MAC_REG_TFTCTL);
+			iowrite8(TFTCTL_TSFCNTREN, priv->port_offset + MAC_REG_TFTCTL);
 		}
 	}
 }
@@ -1561,7 +1558,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			rx_mode |= RCR_BSSID;
 	}
 
-	VNSvOutPortB(priv->port_offset + MAC_REG_RCR, rx_mode);
+	iowrite8(rx_mode, priv->port_offset + MAC_REG_RCR);
 
 	dev_dbg(&priv->pcid->dev, "rx mode out= %x\n", rx_mode);
 }
@@ -1621,7 +1618,7 @@ static void vnt_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct vnt_private *priv = hw->priv;
 
 	/* reset TSF counter */
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	iowrite8(TFTCTL_TSFCNTRST, priv->port_offset + MAC_REG_TFTCTL);
 }
 
 static const struct ieee80211_ops vnt_mac_ops = {
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 114d1f9c2a1a..1017236e3117 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -542,7 +542,7 @@
 do {									\
 	unsigned char byData;						\
 	byData = ioread8(iobase + byRegOfs);			\
-	VNSvOutPortB(iobase + byRegOfs, byData | (byBits));		\
+	iowrite8((u8)(byData | (byBits)), iobase + byRegOfs);		\
 } while (0)
 
 #define MACvWordRegBitsOn(iobase, byRegOfs, wBits)			\
@@ -556,7 +556,7 @@ do {									\
 do {									\
 	unsigned char byData;						\
 	byData = ioread8(iobase + byRegOfs);			\
-	VNSvOutPortB(iobase + byRegOfs, byData & ~(byBits));		\
+	iowrite8((u8)(byData & ~(byBits)), iobase + byRegOfs);		\
 } while (0)
 
 #define MACvWordRegBitsOff(iobase, byRegOfs, wBits)			\
@@ -578,37 +578,30 @@ do {									\
 
 #define MACvWriteBSSIDAddress(iobase, pbyEtherAddr)		\
 do {								\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0,			\
-		     *(pbyEtherAddr));				\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 1,		\
-		     *(pbyEtherAddr + 1));			\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 2,		\
-		     *(pbyEtherAddr + 2));			\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 3,		\
-		     *(pbyEtherAddr + 3));			\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 4,		\
-		     *(pbyEtherAddr + 4));			\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 5,		\
-		     *(pbyEtherAddr + 5));			\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);		\
+	iowrite8((u8)*(pbyEtherAddr), iobase + MAC_REG_BSSID0);				\
+	iowrite8((u8)*(pbyEtherAddr + 1), iobase + MAC_REG_BSSID0 + 1);			\
+	iowrite8((u8)*(pbyEtherAddr + 2), iobase + MAC_REG_BSSID0 + 2);			\
+	iowrite8((u8)*(pbyEtherAddr + 3), iobase + MAC_REG_BSSID0 + 3);			\
+	iowrite8((u8)*(pbyEtherAddr + 4), iobase + MAC_REG_BSSID0 + 4);			\
+	iowrite8((u8)*(pbyEtherAddr + 5), iobase + MAC_REG_BSSID0 + 5);			\
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);		\
 } while (0)
 
 #define MACvReadEtherAddress(iobase, pbyEtherAddr)		\
 do {								\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);		\
 	(*((unsigned char *)pbyEtherAddr) = ioread8(iobase + MAC_REG_PAR0));		\
 	(*(pbyEtherAddr + 1) = ioread8(iobase + MAC_REG_PAR0 + 1));	\
 	(*(pbyEtherAddr + 2) = ioread8(iobase + MAC_REG_PAR0 + 2));	\
 	(*(pbyEtherAddr + 3) = ioread8(iobase + MAC_REG_PAR0 + 3));	\
 	(*(pbyEtherAddr + 4) = ioread8(iobase + MAC_REG_PAR0 + 4));	\
 	(*(pbyEtherAddr + 5) = ioread8(iobase + MAC_REG_PAR0 + 5));	\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);		\
 } while (0)
 
 #define MACvStart(iobase)						\
-	VNSvOutPortB(iobase + MAC_REG_HOSTCR,				\
-		     (HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON))
+	iowrite8(HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON, iobase + MAC_REG_HOSTCR)
 
 #define MACvRx0PerPktMode(iobase)					\
 	VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, RX_PERPKT)
@@ -657,14 +650,14 @@ do {									\
 } while (0)
 
 #define MACvTransmitBCN(iobase)					\
-	VNSvOutPortB(iobase + MAC_REG_BCNDMACTL, BEACON_READY)
+	iowrite8(BEACON_READY, iobase + MAC_REG_BCNDMACTL)
 
 #define MACvClearStckDS(iobase)					\
 do {									\
 	unsigned char byOrgValue;					\
 	byOrgValue = ioread8(iobase + MAC_REG_STICKHW);		\
 	byOrgValue = byOrgValue & 0xFC;					\
-	VNSvOutPortB(iobase + MAC_REG_STICKHW, byOrgValue);		\
+	iowrite8((u8)byOrgValue, iobase + MAC_REG_STICKHW);		\
 } while (0)
 
 #define MACvReadISR(iobase, pdwValue)				\
@@ -680,10 +673,10 @@ do {									\
 	VNSvOutPortD(iobase + MAC_REG_IMR, 0)
 
 #define MACvSelectPage0(iobase)				\
-		VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0)
+		iowrite8(0, iobase + MAC_REG_PAGE1SEL)
 
 #define MACvSelectPage1(iobase)				\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1)
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
 #define MACvReadMIBCounter(iobase, pdwCounter)			\
 	*(pdwCounter) = ioread32(iobase + MAC_REG_MIBCNTR)
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 036f48572334..d4db0a0b702c 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -207,7 +207,7 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 	ret = true;
 
 	/* 3-wire control for normal mode */
-	VNSvOutPortB(iobase + MAC_REG_SOFTPWRCTL, 0);
+	iowrite8(0, iobase + MAC_REG_SOFTPWRCTL);
 
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, (SOFTPWRCTL_SWPECTI  |
 							 SOFTPWRCTL_TXPEINV));
@@ -238,7 +238,7 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 							 SOFTPWRCTL_TXPEINV));
 
 	/* 3-wire control for power saving mode */
-	VNSvOutPortB(iobase + MAC_REG_PSPWRSIG, (PSSIG_WPE3 | PSSIG_WPE2)); /* 1100 0000 */
+	iowrite8((u8)(PSSIG_WPE3 | PSSIG_WPE2), iobase + MAC_REG_PSPWRSIG); /* 1100 0000 */
 
 	return ret;
 }
@@ -254,10 +254,10 @@ static bool RFbAL2230SelectChannel(struct vnt_private *priv, unsigned char byCha
 	ret &= IFRFbWriteEmbedded(priv, al2230_channel_table1[byChannel - 1]);
 
 	/* Set Channel[7] = 0 to tell H/W channel is changing now. */
-	VNSvOutPortB(iobase + MAC_REG_CHANNEL, (byChannel & 0x7F));
+	iowrite8((u8)(byChannel & 0x7F), iobase + MAC_REG_CHANNEL);
 	MACvTimer0MicroSDelay(priv, SWITCH_CHANNEL_DELAY_AL2230);
 	/* Set Channel[7] = 1 to tell H/W channel change is done. */
-	VNSvOutPortB(iobase + MAC_REG_CHANNEL, (byChannel | 0x80));
+	iowrite8((u8)(byChannel | 0x80), iobase + MAC_REG_CHANNEL);
 
 	return ret;
 }
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 53506e242a96..146ad261696d 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1450,9 +1450,9 @@ int vnt_beacon_make(struct vnt_private *priv, struct ieee80211_vif *vif)
 int vnt_beacon_enable(struct vnt_private *priv, struct ieee80211_vif *vif,
 		      struct ieee80211_bss_conf *conf)
 {
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	iowrite8(TFTCTL_TSFCNTRST, priv->port_offset + MAC_REG_TFTCTL);
 
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
+	iowrite8(TFTCTL_TSFCNTREN, priv->port_offset + MAC_REG_TFTCTL);
 
 	CARDvSetFirstNextTBTT(priv, conf->beacon_int);
 
diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index a0432bacb6a0..7feaa5138de0 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -68,13 +68,13 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 	byData = 0xFF;
 	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
 	/* turn off hardware retry for getting NACK */
-	VNSvOutPortB(iobase + MAC_REG_I2MCFG, (byOrg & (~I2MCFG_NORETRY)));
+	iowrite8((u8)(byOrg & (~I2MCFG_NORETRY)), iobase + MAC_REG_I2MCFG);
 	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
-		VNSvOutPortB(iobase + MAC_REG_I2MTGID, EEP_I2C_DEV_ID);
-		VNSvOutPortB(iobase + MAC_REG_I2MTGAD, byContntOffset);
+		iowrite8(EEP_I2C_DEV_ID, iobase + MAC_REG_I2MTGID);
+		iowrite8(byContntOffset, iobase + MAC_REG_I2MTGAD);
 
 		/* issue read command */
-		VNSvOutPortB(iobase + MAC_REG_I2MCSR, I2MCSR_EEMR);
+		iowrite8(I2MCSR_EEMR, iobase + MAC_REG_I2MCSR);
 		/* wait DONE be set */
 		for (wDelay = 0; wDelay < W_MAX_TIMEOUT; wDelay++) {
 			byWait = ioread8(iobase + MAC_REG_I2MCSR);
@@ -88,7 +88,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 		}
 	}
 	byData = ioread8(iobase + MAC_REG_I2MDIPT);
-	VNSvOutPortB(iobase + MAC_REG_I2MCFG, byOrg);
+	iowrite8(byOrg, iobase + MAC_REG_I2MCFG);
 	return byData;
 }
 
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 9617667f1a69..2a6d9cd1b42d 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,9 +20,6 @@
 
 /* For memory mapped IO */
 
-#define VNSvOutPortB(dwIOAddress, byData) \
-	iowrite8((u8)(byData), dwIOAddress)
-
 #define VNSvOutPortW(dwIOAddress, wData) \
 	iowrite16((u16)(wData), dwIOAddress)
 
-- 
2.25.1

