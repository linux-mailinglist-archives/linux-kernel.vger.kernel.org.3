Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931A547F8FE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhLZVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhLZVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:25:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA4DC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:25:51 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1b1X-0000qQ-AZ; Sun, 26 Dec 2021 22:25:47 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/10] staging: r8188eu: remove the private drvext_hdl ioctl
Date:   Sun, 26 Dec 2021 22:25:28 +0100
Message-Id: <20211226212535.197989-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226212535.197989-1-martin@kaiser.cx>
References: <20211226212535.197989-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the private drvext_hdl ioctl, it is mapped to an empty function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index bc23754c7f5c..761511bbb0ad 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2126,16 +2126,6 @@ static int rtw_wx_set_mtk_wps_ie(struct net_device *dev,
 	return 0;
 }
 
-/*
- *	For all data larger than 16 octets, we need to use a
- *	pointer to memory allocated in user space.
- */
-static  int rtw_drvext_hdl(struct net_device *dev, struct iw_request_info *info,
-						union iwreq_data *wrqu, char *extra)
-{
-	return 0;
-}
-
 static int rtw_get_ap_info(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
@@ -4376,7 +4366,7 @@ static const struct iw_priv_args rtw_private_args[] = {
 static iw_handler rtw_private_handler[] = {
 rtw_wx_write32,				/* 0x00 */
 rtw_wx_read32,				/* 0x01 */
-rtw_drvext_hdl,				/* 0x02 */
+	NULL,				/* 0x02 */
 NULL,					/* 0x03 */
 /*  for MM DTV platform */
 	rtw_get_ap_info,		/* 0x04 */
-- 
2.30.2

