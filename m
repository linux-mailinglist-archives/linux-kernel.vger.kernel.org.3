Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800464F5AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580385AbiDFJiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573196AbiDFJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:34:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C51311CF78
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:19:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c42so1370058edf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DNgNlT+7YKaOvPCk/gmrkhMCJ6Py+Nbw2htQid6V97Q=;
        b=QI2Gdu2tXG9iYVqWPzCMp1nFFt1kzrAaSBQuv9xvmpATMAJLTsBrtdPzpcaZRi4sDy
         FhMfnNLYuW5IkKSx51AChbtQAalwUhqgSnwgVlISmyHu6faduh16hRIU7A0UJ0tbHsro
         0vIp7nwQp4HVtcLgtPN5gDxvzMPekkyJ2Y1kDGnZx5G3p95WOh3eY30TB5rsDmF8LwlF
         H4ygxdCVvNu5YGRqEhr32PAqOQifrlmH1QRXuTdLrVSgrAqbkPHBttVAR0m8ACd4xisg
         +SEYm9pP0u3EB6gmePfm2+dk1ibjoSjvfKte05UBXrMx3yh8mt9P2KudKpsMuCjxIv3p
         T+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DNgNlT+7YKaOvPCk/gmrkhMCJ6Py+Nbw2htQid6V97Q=;
        b=rs1OHpWTM+P6jmRGFPU52bzI/73DHyzIK3JgATizNWPWQ+wwfysaG77ol8XxMvUF5e
         IIHK+lajCNj9O+30GN+jF92Q8fX6WEzxwqQcfgAbeVgpFCj614sTFSYQJmSplDfpBkcA
         7a/eYQAZ48X0GJe1WdI4UKWbECXzuQDH3yP2H/fqC6tMXInIfTmXObDrwxR6RpZAjl9O
         nwXItm3wIfYNm61DRWQk/6JWVd+g9EbHU7zhdJ1ueCOsj+pzumJe41P0ULaVJjkrlFtU
         jnzg2KgKiklfotTH6nuWPYYtWnGGlfpUgBaGxvJ5V+s8MJJwmETQLYhTsLjyZZaR1ny1
         F37w==
X-Gm-Message-State: AOAM53065DxsJ7Ua5AqtZ3OJwIVbdSbmEzsVYG7NAMUJ8DwmPbss+PWx
        8CR8m0pzDE5oyYIq4A8ub4RT5341n84=
X-Google-Smtp-Source: ABdhPJyuoF4rDcD4UnydR4O5S6Id89eWt1TrCaA9wMFZX4ynMeTR8soUNMakwXSKjQS4TU2NrkiFHA==
X-Received: by 2002:a05:6402:d0e:b0:418:f011:275e with SMTP id eb14-20020a0564020d0e00b00418f011275emr7045959edb.323.1649225954273;
        Tue, 05 Apr 2022 23:19:14 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id q3-20020a50da83000000b0041cdd6e92b1sm2475251edj.27.2022.04.05.23.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 23:19:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: use round_up() instead of _RND8()
Date:   Wed,  6 Apr 2022 08:18:57 +0200
Message-Id: <20220406061859.9011-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406061859.9011-1-straube.linux@gmail.com>
References: <20220406061859.9011-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use in-kernel round_up() instead of custom _RND8().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 6 +++---
 drivers/staging/r8188eu/include/osdep_service.h | 8 --------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 87095eff107b..e00791efccc8 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -437,7 +437,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
 	pfirstframe = pxmitframe;
 	len = xmitframe_need_length(pfirstframe) + TXDESC_SIZE + (pfirstframe->pkt_offset * PACKET_OFFSET_SZ);
 	pbuf_tail = len;
-	pbuf = _RND8(pbuf_tail);
+	pbuf = round_up(pbuf_tail, 8);
 
 	/*  check pkt amount in one bulk */
 	desc_cnt = 0;
@@ -488,7 +488,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
 
 		len = xmitframe_need_length(pxmitframe) + TXDESC_SIZE + (pxmitframe->pkt_offset * PACKET_OFFSET_SZ);
 
-		if (_RND8(pbuf + len) > MAX_XMITBUF_SZ) {
+		if (round_up(pbuf + len, 8) > MAX_XMITBUF_SZ) {
 			pxmitframe->agg_num = 1;
 			pxmitframe->pkt_offset = 1;
 			break;
@@ -511,7 +511,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
 
 		/*  handle pointer and stop condition */
 		pbuf_tail = pbuf + len;
-		pbuf = _RND8(pbuf_tail);
+		pbuf = round_up(pbuf_tail, 8);
 
 		pfirstframe->agg_num++;
 		if (MAX_TX_AGG_PACKET_NUMBER == pfirstframe->agg_num)
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 388c22751d09..ff44c4a37b9d 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -96,14 +96,6 @@ static inline void flush_signals_thread(void)
 
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
 
-static inline u32 _RND8(u32 sz)
-{
-	u32	val;
-
-	val = ((sz >> 3) + ((sz & 7) ? 1: 0)) << 3;
-	return val;
-}
-
 static inline u32 _RND128(u32 sz)
 {
 	u32	val;
-- 
2.35.1

