Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9520448802F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiAHA4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiAHAzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:55:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D277C061748
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:55:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 2-20020a05600c02c200b003470f96e778so3628553wmn.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 16:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZeUHUZWxDxeensObwbjkGV/GC1wuDs3S5FK89IMeJ4=;
        b=6j3m67ME9247HChzfrdYL3VKRv/MROei8xh+98+nKPJTWHQAfqjaTW8EdeGMzb9gQR
         lwm01PkOJxbDcod+0bMgwSFx+oSQEArWDA3TxPp2R6nilHOrO0HxF7EZJ9DS0mg+nf/b
         Sh9wBmN6bF8x03pEouDlPtYcMArWoPmqt5OiQcq/dMJbzSsQ+4vlDaJqG9GWOFbmMzQ9
         SxVDQmZ7zkzsozPZWWdNL72Zh90r0ql91DrCvSKS051BJlrJS8wxzVKXHT/BWayaUgES
         v381m7kpYygeg8TmOt0hcHBzidWBwx8KQRzBi6QfbmrqBw7q9QpIUILxhYPb8PoVXMia
         r/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZeUHUZWxDxeensObwbjkGV/GC1wuDs3S5FK89IMeJ4=;
        b=eKvr6wXxvh2yEiu4hkqry5R1DKo5SpMwO1rYgDpXTim1pHlRNUUK4q5BPkDztRcNox
         frRSSVRalRwWeaSRMCYPnlHamAGIy0yHrRVdJayYdBUpPFzS7LBvefiWlQjqkAA9ibOs
         /ckiYlm0nwmPbBF2v6h/BfpEYPyU4Aq580OVYrDe9NL1XwMJBKtJk3kARhryy/vAKHyf
         5DVCSSICbsJamBh3xAjaxc7QMHf8eGc42cGe1MnBDBP+SQ2IqJxUxKgOXED0l4Ck+fTV
         pFHq0cbE4xxIp1fjdxPgcfxQSgdQYWyK3sAK7WdQz6iLwo19Qub7VTC2ziOjtGxCfU4u
         aABg==
X-Gm-Message-State: AOAM530b1ffd9fpJVmD2x9Kt8ODVA294CqDfVGdSgMWzdzrhNgOBultK
        qPlLTR9utJahtS2d0uIohZ4kW3jW+OxMRA==
X-Google-Smtp-Source: ABdhPJwpLN+CzfcKC0RpG9YvyGuPfMfFYBc1t+jbBgzRtR+fyktl4S1MqY36VNJtzXR3RFHjHy5Xmw==
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr12989668wme.55.1641603352779;
        Fri, 07 Jan 2022 16:55:52 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id c18sm238853wrn.81.2022.01.07.16.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 16:55:52 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: r8188eu: convert DBG_88E calls in os_dep/xmit_linux.c
Date:   Sat,  8 Jan 2022 00:55:47 +0000
Message-Id: <20220108005550.26264-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108005550.26264-1-phil@philpotter.co.uk>
References: <20220108005550.26264-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert three DBG_88E macro calls in core/rtw_ap.c to use netdev_dbg
as their information may be useful to observers, and this gets the
driver closer to the point of being able to remove DBG_88E itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/xmit_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 088c294f2586..7287897b3f65 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -79,7 +79,7 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!pxmitbuf->pxmit_urb[i]) {
-			DBG_88E("pxmitbuf->pxmit_urb[i]==NULL");
+			netdev_dbg(padapter->pnetdev, "pxmitbuf->pxmit_urb[i]==NULL");
 			return _FAIL;
 		}
 	}
@@ -188,14 +188,14 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 			memcpy(newskb->data, psta->hwaddr, 6);
 			res = rtw_xmit(padapter, &newskb);
 			if (res < 0) {
-				DBG_88E("%s()-%d: rtw_xmit() return error!\n", __func__, __LINE__);
+				netdev_dbg(padapter->pnetdev, "rtw_xmit() return error!\n");
 				pxmitpriv->tx_drop++;
 				dev_kfree_skb_any(newskb);
 			} else {
 				pxmitpriv->tx_pkts++;
 			}
 		} else {
-			DBG_88E("%s-%d: skb_copy() failed!\n", __func__, __LINE__);
+			netdev_dbg(padapter->pnetdev, "skb_copy() failed!\n");
 			pxmitpriv->tx_drop++;
 
 			spin_unlock_bh(&pstapriv->asoc_list_lock);
-- 
2.33.1

