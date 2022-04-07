Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB984F7FA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245578AbiDGM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbiDGM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:59:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FCC6C914
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:57:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f18so6313468edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhBV9fSUs/h1yxQ+cBz6nBKH5UMTCWQCPrPfKTVvcIc=;
        b=BSS4VNu7ODpEcdLkoR08kArNJC6n5/uLzHUrLxtD9C7u2qFy8WQ2cB/q+sGaD5keHS
         YPeJO3RhBFf0fAzaGBs3a8nPaEg5fJK7CsUAXWUb0GwnQhZe2jnnIp1PJVEcZoOXx43e
         Nhm0MRLxPYaGFw7zTofznmZZ7euw0ZHtqyYrXBl1GwQlrrOEatoPUhzQF1h33SP9CSV2
         fQJS4kXwM8CNfd/LlRI9MoXzj0VZsz2uqvEKSUbuU0J1y3/plhJnO7zH92rkVG9A1juN
         YxzwUIL9zhZZKbKznbzh3wxEGe28EYmGKs6YUDzUixILDisUVPJN/wnqzD0L0vQAc1T4
         d+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhBV9fSUs/h1yxQ+cBz6nBKH5UMTCWQCPrPfKTVvcIc=;
        b=uPJ5oARxJNdyXF2zmr8UDwqWe6ScR5AEse584ZgcIXgnl1KbT8/3v1W71SCYk4MEsS
         sYLCTulRR7HaSxTnAWBpVym5eufytvnMhVyOpz9L2n818Y7qlKG43lcvdH4hrBg7/pLj
         xTb9fw1BIKrJN0Nbju0mvSPibWcc6RGBGww5Yv1dTneKLuy1ZOmcoyU8cGhWHbxzvB4t
         yJFVqi8Yp1ga0OzKmF4xY69ZkMqytlRXeQp6/YPQUiWiW7Hb4QAKNEHoV8GZwM66svIz
         8S7//t82qdKcU/NBVsRAaZ+cbMx2ZOL8vnbbm06cyTBHy0tjTTmX6p7EUsJRr9Q7ALds
         FoBQ==
X-Gm-Message-State: AOAM5305k2dML3DDpKbEK8dwfnWaBFNvI/KzHkWnq2VwOOUY9hs8OQFU
        i1XaBNv2OKAdNPHFZgKMBA4=
X-Google-Smtp-Source: ABdhPJzNEkdolj1fwRZkSHCDdVLOqdSreLW+sdhMxT7ie2gX60F2ufWilY7PnlcaX+RjiR+iHnhg1Q==
X-Received: by 2002:a50:9fa2:0:b0:41c:d9c2:6b19 with SMTP id c31-20020a509fa2000000b0041cd9c26b19mr13884900edf.393.1649336268558;
        Thu, 07 Apr 2022 05:57:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm7676764ejk.119.2022.04.07.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 05:57:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 1/5] staging: r8188eu: use PTR_ALIGN() instead of RND4()
Date:   Thu,  7 Apr 2022 14:57:38 +0200
Message-Id: <20220407125742.7814-2-straube.linux@gmail.com>
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

Use in-kernel PTR_ALIGN() instead of custom RND4().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: no changes
v2: use PTR_ALIGN

 drivers/staging/r8188eu/core/rtw_security.c     | 6 +++---
 drivers/staging/r8188eu/core/rtw_xmit.c         | 7 ++-----
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 1 -
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 2cdcdfd5ca5c..5bba57d18b5f 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -63,7 +63,7 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 				arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 				pframe += pxmitpriv->frag_len;
-				pframe = (u8 *)RND4((size_t)(pframe));
+				pframe = PTR_ALIGN(pframe, 4);
 			}
 		}
 	}
@@ -504,7 +504,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 					arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 					pframe += pxmitpriv->frag_len;
-					pframe = (u8 *)RND4((size_t)(pframe));
+					pframe = PTR_ALIGN(pframe, 4);
 				}
 			}
 		} else {
@@ -1133,7 +1133,7 @@ u32 rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 					aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
 					pframe += pxmitpriv->frag_len;
-					pframe = (u8 *)RND4((size_t)(pframe));
+					pframe = PTR_ALIGN(pframe, 4);
 				}
 			}
 		} else {
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index aede8ef8b098..029b994e1b71 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -642,7 +642,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 			payload = pframe;
 
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-				payload = (u8 *)RND4((size_t)(payload));
+				payload = PTR_ALIGN(payload, 4);
 
 				payload = payload + pattrib->hdrlen + pattrib->iv_len;
 				if ((curfragnum + 1) == pattrib->nr_frags) {
@@ -868,7 +868,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 {
 	struct pkt_file pktfile;
 	s32 frg_inx, frg_len, mpdu_len, llc_sz, mem_sz;
-	size_t addr;
 	u8 *pframe, *mem_start;
 	u8 hw_hdr_offset;
 	struct sta_info		*psta;
@@ -985,9 +984,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 			break;
 		}
 
-		addr = (size_t)(pframe);
-
-		mem_start = (unsigned char *)RND4(addr) + hw_hdr_offset;
+		mem_start = PTR_ALIGN(pframe, 4) + hw_hdr_offset;
 		memcpy(mem_start, pbuf_start + hw_hdr_offset, pattrib->hdrlen);
 	}
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 55032d7ae7e3..9bd2428514de 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -347,7 +347,7 @@ static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 
 		mem_addr += w_sz;
 
-		mem_addr = (u8 *)RND4(((size_t)(mem_addr)));
+		mem_addr = PTR_ALIGN(mem_addr, 4);
 	}
 
 	rtw_free_xmitframe(pxmitpriv, pxmitframe);
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index fca8f3d116c2..56e5cbfec1f1 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -95,7 +95,6 @@ static inline void flush_signals_thread(void)
 }
 
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
-#define RND4(x)	(((x >> 2) + (((x & 3) == 0) ?  0: 1)) << 2)
 
 static inline u32 _RND4(u32 sz)
 {
-- 
2.35.1

