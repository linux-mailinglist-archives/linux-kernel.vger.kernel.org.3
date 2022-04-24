Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E37B50D04B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiDXHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 03:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiDXHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 03:47:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E3F17E21B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:44:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x18so16726834wrc.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=au6OP3T7ZHPNQ6sb5Bz2kPDT8OBTWIe8DZ+Sd+EF8Zg=;
        b=RpXgfDr75l0KG5N7VzfongQHJpB2IOknQOb7Uj5LjF0aia36fEVDu+v9Jag41s+g77
         oe0yfTOeflvymZv1qtSL1aDmZK0BqIJhUxtq2erwMDF3ocW2+R+M96yF2qOJPhkj2Wjx
         to05ZLcJjnsLYwPQrBAeD9j0p3LlBUAp/oZdGyXPLDt5RMEPQ46blHYhbhTFUcbPQ94P
         s4drH8NtY/Ap49j++1I0qeqf72RvB2GvMCaNTWjBG/27swKdQ2g3PlaOu8GwV0G1TdWC
         /r2JQWje+e2QO+IY9qGu4uLmtTeX+qy8LSCRiAKSbhyZdvnHi3HeX5TcWekyYIOHL8DY
         OFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=au6OP3T7ZHPNQ6sb5Bz2kPDT8OBTWIe8DZ+Sd+EF8Zg=;
        b=B/Gz9a2WKKLiHu8J31qLC4qmEo540Ni1qYNnq2vbZr0ETZhi1niX3zD6tkh+aZtOqp
         ynmSuDG/st0N9j7CHHbMQWyARsVuSDA4NkSBTCgmEDNrCGM/3cb9gRhzgF/iudG5wwyW
         9PyhQCC3UdCI2UErTLRMTsTIBL3U/CNHw0/CDrk63qhdpeEwB9yPGGDaxWKomvW8Ov0X
         JVjhqvLojF1dT8aVB70/4Gc9TVBl7yZQe3vpIBcrWGxk4ONc8q0/i4hkr7cww3mzG2uy
         NFrLlZr/k0OJPbgjdTicJ6Fp2l/ccPegXQcMTk2Znak2mVO5caqXQxnRo/e45DLNFjwW
         +OJw==
X-Gm-Message-State: AOAM532w1cAxhsqg0ErciDsF2+iSyehz0Hxp5Z9ophzW08bFMSbzNd7z
        JEWOx735XFfZcxmP2hfd7iA=
X-Google-Smtp-Source: ABdhPJzcP+psa1Rt93JzRrM3x/qcATxeuWZMvRVKksGiGP90W5+5brCHpdpm4HEOy7uYutCjVf1kSA==
X-Received: by 2002:a05:6000:18a8:b0:20a:8a58:1639 with SMTP id b8-20020a05600018a800b0020a8a581639mr9781511wri.483.1650786271519;
        Sun, 24 Apr 2022 00:44:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id o38-20020a05600c512600b00393ead99c5bsm490109wms.26.2022.04.24.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 00:44:31 -0700 (PDT)
Date:   Sun, 24 Apr 2022 09:44:28 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: vt6655: Replace VNSvInPortD with ioread32
Message-ID: <e02a0d78937204b41eec48d31eb4908c4bc8cac8.1650784817.git.philipp.g.hortmann@gmail.com>
References: <cover.1650784817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650784817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvInPortD with ioread32.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: This patch was 5/7 and is now 4/6
V2 -> V3: Inserted patch that was before in a different way in
          "Rename macros VNSvInPortB,W,D with CamelCase ..."
          This patch was part of 4/6 and is now 3/7
V3 -> V4: Removed casting of the output variable
---
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/mac.h         | 18 +++++++++---------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 4 files changed, 13 insertions(+), 16 deletions(-)

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

