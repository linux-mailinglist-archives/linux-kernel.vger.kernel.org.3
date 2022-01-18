Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54803492E82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348830AbiARTdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348763AbiARTda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:33:30 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88CEC061401
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:33:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d1so2063870plh.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtNhvDKyXQZ6Jo36sZZYMctRg/Y7isVGvsp0Av2OLNI=;
        b=BdL5H9cYY+49MxXn/iNc78kLpAnP1DypS2/R4UfayzZ09NM0ONhgKl+LRx0Gu3cakI
         K2K8w8c1rNuqroSg3BXmfl7zGIaeGTmES1D0niOyRHVWEoDGR3RzsWZGNO/sigNlPpwV
         thDIWoCH/zMpN59d549rmUf5ock/JsxhOy67o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtNhvDKyXQZ6Jo36sZZYMctRg/Y7isVGvsp0Av2OLNI=;
        b=GhkvSOTh5m+KCzBSQqXzUSPlU2eQbjxmdBSZJuC1Thw8qD+FObz/gYVGSgKQ/J3TJh
         29uCXm5SW+/n7agZUMK2KF9lgg+2YcnEDWxp+SQZOLzIxDJWRazRqCiGP/vxWmSmUrqv
         Y4ekgtPO5SqGEO+XRoyb79L7f8/9dPTl80Ju76nkUwyyVf4qF/+r8bRZaZ/jXkQ/3qw/
         nrOtUnG6AzpBA+qtF8JB4atLTF98syW5OSdYQe4w3OPX99V6Tu9/sXMDH1m23cCNy2YM
         M89DI6eZ+ji3+DpEaUf7yBaH//5n88DmRfs0fDHwdVWH+YMZ/Y7f/iaQxY4KBXyX75mB
         Zp/A==
X-Gm-Message-State: AOAM531CnbC82BkO1zLCwjZvpJlW4BdUHlrh5LoAoSogBxZjx5tDNhWc
        yC5ssKxxk4NL1+WtybGfxM9I9w==
X-Google-Smtp-Source: ABdhPJwgE8jcCT3labTDwao+nHGvfWqRwKzFNqt9hExsgXilGxYF0m09Y3u3MTDb4o9vay68AQtaOw==
X-Received: by 2002:a17:902:aa4b:b0:14a:cff4:19ec with SMTP id c11-20020a170902aa4b00b0014acff419ecmr5946219plr.60.1642534409435;
        Tue, 18 Jan 2022 11:33:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 25sm3508985pje.22.2022.01.18.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:33:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Joe Perches <joe@perches.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/3] staging: r8188eu: Drop get_recvframe_data()
Date:   Tue, 18 Jan 2022 11:33:25 -0800
Message-Id: <20220118193327.2822099-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118193327.2822099-1-keescook@chromium.org>
References: <20220118193327.2822099-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4934; h=from:subject; bh=91pfgNSNKQZ90Z5sOLt9nzmWsWo2UUEN0XKGD4U7vGE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh5xYFlQv2coVuKsjKL2V15ndg7Erkujlv2Soj3VY3 WBrgQfuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYecWBQAKCRCJcvTf3G3AJnjaEA CynCag1EmCrN2PCAl/92wBGlf4AvWgcHIHj6wnKvOw5aWiYVAqAo1X8Qwi+EKTR5MZUut7Q5EMdIHW uJ9QmMBEn3KKzX7RPfIWkz5winwPnvc7Xbue6U01mHxVkSjoh/aBuI8Whk4xxHll/onynWc9S3NwTR ciSzWlzxLnjr5FD4FLKHTvn3Ma8ggFIY+Hduqjud3Xyhpp74zl3dS7nt3YD1Zy/cAIq4RwXjkEqrgZ qVdnn/CZezaCzhRqkkRMA8x50L3spzYIK+1J9HxHDNkRuXWTv4Y8cznBKyzXPKmlNN0TMYU36RADnz SZc3tBVZeWsz9TWOFrEqfh/zCf7VdN51lJF63PljlnOHi3LOgvVlKHLDwpjPDThBwTX17uvKqdnAFE xTHa/z83bIofJg3uHxPOiF9eTP/O6rX4k/ggqxipSX0ow0xiDVVHIc17ypBm7SfunZFrYF3wRUttiB cqQENioI3v+tVIo996Y4NrODehhbe10kuEYQ2PQVnW8L4pHprLF6wjHVx8pMK4J+PANzx1I1xMihtO h6QaBVEeK+MD0imfaKC8ZlFG687xOOogHzI/TlYP2/fhLBRwJJtuiID1hhZ4zELVH3E1fYSmkVJ2gp VQ02QBXboNpzL+1REJ+FQn45ylj2NyFBAv27HMc56y3ATUMeX7fOGCHW6GvQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Warray-bounds, the following warning is emitted:

