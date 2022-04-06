Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4DE4F6A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiDFTuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiDFTuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:50:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8B528F83B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:22:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q26so3457814edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdJD0sEz6JwadVVPr09JFw5k3V85Yh/6gSBnE158MpY=;
        b=fvdNsxkRy3WWly5FIzP7B0aqEiXB88vpmchkCe+qdiFRcqBjIEW7bEwTJhNBIi+Udp
         x6v2sIHGISgtnSFjsWnbTCI/qq/UIk4LTD4K0Lxoxld2aj5nN09atQQ0TLZlATTXu/l6
         LudZ1GbQSbyyx9VAqVs6gMYlkR+Cr3OnV3/z2OXPlAJ4NYzOqYEQ2cPOGCU+BnEuoSuk
         UuxN/gyz/Atf3qYAos0j9x1Q/LXk1PWrDlPC3FRExAJQE8gj4b+Q3KzejN2C9V4hAA5B
         kq4DwToVP6IJEGVtUFxuz1VbflO0U7At7hll8YHGunlmFrx6kUwg56+8acN0yc3ubqun
         eQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdJD0sEz6JwadVVPr09JFw5k3V85Yh/6gSBnE158MpY=;
        b=JBMjgD0ug8wtiBfN3lJu7HjLOxvzT9o5haY8jbdNFa7iKxr5XSVsCu7cb5xRFE9n6K
         UEJltKxZYogdaIhWQKROiBse6AQmv76QLpzV8tdVTvevwUiq77ruKDfgo5UIvmFub5KD
         T5ihtxj8JzOhCrImEK3f6GBMvnsiVBm1hDNLtU6AZkXStm36Vf9s9/MLCP4yYL/yfxep
         ai27ZcVJohrATKpzDxhZuZEG27jZYkXoOTMzUm0Zg2CcrT6O8QVQXInyTs49oCJi3q1A
         QSXpeUqpf3MpnnFuLif098HsFc/HFLsZZYvmtp5tJ25Y184ftv/l0g6n2KJKoLjnRPpm
         2elA==
X-Gm-Message-State: AOAM533WoQK4CM02Bygh0F8l5YVyI/vrNnnb+q6KVk0Gnxj8r5HCSzo5
        utl6D2gBddGhUeGYcGAyDmk=
X-Google-Smtp-Source: ABdhPJyyp3Tik/xLKv/T9iImv2aa39sxGQbc2ut7VH4ZAYYM1I3/7Ab7q13INWl44i3OuioMWgWEow==
X-Received: by 2002:a50:9d0f:0:b0:416:95a3:1611 with SMTP id v15-20020a509d0f000000b0041695a31611mr9953294ede.77.1649265757668;
        Wed, 06 Apr 2022 10:22:37 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm7912730edb.14.2022.04.06.10.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:22:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/5] staging: r8188eu: use round_up() instead of _RND8()
Date:   Wed,  6 Apr 2022 19:22:17 +0200
Message-Id: <20220406172219.15565-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406172219.15565-1-straube.linux@gmail.com>
References: <20220406172219.15565-1-straube.linux@gmail.com>
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
v2: no changes

 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 6 +++---
 drivers/staging/r8188eu/include/osdep_service.h | 8 --------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 9bd2428514de..2feae03a271b 100644
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

