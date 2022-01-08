Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2B488034
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiAHA4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiAHAz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:55:56 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E95C061747
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:55:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so3736707wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 16:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hx9acdXZrHH5WrEhXGyj7+f46x8W+jthxlPUPFgwmdA=;
        b=NazZP+1WN4fOzaHsJ58tz0viTo/FlUhGS6Tc6z1HT6/H+FVuZJODIq/ieurYVxogP4
         cF0wNmD4iEEgAagUgLy4e4ZnUEfAS9zX8upeFfoSiilLGWP1RW8pN0i8CeUM+DQrkRk7
         nW2uZ5EjT2EifoBzykJ5xP7Qjah8QBC5fR4ZwDhA7E0dJ9hE9NcdLZcfptnQIbLwOnKC
         HgS+UUg8dNnXneEm6n378kHKaIoHNKRLx2ME9MJ7ypHXFKlntSvJBmR4+Ct+8CG3bV0k
         Bxmp0hSA1qwK5+gKR6iGKJskLupf0ETqhvLWk1k4T82/c0yB2EMcGYKdHdU+apAcAXfs
         YK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hx9acdXZrHH5WrEhXGyj7+f46x8W+jthxlPUPFgwmdA=;
        b=hXn5BVzU+NUlpamifVufVW/X9o2s9nIfbHENFiqU59bvuz5dfNjV0QWOUX7P1wS2zM
         fnIaQzhG3GpgfVgbvKzmG9JBRXPyEG9+jDUrke3nKwMEt7ltOWFFRJb6pBtSSIOD7LUC
         6/m2xlSmjiNA778mYiPhe95EfH+r/fDyvTgvBV9Xp+7konen830MY2tP1K2bjEhlZm9g
         KBEDm9XP0kSWAa2MXAjqAkbXbgZfUd7nDRLw+WK6XdB1Mh39VikYQo25AWfb42nHpkvO
         /lSeN5Jjyxr5z+X/+33JlTBtctKM5QV5//n1c94hk/mjNnbYrMNHtcs134owbFaiQgeM
         KxAg==
X-Gm-Message-State: AOAM531fqrXW7ovLQrqgOkL36T/FaVm/GyfVv/oKYFFMCwrlRVGj+Mst
        VzFOXv0jG645ROVZMg9lzEY5yA==
X-Google-Smtp-Source: ABdhPJxuzbWpuwtH/naH3oZqYAsR/BlcwGg+trqccxjemAKPgZC/QM4bAZCM5uurIIOaiBZUWf0WEQ==
X-Received: by 2002:a05:600c:600a:: with SMTP id az10mr12771504wmb.69.1641603354892;
        Fri, 07 Jan 2022 16:55:54 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id c18sm238853wrn.81.2022.01.07.16.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 16:55:54 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: r8188eu: convert/remove DBG_88E calls in os_dep/usb_ops_linux.c
Date:   Sat,  8 Jan 2022 00:55:50 +0000
Message-Id: <20220108005550.26264-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108005550.26264-1-phil@philpotter.co.uk>
References: <20220108005550.26264-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert DBG_88E macro calls in os_dep/usb_ops_linux.c to use netdev_dbg
when they may display useful information, and remove erroneous DBG_88E
calls entirely.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/r8188eu/os_dep/usb_ops_linux.c    | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index d1cb33d3e6a7..3977a717d30a 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -32,8 +32,6 @@ void rtw_read_port_cancel(struct adapter *padapter)
 	int i;
 	struct recv_buf *precvbuf = (struct recv_buf *)padapter->recvpriv.precv_buf;
 
-	DBG_88E("%s\n", __func__);
-
 	padapter->bReadPortCancel = true;
 
 	for (i = 0; i < NR_RECVBUFF; i++) {
@@ -72,30 +70,32 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
 	    padapter->bWritePortCancel) {
-		DBG_88E("%s(): TX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bWritePortCancel(%d) pxmitbuf->ext_tag(%x)\n",
-			__func__, padapter->bDriverStopped,
-			padapter->bSurpriseRemoved, padapter->bReadPortCancel,
-			pxmitbuf->ext_tag);
+		netdev_dbg(padapter->pnetdev,
+			   "TX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d)\n",
+			   padapter->bDriverStopped, padapter->bSurpriseRemoved);
+		netdev_dbg(padapter->pnetdev,
+			   "TX Warning! bWritePortCancel(%d) pxmitbuf->ext_tag(%x)\n",
+			   padapter->bReadPortCancel, pxmitbuf->ext_tag);
 
 		goto check_completion;
 	}
 
 	if (purb->status) {
-		DBG_88E("###=> urb_write_port_complete status(%d)\n", purb->status);
+		netdev_dbg(padapter->pnetdev, "status(%d)\n", purb->status);
 		if (purb->status == -EINPROGRESS) {
 			goto check_completion;
 		} else if (purb->status == -ENOENT) {
-			DBG_88E("%s: -ENOENT\n", __func__);
+			netdev_dbg(padapter->pnetdev, "-ENOENT\n");
 			goto check_completion;
 		} else if (purb->status == -ECONNRESET) {
-			DBG_88E("%s: -ECONNRESET\n", __func__);
+			netdev_dbg(padapter->pnetdev, "-ECONNRESET\n");
 			goto check_completion;
 		} else if (purb->status == -ESHUTDOWN) {
 			padapter->bDriverStopped = true;
 			goto check_completion;
 		} else if ((purb->status != -EPIPE) && (purb->status != -EPROTO)) {
 			padapter->bSurpriseRemoved = true;
-			DBG_88E("bSurpriseRemoved = true\n");
+			netdev_dbg(padapter->pnetdev, "bSurpriseRemoved = true\n");
 
 			goto check_completion;
 		}
@@ -174,7 +174,7 @@ u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 	status = usb_submit_urb(purb, GFP_ATOMIC);
 	if (status) {
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_WRITE_PORT_ERR);
-		DBG_88E("usb_write_port, status =%d\n", status);
+		netdev_dbg(padapter->pnetdev, "usb_write_port, status = %d\n", status);
 
 		switch (status) {
 		case -ENODEV:
@@ -202,8 +202,6 @@ void rtw_write_port_cancel(struct adapter *padapter)
 	int i, j;
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmitbuf;
 
-	DBG_88E("%s\n", __func__);
-
 	padapter->bWritePortCancel = true;
 
 	for (i = 0; i < NR_XMITBUFF; i++) {
-- 
2.33.1

