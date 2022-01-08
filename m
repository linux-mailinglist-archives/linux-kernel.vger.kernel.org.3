Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB34883A5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiAHMut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiAHMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:27 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1834FC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:27 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAs-0005EJ-F3; Sat, 08 Jan 2022 13:50:22 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 12/12] staging: r8188eu: we always enqueue in rtw_set_chplan_cmd
Date:   Sat,  8 Jan 2022 13:49:59 +0100
Message-Id: <20220108124959.313215-13-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108124959.313215-1-martin@kaiser.cx>
References: <20220108124959.313215-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of rtw_set_chplan_cmd requests that the message be
enqueued and not sent directly.

Remove the enqueue parameter and the code for direct sending.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_cmd.c       | 26 +++++++-------------
 drivers/staging/r8188eu/include/rtw_cmd.h    |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  2 +-
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 712fd6e536c4..3d22a8888ea7 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -836,7 +836,7 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *padapter)
 	return res;
 }
 
-u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
+u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan)
 {
 	struct	cmd_obj *pcmdobj;
 	struct	SetChannelPlan_param *setChannelPlan_param;
@@ -859,25 +859,17 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 	}
 	setChannelPlan_param->channel_plan = chplan;
 
-	if (enqueue) {
-		/* need enqueue, prepare cmd_obj and enqueue */
-		pcmdobj = kzalloc(sizeof(struct	cmd_obj), GFP_KERNEL);
-		if (!pcmdobj) {
-			kfree(setChannelPlan_param);
-			res = _FAIL;
-			goto exit;
-		}
-
-		init_h2fwcmd_w_parm_no_rsp(pcmdobj, setChannelPlan_param, GEN_CMD_CODE(_SetChannelPlan));
-		res = rtw_enqueue_cmd(pcmdpriv, pcmdobj);
-	} else {
-		/* no need to enqueue, do the cmd hdl directly and free cmd parameter */
-		if (H2C_SUCCESS != set_chplan_hdl(padapter, (unsigned char *)setChannelPlan_param))
-			res = _FAIL;
-
+	/* need enqueue, prepare cmd_obj and enqueue */
+	pcmdobj = kzalloc(sizeof(struct	cmd_obj), GFP_KERNEL);
+	if (!pcmdobj) {
 		kfree(setChannelPlan_param);
+		res = _FAIL;
+		goto exit;
 	}
 
+	init_h2fwcmd_w_parm_no_rsp(pcmdobj, setChannelPlan_param, GEN_CMD_CODE(_SetChannelPlan));
+	res = rtw_enqueue_cmd(pcmdpriv, pcmdobj);
+
 	/* do something based on res... */
 	if (res == _SUCCESS)
 		padapter->mlmepriv.ChannelPlan = chplan;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index cf0945ae11c1..60cecdd4ee0e 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -772,7 +772,7 @@ u8 rtw_ps_cmd(struct adapter*padapter);
 
 u8 rtw_chk_hi_queue_cmd(struct adapter*padapter);
 
-u8 rtw_set_chplan_cmd(struct adapter*padapter, u8 chplan, u8 enqueue);
+u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan);
 
 u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 41b457838a5b..b9f9698d70cf 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2098,7 +2098,7 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 channel_plan_req = (u8)(*((int *)wrqu));
 
-	if (_SUCCESS == rtw_set_chplan_cmd(padapter, channel_plan_req, 1))
+	if (_SUCCESS == rtw_set_chplan_cmd(padapter, channel_plan_req))
 		DBG_88E("%s set channel_plan = 0x%02X\n", __func__, pmlmepriv->ChannelPlan);
 	else
 		return -EPERM;
-- 
2.30.2

