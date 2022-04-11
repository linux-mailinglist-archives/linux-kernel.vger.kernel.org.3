Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106EB4FC622
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349948AbiDKUvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiDKUvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:51:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5B13F12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bh17so33310167ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dWNuoN45sTUkZkT5Ou1BRhQysWHb8DTjQZwdAQKOIe8=;
        b=UXsbplgyyWQgfElwHXtIoOaGmf0A25proLl02YtSj19BiJzN/XpseXCi04U75Lwwtj
         uXK5uSbc4TkHFxFF3M9N3AC9TQQ7Vcqof5DbKF6oyw8bT+MiCiB+vMZbh31nWodi5eFc
         8HYVWs0lhijSng4IjdguEnqdwkOd/u2mB0cz17eT3JbosupyGvWNzfI2iQPJlcCXMVbC
         L+8nqcQ+zXW1YqAJbcKD+0dR4cf3LF7lqPOSZAT3AOcRyhdrEVK6wwmeHLRRQY4bYTiw
         gVSSCeYHNuspLbFOJm2e9MR9kmzEZdo69bY4q+ICW4BE+mRHYlcCSckSZ5Ay0m3cNKwm
         9wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dWNuoN45sTUkZkT5Ou1BRhQysWHb8DTjQZwdAQKOIe8=;
        b=4ww7/1Ls2FQWaZFo4o6pXI5rg8Ugl2gQ3oNnHxPPkGamKiwmHWo3QgXzShNDXFgRr/
         eDsmgMlx+KPKTcISxnco7HXEp7FhsKOehD9kDHotYlcxBZGaV97mZsGSXP+uFaIf7QnO
         LuT+ZAHbvrms6g3xMgqa0jHd+4K070Y7mFl27XBfaR9Kk+WAEzYhp0fIOJ7laW4Guajq
         LJ3xxjvEXsPlOu5YOAZMD1oBsw1cw+0s7NNSvrhl+Nm04o8GsjqwNVw9kAiw7xmaatZi
         ouvMVyitpMLKdzPx76irDki/pd+WFx3b3o11P9egvpL09YxozGHCdpkatmUhflegn7Eu
         I/MA==
X-Gm-Message-State: AOAM533le3Przps9PzvadcjwRi8syKUcwaW/MI7pmCa4nmHbwSDHMSGj
        dn4tD4RvuK/l2/1pWLNXv3k=
X-Google-Smtp-Source: ABdhPJx6OeiftYzAEkZf0Qv3k/sEKVHPwn5HgYMlHpKkBbPqeq8L+BacW9FqbcXO9dFNEd6HZsNptQ==
X-Received: by 2002:a17:907:96a9:b0:6e0:db4a:ba8d with SMTP id hd41-20020a17090796a900b006e0db4aba8dmr32664707ejc.87.1649710162712;
        Mon, 11 Apr 2022 13:49:22 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id d1-20020a50fe81000000b004197f2ecdc2sm15568391edt.89.2022.04.11.13.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:49:22 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:49:20 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] staging: vt6655: Replace VNSvInPortB with ioread8
Message-ID: <2f1392d831d005709c859aedf75de7e7ca2269cf.1649706687.git.philipp.g.hortmann@gmail.com>
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

Replace macro VNSvInPortB with ioread8.
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
---
 drivers/staging/vt6655/baseband.c    |  6 +++---
 drivers/staging/vt6655/card.c        |  2 +-
 drivers/staging/vt6655/device_main.c |  4 ++--
 drivers/staging/vt6655/mac.h         | 26 ++++++++++----------------
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
index 897d70cf32b8..16b031c31925 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -219,7 +219,7 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvInitialize(priv);
 
 	/* Get Local ID */
-	VNSvInPortB(priv->port_offset + MAC_REG_LOCALID, &priv->local_id);
+	priv->local_id = ioread8(priv->port_offset + MAC_REG_LOCALID);
 
 	spin_lock_irqsave(&priv->lock, flags);
 
@@ -1513,7 +1513,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 
 	*total_flags &= FIF_ALLMULTI | FIF_OTHER_BSS | FIF_BCN_PRBRESP_PROMISC;
 
-	VNSvInPortB(priv->port_offset + MAC_REG_RCR, &rx_mode);
+	rx_mode = ioread8(priv->port_offset + MAC_REG_RCR);
 
 	dev_dbg(&priv->pcid->dev, "rx mode in = %x\n", rx_mode);
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 6221351c6400..88bf5dba9b43 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -541,7 +541,7 @@
 #define MACvRegBitsOn(iobase, byRegOfs, byBits)			\
 do {									\
 	unsigned char byData;						\
-	VNSvInPortB(iobase + byRegOfs, &byData);			\
+	byData = ioread8(iobase + byRegOfs);			\
 	VNSvOutPortB(iobase + byRegOfs, byData | (byBits));		\
 } while (0)
 
@@ -555,7 +555,7 @@ do {									\
 #define MACvRegBitsOff(iobase, byRegOfs, byBits)			\
 do {									\
 	unsigned char byData;						\
-	VNSvInPortB(iobase + byRegOfs, &byData);			\
+	byData = ioread8(iobase + byRegOfs);			\
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
+	(*((unsigned char *)pbyEtherAddr) = ioread8(iobase + MAC_REG_PAR0));		\
+	(*(pbyEtherAddr + 1) = ioread8(iobase + MAC_REG_PAR0 + 1));	\
+	(*(pbyEtherAddr + 2) = ioread8(iobase + MAC_REG_PAR0 + 2));	\
+	(*(pbyEtherAddr + 3) = ioread8(iobase + MAC_REG_PAR0 + 3));	\
+	(*(pbyEtherAddr + 4) = ioread8(iobase + MAC_REG_PAR0 + 4));	\
+	(*(pbyEtherAddr + 5) = ioread8(iobase + MAC_REG_PAR0 + 5));	\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
 } while (0)
 
@@ -668,7 +662,7 @@ do {									\
 #define MACvClearStckDS(iobase)					\
 do {									\
 	unsigned char byOrgValue;					\
-	VNSvInPortB(iobase + MAC_REG_STICKHW, &byOrgValue);		\
+	byOrgValue = ioread8(iobase + MAC_REG_STICKHW);		\
 	byOrgValue = byOrgValue & 0xFC;					\
 	VNSvOutPortB(iobase + MAC_REG_STICKHW, byOrgValue);		\
 } while (0)
@@ -736,7 +730,7 @@ do {									\
 } while (0)
 
 #define MACvGPIOIn(iobase, pbyValue)					\
-	VNSvInPortB(iobase + MAC_REG_GPIOCTL1, pbyValue)
+	*(pbyValue) = ioread8(iobase + MAC_REG_GPIOCTL1)
 
 #define MACvSetRFLE_LatchBase(iobase)                                 \
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT)
diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 5cdbc24e8c45..a0432bacb6a0 100644
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
 			PCAvDelayByIO(CB_DELAY_LOOP_WAIT);
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
index b374db5fca81..44d746de6344 100644
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

