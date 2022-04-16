Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D2D503512
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiDPIDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiDPIDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:03:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0553DA40
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:00:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u15so18762162ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2OH6YITjPCmzx/9D8LSWWvC6onzpDes2kY/eqgyLQz4=;
        b=Ee7iIPUesrmyUCSTujUbLLiY3m9W8or5mgfAzKyHrxJbZMqyZRmrNT2+DySPyHAm+l
         zo30AOrnr4ZZo0bekpECGexo1MJ7K/og6jNpKrBL9QF3Rg1P6vKTWqG5ccFwA1H67WQQ
         VkT9OmrXBw9h80whkWVkz6pHivbeIr3jOWr7/Mltko0C2P4NgySaM68Df7Tr2q+mXiWD
         Q5beM767f62LWg/H63p5WrwC8duw7uvbftB72QKYG59rBxRmRRe2uF38QzcEG63vnuyH
         RSJz2i0wWk2FKB7riA9RaLTEa5f1vRq2RxlneMGuQC2cv5RPiStYFPjPxVGvJ/OG4bQh
         hnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2OH6YITjPCmzx/9D8LSWWvC6onzpDes2kY/eqgyLQz4=;
        b=el2/A4Tlu4DKkAbF1vrh8ht7ojBZv6lDOh9DW4tsbVKhghG14kK6qaM/9nEMiUmzbn
         n0cuUa+dfXKhh2s5NS8ORAV//N0P+oykVRL8h8Ihmse94kyJL1vvpJOsZJjm05E73lZ0
         oGp4Du9uHCMcNSGOodxaAh470DmwjuJgt/7qxFW8Vfr/Eb7o9Av6wjplpjrtRJ3nsYri
         uhKfwsdS/nzHgY0GZW1R9291VvKVmkCN6tWzf3fBrYTd0TuYPqdgE6WB9olabgXD8wVG
         nloWMAb5St4Gk/aVOo7FH1cshpZi1HRu81PuHI3Vv52Zli5AEv8MhjyVRLU9oYO7KpmK
         tuYg==
X-Gm-Message-State: AOAM530IbkQ3F34w+4YqO8ogGV4ldPR7ZND2uZxy1Ce4BebnH4m2Iui3
        JLTtjDRog3WqCCbU3aplLDk=
X-Google-Smtp-Source: ABdhPJyWU5LmL0P/c02r2032sXpfDJt3T71kyZZe77iCYRjT9cW73cKyoMUjDshCyGGzhEHfEdozKg==
X-Received: by 2002:a17:907:6e1e:b0:6ef:5a59:2bd4 with SMTP id sd30-20020a1709076e1e00b006ef5a592bd4mr1992400ejc.143.1650096058299;
        Sat, 16 Apr 2022 01:00:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id f10-20020a056402328a00b0041f7a15a59fsm3664772eda.16.2022.04.16.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 01:00:57 -0700 (PDT)
Date:   Sat, 16 Apr 2022 10:00:55 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: vt6655: Replace VNSvInPortB with ioread8
Message-ID: <fd71797d9d55d53f95c5c4e2df826bf85dd4626a.1650094595.git.philipp.g.hortmann@gmail.com>
References: <cover.1650094595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650094595.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvInPortB with ioread8. Avoid cast of the return
value is possible with one exception.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: This patch was 4/7 and is now 3/6
V2 -> V3: Changed from rename macro arguments to replace
          macro VNSvInPortB with ioread8
          This patch was 3/6 and is now 1/7
V3 -> V4: Replacement now without a cast of the return value with
          only one exception.

Note: The one casting exception could be removed by changing
      bb_read_embedded. Instead of having a unused return value bool
      the return value could be an unsigned char.
---
 drivers/staging/vt6655/baseband.c    |  6 +++---
 drivers/staging/vt6655/card.c        |  2 +-
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/mac.h         | 24 +++++++++---------------
 drivers/staging/vt6655/srom.c        |  6 +++---
 drivers/staging/vt6655/upc.h         |  3 ---
 6 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index dfdb0ebf43b5..decb55e96f02 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1916,13 +1916,13 @@ bool bb_read_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGR);
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
-		VNSvInPortB(iobase + MAC_REG_BBREGCTL, &by_value);
+		by_value = ioread8(iobase + MAC_REG_BBREGCTL);
 		if (by_value & BBREGCTL_DONE)
 			break;
 	}
 
 	/* get BB data */
-	VNSvInPortB(iobase + MAC_REG_BBREGDATA, pby_data);
+	*pby_data = ioread8(iobase + MAC_REG_BBREGDATA);
 
 	if (ww == W_MAX_TIMEOUT) {
 		pr_debug(" DBG_PORT80(0x30)\n");
@@ -1961,7 +1961,7 @@ bool bb_write_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGW);
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
-		VNSvInPortB(iobase + MAC_REG_BBREGCTL, &by_value);
+		by_value = ioread8(iobase + MAC_REG_BBREGCTL);
 		if (by_value & BBREGCTL_DONE)
 			break;
 	}
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 1110366fc415..1ccf08b1fd5c 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -748,7 +748,7 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
 
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
-		VNSvInPortB(iobase + MAC_REG_TFTCTL, &data);
+		data = ioread8(iobase + MAC_REG_TFTCTL);
 		if (!(data & TFTCTL_TSFCNTRRD))
 			break;
 	}
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 8b6efe2126ac..08b955c71b3c 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -219,7 +219,7 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvInitialize(priv);
 
 	/* Get Local ID */
-	VNSvInPortB(priv->port_offset + MAC_REG_LOCALID, &priv->local_id);
+	priv->local_id = ioread8(priv->port_offset + MAC_REG_LOCALID);
 
 	spin_lock_irqsave(&priv->lock, flags);
 
