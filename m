Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A206B48F4BC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 05:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiAOE0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 23:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiAOEYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 23:24:31 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C5C061748
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:24:31 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v25so4419027pge.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkesN9KWjSVv/K/BwDv4IWH7+poIeTrqlxSPCmZ0Qp4=;
        b=OvtNBGAIw/KZDU1aYaf2wr6DUwwH76kziXBSgSi1C/Soc4HBS2mLNv36xO96AoA1Jg
         y50BYGjmv64cF1L3VhGrDvxK5jfpH0tb5+v5g9/rcgaKvrb24ehk4+f3tO62mrDCokTO
         xPXZJiaC7nAmMWdvqZ9sT8Qv0V5VFCoKyOSw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkesN9KWjSVv/K/BwDv4IWH7+poIeTrqlxSPCmZ0Qp4=;
        b=OV7x79unfCamU+rIpcdpYd+xCcOfggo3jJxfmfx5JmYvTDBVkUcW8lGT2PiikL1tuV
         q74RAiJby+Vc3O2zTT814+Pw4CJFKrO9z68WdFxVRB4L1uF9jp1M3cSmhnPrE8Tbs8cK
         cYzvv7JaBIGTPmXL0+Tzq1gtx2G/fSdm1QweUlP4ER6tTyk/mh3gFuubk52rHnu0+dLz
         +vQkewJP4QanQ2z7f9WY95SXXrLS7mXpPAocoqL/5nqOOZx0Db6niX3VTc4ciuGWe2qi
         4vitNUZAFQmiXbjJJkUfxhzkY8kTaHAUTo0otiFJj1iv+wBfGK3zulk2/Xid/0z9hdTW
         BHkg==
X-Gm-Message-State: AOAM533CFWjxoarw0j22RI+VFEO8lZNLGfspecMLtXJWAe72RMvszB2X
        mEIJHPAEseSBlfiy5NjMhx4gSA==
X-Google-Smtp-Source: ABdhPJxSuLNJa9YR5ljfxzcuGsLA96PC4Kf+o9mQ9v2a6LmQr3n605NBmESGzo5iKBOC28izNz/bpA==
X-Received: by 2002:a63:9249:: with SMTP id s9mr10748342pgn.124.1642220670598;
        Fri, 14 Jan 2022 20:24:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gm2sm12289154pjb.21.2022.01.14.20.24.29
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
Subject: [PATCH 2/3 v2] staging: rtl8723bs: Drop get_recvframe_data()
Date:   Fri, 14 Jan 2022 20:24:26 -0800
Message-Id: <20220115042427.824542-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220115042427.824542-1-keescook@chromium.org>
References: <20220115042427.824542-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5267; h=from:subject; bh=Z6Wfwf6J3jPxC9N20ooqglvng7tGlFpo9yMXY4ONGgY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh4kx6rMJrMC8W6yDUxFp3e6Z57hAL5JlEjMqwbMfu kf+UFhiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYeJMegAKCRCJcvTf3G3AJlkjEA CN3vYikUMRVE1xXmmwivQxstd/0eGne+wIQ8+LnWOwICl8klblpN1AFhgS3Y/9hgjAS5x57pVHmCRx av8TgSTDdrseku8EpUGz/ljcMWrxLNMMKpIXznB1RUzXihOdbCB0ivOpbPZWcxtUruGf/WaQHGDMx1 0FA7jJrzJqr6HTIJni65+NxZAsnxr0Qm7FMFbqmk57Iu1PfFN3Q3L8UqQsDLHeZ49ZUKntwxk0l445 1a2KS0Bq9HBnDOvUlF2k7199hZx6KWlF/FCwqaif350logcFak5t7TZic6Wk/aH/4KuLf95Tfto6yn P+bvZvEsZBCbTLJXcA0g222Rj0w6vd3GuZJn4sND0kLN/STj8cVQZJL6K6I1s7K+5oTSmNi7h9zCzY 26u1cRWYThdRbK4IyWxfYBfzlRP2kCwFUmhwx8CeHObDk6hu1LE6fz7hP8B+TGxd+hk/u7Qc3JYkNW WO3QK5gjydWXyZfch1Fho8xmjPf9QvbJKk3Q7nSUURiXKXthQzj2DpkVqh25x+PMkgb/prjw7BrTHT TGoppmDZ8RVlx5vwDpS8v0XnqAQ+LJPxUXS4cIqC49eMjOHx3/dgcGQmED5ACd8YfDtvSRAKB2jvoS iaM74RSQP6mtEgk2fPhOcaLO4WBObxhAyQHw44WpMWddwxgRDusr/rQPAGBA==
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
 drivers/staging/rtl8723bs/core/rtw_recv.c      | 11 ++++++++---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c |  3 +--
 drivers/staging/rtl8723bs/include/rtw_recv.h   | 11 -----------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 41bfca549c64..ffb455688a7d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -465,7 +465,7 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 
 	auth_alg = adapter->securitypriv.dot11AuthAlgrthm;
 
