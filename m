Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDB65167C2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354725AbiEAU3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 16:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354449AbiEAU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 16:29:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4DF3DDEE
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 13:25:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so24503230ejj.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BIvoiMNV2suMEQS65MP5bpJiVeZk0XLREaqe1qAhSxU=;
        b=gyzFpCRv/U6BNSYqzAmCRmCXWJU6HqVl/ku7gQ61xyhMJsArJx68IDOG31jkezrlos
         1R/jwbqbLWMw7I6d75FW1q5rcXnDuQso+Ei3JisvY3j7Wslf/xLHy4wGSFsP9cNMxLTK
         oPSz030zyXEmhcDe3m4MOM2yqTQPXpcQVPyRwfvPZYz8g9dOg3+1zLHCr3pQITztg5cZ
         qG77J0GKonbJWBTxi7vJ+MUqLjG114PwsYF5ZumdP83N73xnkPI6/AO7SWUg5I+UPgx3
         MyOZx14ori+Si0YY4+j1jNUTOBeeHJ8RByp7TNVeO/27XYHSi5gWyh12npjf+aGgdyHE
         Zl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BIvoiMNV2suMEQS65MP5bpJiVeZk0XLREaqe1qAhSxU=;
        b=BGSHT35ZLSNClWOZ0D75bVj7VITHAm6R7Mm11ba+IRX7O/XOf3la4UrG3mS3so+JJY
         kuzIfY+RCYm6V6uw2ORjGXQiKvP05tPPY6zvHqtdXYFLx/ARXMRgTUDUxjt3GLKFfNOn
         F8e1VlHsn6HmIxbM2iUgCJXTyqJ6w2FgzuhSHrdIB9B8iJ7Sv7ILiFZtb9xO16dDmUnl
         0RRMP+RRJY9vEWLT385pZcwJmF4AbQ+Ux3VZNLxd03uMT5NCGZxMAPJ51G5ygJO1i1VO
         0UMRhY9u2Uh3WEd3K8hvHdLOSn0cMKlVjx2QXcm8mgvOJY9gRsid6S/Xl99OHus6oh1B
         2/2A==
X-Gm-Message-State: AOAM5306XOuacI3magZbBIrIJpMUuNGZdtgVgHz0lipyjYqoT8zh1xL4
        UF3i9qmVNl5yL0XoPs4nGA0=
X-Google-Smtp-Source: ABdhPJwQ4YAhxPfsb4bkGuMLmzKYYXZmbLqsnhQuJiuw1zmdbo5kMZZSOTBa/RxC1eR570ihEAwpHA==
X-Received: by 2002:a17:906:5d08:b0:6da:b4ea:937 with SMTP id g8-20020a1709065d0800b006dab4ea0937mr8849505ejt.446.1651436743984;
        Sun, 01 May 2022 13:25:43 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id gx10-20020a1709068a4a00b006f3ef214e6bsm2829254ejc.209.2022.05.01.13.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 13:25:43 -0700 (PDT)
Date:   Sun, 1 May 2022 22:25:41 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging vt6655: Replace unused return value of
 vt6655_get_current_tsf
Message-ID: <62c83d78627196ec0ce2f5a562cb080a1c87a05a.1651435890.git.philipp.g.hortmann@gmail.com>
References: <cover.1651435890.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651435890.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unused return value with u64 to increase readability,
reduce address and dereference operators and omit pqwCurrTSF that
uses CamelCase which is not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Updated this patch from changes of previous ones
          Updated below test

Code for testing:
void CARDvSetFirstNextTBTT(struct vnt_private *priv,
			   unsigned short wBeaconInterval)
	...
	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
	dev_info(&priv->pcid->dev, "CARDvSetFirstNextTBTT 0x%016llx", qwNextTBTT);

bool CARDbSetBeaconPeriod(struct vnt_private *priv,
			  unsigned short wBeaconInterval)
	...
	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
	dev_info(&priv->pcid->dev, "CARDbSetBeaconPeriod  0x%016llx", qwNextTBTT);

Log of the microsecond counter:
vt6655 0000:01:05.0: CARDbSetBeaconPeriod  0x00 00 00 04 65 9f 75 d8
vt6655 0000:01:05.0: CARDvSetFirstNextTBTT 0x00 00 00 04 65 9f 75 e4
---
 drivers/staging/vt6655/card.c        | 18 ++++++++----------
 drivers/staging/vt6655/card.h        |  2 +-
 drivers/staging/vt6655/device_main.c |  2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index c8372701bf43..d3c47b37ad3b 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -288,7 +288,7 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 	u64 local_tsf;
 	u64 qwTSFOffset = 0;
 
-	vt6655_get_current_tsf(priv, &local_tsf);
+	local_tsf = vt6655_get_current_tsf(priv);
 
 	if (qwBSSTimestamp != local_tsf) {
 		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
@@ -320,9 +320,9 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 			  unsigned short wBeaconInterval)
 {
-	u64 qwNextTBTT = 0;
+	u64 qwNextTBTT;
 
-	vt6655_get_current_tsf(priv, &qwNextTBTT); /* Get Local TSF counter */
+	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 
@@ -739,7 +739,7 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2)
  *
  * Return Value: true if success; otherwise false
  */
-bool vt6655_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF)
+u64 vt6655_get_current_tsf(struct vnt_private *priv)
 {
 	void __iomem *iobase = priv->port_offset;
 	unsigned short ww;
@@ -753,12 +753,10 @@ bool vt6655_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF)
 			break;
 	}
 	if (ww == W_MAX_TIMEOUT)
-		return false;
+		return 0;
 	low = ioread32(iobase + MAC_REG_TSFCNTR);
 	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
-	*pqwCurrTSF = le64_to_cpu(low + ((u64)high << 32));
-
-	return true;
+	return le64_to_cpu(low + ((u64)high << 32));
 }
 
 /*
@@ -805,9 +803,9 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 			   unsigned short wBeaconInterval)
 {
 	void __iomem *iobase = priv->port_offset;
-	u64 qwNextTBTT = 0;
+	u64 qwNextTBTT;
 
-	vt6655_get_current_tsf(priv, &qwNextTBTT); /* Get Local TSF counter */
+	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 	/* Set NextTBTT */
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 340516b329e3..22dc359a6565 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -46,7 +46,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 			   unsigned short wBeaconInterval);
 void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short wBeaconInterval);
-bool vt6655_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF);
+u64 vt6655_get_current_tsf(struct vnt_private *priv);
 u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval);
 u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2);
 unsigned char CARDbyGetPktType(struct vnt_private *priv);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index bb8a30eefc74..4f26f5c7e84f 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1603,7 +1603,7 @@ static u64 vnt_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct vnt_private *priv = hw->priv;
 	u64 tsf;
 
-	vt6655_get_current_tsf(priv, &tsf);
+	tsf = vt6655_get_current_tsf(priv);
 
 	return tsf;
 }
-- 
2.25.1

