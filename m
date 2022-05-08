Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA851F0AB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiEHTfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiEHTem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:34:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5656EF1B
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:30:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j15so16794871wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ieVlxjoMYTv3Cb34BiI6Rfab/LVZI52IXtHOAIyIJlc=;
        b=a5qojSM5JMY/wNMCyj2NyvNi6ZGNh2O7VcZwGXxiR9pCLjnQY0jJ5lwUwlFvzJAJsm
         ACtibIkagi5se/t5dSOjjUlmAmYFfCVBnb//IMNnz8SmJOoJDj5zi9aF8gKibcipIj9U
         XkPhIDkuwotF2JhwmNASo7oQCPg0IUbfg2pyXzjPP2bezj1XdVPsgI2yZQG2Y6Nshc/8
         sP6GaPUHgIT194CuRrh4KV7oXJObvPen+g0HAocKMWHlQKQJTv7FYgj5Uc31KxitOzMK
         HDQ6tIc8TmTtsxocynrWwx4m7xBUPdaBrk35zPdnX9hKo2+/tRURL1t0WndhV5/cc5Fd
         Pn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieVlxjoMYTv3Cb34BiI6Rfab/LVZI52IXtHOAIyIJlc=;
        b=uxm8jM3IETYlnIqLqqj8m6UdmtVA88+D1eBGRWVPbiouwX8Qse3VSXjNrQLN6GX48f
         oKEPq2mTr2oy3u8A4uu3uim29Zos3h7eS/7n8pMK4JAlr2Nec4pVOyaYu6mONu1HaCj6
         G46kBMihsOVADtGLcKh+bq8C4USoHjnttLWrDHbN8FYrXKpRB4/VNYmKdKz5OFgVQGQ+
         Z6cX/gOWBbg4nKc+aYn5DJR4aG/AfEWCkO1pLFZzeDfeMRfwIFFRFvI6topkHm3tMgge
         vRwx5l7P4TjBVcv+d/XV+bcPGNyFFuLlF2iy3yLuk4Ii9nTDcuXiFopgAx+Jjg2cJL2h
         Twaw==
X-Gm-Message-State: AOAM5339ullQtosotJ2adcZ0uP+c9vmN5DifBnpkSSnlnNd0P7ruOSo1
        Kh1i191MMnkkvX0JEA+pd+M=
X-Google-Smtp-Source: ABdhPJwJjHxMYYfsRxJ8iIroHPLN/aj9ocEW6j3Ia3g3WJc7l6w+nsFUIW6HfbUL4Ax2DR5XZ4P8Jw==
X-Received: by 2002:a5d:6806:0:b0:20a:db0b:ad9b with SMTP id w6-20020a5d6806000000b0020adb0bad9bmr10952343wru.294.1652038205724;
        Sun, 08 May 2022 12:30:05 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f3ed42031f51b0dd5fb7060.dip0.t-ipconnect.de. [2003:c7:8f3e:d420:31f5:1b0d:d5fb:7060])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b0038ec8b633fesm10106299wms.1.2022.05.08.12.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:30:05 -0700 (PDT)
Date:   Sun, 8 May 2022 21:30:03 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: vt6655: Replace VNSvOutPortB with iowrite8
Message-ID: <38611512677a18f63d9266cde1d20758c0feeb6e.1651957741.git.philipp.g.hortmann@gmail.com>
References: <cover.1651957741.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651957741.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvOutPortB with iowrite8 because it replaces
just one line.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Code for testing of written BSSIDAddress:
added in file mac.h
'#define MACvReadBSSIDAddress(iobase, pbyEtherAddr)		\
do {								\
	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
	pbyEtherAddr[0] = ioread8(iobase + MAC_REG_BSSID0);	\
	pbyEtherAddr[1] = ioread8(iobase + MAC_REG_BSSID0 + 1);	\
	pbyEtherAddr[2] = ioread8(iobase + MAC_REG_BSSID0 + 2);	\
	pbyEtherAddr[3] = ioread8(iobase + MAC_REG_BSSID0 + 3);	\
	pbyEtherAddr[4] = ioread8(iobase + MAC_REG_BSSID0 + 4);	\
	pbyEtherAddr[5] = ioread8(iobase + MAC_REG_BSSID0 + 5);	\
	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
} while (0)

