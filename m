Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C6D4B3654
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiBLQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:18:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbiBLQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:17:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC52240A6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:17:54 -0800 (PST)
Received: from dslb-188-097-215-215.188.097.pools.vodafone-ip.de ([188.97.215.215] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nIv5q-0007YM-J3; Sat, 12 Feb 2022 17:17:50 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/10] staging: r8188eu: limit rtw_dbg_port to path a
Date:   Sat, 12 Feb 2022 17:17:34 +0100
Message-Id: <20220212161737.381841-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220212161737.381841-1-martin@kaiser.cx>
References: <20220212161737.381841-1-martin@kaiser.cx>
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

Rf registers can be read by rtw_wx_read_rf or via the private ioctl 0x0B.
The latter calls rtw_dbg_port. Limit rf register reads to path a in
rtw_debug_port.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 30fdc8afcffe..4b3134aef917 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3621,7 +3621,11 @@ static int rtw_dbg_port(struct net_device *dev,
 		DBG_88E("write_bbreg(0x%x) = 0x%x\n", arg, rtl8188e_PHY_QueryBBReg(padapter, arg, 0xffffffff));
 		break;
 	case 0x74:/* read_rf */
-		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtl8188e_PHY_QueryRFReg(padapter, minor_cmd, arg, 0xffffffff));
+		if (minor_cmd != RF_PATH_A) {
+			ret = -EINVAL;
+			break;
+		}
+		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", RF_PATH_A, arg, rtl8188e_PHY_QueryRFReg(padapter, RF_PATH_A, arg, 0xffffffff));
 		break;
 	case 0x75:/* write_rf */
 		if (minor_cmd != RF_PATH_A) {
-- 
2.30.2