In file included from ./include/linux/string.h:253,
                 from ./arch/x86/include/asm/page_32.h:22,
                 from ./arch/x86/include/asm/page.h:14,
                 from ./arch/x86/include/asm/thread_info.h:12,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/rcupdate.h:27,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/sched/signal.h:5,
                 from ./drivers/staging/rtl8723bs/include/drv_types.h:17,
                 from drivers/staging/rtl8723bs/core/rtw_recv.c:7:
In function 'memcpy',
    inlined from 'wlanhdr_to_ethhdr' at drivers/staging/rtl8723bs/core/rtw_recv.c:1554:2:
./include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' offset [0, 5] is out of the bounds [0, 0] [-Warray-bounds]
   41 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^

This is because the compiler sees it is possible for "ptr" to be a NULL
value, and concludes that it has zero size and attempts to copy to it
would overflow. Instead, remove the get_recvframe_data() entirely, as
it's not possible for this to ever be NULL.

Additionally add missing NULL checks after recvframe_pull() (which are
present in the rtl8712 driver).

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Straube <straube.linux@gmail.com>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/r8188eu/core/rtw_recv.c       | 6 +++++-
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 4 +---
 drivers/staging/r8188eu/include/rtw_recv.h    | 9 ---------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 51a13262a226..946e659ae97a 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1188,7 +1188,7 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
 	struct adapter			*adapter = precvframe->adapter;
 	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
 
-	u8	*ptr = get_recvframe_data(precvframe); /*  point to frame_ctrl field */
+	u8	*ptr = precvframe->rx_data; /*  point to frame_ctrl field */
 	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
 
 	if (pattrib->encrypt)
@@ -1223,10 +1223,14 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
 		eth_type = 0x8712;
 		/*  append rx status for mp test packets */
 		ptr = recvframe_pull(precvframe, (rmv_len - sizeof(struct ethhdr) + 2) - 24);
+		if (!ptr)
+			return _FAIL;
 		memcpy(ptr, get_rxmem(precvframe), 24);
 		ptr += 24;
 	} else {
 		ptr = recvframe_pull(precvframe, (rmv_len - sizeof(struct ethhdr) + (bsnaphdr ? 2 : 0)));
+		if (!ptr)
+			return _FAIL;
 	}
 
 	memcpy(ptr, pattrib->dst, ETH_ALEN);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 90d426199f52..bf93ff3af140 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -128,7 +128,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat
 	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
 	struct hal_data_8188e *pHalData = &padapter->haldata;
 	struct phy_info *pPHYInfo  = &pattrib->phy_info;
-	u8 *wlanhdr;
+	u8 *wlanhdr = precvframe->rx_data;
 	struct odm_per_pkt_info	pkt_info;
 	u8 *sa = NULL;
 	struct sta_priv *pstapriv;
@@ -138,8 +138,6 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat
 	pkt_info.bPacketToSelf = false;
 	pkt_info.bPacketBeacon = false;
 
-	wlanhdr = get_recvframe_data(precvframe);
-
 	pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
 		!pattrib->icv_err && !pattrib->crc_err &&
 		!memcmp(get_hdr_bssid(wlanhdr),
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index b43a46887343..920f33235e00 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -296,15 +296,6 @@ static inline u8 *get_rx_status(struct recv_frame *precvframe)
 	return get_rxmem(precvframe);
 }
 
-static inline u8 *get_recvframe_data(struct recv_frame *precvframe)
-{
-	/* always return rx_data */
-	if (precvframe == NULL)
-		return NULL;
-
-	return precvframe->rx_data;
-}
-
 static inline u8 *recvframe_push(struct recv_frame *precvframe, int sz)
 {
 	/*  append data before rx_data */
-- 
2.30.2