added in file device_main.c
static void vnt_bss_info_changed(struct ieee80211_hw *hw,
...
unsigned char tmp[6] __attribute__((aligned(2)));
...
	dev_info(&priv->pcid->dev, "conf->bssid: MAC=%pM\n", conf->bssid);
	MACvWriteBSSIDAddress(priv->port_offset, conf->bssid);
	MACvReadBSSIDAddress(priv->port_offset, tmp);
	dev_info(&priv->pcid->dev, "tmp: MAC=%pM\n", tmp);

Log:
vt6655 0000:01:05.0: conf->bssid: MAC=f4:ec:38:e9:c5:1c
vt6655 0000:01:05.0: tmp: MAC=f4:ec:38:e9:c5:1c
---
 drivers/staging/vt6655/baseband.c    |  8 +++----
 drivers/staging/vt6655/card.c        | 11 ++++-----
 drivers/staging/vt6655/channel.c     |  6 ++---
 drivers/staging/vt6655/device_main.c | 24 ++++++++-----------
 drivers/staging/vt6655/mac.h         | 36 ++++++++++++----------------
 drivers/staging/vt6655/rf.c          |  8 +++----
 drivers/staging/vt6655/rxtx.c        |  6 ++---
 drivers/staging/vt6655/srom.c        | 10 ++++----
 drivers/staging/vt6655/upc.h         |  3 ---
 9 files changed, 48 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 21e691c3ea30..577a38fae369 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1909,7 +1909,7 @@ bool bb_read_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	unsigned char by_value;
 
 	/* BB reg offset */
-	VNSvOutPortB(iobase + MAC_REG_BBREGADR, by_bb_addr);
+	iowrite8(by_bb_addr, iobase + MAC_REG_BBREGADR);
 
 	/* turn on REGR */
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGR);
@@ -1952,9 +1952,9 @@ bool bb_write_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	unsigned char by_value;
 
 	/* BB reg offset */
-	VNSvOutPortB(iobase + MAC_REG_BBREGADR, by_bb_addr);
+	iowrite8(by_bb_addr, iobase + MAC_REG_BBREGADR);
 	/* set BB data */
-	VNSvOutPortB(iobase + MAC_REG_BBREGDATA, by_data);
+	iowrite8(by_data, iobase + MAC_REG_BBREGDATA);
 
 	/* turn on BBREGCTL_REGW */
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGW);
@@ -2053,7 +2053,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 				byVT3253B0_AGC[ii][0],
 				byVT3253B0_AGC[ii][1]);
 
-		VNSvOutPortB(iobase + MAC_REG_ITRTMSET, 0x23);
+		iowrite8(0x23, iobase + MAC_REG_ITRTMSET);
 		MACvRegBitsOn(iobase, MAC_REG_PAPEDELAY, BIT(0));
 
 		priv->abyBBVGA[0] = 0x14;
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index d3c47b37ad3b..2cde0082fc03 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -238,26 +238,25 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 
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
index 1ab7c1c3644d..afaf331fe125 100644
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
@@ -406,8 +405,7 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvReceive1(priv->port_offset);
 
 	/* start the adapter */
-	VNSvOutPortB(priv->port_offset + MAC_REG_HOSTCR,
-		     (HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON));
+	iowrite8(HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON, priv->port_offset + MAC_REG_HOSTCR);
 }
 
 static void device_print_info(struct vnt_private *priv)
@@ -1061,7 +1059,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 
 		if (isr & ISR_FETALERR) {
 			pr_debug(" ISR_FETALERR\n");
-			VNSvOutPortB(priv->port_offset + MAC_REG_SOFTPWRCTL, 0);
+			iowrite8(0, priv->port_offset + MAC_REG_SOFTPWRCTL);
 			VNSvOutPortW(priv->port_offset +
 				     MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPECTI);
 			device_error(priv, isr);
@@ -1408,7 +1406,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 		spin_lock_irqsave(&priv->lock, flags);
 
-		MACvWriteBSSIDAddress(priv->port_offset, (u8 *)conf->bssid);
+		MACvWriteBSSIDAddress(priv->port_offset, conf->bssid);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
@@ -1478,10 +1476,8 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
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
@@ -1562,7 +1558,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			rx_mode |= RCR_BSSID;
 	}
 
-	VNSvOutPortB(priv->port_offset + MAC_REG_RCR, rx_mode);
+	iowrite8(rx_mode, priv->port_offset + MAC_REG_RCR);
 
 	dev_dbg(&priv->pcid->dev, "rx mode out= %x\n", rx_mode);
 }
