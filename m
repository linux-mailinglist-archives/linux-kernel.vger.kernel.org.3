Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632964F10CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353719AbiDDIX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348387AbiDDIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:23:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4AC3B3F5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:21:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id yy13so18274459ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwsH1XHMhYpHAHuQYTzJcbJHbl5Y3E62Se4odAiOvro=;
        b=hcw7OiTZegjMnjMYOc3Mf29TNrKx3WvEthqQm+u5PwM2QoI6gw3bDB7EgjauRW9bXp
         5E7SGUiqsm/80TQPDyWKtMPvaO1pNHMR8j/vUADxtlbRGe8jc4X5//LEq/qL6myYrbVH
         vbaGsw9uKaaDGN0tM0YrXnxEFr/OdBrq9yyxVn9DgZyZGmbEyFo3SVBPHb+nFzuOdANi
         1eW9yHCMqawuSShT09VcCegPYwGbkNTDxA+DcjCPY+Z0WG9CsR/RBc7uXQjM2BjW07Fp
         AnBJP8plRqwr8wNiXG5xnkvYtJG8jE1kqrQsIaJhXdg2XzkxZGk6v+0/08ptfdz3Qxms
         YUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwsH1XHMhYpHAHuQYTzJcbJHbl5Y3E62Se4odAiOvro=;
        b=DzJegehb9uefLcoYM+AG9d1Mx1qM949ba7CodNoLTx4QPrPmifinuwLE0usqlGSLZ0
         FsVZTPoW0hHdkmLssAcPzZKzgmqTr2X2zgRAWdSlfRc76VA3+HtRCnRdrJk8YMQMMZHK
         JEB4qeqOGfSkII8NNlROoFusuc4x/43yd40mpqoqbDwxe7milqV8pwiY63UaF6YKvchc
         rR6zLVcrmYyfVHi3OgILq/wfr7jDU4/bTja4NNJgsSuhdKr7dNxCLQv8GFZuJLRbVPEV
         lybavkDfpznSYalO/XiOjVPQjPmd2TDSYeGV4vxmQfUs6eCOJBdoPSk2RqvfjNPwTGnN
         lbew==
X-Gm-Message-State: AOAM533mzN2lVv38GK2iaM6y/o7koMfMdc5FuQE+iMimwXc3K9OSDn8M
        W8SM2zrl8qVMOz8IqiTqQr8=
X-Google-Smtp-Source: ABdhPJwzrg6vSJfu2vqfp9sme37FQrq1ZQPDetPp5e6ytHFpurajaA91xJ/Srr+MycaqokQkem0SGg==
X-Received: by 2002:a17:907:6da1:b0:6e7:efbe:d217 with SMTP id sb33-20020a1709076da100b006e7efbed217mr3381401ejc.119.1649060508614;
        Mon, 04 Apr 2022 01:21:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm4047336ejh.204.2022.04.04.01.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:21:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: pnp_bstop_trx is never set
Date:   Mon,  4 Apr 2022 10:21:40 +0200
Message-Id: <20220404082142.4639-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404082142.4639-1-straube.linux@gmail.com>
References: <20220404082142.4639-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field pnp_bstop_trx in struct pwrctrl_priv is never set. It stays
at its default value 0. Remove it and remove related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c    | 7 +++----
 drivers/staging/r8188eu/include/rtw_pwrctrl.h  | 1 -
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index e5d6cd6228f2..6a65dcf57112 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -16,7 +16,7 @@ static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 	int status;
 	u8 io_buf[4];
 
-	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
+	if (adapt->bSurpriseRemoved)
 		return -EPERM;
 
 	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
@@ -59,7 +59,7 @@ static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
 	int status;
 	u8 io_buf[VENDOR_CMD_MAX_DATA_LEN];
 
-	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
+	if (adapt->bSurpriseRemoved)
 		return -EPERM;
 
 	memcpy(io_buf, data, size);
@@ -414,8 +414,7 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 	size_t alignment = 0;
 	u32 ret = _SUCCESS;
 
-	if (adapter->bDriverStopped || adapter->bSurpriseRemoved ||
-	    adapter->pwrctrlpriv.pnp_bstop_trx)
+	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return _FAIL;
 
 	if (!precvbuf)
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 3efcc65b2f6e..94a65056a77e 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -64,7 +64,6 @@ struct pwrctrl_priv {
 	u8	power_mgnt;
 	u8	bFwCurrentInPSMode;
 	u32	DelayLPSLastTimeStamp;
-	u8		pnp_bstop_trx;
 
 	u8		bInSuspend;
 	u8		bSupportRemoteWakeup;
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index c4b6dbc8d66d..8ca16861bfcc 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -106,8 +106,7 @@ u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 	struct xmit_frame *pxmitframe = (struct xmit_frame *)pxmitbuf->priv_data;
 	struct usb_device *pusbd = pdvobj->pusbdev;
 
-	if ((padapter->bDriverStopped) || (padapter->bSurpriseRemoved) ||
-	    (padapter->pwrctrlpriv.pnp_bstop_trx)) {
+	if (padapter->bDriverStopped || padapter->bSurpriseRemoved) {
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_TX_DENY);
 		goto exit;
 	}
-- 
2.35.1

