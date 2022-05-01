Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF2516551
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349517AbiEAQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349465AbiEAQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:40:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B135A9F
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 09:37:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq17so23964261ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RuBggiuD5oIMX1zxUHB2r8PYsvHVOiwUMLDRoSntVGA=;
        b=kEI4bMTv9yBKbNra1uMzo8dPs26j5U7OZkrKy4pi5nBl+dDf/bBHWkKuPAlx68vh0x
         4abWCI2OsVKX3c4rVZEtOX5tgeGimNRw+VtmvrNGbGiOei2tTQGURQsJ5fLAkGrSf0ar
         QxUFxpTdv6vpjgNBVUKqbZl0sLln1L1BLAL4994l5gfQ9Czv9gfJ4s12xvYI7b0iZvNg
         zel3iWURE5d7h2ApEb3LvlCOYc3rCzGIjs0D0m1j2JpZRhVq4a7Oxe0HOwukPQ3Fx3Fy
         7DPEW8e++Iis662etdXQU7LOC/LXUV2tCf+Xujh/+cZUWXfmhWn//EkbGF7v8cqz/YRd
         cG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RuBggiuD5oIMX1zxUHB2r8PYsvHVOiwUMLDRoSntVGA=;
        b=xpkua7CxzZK6w/Ns3KcOQ+z+4TJIXVj6EnvD7UmEFd8mJJnz25AKJfouaoI7Vw8SxD
         LuGTvBVfgEChd19e041ykrUi8wlCltCeVCzrtua9hLnE9JDLGvcV74sdyBKEIQqJYZVL
         13CWeFiZLKOJJeh3HDJW7HFHaozNIjz2JJqCSt3UDEJAZeyJlJpJEs50DYk4QBJv4sBB
         YKiTdAzqWY3L3yvZuhuhoAVHaVIljjgYyf2a8O8xY1lXNlQ6T+pkXrcgFyF400St08bo
         CoWKUWyKpcd56+A58b1HUqX5RjChMB1rQ5eOjtHCt5frJkLlFOo/q30wlhogfDR/kxul
         aFxg==
X-Gm-Message-State: AOAM5319TsFEjIdbfpE+4b6YC41HdbMeW1oFz8RkTJ2ho/hy2TGQ6buH
        RDxYml8lyuRq5MuALlZz6V8=
X-Google-Smtp-Source: ABdhPJzVlsS7kY0LqUKGbcm93QmGrQldwvfk0YwnoGZ2O5Eine7HMN1rCeztlBv/5f8VvkG+ihQLnA==
X-Received: by 2002:a17:906:3042:b0:6cd:20ed:7c5c with SMTP id d2-20020a170906304200b006cd20ed7c5cmr7934254ejd.241.1651423033482;
        Sun, 01 May 2022 09:37:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id p14-20020a056402154e00b0042617ba63a8sm5482223edx.50.2022.05.01.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 09:37:13 -0700 (PDT)
Date:   Sun, 1 May 2022 18:37:11 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: vt6655: Replace unused return value of
 card_get_current_tsf
Message-ID: <2533d7e6b64660e0c23e495a56737fc35b2f916b.1651422181.git.philipp.g.hortmann@gmail.com>
References: <cover.1651422181.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651422181.git.philipp.g.hortmann@gmail.com>
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
Diffs for testing:
        u64 qwNextTBTT;

        qwNextTBTT = card_get_current_tsf(priv); /* Get Local TSF counter */
+       dev_info(&priv->pcid->dev, "CARDbSetBeaconPeriod 0x%016llx", qwNextTBTT);
        qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);

        /* set HW beacon interval */
@@ -810,7 +810,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
        u64 qwNextTBTT;

        qwNextTBTT = card_get_current_tsf(priv); /* Get Local TSF counter */
+       dev_info(&priv->pcid->dev, "CARDvSetFirstNextTBTT 0x%016llx", qwNextTBTT);
        qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
        /* Set NextTBTT */
        VNSvOutPortD(iobase + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
Log:
vt6655 0000:01:05.0: CARDbSetBeaconPeriod  0x00 00 00 01 4a 89 52 c4
vt6655 0000:01:05.0: CARDvSetFirstNextTBTT 0x00 00 00 01 4a 89 52 dc
---
 drivers/staging/vt6655/card.c        | 20 +++++++++-----------
 drivers/staging/vt6655/card.h        |  2 +-
 drivers/staging/vt6655/device_main.c |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index d1dfd96e13b7..50d70ebff83a 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -288,7 +288,7 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 	u64 local_tsf;
 	u64 qwTSFOffset = 0;
 
-	card_get_current_tsf(priv, &local_tsf);
+	local_tsf = card_get_current_tsf(priv);
 
 	if (qwBSSTimestamp != local_tsf) {
 		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
@@ -320,9 +320,9 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 			  unsigned short wBeaconInterval)
 {
-	u64 qwNextTBTT = 0;
+	u64 qwNextTBTT;
 
-	card_get_current_tsf(priv, &qwNextTBTT); /* Get Local TSF counter */
+	qwNextTBTT = card_get_current_tsf(priv); /* Get Local TSF counter */
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 
@@ -739,7 +739,7 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2)
  *
  * Return Value: true if success; otherwise false
  */
-bool card_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF)
+u64 card_get_current_tsf(struct vnt_private *priv)
 {
 	void __iomem *iobase = priv->port_offset;
 	unsigned short ww;
@@ -753,16 +753,14 @@ bool card_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF)
 			break;
 	}
 	if (ww == W_MAX_TIMEOUT)
-		return false;
+		return 0;
 	low = ioread32(iobase + MAC_REG_TSFCNTR);
 	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
 #ifdef __BIG_ENDIAN
-	*pqwCurrTSF = high + ((u64)low << 32);
+	return high + ((u64)low << 32);
 #else
-	*pqwCurrTSF = low + ((u64)high << 32);
+	return low + ((u64)high << 32);
 #endif
-
-	return true;
 }
 
 /*
@@ -809,9 +807,9 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 			   unsigned short wBeaconInterval)
 {
 	void __iomem *iobase = priv->port_offset;
-	u64 qwNextTBTT = 0;
+	u64 qwNextTBTT;
 
-	card_get_current_tsf(priv, &qwNextTBTT); /* Get Local TSF counter */
+	qwNextTBTT = card_get_current_tsf(priv); /* Get Local TSF counter */
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 	/* Set NextTBTT */
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 55fe039065db..7830a055b855 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -46,7 +46,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 			   unsigned short wBeaconInterval);
 void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short wBeaconInterval);
-bool card_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF);
+u64 card_get_current_tsf(struct vnt_private *priv);
 u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval);
 u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2);
 unsigned char CARDbyGetPktType(struct vnt_private *priv);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 393430757700..6989d8d04f2f 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1603,7 +1603,7 @@ static u64 vnt_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct vnt_private *priv = hw->priv;
 	u64 tsf;
 
-	card_get_current_tsf(priv, &tsf);
+	tsf = card_get_current_tsf(priv);
 
 	return tsf;
 }
-- 
2.25.1

