Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79554F5B36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456469AbiDFJiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572986AbiDFJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:34:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E89062A13
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:19:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k23so2124951ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m27zJUa0hUUwtRXnhRp6D7XxaujvdIa/9+L7Kmi7OFw=;
        b=BPH9+Z3kr7zvAWWA4yfUUO3TcJNju39QUV/9+CoH/guctJPX6fRcgRAdhqT4i9Jr8Z
         NFd4TtLX+Z+8MoqjjeCN3efaw97bob0mGVrO+DX+/YOrHM4h1BBsjEZtJ1PDebrQMKjZ
         yJoQ8jBuh5xAjgPjL+DDHhiU9BO3sm4yF3/oDroYGMXvxgpE6GRa5KdnDZFOlS1rbDr8
         Ne++IpU9YzJXZzRWULu2sTdINW3kBmh391dxh7BPrinY7IwhjyZrkMnp5VQMsekIc6/U
         2sNlWx0D0vM76lqC7xZuVCaGIw35UGXzv1VwoAPCYXzdUDK1w+tVpFEsKm9yhvCOtdkl
         L/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m27zJUa0hUUwtRXnhRp6D7XxaujvdIa/9+L7Kmi7OFw=;
        b=ZGq+Ar5PviHnWEkeTyKDz3RGHgpquuX8L6iTwih+tvTN0DKMxzB+RDbPi+OLqtFDDv
         ohW8nKXi4RbEUQGGbjA4VUGYp62pvosYxUMcKdO26cHdZ4T6HnMRMZCbfZtpO+N1ZDG3
         JC695gxq5+gZHmIi87Y3rYJ/0UcwUsGDsPGmtH0bC098ywOL7DTEbyEWXSpRgPPfcCLp
         jHlh8Zl40DLeD1f7eTZYwiakGvaRFPlYdSdtUuB7F89QssPMWcBXGsXpRHb46amSz9Nl
         gms/tu8Gql/oBsvP2WvoKEyAtFCLHRtM/ZQNWg81tQ3Jok21ZwXhKHmO8UPS845PfQYB
         SKyw==
X-Gm-Message-State: AOAM531IeMgxG6hpqFvmIEzMw7qQ2EmZNq6T20X+X9jRjlyCRYIjDM6c
        3G5KZ0LjktJEZp1CxDkdYhk=
X-Google-Smtp-Source: ABdhPJzbVQ8/OwGlOVZ3+2MKzr8wTDXkN5t0bdWEb8X9/9VaHHvUAu6voeu4k67V9vFVF0LTTaMf5A==
X-Received: by 2002:a17:907:8a1c:b0:6df:ecd6:b6ea with SMTP id sc28-20020a1709078a1c00b006dfecd6b6eamr6745695ejc.530.1649225952609;
        Tue, 05 Apr 2022 23:19:12 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id q3-20020a50da83000000b0041cdd6e92b1sm2475251edj.27.2022.04.05.23.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 23:19:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: use round_up() instead of RND4()
Date:   Wed,  6 Apr 2022 08:18:55 +0200
Message-Id: <20220406061859.9011-2-straube.linux@gmail.com>
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

Use in-kernel round_up() instead of custom RND4().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c     | 6 +++---
 drivers/staging/r8188eu/core/rtw_xmit.c         | 4 ++--
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 1 -
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 2cdcdfd5ca5c..7462eaab8d2e 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -63,7 +63,7 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 				arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 				pframe += pxmitpriv->frag_len;
-				pframe = (u8 *)RND4((size_t)(pframe));
+				pframe = (u8 *)round_up((size_t)pframe, 4);
 			}
 		}
 	}
@@ -504,7 +504,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 					arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 					pframe += pxmitpriv->frag_len;
-					pframe = (u8 *)RND4((size_t)(pframe));
+					pframe = (u8 *)round_up((size_t)pframe, 4);
 				}
 			}
 		} else {
@@ -1133,7 +1133,7 @@ u32 rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 					aes_cipher(prwskey, pattrib->hdrlen, pframe, length);
 					pframe += pxmitpriv->frag_len;
-					pframe = (u8 *)RND4((size_t)(pframe));
+					pframe = (u8 *)round_up((size_t)pframe, 4);
 				}
 			}
 		} else {
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index aede8ef8b098..0f84d9ade0a3 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -642,7 +642,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 			payload = pframe;
 
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-				payload = (u8 *)RND4((size_t)(payload));
+				payload = (u8 *)round_up((size_t)payload, 4);
 
 				payload = payload + pattrib->hdrlen + pattrib->iv_len;
 				if ((curfragnum + 1) == pattrib->nr_frags) {
@@ -987,7 +987,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 		addr = (size_t)(pframe);
 
-		mem_start = (unsigned char *)RND4(addr) + hw_hdr_offset;
+		mem_start = (unsigned char *)round_up(addr, 4) + hw_hdr_offset;
 		memcpy(mem_start, pbuf_start + hw_hdr_offset, pattrib->hdrlen);
 	}
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 55032d7ae7e3..87095eff107b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -347,7 +347,7 @@ static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 
 		mem_addr += w_sz;
 
-		mem_addr = (u8 *)RND4(((size_t)(mem_addr)));
+		mem_addr = (u8 *)round_up((size_t)mem_addr, 4);
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