@@ -377,7 +377,7 @@ static void device_init_registers(struct vnt_private *priv)
 
 	if (priv->byRadioCtl & EEP_RADIOCTL_ENABLE) {
 		/* Get GPIO */
-		VNSvInPortB(priv->port_offset + MAC_REG_GPIOCTL1, &priv->byGPIO);
+		priv->byGPIO = ioread8(priv->port_offset + MAC_REG_GPIOCTL1);
 
 		if (((priv->byGPIO & GPIO0_DATA) &&
 		     !(priv->byRadioCtl & EEP_RADIOCTL_INV)) ||
@@ -1513,7 +1513,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 
 	*total_flags &= FIF_ALLMULTI | FIF_OTHER_BSS | FIF_BCN_PRBRESP_PROMISC;
 
-	VNSvInPortB(priv->port_offset + MAC_REG_RCR, &rx_mode);
+	rx_mode = ioread8(priv->port_offset + MAC_REG_RCR);
 
 	dev_dbg(&priv->pcid->dev, "rx mode in = %x\n", rx_mode);
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index a5ce084f6961..4d8496024abf 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -541,7 +541,7 @@
 #define MACvRegBitsOn(iobase, byRegOfs, byBits)			\
 do {									\
 	unsigned char byData;						\
-	VNSvInPortB(iobase + byRegOfs, &byData);			\
+	byData = ioread8(iobase + byRegOfs);				\
 	VNSvOutPortB(iobase + byRegOfs, byData | (byBits));		\
 } while (0)
 
@@ -555,7 +555,7 @@ do {									\
 #define MACvRegBitsOff(iobase, byRegOfs, byBits)			\
 do {									\
 	unsigned char byData;						\
-	VNSvInPortB(iobase + byRegOfs, &byData);			\
+	byData = ioread8(iobase + byRegOfs);				\
 	VNSvOutPortB(iobase + byRegOfs, byData & ~(byBits));		\
 } while (0)
 
@@ -597,18 +597,12 @@ do {								\
 #define MACvReadEtherAddress(iobase, pbyEtherAddr)		\
 do {								\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
-	VNSvInPortB(iobase + MAC_REG_PAR0,			\
-		    (unsigned char *)pbyEtherAddr);		\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 1,		\
-		    pbyEtherAddr + 1);				\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 2,		\
-		    pbyEtherAddr + 2);				\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 3,		\
-		    pbyEtherAddr + 3);				\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 4,		\
-		    pbyEtherAddr + 4);				\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 5,		\
-		    pbyEtherAddr + 5);				\
+	pbyEtherAddr[0] = ioread8(iobase + MAC_REG_PAR0);	\
+	pbyEtherAddr[1] = ioread8(iobase + MAC_REG_PAR0 + 1);	\
+	pbyEtherAddr[2] = ioread8(iobase + MAC_REG_PAR0 + 2);	\
+	pbyEtherAddr[3] = ioread8(iobase + MAC_REG_PAR0 + 3);	\
+	pbyEtherAddr[4] = ioread8(iobase + MAC_REG_PAR0 + 4);	\
+	pbyEtherAddr[5] = ioread8(iobase + MAC_REG_PAR0 + 5);	\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
 } while (0)
 
@@ -668,7 +662,7 @@ do {									\
 #define MACvClearStckDS(iobase)					\
 do {									\
 	unsigned char byOrgValue;					\
-	VNSvInPortB(iobase + MAC_REG_STICKHW, &byOrgValue);		\
+	byOrgValue = ioread8(iobase + MAC_REG_STICKHW);			\
 	byOrgValue = byOrgValue & 0xFC;					\
 	VNSvOutPortB(iobase + MAC_REG_STICKHW, byOrgValue);		\
 } while (0)
diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 63f62b0e2db8..84ec9eb8cdd3 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -66,7 +66,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 	unsigned char byOrg;
 
 	byData = 0xFF;
-	VNSvInPortB(iobase + MAC_REG_I2MCFG, &byOrg);
+	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
 	/* turn off hardware retry for getting NACK */
 	VNSvOutPortB(iobase + MAC_REG_I2MCFG, (byOrg & (~I2MCFG_NORETRY)));
 	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
@@ -77,7 +77,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 		VNSvOutPortB(iobase + MAC_REG_I2MCSR, I2MCSR_EEMR);
 		/* wait DONE be set */
 		for (wDelay = 0; wDelay < W_MAX_TIMEOUT; wDelay++) {
-			VNSvInPortB(iobase + MAC_REG_I2MCSR, &byWait);
+			byWait = ioread8(iobase + MAC_REG_I2MCSR);
 			if (byWait & (I2MCSR_DONE | I2MCSR_NACK))
 				break;
 			udelay(CB_DELAY_LOOP_WAIT);
@@ -87,7 +87,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 			break;
 		}
 	}
-	VNSvInPortB(iobase + MAC_REG_I2MDIPT, &byData);
+	byData = ioread8(iobase + MAC_REG_I2MDIPT);
 	VNSvOutPortB(iobase + MAC_REG_I2MCFG, byOrg);
 	return byData;
 }
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 6bc2be0bf4f0..d2c1528c8e1b 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,9 +20,6 @@
 
 /* For memory mapped IO */
 
-#define VNSvInPortB(dwIOAddress, pbyData) \
-	(*(pbyData) = ioread8(dwIOAddress))
-
 #define VNSvInPortW(dwIOAddress, pwData) \
 	(*(pwData) = ioread16(dwIOAddress))
 
-- 
2.25.1

