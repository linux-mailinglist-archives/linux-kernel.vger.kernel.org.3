Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7F84F6B18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiDFUSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiDFUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:16:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452228E35F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:22:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d10so3530448edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQHPYFD1Py8zNnywpsqR57whk+RQMCTk3DSycMVZoGs=;
        b=i3285HxhOHK+wsC2Sx1TdhTQ+r7HTGVY90ljRxlx5XyfINjbt5tgpYWCX8OOchd/AK
         KSRf1EIcTp0BC/+unXiBAoc5zggnumgcKHKD3RNsFV/uALsMxQfgTTiQnTz0BbY2Xp5Z
         k9xgMH2wYhIeShrQGa5E39WZn5iiJ3hd06q8c/i70lGPnCsMTiH+ApXi2r66DIZbMwEr
         N6rO7auN6KtNdQejV7+SzkUWFrNVQp7noRR++bZ3aI1vAvahlXc+gXZzFnDtIgfgzJ+v
         mOb/kQxf+M5+kuKoznZBqKA6eb7KHSRSuoEKjmBYgqBcwQzsEA02Pmm6VjOac6sTymGl
         GPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQHPYFD1Py8zNnywpsqR57whk+RQMCTk3DSycMVZoGs=;
        b=zIGP3cAlUQJo5sfD5UHv2QmF/EdBzxWgustaRUfDoH7tDoEqfls14b3NCDolSCYjI5
         Md8GRTpCt5VOgOISSUQz4EKYlwYwPY6EaNArbl5PNBnH7DJSiQrM4FA4NwQKjaGUdDiQ
         8tfZM+HzesGqEjZ5NoKPgOO1K+WwSbL5rkoJTRBRJ5TAOVTBDhR71mw5k+xUg6r+FSHT
         NaBXgjGV6YF3qH9+keikgnc8Bnd2Ofy9RkiCz/ZfKdWL6VTTr5yrbKBlF7dcqSylgeTD
         NwpJeTLguXxSoLZfamycD9BGRLssQOwVv+8yfhQ5+K/JbHYzv+e11FvfnDuUa5gW29Y5
         WDjQ==
X-Gm-Message-State: AOAM5305BIYPW4Ytnq+NGAWFaUU/mJEzFMSxkYPwttFkMuHt7L8JsMz0
        tcr3C9balwdvrmuUNIlW7SQ=
X-Google-Smtp-Source: ABdhPJxTLzdy7NH5f/05EmF9B7YY/OHkx1w89J5gA3kDRTQwcqmx5OjjXPssz+kL8Id3eYvIFvDyOg==
X-Received: by 2002:a05:6402:1909:b0:418:d876:3119 with SMTP id e9-20020a056402190900b00418d8763119mr10249749edz.266.1649265756026;
        Wed, 06 Apr 2022 10:22:36 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm7912730edb.14.2022.04.06.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:22:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/5] staging: r8188eu: use PTR_ALIGN() instead of RND4()
Date:   Wed,  6 Apr 2022 19:22:15 +0200
Message-Id: <20220406172219.15565-2-straube.linux@gmail.com>
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

Use in-kernel PTR_ALIGN() instead of custom RND4().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
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

