Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193664AB09F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbiBFQSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244706AbiBFQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:18:29 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ACDC043187
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:18:28 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGkF6-0001bS-D9; Sun, 06 Feb 2022 17:18:24 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/14] staging: r8188eu: remove the global DriverState
Date:   Sun,  6 Feb 2022 17:18:04 +0100
Message-Id: <20220206161809.423031-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206161809.423031-1-martin@kaiser.cx>
References: <20220206161809.423031-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DriverState in struct adapter is never set. It remains 0 (DRIVER_NORMAL)
all the time, DriverState != DRIVER_DISAPPEAR is always true.

Both DriverState and the check can be removed. enum driver_state contains
the possible values of DriverState. This enum can be removed as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/drv_types.h | 8 --------
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 8 +++-----
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index a07bcf0b6358..1260cacbae64 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -159,15 +159,7 @@ static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
 	return &dvobj->pusbintf->dev;
 };
 
-enum driver_state {
-	DRIVER_NORMAL = 0,
-	DRIVER_DISAPPEAR = 1,
-	DRIVER_REPLACE_DONGLE = 2,
-};
-
 struct adapter {
-	int	DriverState;/* for disable driver using module, use dongle toi
-			     * replace module. */
 	int	pid[3];/* process id from UI, 0:wps, 1:hostapd, 2:dhcpcd */
 	int	bDongle;/* build-in module or external dongle */
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 1a67486ff5fb..b20d0eca12fa 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -454,11 +454,9 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
 
 	free_mlme_ap_info(if1);
 
-	if (if1->DriverState != DRIVER_DISAPPEAR) {
-		if (pnetdev) {
-			/* will call netdev_close() */
-			unregister_netdev(pnetdev);
-		}
+	if (pnetdev) {
+		/* will call netdev_close() */
+		unregister_netdev(pnetdev);
 	}
 	rtw_cancel_all_timer(if1);
 
-- 
2.30.2

