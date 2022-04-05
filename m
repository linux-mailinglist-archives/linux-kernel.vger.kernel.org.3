Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623104F222D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiDEErS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiDEErC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:47:02 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37939BC8C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649133800;
        bh=ZOWmbRSE1ugYDN4B9+8FobQREdvXAlF1kKgzI2u7cr0=;
        h=From:To:Cc:Subject:Date;
        b=ZbZyLf6a/g/c+/dbQggekZHwx50vB+fCtgVEcg0tBRKsuB8w5ADhLr22TalAcQFXX
         dDX1LbLR4fUs2+LrgUBUv04ijUfMa7ZLrKXbpnUxjVmashhWW3bvgNq4LfBKTMbtNw
         9QlEw7n2MxDwe2P/zd8ifRwd8S54HDzXt4lapJxc=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id AD187C0F; Tue, 05 Apr 2022 12:43:17 +0800
X-QQ-mid: xmsmtpt1649133797tybode3xr
Message-ID: <tencent_B8048C592777830380A23A7C4409F9DF1305@qq.com>
X-QQ-XMAILINFO: Nci1v0XuD9lF/UxJPIUnSOW35WJxhNHJ9+ASszE4sLfv8CucVVmCZNiogRzfLA
         FCueO2kxVwfgM/NnbjiZK+E+XJyJhRwuiBT8F7HDdKMjyH1CChIvlR3Axc1C++TAdWn+UWOmvfmv
         uF94lvzfEtFV2S7zeuitxu28ku6Rhf/8skdeop9GbjdNtA7sVq9waWY1hedDYT6vinVAYaBc7Hns
         2c2s3WvD2IPVB2J7qiF0HgGLj2nrIBqKGXlZUcXB+0pVBLoi1PWnrQj/bYQdEBQ0+IvgZqT/eFzx
         hVuIGMhpi3r8Dj00Cccbdnc8xEqSNLbG0aYf0udQT4bS0kqVB1D7uR12PM/WeD4LeFzYwUIUzib2
         Tes/qKEpqWiSFbtvV4VFXbK/RwdlCGsJ37J2tQ1PEKDK/WPOfpnLKKlUyBmFFH/8B9xwzy+0zJvw
         DThKCloCsmnsTdDQGW1mvMhsVM0ITDHUgxlg170tsxA5uDrllGT9EvtZuL3N+FpwNEYTOacQiiIt
         qear8mS+d6Q/F1TlpQ0D5ZgKgIi2zC+ZGT+chKu4HliSbEFDdP1fBBjI+f6iXgyCZljBzhSmjKH/
         rRtchvP3GuTO7Mj2sWuxPWMSf79IjRGxWfloPEKsukVhfhnTi+NwdRExQ/XGsFE+E64wnPp+xQ/C
         SNTRB7YGA8bxyoQknrdgj7WaY4Qp8WLdDuUXwsxUEzuUhtapC/8amBQLRVtxRAlpEHbq15ZqiM1f
         vEi2c/qQmKPVG7r3r+worYmPOIBbZpdhK5lDk6Q6OcCKh5zjT4HDNmkQdLBmvWUgW5cT24aWrZDR
         NE9VYuUcR5NE7S29TrUaz4TgTxe+xYejUQuiqixb2aEb3VjNAzW0WrqcomdjVahPMIw1U/3e33OB
         gXjGbaibi/DfSQx6fyavUq1DanypyU8DEcmMAHMGxqc0wvClVp9m0/OZQqX5iQ4yccM97e2bWcDs
         ipOKQzFdRCBjEYXM7avw==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: rtl8712: fix a potential memory leak in r871xu_drv_init()
Date:   Tue,  5 Apr 2022 12:43:07 +0800
X-OQ-MSGID: <20220405044307.11297-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In r871xu_drv_init(), if r8712_init_drv_sw() fails, then the memory
allocated by r8712_alloc_io_queue() in r8712_usb_dvobj_init() is not
properly released as there is no action will be performed by
r8712_usb_dvobj_deinit().
To properly release it, we should call r8712_free_io_queue() in
r8712_usb_dvobj_deinit().

Besides, in r871xu_dev_remove(), r8712_usb_dvobj_deinit() will be called
by r871x_dev_unload() under condition `padapter->bup` and
r8712_free_io_queue() is called by r8712_free_drv_sw().
However, r8712_usb_dvobj_deinit() does not rely on `padapter->bup` and
calling r8712_free_io_queue() in r8712_free_drv_sw() is negative for
better understading the code.
So I move r8712_usb_dvobj_deinit() into r871xu_dev_remove(), and remove
r8712_free_io_queue() from r8712_free_drv_sw().

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/rtl8712/os_intfs.c | 1 -
 drivers/staging/rtl8712/usb_intf.c | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 28b1684..220fed5 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -348,7 +348,6 @@ void r8712_free_drv_sw(struct _adapter *padapter)
 	r8712_free_evt_priv(&padapter->evtpriv);
 	r8712_DeInitSwLeds(padapter);
 	r8712_free_mlme_priv(&padapter->mlmepriv);
-	r8712_free_io_queue(padapter);
 	_free_xmit_priv(&padapter->xmitpriv);
 	_r8712_free_sta_priv(&padapter->stapriv);
 	_r8712_free_recv_priv(&padapter->recvpriv);
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 8df50e2..8cbd419 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -265,6 +265,7 @@ static uint r8712_usb_dvobj_init(struct _adapter *padapter)
 
 static void r8712_usb_dvobj_deinit(struct _adapter *padapter)
 {
+	r8712_free_io_queue(padapter);
 }
 
 void rtl871x_intf_stop(struct _adapter *padapter)
@@ -302,9 +303,6 @@ void r871x_dev_unload(struct _adapter *padapter)
 			rtl8712_hal_deinit(padapter);
 		}
 
-		/*s6.*/
-		if (padapter->dvobj_deinit)
-			padapter->dvobj_deinit(padapter);
 		padapter->bup = false;
 	}
 }
@@ -607,6 +605,8 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 	/* Stop driver mlme relation timer */
 	r8712_stop_drv_timers(padapter);
 	r871x_dev_unload(padapter);
+	if (padapter->dvobj_deinit)
+		padapter->dvobj_deinit(padapter);
 	r8712_free_drv_sw(padapter);
 	free_netdev(pnetdev);
 
-- 
