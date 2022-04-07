Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB24F7FA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245589AbiDGNAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiDGM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:59:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743656C914
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:57:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x24so1334532edl.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQFB5yWy+dqTr0/vXZMWZCnU/4D4Laj4hZ4wf3r7fdQ=;
        b=EdsSwzHfuZMpjh/pj5QJxv5ix7SQQN0fexd1yk+3DYy3b79RdgL/a0qcaJ3ckfuQYZ
         3HJjyOSL1QhzSEvv/kX2jPOgUt0STtMQHOfPM2r/ZpsEKyz3dlatGceDC5kxEadL6OHN
         oF2atjnAeeZqLydyT8zPZVl8bMtNavc2wR4t9wJNY1DkQpBNKZQy36ys1WJjC1qdPGcH
         cy00Ohyy7NJ11/U9XjyLUmWat+JAMHH/zCDW+vZ+4Y/mPUWtDnJnqtUtq3hUMg4Ri3/F
         RTsUWnffHvsNXPw2G2PUfHAhOF0/GkYNx9ouSsFFTIMZi+c4nVkPTyyOdEcuIWvYy/Nq
         UNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQFB5yWy+dqTr0/vXZMWZCnU/4D4Laj4hZ4wf3r7fdQ=;
        b=DZ6i7y6vunjeoEN1Gl4om8B7Z0vlPyPhOJMG0fjA2YvxfCRnUr2VzVJb104hi03yNM
         zido4Q58IYWvlcIPLm3uJsQZoKQYEa5G5wLHX3qk0Zo1ghRZgF9lMjC5dvMjD/0onME7
         oDg7lyd4msRNfglKAp6Zs9mUd1iZVjgJkSGXCSicXhwpaXrMaEKgyfYe8JkXMwvxR4eV
         ySoj5HSmdqD4x2iQikgDL6wIrfmTmGIG14L5xkuSdRfVzwWM9yRh5F+QlOll2xmKjb/l
         LBHPvFdZWufb4gBC9B81nW25qyBnSW9AkSClh1bsMWOx8XrVVgjdXYasxeWokxB7TBee
         coEg==
X-Gm-Message-State: AOAM530ws2imQ0CWyxkYR1UOMKH/1A30tchKsIGknNbB5urKDXcqDsuP
        3YQslWN2gC5nAjx7DoS42lg=
X-Google-Smtp-Source: ABdhPJzgMxNu9bVKPUiyFBJrI3NYATy0seuQtm3wUICFma8ZcRZ/acC9lzr4cb8MsrM/H699EXtINw==
X-Received: by 2002:a50:f08d:0:b0:41c:d21a:e77 with SMTP id v13-20020a50f08d000000b0041cd21a0e77mr13873355edl.277.1649336270017;
        Thu, 07 Apr 2022 05:57:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm7676764ejk.119.2022.04.07.05.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 05:57:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 3/5] staging: r8188eu: use round_up() instead of _RND8()
Date:   Thu,  7 Apr 2022 14:57:40 +0200
Message-Id: <20220407125742.7814-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407125742.7814-1-straube.linux@gmail.com>
References: <20220407125742.7814-1-straube.linux@gmail.com>
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
Just remove _RND8 where it is not necessary to round up.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: just remove _RND8 in one case
v2: no changes

 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 6 +++---
 drivers/staging/r8188eu/include/osdep_service.h | 8 --------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 9bd2428514de..bdfa51949289 100644
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
+		if (pbuf + len > MAX_XMITBUF_SZ) {
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

