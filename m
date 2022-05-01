Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14D651674E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352146AbiEATQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243750AbiEATPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:15:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CDD3B285
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:12:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kq17so24359968ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K5sAjOjXvlka5n0wtB6ed8J2qZIqF9rJOXwWBP4pWf8=;
        b=I6A4D++r3MlMConrbLk1uVWYkQ4yEbL74nyKsE3s4wrK9npG5wM66Qw8Ei9GJ9Ai6f
         7g1xAkmVKZVCIccpCc5YoSOjakC1L7+ApfffQOZLIvPwFqRYvIYb/UoeRR7ObOC8vitf
         88SqNlW9FqJCFkdX/8K9ujU98O6xckKB7j4l2f0HEw2OkQkZkIHg9PGMhl6IG+CiKhHS
         1hryevwOsjUYlfWz4WFNhCgxkIhWEsmOW+6A8eCFTlssn+e3cU8c37c1RjWjWleoKzYV
         RPlajvj/m8K8qxZ1OXE4ytRj/zHiPw0s0jbG9Wfj5JDYCUMgKKvPiIuZi/1NU+xaA4Y4
         8TFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K5sAjOjXvlka5n0wtB6ed8J2qZIqF9rJOXwWBP4pWf8=;
        b=sUCxMmV+wiXYTnkPjdD1CubKEjDW+q20ljgbaqCJPSC4AZ9g36l8LnHtPBwSQXeI7b
         nfj1ipzuz4CKOjyZqdsRLZCiFOoIsDKOsUR+JS8NJYX80c9Xdhfr/pX2sG96fiL3DQI9
         q7DoHl7w234p9YJv5mZnP3TtaywRBImZxUhxab87y5F2lbTgCUJ/698EReAB73h0Ff5I
         QhzbYso66HOK8czyZKbrrKm4W+SSE7oJJ9NWgRE9sGQbYsSMjyRadIWIkIozbMdAkSEj
         neX0cMrS/3FvZu2Wbe9gH/b5FMu5lyE3V4kzrhxSIXeWxIPImtoSXnmneWch0nrarGKr
         yxEA==
X-Gm-Message-State: AOAM531tz4GNHZ+joID/pM8V2h/Q5AOANw00FTiqO4G26puUrd7HBW9R
        XfNMrSNlAAlq3EDmsv3bQ2btSKtwRuB4Sw==
X-Google-Smtp-Source: ABdhPJweRtvsKp/Pht5YxwI6bOBZCEmCm/G8kKuhjQ0gougFXMhtLhtO5+OUYzwFuauTAfd1Vci0AQ==
X-Received: by 2002:a17:907:da7:b0:6df:9ff4:10c7 with SMTP id go39-20020a1709070da700b006df9ff410c7mr8319382ejc.106.1651432346035;
        Sun, 01 May 2022 12:12:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b006f3ef214e34sm2833130ejc.154.2022.05.01.12.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:12:25 -0700 (PDT)
Date:   Sun, 1 May 2022 21:12:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v5 1/2] staging: vt6655: Replace VNSvInPortD with ioread32
Message-ID: <3945d32053898e5f9771d6f742ae118ca56943ce.1651431640.git.philipp.g.hortmann@gmail.com>
References: <cover.1651431640.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651431640.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvInPortD with ioread32 and as it was
the only user, it can now be removed.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: This patch was 5/7 and is now 4/6
V2 -> V3: Inserted patch that was before in a different way in
          "Rename macros VNSvInPortB,W,D with CamelCase ..."
          This patch was part of 4/6 and is now 3/7
V3 -> V4: Removed casting of the output variable
V4 -> V5: Joint patch "Replace two VNSvInPortD with ioread64_lo_hi"
          with this patch. Changed ioread64 to two ioread32 as
          ioread64 does not work with 32 Bit computers.
          Shorted and simplified patch description.
V5 -> V6: Added missing version in subject
V6 -> V7: Added below testing example
V7 -> V8: No changes

Code for testing:
	u32 high, low;

	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF from VNSvInPortD: 0x%016llx", *pqwCurrTSF);

	low = ioread32(iobase + MAC_REG_TSFCNTR);
	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
	*pqwCurrTSF = low + ((u64)high << 32);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF from ioread32:    0x%016llx", *pqwCurrTSF);

Log from testing:
vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF from VNSvInPortD: 0x0000000d c025dd7c
vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF from ioread32:    0x0000000d c025dd7c
vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF from VNSvInPortD: 0x0000000d c025dd8a
vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF from ioread32:    0x0000000d c025dd8a
---
 drivers/staging/vt6655/card.c        |  6 ++++--
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/mac.h         | 18 +++++++++---------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 5 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 022310af5485..0dd13e475d6b 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -744,6 +744,7 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
 	void __iomem *iobase = priv->port_offset;
 	unsigned short ww;
 	unsigned char data;
