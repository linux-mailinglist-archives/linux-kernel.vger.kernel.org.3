Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D41E46AE9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377568AbhLFXx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377352AbhLFXx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:53:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A8C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:49:58 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a9so25673144wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 15:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+BIND2ZoVF4Tr9QPLxHGVGa7QFELkyk6ki+EZDKm8g=;
        b=fwABxHvSrhuBMlL8yiFaS/KVVOSVAgYLcIVmBXmI3BFjOJ7Zv4N2p90xKjnxtTD75r
         NJAdcN6Hff7EOX9KbncY9pcbMkJMqf2IHvydi1SCK1fhuOC5WPkPQzX6vG8l9kiXfpbV
         2Fz7D63+VkWhVlLuFinJhW/bgAIrPY4nkmbe309eJHlLoDRWMGgZ58jUEQCch6uOYKcW
         +W94CJ44Kzsw0wh0jFa7kFXT9aDOxZStesez2I27+2zB+Pfuy+uZ9ZJV17VWWpMKI5M1
         xNIMU20sZMK7Lnl3zR7Y0attBQ320UGu4MIBsPtjVv4ZPmqGAIzOnCCJUKnEHBISuQXt
         0a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+BIND2ZoVF4Tr9QPLxHGVGa7QFELkyk6ki+EZDKm8g=;
        b=l47WQWOFm537lPMatOZTg+gmKuWBW66FJmuqKXTN1x5X5obe54/vnFnn+vFxyuGKAx
         fJKVCuu4wW4rtm5IeUYdxuxY4+/qE+GSY40Bgbj8lkjunh/jcym8ST4FsAxrC7+HJtE7
         BgHaTRWTkGAEuak7McxufAtSpwcvjBSrR1K4XpRhcZ0lNfyvFRDZlxjLAuhivLSVU/0U
         9HjOSgnWH4tLEsln7o43CPpRPX+d1kAelm4JLMcIDsF5s1YC6U/nO/zqd9ymJVg3N/Qv
         exgne7tRl8PiavtPwn3ArpEsGDuenhLueA8g/Eum7bXfHU5I86kiXpH8Jx+LdRweR7PL
         5B6A==
X-Gm-Message-State: AOAM533CTCzjLtyGLquN2UKYlW9iR0Q8nZaHu7VbI7C7j08OwMUJ3swZ
        n4BMj23/V36oQhytRm+DPmIetA==
X-Google-Smtp-Source: ABdhPJz7gzMn+Wto+IJl8RwX775COT5DHG8twcU/+8raVJA/xpsiOjBV+5aBbzMcb90RVLaAUD80Rg==
X-Received: by 2002:adf:ce08:: with SMTP id p8mr47417101wrn.154.1638834597361;
        Mon, 06 Dec 2021 15:49:57 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id k187sm1241189wme.0.2021.12.06.15.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 15:49:56 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: r8188eu: convert DBG_88E calls in core/rtw_security.c
Date:   Mon,  6 Dec 2021 23:49:51 +0000
Message-Id: <20211206234952.1238-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211206234952.1238-1-phil@philpotter.co.uk>
References: <20211206234952.1238-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all DBG_88E calls in core/rtw_security.c to netdev_dbg calls.
These calls seem to contain useful information/assertions and so are
probably worth keeping. In doing this conversion, also convert
static aes_decipher to take a struct adapter * parameter, as per the
convention elsewhere in the driver currently. This allows us to pass
this through and access its pnetdev member for the netdev_dbg call in
the function.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_security.c | 22 +++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index db35f326bbb1..4e93c720c1b6 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -545,7 +545,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 			if (is_multicast_ether_addr(prxattrib->ra)) {
 				if (!psecuritypriv->binstallGrpkey) {
 					res = _FAIL;
-					DBG_88E("%s:rx bc/mc packets, but didn't install group key!!!!!!!!!!\n", __func__);
+					netdev_dbg(padapter->pnetdev,
+						   "rx bc/mc packets, but didn't install group key!\n");
 					goto exit;
 				}
 				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
@@ -1145,7 +1146,7 @@ u32 rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-static int aes_decipher(u8 *key, uint	hdrlen,
+static int aes_decipher(struct adapter *padapter, u8 *key, uint hdrlen,
 			u8 *pframe, uint plen)
 {
 	static u8	message[MAX_MSG_SIZE];
@@ -1329,8 +1330,10 @@ static int aes_decipher(u8 *key, uint	hdrlen,
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
 		if (pframe[hdrlen + 8 + plen - 8 + i] != message[hdrlen + 8 + plen - 8 + i]) {
-			DBG_88E("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
-				i, pframe[hdrlen + 8 + plen - 8 + i], message[hdrlen + 8 + plen - 8 + i]);
+			netdev_dbg(padapter->pnetdev,
+				   "mic check error mic[%d]: pframe(%x)!=message(%x)\n",
+				   i, pframe[hdrlen + 8 + plen - 8 + i],
+				   message[hdrlen + 8 + plen - 8 + i]);
 			res = _FAIL;
 		}
 	}
@@ -1358,13 +1361,16 @@ u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 				/* in concurrent we should use sw descrypt in group key, so we remove this message */
 				if (!psecuritypriv->binstallGrpkey) {
 					res = _FAIL;
-					DBG_88E("%s:rx bc/mc packets, but didn't install group key!!!!!!!!!!\n", __func__);
+					netdev_dbg(padapter->pnetdev,
+						   "rx bc/mc packets, but didn't install group key!\n");
 					goto exit;
 				}
 				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
 				if (psecuritypriv->dot118021XGrpKeyid != prxattrib->key_index) {
-					DBG_88E("not match packet_index=%d, install_index=%d\n",
-						prxattrib->key_index, psecuritypriv->dot118021XGrpKeyid);
+					netdev_dbg(padapter->pnetdev,
+						   "not match packet_index=%d, install_index=%d\n",
+						   prxattrib->key_index,
+						   psecuritypriv->dot118021XGrpKeyid);
 					res = _FAIL;
 					goto exit;
 				}
@@ -1372,7 +1378,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
 			length = precvframe->len - prxattrib->hdrlen - prxattrib->iv_len;
-			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
+			res = aes_decipher(padapter, prwskey, prxattrib->hdrlen, pframe, length);
 		} else {
 			res = _FAIL;
 		}
-- 
2.33.1