@@ -1622,7 +1618,7 @@ static void vnt_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct vnt_private *priv = hw->priv;
 
 	/* reset TSF counter */
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	iowrite8(TFTCTL_TSFCNTRST, priv->port_offset + MAC_REG_TFTCTL);
 }
 
 static const struct ieee80211_ops vnt_mac_ops = {
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 89fad233bbc6..57ae3bdbdb2d 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -541,7 +541,7 @@
 do {									\
 	unsigned char byData;						\
 	byData = ioread8(iobase + byRegOfs);				\
-	VNSvOutPortB(iobase + byRegOfs, byData | (byBits));		\
+	iowrite8(byData | (byBits), iobase + byRegOfs);			\
 } while (0)
 
 #define MACvWordRegBitsOn(iobase, byRegOfs, wBits)			\
@@ -555,7 +555,7 @@ do {									\
 do {									\
 	unsigned char byData;						\
 	byData = ioread8(iobase + byRegOfs);				\
-	VNSvOutPortB(iobase + byRegOfs, byData & ~(byBits));		\
+	iowrite8(byData & ~(byBits), iobase + byRegOfs);		\
 } while (0)
 
 #define MACvWordRegBitsOff(iobase, byRegOfs, wBits)			\
@@ -577,32 +577,26 @@ do {									\
 
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
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
+	iowrite8(pbyEtherAddr[0], iobase + MAC_REG_BSSID0);	\
+	iowrite8(pbyEtherAddr[1], iobase + MAC_REG_BSSID0 + 1);	\
+	iowrite8(pbyEtherAddr[2], iobase + MAC_REG_BSSID0 + 2);	\
+	iowrite8(pbyEtherAddr[3], iobase + MAC_REG_BSSID0 + 3);	\
+	iowrite8(pbyEtherAddr[4], iobase + MAC_REG_BSSID0 + 4);	\
+	iowrite8(pbyEtherAddr[5], iobase + MAC_REG_BSSID0 + 5);	\
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
 } while (0)
 
 #define MACvReadEtherAddress(iobase, pbyEtherAddr)		\
 do {								\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
 	pbyEtherAddr[0] = ioread8(iobase + MAC_REG_PAR0);	\
 	pbyEtherAddr[1] = ioread8(iobase + MAC_REG_PAR0 + 1);	\
 	pbyEtherAddr[2] = ioread8(iobase + MAC_REG_PAR0 + 2);	\
 	pbyEtherAddr[3] = ioread8(iobase + MAC_REG_PAR0 + 3);	\
 	pbyEtherAddr[4] = ioread8(iobase + MAC_REG_PAR0 + 4);	\
 	pbyEtherAddr[5] = ioread8(iobase + MAC_REG_PAR0 + 5);	\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
 } while (0)
 
 #define MACvRx0PerPktMode(iobase)					\
@@ -656,7 +650,7 @@ do {									\
 	unsigned char byOrgValue;					\
 	byOrgValue = ioread8(iobase + MAC_REG_STICKHW);			\
 	byOrgValue = byOrgValue & 0xFC;					\
-	VNSvOutPortB(iobase + MAC_REG_STICKHW, byOrgValue);		\
+	iowrite8(byOrgValue, iobase + MAC_REG_STICKHW);			\
 } while (0)
 
 #define MACvWriteISR(iobase, dwValue)				\
@@ -669,10 +663,10 @@ do {									\
 	VNSvOutPortD(iobase + MAC_REG_IMR, 0)
 
 #define MACvSelectPage0(iobase)				\
-		VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0)
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL)
 
 #define MACvSelectPage1(iobase)				\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1)
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
 #define MACvEnableProtectMD(iobase)					\
 do {									\
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 036f48572334..ee5e2e0d9a8c 100644
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
+	iowrite8(PSSIG_WPE3 | PSSIG_WPE2, iobase + MAC_REG_PSPWRSIG);
 
 	return ret;
 }
@@ -254,10 +254,10 @@ static bool RFbAL2230SelectChannel(struct vnt_private *priv, unsigned char byCha
 	ret &= IFRFbWriteEmbedded(priv, al2230_channel_table1[byChannel - 1]);
 
 	/* Set Channel[7] = 0 to tell H/W channel is changing now. */
-	VNSvOutPortB(iobase + MAC_REG_CHANNEL, (byChannel & 0x7F));
+	iowrite8(byChannel & 0x7F, iobase + MAC_REG_CHANNEL);
 	MACvTimer0MicroSDelay(priv, SWITCH_CHANNEL_DELAY_AL2230);
 	/* Set Channel[7] = 1 to tell H/W channel change is done. */
-	VNSvOutPortB(iobase + MAC_REG_CHANNEL, (byChannel | 0x80));
+	iowrite8(byChannel | 0x80, iobase + MAC_REG_CHANNEL);
 
 	return ret;
 }
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 14feff4f2e70..71cbfa607d96 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1426,7 +1426,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 	/* Set auto Transmit on */
 	MACvRegBitsOn(priv->port_offset, MAC_REG_TCR, TCR_AUTOBCNTX);
 	/* Poll Transmit the adapter */
-	VNSvOutPortB(priv->port_offset + MAC_REG_BCNDMACTL, BEACON_READY);
+	iowrite8(BEACON_READY, priv->port_offset + MAC_REG_BCNDMACTL);
 
 	return 0;
 }
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
index 8786b55161fa..722a2cc9a473 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -67,13 +67,13 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 	byData = 0xFF;
 	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
 	/* turn off hardware retry for getting NACK */
-	VNSvOutPortB(iobase + MAC_REG_I2MCFG, (byOrg & (~I2MCFG_NORETRY)));
+	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
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
@@ -87,7 +87,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 		}
 	}
 	byData = ioread8(iobase + MAC_REG_I2MDIPT);
-	VNSvOutPortB(iobase + MAC_REG_I2MCFG, byOrg);
+	iowrite8(byOrg, iobase + MAC_REG_I2MCFG);
 	return byData;
 }
 
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index a5b74aaadcd3..2a47f5782b71 100644
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