-	ptr = get_recvframe_data(precv_frame);
+	ptr = precvframe->u.hdr.rx_data;
 	pfhdr = &precv_frame->u.hdr;
 	pattrib = &pfhdr->attrib;
 	psta_addr = pattrib->ta;
@@ -1510,7 +1510,7 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	__be16 be_tmp;
 	struct adapter			*adapter = precvframe->u.hdr.adapter;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	u8 *ptr = get_recvframe_data(precvframe) ; /*  point to frame_ctrl field */
+	u8 *ptr = precvframe->u.hdr.rx_data; /*  point to frame_ctrl field */
 	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
 
 	if (pattrib->encrypt)
@@ -1546,10 +1546,15 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
 		eth_type = 0x8712;
 		/*  append rx status for mp test packets */
 		ptr = recvframe_pull(precvframe, (rmv_len-sizeof(struct ethhdr)+2)-24);
+		if (!ptr)
+			return _FAIL;
 		memcpy(ptr, get_rxmem(precvframe), 24);
 		ptr += 24;
-	} else
+	} else {
 		ptr = recvframe_pull(precvframe, (rmv_len-sizeof(struct ethhdr) + (bsnaphdr?2:0)));
+		if (!ptr)
+			return _FAIL;
+	}
 
 	memcpy(ptr, pattrib->dst, ETH_ALEN);
 	memcpy(ptr+ETH_ALEN, pattrib->src, ETH_ALEN);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index c0a1a6fbeb91..74e75dc970f7 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -81,7 +81,7 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	struct odm_phy_info *p_phy_info =
 		(struct odm_phy_info *)(&pattrib->phy_info);
 
-	u8 *wlanhdr;
+	u8 *wlanhdr = precvframe->u.hdr.rx_data;
 	u8 *my_bssid;
 	u8 *rx_bssid;
 	u8 *rx_ra;
@@ -100,7 +100,6 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	struct sta_priv *pstapriv;
 	struct sta_info *psta;
 
-	wlanhdr = get_recvframe_data(precvframe);
 	my_bssid = get_bssid(&padapter->mlmepriv);
 	rx_bssid = get_hdr_bssid(wlanhdr);
 	pkt_info.bssid_match = ((!IsFrameTypeCtrl(wlanhdr)) &&
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index a88b7c088a86..44f67103503a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -385,17 +385,6 @@ static inline u8 *get_rxmem(union recv_frame *precvframe)
 	return precvframe->u.hdr.rx_head;
 }
 
-static inline u8 *get_recvframe_data(union recv_frame *precvframe)
-{
-
-	/* alwasy return rx_data */
-	if (precvframe == NULL)
-		return NULL;
-
-	return precvframe->u.hdr.rx_data;
-
-}
-
 static inline u8 *recvframe_pull(union recv_frame *precvframe, signed int sz)
 {
 	/*  rx_data += sz; move rx_data sz bytes  hereafter */
-- 
2.30.2

