Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F955515AE2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382238AbiD3Gwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382208AbiD3Gwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:52:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F539680F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:49:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so19030928ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Otnno+xDsAMvzAiAgtx96JNqSXheolAMTKkyal93G9I=;
        b=L/Lx1j0T80IPNbQqPyxWbrD38q6mtFslm4CiPqvQC1SruopR5B8sgVjhD4qd6pPDIa
         mYcKibRQcf651PdKzUzqBL/P/Iqqrz0nAjMVlLT6AB+c2QmMhzs2e/bizCGr0x/0IA8t
         3Nq61C6av9DMHG0oggx/1dvaXIONDhYgAlyexzLGt2E3TWCBe1E/+rLg0NDLF7hqRzaK
         3YzO2sBCLTfXE3dIaQ2163V70Oab+Iz9BHwhhqq6oxiHrKxna3oZeqvg5HeEV3oTSMMa
         pcpStJay+YhRS7632xd9ySuV1k05gXHSXXWOAXOlV6rN2LHQAZg1JNWUrDnIygFzuwvM
         qAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Otnno+xDsAMvzAiAgtx96JNqSXheolAMTKkyal93G9I=;
        b=3Q/l4kJDHaHdTwUtu/WNEbOEWUupO9PWqcCBRRL/7zHxgdjHJ2HACKkdgaatMiHyR+
         e8cd/v0NxsAcFQ1JXnz+XRkqjqrNNknQz35bR6yXaFH4dA3MC4VFbAkGXPaj2aJ7l6Cz
         B/iBGL4vAjT42+FIQKoj61CIqOdfjWSL7klDbEsAzTdwSwlwSyu2WL9mheX6dCz3ffIn
         REtETK2bZcErGldjzAo1I+OMOYwRRE+6HkkVlGAMX9suo0IQt8rOvjlJN+F2cMK8HTO8
         fnobhH4IaOsFj9d0CzAVO90lZaZOJuniIr77h18BhvP3oAYBSyZpRQik9jrooenHeigG
         9zqg==
X-Gm-Message-State: AOAM531i9n459ZvL3oR3D2Rw3rTGbWzLUnTuvUvL7CxPZhiRPf/3G2/m
        ntAued9qeOQNwQtdgVdVs9c=
X-Google-Smtp-Source: ABdhPJwhCbAC9gFuk+9L8mXatzGlzu0XTHeq2BPhEsl6iGYzQHTt84u25M2UzqQQ3ULfvoAdRHGtIg==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr2677603ejc.81.1651301364802;
        Fri, 29 Apr 2022 23:49:24 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id hy26-20020a1709068a7a00b006f3ef214dbasm1323597ejc.32.2022.04.29.23.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 23:49:24 -0700 (PDT)
Date:   Sat, 30 Apr 2022 08:49:22 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v4 1/2] staging: vt6655: Replace VNSvInPortD with ioread32
Message-ID: <5c544bcc9bcc9d7a9c7449baec78fe509e29c8d2.1651300094.git.philipp.g.hortmann@gmail.com>
References: <cover.1651300094.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651300094.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

