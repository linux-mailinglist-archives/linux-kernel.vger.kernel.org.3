Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362D447F900
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhLZVZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhLZVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:25:53 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED32FC061757
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:25:52 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1b1Y-0000qQ-TA; Sun, 26 Dec 2021 22:25:48 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/10] staging: r8188eu: remove private ioctls that return -1
Date:   Sun, 26 Dec 2021 22:25:30 +0100
Message-Id: <20211226212535.197989-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226212535.197989-1-martin@kaiser.cx>
References: <20211226212535.197989-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the private ioctls that are mapped to rtw_wx_priv_null.
rtw_wx_priv_null itself can also be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index b1f4f5ae71c1..db88a78b1c87 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2090,12 +2090,6 @@ static int rtw_wx_write_rf(struct net_device *dev,
 	return 0;
 }
 
-static int rtw_wx_priv_null(struct net_device *dev, struct iw_request_info *a,
-		 union iwreq_data *wrqu, char *b)
-{
-	return -1;
-}
-
 static int rtw_wx_set_channel_plan(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
@@ -4385,9 +4379,9 @@ NULL,					/* 0x03 */
 	rtw_tdls_get,			/* 0x15 */
 
 	rtw_pm_set,			/* 0x16 */
-	rtw_wx_priv_null,		/* 0x17 */
+	NULL,				/* 0x17 */
 	rtw_rereg_nd_name,		/* 0x18 */
-	rtw_wx_priv_null,		/* 0x19 */
+	NULL,				/* 0x19 */
 
 	NULL,				/* 0x1A */
 	NULL,				/* 0x1B */
-- 
2.30.2