+	u32 low, high;
 
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
@@ -753,8 +754,9 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
 	}
 	if (ww == W_MAX_TIMEOUT)
 		return false;
-	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
-	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
+	low = ioread32(iobase + MAC_REG_TSFCNTR);
+	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
+	*pqwCurrTSF = low + ((u64)high << 32);
 
 	return true;
 }
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index c21787f32252..12fd825c23fe 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1029,7 +1029,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	u32 isr;
 	unsigned long flags;
 
-	VNSvInPortD(priv->port_offset + MAC_REG_ISR, &isr);
+	isr = ioread32(priv->port_offset + MAC_REG_ISR);
 
 	if (isr == 0)
 		return;
@@ -1042,7 +1042,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Read low level stats */
-	VNSvInPortD(priv->port_offset + MAC_REG_MIBCNTR, &mib_counter);
+	mib_counter = ioread32(priv->port_offset + MAC_REG_MIBCNTR);
 
 	low_stats->dot11RTSSuccessCount += mib_counter & 0xff;
 	low_stats->dot11RTSFailureCount += (mib_counter >> 8) & 0xff;
@@ -1116,7 +1116,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 		    ieee80211_queue_stopped(priv->hw, 0))
 			ieee80211_wake_queues(priv->hw);
 
-		VNSvInPortD(priv->port_offset + MAC_REG_ISR, &isr);
+		isr = ioread32(priv->port_offset + MAC_REG_ISR);
 
 		MACvReceive0(priv->port_offset);
 		MACvReceive1(priv->port_offset);
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 5aaa0de20e67..5b684194745c 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -618,7 +618,7 @@ do {								\
 #define MACvReceive0(iobase)						\
 do {									\
 	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_RXDMACTL0, &dwData);		\
+	dwData = ioread32(iobase + MAC_REG_RXDMACTL0);			\
 	if (dwData & DMACTL_RUN)					\
 		VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, DMACTL_WAKE); \
 	else								\
@@ -628,7 +628,7 @@ do {									\
 #define MACvReceive1(iobase)						\
 do {									\
 	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_RXDMACTL1, &dwData);		\
+	dwData = ioread32(iobase + MAC_REG_RXDMACTL1);			\
 	if (dwData & DMACTL_RUN)					\
 		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_WAKE); \
 	else								\
@@ -638,7 +638,7 @@ do {									\
 #define MACvTransmit0(iobase)						\
 do {									\
 	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_TXDMACTL0, &dwData);		\
+	dwData = ioread32(iobase + MAC_REG_TXDMACTL0);			\
 	if (dwData & DMACTL_RUN)					\
 		VNSvOutPortD(iobase + MAC_REG_TXDMACTL0, DMACTL_WAKE); \
 	else								\
@@ -648,7 +648,7 @@ do {									\
 #define MACvTransmitAC0(iobase)					\
 do {									\
 	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_AC0DMACTL, &dwData);		\
+	dwData = ioread32(iobase + MAC_REG_AC0DMACTL);			\
 	if (dwData & DMACTL_RUN)					\
 		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_WAKE); \
 	else								\
@@ -684,7 +684,7 @@ do {									\
 #define MACvEnableProtectMD(iobase)					\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue | ENCFG_PROTECTMD;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
@@ -692,7 +692,7 @@ do {									\
 #define MACvDisableProtectMD(iobase)					\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue & ~ENCFG_PROTECTMD;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
@@ -700,7 +700,7 @@ do {									\
 #define MACvEnableBarkerPreambleMd(iobase)				\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue | ENCFG_BARKERPREAM;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
@@ -708,7 +708,7 @@ do {									\
 #define MACvDisableBarkerPreambleMd(iobase)				\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue & ~ENCFG_BARKERPREAM;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
@@ -716,7 +716,7 @@ do {									\
 #define MACvSetBBType(iobase, byTyp)					\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
 	dwOrgValue = dwOrgValue & ~ENCFG_BBTYPE_MASK;			\
 	dwOrgValue = dwOrgValue | (unsigned long)byTyp;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 4498c9d400f2..036f48572334 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -175,7 +175,7 @@ bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData)
 
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
-		VNSvInPortD(iobase + MAC_REG_IFREGCTL, &dwValue);
+		dwValue = ioread32(iobase + MAC_REG_IFREGCTL);
 		if (dwValue & IFREGCTL_DONE)
 			break;
 	}
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 4d09cf18ebe0..a5b74aaadcd3 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,9 +20,6 @@
 
 /* For memory mapped IO */
 
-#define VNSvInPortD(dwIOAddress, pdwData) \
-	(*(pdwData) = ioread32(dwIOAddress))
-
 #define VNSvOutPortB(dwIOAddress, byData) \
 	iowrite8((u8)(byData), dwIOAddress)
 
-- 
2.25.1

