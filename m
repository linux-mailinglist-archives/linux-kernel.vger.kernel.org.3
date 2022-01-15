Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725E648F4B7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 05:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiAOEYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 23:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiAOEYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 23:24:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2A3C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:24:30 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i65so4536217pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtNhvDKyXQZ6Jo36sZZYMctRg/Y7isVGvsp0Av2OLNI=;
        b=hUzYCGC55NH+cf3c7waBsuULipT4Kpa+W+PA6ihbTRK8lLC1JncQ1OMXHYRbROa0zh
         OUzv4bFaAIKnuyK/uvPaI7YxbRKSxMKkgFIqg2n9QlkWLPo4sIsWOLmi7EMma/m0sahy
         zThEmlNRip4lD3IG4ClYwZ2LyVwmVEvoF9OMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtNhvDKyXQZ6Jo36sZZYMctRg/Y7isVGvsp0Av2OLNI=;
        b=2marVX0qTNrYHtnXy5XfQswcm+555P2LavEeJTPn3veIZ7C6VVqr5Uup32qfeCvvwh
         Uaz8g6b2pbQh4AqSvQvrz65b616cJolthQf9FrExS0EwvbCKakgq38l3bc+a7nwnEqIu
         hVBa7lrU5XjlCTlORcXo8R+1NUZWSRD45La4u7+I5+KQ+7TVng6oiOD/pSK6/+KwPPz8
         tvntuGIpZy6EK3gI14w4fzuZlZRS93kY0wEEy7rWc8e71YfU5ySJFB1YQjPvyFx8wviA
         Ha/ZRXCnzEmh2D6RTNIUsRQGVK7NNLNUunxIP84ipXSPng8IJcvwaD4Lkqg3zVGvDz8K
         obSA==
X-Gm-Message-State: AOAM533zW2fwu9exWvLuJ+yPTcV5zP8KVw5+6cucp0xUBm4n51bcXI7l
        cOHoyYoPqb7ZtifBujRiZynD+Q==
X-Google-Smtp-Source: ABdhPJz5tCXujzY8OghCUBQNUBHDa22zyVcbaZ6BUO5ym91jHLtpezu5wFeJRQOAchTuClwI1F033A==
X-Received: by 2002:a63:d114:: with SMTP id k20mr4198126pgg.75.1642220669870;
        Fri, 14 Jan 2022 20:24:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q9sm5777743pgv.71.2022.01.14.20.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 20:24:29 -0800 (PST)
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
Subject: [PATCH 1/3 v2] staging: r8188eu: Drop get_recvframe_data()
Date:   Fri, 14 Jan 2022 20:24:25 -0800
Message-Id: <20220115042427.824542-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220115042427.824542-1-keescook@chromium.org>
References: <20220115042427.824542-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4934; h=from:subject; bh=91pfgNSNKQZ90Z5sOLt9nzmWsWo2UUEN0XKGD4U7vGE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh4kx6lQv2coVuKsjKL2V15ndg7Erkujlv2Soj3VY3 WBrgQfuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYeJMegAKCRCJcvTf3G3AJv0xD/ 92Y3jbnr8L5D4H7cCfqWdvnWn/NXAJodrOeNxdk7ul/0rRz3EqIiZVoWUOpJ3pq0fQ+s87Wf+pCt3u ebrZiFUNQBMQvVLQOPZsuH93QLbMHK0heQuRM6ogcPNx3Q9FzCDJszz96ZEOrv2aqLmZJu8Z5FzGIa sVAn6r+vbNgmU/BmjefnN0RzUArx+gL6rBYRSnzg99cHhI6A1qw9b8VUfCgdoMxnRzPg67sbxcy3b1 zUwdhsxXS5HyLenfz9vUp3jxU2pDd0Mjba2njaWMdllw4h+KAm7u7AZEKYOB8IQlJuDYsdqAb3IZYy 8RaG9xNmBczKAy+kzccVKpw67WfHtrxMt4jqQXyTHpXQIVm37im+BNOKRfgWKv1ecJxQQDKKwWLjFy P0ysyE0vtPd035lKVYTEpqyeRhdLYJqMcsJrifdHtw09jyMbHvY1WNByaiuQNx0gy//DuJ16Catjdr I7BaJB0Y60TaSe1A2DZxavoy7hiUYd8fiI1egvTtjquDEEGBRYg685JnWmDv20JfNgqqeVZkCDqiIh aLlHB9oJ8VLOJEggpNZbNkBnWPEDfIZOR5pZx0N2Gubu2kQj+40PRI6Wd+aBl7IQaQm6NY5lcQFzK5 Ysnrr8OM78uiOjOYvzfOrApU+bmpXeKc6nVmm6vqJ5CjXlGUtJpsokZYMxlw==
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

