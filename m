Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835CC49AB42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356621AbiAYErR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S247428AbiAYDv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:51:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E7C0E5328
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a13so16368739wrh.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjZ8PLVnXqnno9kir5dp5L6WIttIawNZBxOaOCf6Vj0=;
        b=EuZVItfR0P+66kfbyVI3/k/FcfnQUx/aAU8zxh8rJUlZZdU9O73kwNGxAjVDlP2Q/b
         ZR6kdiaLinS4B/gt+8Q6zfwF60WpValrxquIH0K98cEq6iqvw6QzBf4P1Ph6C6NzYg1r
         KmyNbPSfGt47impg2fS5dRN2YLVO/8am0VZHlVvmc3jooSGnHFV4ELAc+FTB+fUyEach
         AGe5EvTLormzy/B6YXJSHvSTxQJC6CLsPkb7fjl6ajBUGa7FnraaPG1zB4Vav5qw2y/2
         XT58FDMOR74f456MBxWVnGMKY+65CBuZllj61e7g8xD9qPPXvWWOy62i8hH3ZvjjaXD+
         E3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjZ8PLVnXqnno9kir5dp5L6WIttIawNZBxOaOCf6Vj0=;
        b=ZYybWfCBV7VNnoVUFW4CSNntAX6/qAo0jc3l7lCK6o8G61Zh36EFkfaRmEywi6GTXf
         79UWtj5182K1u+xMmodLAFF4Zz6uUUmq5TitgNnpGMQNhRQzOUvDJBPIiwUwXbwZAqdV
         9ZZUtN/JyXVs4TEhg4PcubJYlr93u9ap0EaYr/mkYmSKx8mDTyD2ynOHE/ZvCsTG5Xq3
         iSxpt9u0ER9SGmImSdPTw0X3PGoo8ghLQoNenOMRQV2I1Lq1Znda/g3MdZw+UssWVnow
         fxJEW0NHL6OVCt2VtIfSt0Kn8UCnZWM25ZLhVbZYWJHgtKUlwmx1ynoL3SM1XHjxNlHb
         FoVA==
X-Gm-Message-State: AOAM531kLmhfchfowE16cIxR7A+pQHyyus5sFQ5RsWn9RBZ7izhtx3QE
        ndwPd1dOB4hV6WueCfj7VAj1mQ==
X-Google-Smtp-Source: ABdhPJyI7wgL0T/Crgicq789t5pOVqqKb9t0jl49lPsMB5LceBuD2s7Kd5FsLxecYPCDb9pYqciOEg==
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr3234394wri.589.1643064272200;
        Mon, 24 Jan 2022 14:44:32 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id i3sm15010613wru.33.2022.01.24.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:44:31 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 05/10] staging: r8188eu: remove smaller sets of DBG_88E calls from os_dep dir
Date:   Mon, 24 Jan 2022 22:44:10 +0000
Message-Id: <20220124224415.831-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124224415.831-1-phil@philpotter.co.uk>
References: <20220124224415.831-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from the os_dep directory, other than those in
os_dep/ioctl_linux.c, as this contains almost 200 on its own so will be
done in a separate patch for ease of review. These calls do not conform
to kernel coding standards and are superfluous. Also restructure where
appropriate to remove no longer needed code left behind by removal of
these calls. This will allow the eventual removal of the DBG_88E macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |  4 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 33 +-------
 .../staging/r8188eu/os_dep/osdep_service.c    |  2 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 84 ++-----------------
 .../staging/r8188eu/os_dep/usb_ops_linux.c    | 18 +---
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |  6 +-
 6 files changed, 14 insertions(+), 133 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index f7ce724ebf87..72ad9700130e 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -181,8 +181,6 @@ void rtw_indicate_sta_assoc_event(struct adapter *padapter, struct sta_info *pst
 
 	memcpy(wrqu.addr.sa_data, psta->hwaddr, ETH_ALEN);
 
-	DBG_88E("+rtw_indicate_sta_assoc_event\n");
-
 	wireless_send_event(padapter->pnetdev, IWEVREGISTERED, &wrqu, NULL);
 }
 
@@ -204,7 +202,5 @@ void rtw_indicate_sta_disassoc_event(struct adapter *padapter, struct sta_info *
 
 	memcpy(wrqu.addr.sa_data, psta->hwaddr, ETH_ALEN);
 
-	DBG_88E("+rtw_indicate_sta_disassoc_event\n");
-
 	wireless_send_event(padapter->pnetdev, IWEVEXPIRED, &wrqu, NULL);
 }
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index b65e44f97826..17249b4fb7ad 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -362,7 +362,6 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	pnetdev->dev.type = &wlan_type;
 	padapter = rtw_netdev_priv(pnetdev);
 	padapter->pnetdev = pnetdev;
-	DBG_88E("register rtw_netdev_ops to netdev_ops\n");
 	pnetdev->netdev_ops = &rtw_netdev_ops;
 	pnetdev->watchdog_timeo = HZ * 3; /* 3 second timeout */
 	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
@@ -492,20 +491,14 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	if (init_mlme_ext_priv(padapter) == _FAIL)
 		return _FAIL;
 
-	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
-		DBG_88E("Can't _rtw_init_xmit_priv\n");
+	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL)
 		return _FAIL;
-	}
 
-	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
-		DBG_88E("Can't _rtw_init_recv_priv\n");
+	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL)
 		return _FAIL;
-	}
 
-	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
-		DBG_88E("Can't _rtw_init_sta_priv\n");
+	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL)
 		return _FAIL;
-	}
 
 	padapter->stapriv.padapter = padapter;
 
@@ -611,8 +604,6 @@ int _netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
-	DBG_88E("+88eu_drv - drv_open, bup =%d\n", padapter->bup);
-
 	if (pwrctrlpriv->ps_flag) {
 		padapter->net_closed = false;
 		goto netdev_open_normal_process;
@@ -661,14 +652,12 @@ int _netdev_open(struct net_device *pnetdev)
 	netdev_br_init(pnetdev);
 
 netdev_open_normal_process:
-	DBG_88E("-88eu_drv - drv_open, bup =%d\n", padapter->bup);
 	return 0;
 
 netdev_open_error:
 	padapter->bup = false;
 	netif_carrier_off(pnetdev);
 	rtw_netif_stop_queue(pnetdev);
-	DBG_88E("-88eu_drv - drv_open fail, bup =%d\n", padapter->bup);
 	return -1;
 }
 
@@ -687,7 +676,6 @@ static int  ips_netdrv_open(struct adapter *padapter)
 {
 	int status = _SUCCESS;
 	padapter->net_closed = false;
-	DBG_88E("===> %s.........\n", __func__);
 
 	padapter->bDriverStopped = false;
 	padapter->bSurpriseRemoved = false;
@@ -706,31 +694,23 @@ static int  ips_netdrv_open(struct adapter *padapter)
 	return _SUCCESS;
 
 netdev_open_error:
-	DBG_88E("-ips_netdrv_open - drv_open failure, bup =%d\n", padapter->bup);
-
 	return _FAIL;
 }
 
 int rtw_ips_pwr_up(struct adapter *padapter)
 {
 	int result;
-	u32 start_time = jiffies;
-	DBG_88E("===>  rtw_ips_pwr_up..............\n");
 	rtw_reset_drv_sw(padapter);
 
 	result = ips_netdrv_open(padapter);
 
 	rtw_led_control(padapter, LED_CTL_NO_LINK);
 
-	DBG_88E("<===  rtw_ips_pwr_up.............. in %dms\n", rtw_get_passing_time_ms(start_time));
 	return result;
 }
 
 void rtw_ips_pwr_down(struct adapter *padapter)
 {
-	u32 start_time = jiffies;
-	DBG_88E("===> rtw_ips_pwr_down...................\n");
-
 	padapter->bCardDisableWOHSM = true;
 	padapter->net_closed = true;
 
@@ -738,13 +718,10 @@ void rtw_ips_pwr_down(struct adapter *padapter)
 
 	rtw_ips_dev_unload(padapter);
 	padapter->bCardDisableWOHSM = false;
-	DBG_88E("<=== rtw_ips_pwr_down..................... in %dms\n", rtw_get_passing_time_ms(start_time));
 }
 
 void rtw_ips_dev_unload(struct adapter *padapter)
 {
-	DBG_88E("====> %s...\n", __func__);
-
 	SetHwReg8188EU(padapter, HW_VAR_FIFO_CLEARN_UP, NULL);
 
 	if (padapter->intf_stop)
@@ -763,9 +740,6 @@ int netdev_close(struct net_device *pnetdev)
 	padapter->net_closed = true;
 
 	if (padapter->pwrctrlpriv.rf_pwrstate == rf_on) {
-		DBG_88E("(2)88eu_drv - drv_close, bup =%d, hw_init_completed =%d\n",
-			padapter->bup, padapter->hw_init_completed);
-
 		/* s1. */
 		if (pnetdev) {
 			if (!rtw_netif_queue_stopped(pnetdev))
@@ -792,6 +766,5 @@ int netdev_close(struct net_device *pnetdev)
 	kfree(dvobj->firmware.szFwBuffer);
 	dvobj->firmware.szFwBuffer = NULL;
 
-	DBG_88E("-88eu_drv - drv_close, bup =%d\n", padapter->bup);
 	return 0;
 }
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 59bdd0abea7e..7a6fcc96081a 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -236,8 +236,6 @@ void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 	if (rtw_cbuf_empty(cbuf))
 		return NULL;
 
-	if (0)
-		DBG_88E("%s on %u\n", __func__, cbuf->read);
 	buf = cbuf->bufs[cbuf->read];
 	cbuf->read = (cbuf->read + 1) % cbuf->size;
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 91792dfd3bbe..adb46c353cf8 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -117,13 +117,10 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 	if (rt_num_in_pipes != 1)
 		goto err;
 
-	if (pusbd->speed == USB_SPEED_HIGH) {
+	if (pusbd->speed == USB_SPEED_HIGH)
 		pdvobjpriv->ishighspeed = true;
-		DBG_88E("USB_SPEED_HIGH\n");
-	} else {
+	else
 		pdvobjpriv->ishighspeed = false;
-		DBG_88E("NON USB_SPEED_HIGH\n");
-	}
 
 	/* 3 misc */
 	sema_init(&pdvobjpriv->usb_suspend_sema, 0);
@@ -148,15 +145,13 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 		    dvobj->NumInterfaces != 3) ||
 	    (dvobj->InterfaceNumber == 1)) {
 			if (interface_to_usbdev(usb_intf)->state !=
-			    USB_STATE_NOTATTACHED) {
+			    USB_STATE_NOTATTACHED)
 				/* If we didn't unplug usb dongle and
 				 * remove/insert module, driver fails
 				 * on sitesurvey for the first time when
 				 * device is up . Reset usb port for sitesurvey
 				 * fail issue. */
-				DBG_88E("usb attached..., try to reset usb device\n");
 				usb_reset_device(interface_to_usbdev(usb_intf));
-			}
 		}
 		kfree(dvobj);
 	}
@@ -184,7 +179,6 @@ static void usb_intf_stop(struct adapter *padapter)
 static void rtw_dev_unload(struct adapter *padapter)
 {
 	if (padapter->bup) {
-		DBG_88E("===> rtw_dev_unload\n");
 		padapter->bDriverStopped = true;
 		if (padapter->xmitpriv.ack_tx)
 			rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_DRV_STOP);
@@ -202,8 +196,6 @@ static void rtw_dev_unload(struct adapter *padapter)
 
 		padapter->bup = false;
 	}
-
-	DBG_88E("<=== rtw_dev_unload\n");
 }
 
 static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
@@ -215,18 +207,10 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
 	int ret = 0;
-	u32 start_time = jiffies;
-
-
-	DBG_88E("==> %s (%s:%d)\n", __func__, current->comm, current->pid);
 
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
-	    (padapter->bSurpriseRemoved)) {
-		DBG_88E("padapter->bup=%d bDriverStopped=%d bSurpriseRemoved = %d\n",
-			padapter->bup, padapter->bDriverStopped,
-			padapter->bSurpriseRemoved);
+	    (padapter->bSurpriseRemoved))
 		goto exit;
-	}
 
 	pwrpriv->bInSuspend = true;
 	rtw_cancel_all_timer(padapter);
@@ -243,16 +227,9 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	rtw_disassoc_cmd(padapter, 0, false);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
-	    check_fwstate(pmlmepriv, _FW_LINKED)) {
-		DBG_88E("%s:%d %s(%pM), length:%d assoc_ssid.length:%d\n",
-			__func__, __LINE__,
-			pmlmepriv->cur_network.network.Ssid.Ssid,
-			pmlmepriv->cur_network.network.MacAddress,
-			pmlmepriv->cur_network.network.Ssid.SsidLength,
-			pmlmepriv->assoc_ssid.SsidLength);
-
+	    check_fwstate(pmlmepriv, _FW_LINKED))
 		pmlmepriv->to_roaming = 1;
-	}
+
 	/* s2-2.  indicate disconnect to os */
 	rtw_indicate_disconnect(padapter);
 	/* s2-3. */
@@ -270,9 +247,6 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 		rtw_indicate_disconnect(padapter);
 
 exit:
-	DBG_88E("<===  %s return %d.............. in %dms\n", __func__
-		, ret, rtw_get_passing_time_ms(start_time));
-
 		return ret;
 }
 
@@ -283,9 +257,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	struct net_device *pnetdev;
 	struct pwrctrl_priv *pwrpriv = NULL;
 	int ret = -1;
-	u32 start_time = jiffies;
-
-	DBG_88E("==> %s (%s:%d)\n", __func__, current->comm, current->pid);
 
 	pnetdev = padapter->pnetdev;
 	pwrpriv = &padapter->pwrctrlpriv;
@@ -295,7 +266,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	if (pwrpriv)
 		pwrpriv->bkeepfwalive = false;
 
-	DBG_88E("bkeepfwalive(%x)\n", pwrpriv->bkeepfwalive);
 	if (netdev_open(pnetdev) != 0) {
 		mutex_unlock(&pwrpriv->lock);
 		goto exit;
@@ -306,10 +276,8 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 
 	mutex_unlock(&pwrpriv->lock);
 
-	if (padapter->pid[1] != 0) {
-		DBG_88E("pid[1]:%d\n", padapter->pid[1]);
+	if (padapter->pid[1] != 0)
 		rtw_signal_process(padapter->pid[1], SIGUSR2);
-	}
 
 	rtw_roaming(padapter, NULL);
 
@@ -317,9 +285,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 exit:
 	if (pwrpriv)
 		pwrpriv->bInSuspend = false;
-	DBG_88E("<===  %s return %d.............. in %dms\n", __func__,
-		ret, rtw_get_passing_time_ms(start_time));
-
 
 	return ret;
 }
@@ -388,36 +353,20 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 		dvobj->pusbdev->do_remote_wakeup = 1;
 		pusb_intf->needs_remote_wakeup = 1;
 		device_init_wakeup(&pusb_intf->dev, 1);
-		DBG_88E("\n  padapter->pwrctrlpriv.bSupportRemoteWakeup~~~[%d]~~~\n",
-			device_may_wakeup(&pusb_intf->dev));
 	}
 #endif
 
-	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
-	 * suspend influence */
-	if (usb_autopm_get_interface(pusb_intf) < 0)
-			DBG_88E("can't get autopm:\n");
-
 	/*  alloc dev name after read efuse. */
 	rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
 	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);
 	rtw_init_wifidirect_addrs(padapter, padapter->eeprompriv.mac_addr,
 				  padapter->eeprompriv.mac_addr);
 	eth_hw_addr_set(pnetdev, padapter->eeprompriv.mac_addr);
-	DBG_88E("MAC Address from pnetdev->dev_addr =  %pM\n",
-		pnetdev->dev_addr);
 
 	/* step 6. Tell the network stack we exist */
 	if (register_netdev(pnetdev) != 0)
 		goto handle_dualmac;
 
-	DBG_88E("bDriverStopped:%d, bSurpriseRemoved:%d, bup:%d, hw_init_completed:%d\n"
-		, padapter->bDriverStopped
-		, padapter->bSurpriseRemoved
-		, padapter->bup
-		, padapter->hw_init_completed
-	);
-
 	status = _SUCCESS;
 
 handle_dualmac:
@@ -454,8 +403,6 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
 	rtw_cancel_all_timer(if1);
 
 	rtw_dev_unload(if1);
-	DBG_88E("+r871xu_dev_remove, hw_init_completed=%d\n",
-		if1->hw_init_completed);
 	rtw_handle_dualmac(if1, 0);
 	rtw_free_drv_sw(if1);
 	if (pnetdev)
@@ -473,15 +420,11 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 		goto err;
 
 	if1 = rtw_usb_if1_init(dvobj, pusb_intf);
-	if (!if1) {
-		DBG_88E("rtw_init_primarystruct adapter Failed!\n");
+	if (!if1)
 		goto free_dvobj;
-	}
 
-	if (ui_pid[1] != 0) {
-		DBG_88E("ui_pid[1]:%d\n", ui_pid[1]);
+	if (ui_pid[1] != 0)
 		rtw_signal_process(ui_pid[1], SIGUSR2);
-	}
 
 	return 0;
 
@@ -500,8 +443,6 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
 	struct adapter *padapter = dvobj->if1;
 
-	DBG_88E("+rtw_dev_remove\n");
-
 	if (usb_drv->drv_registered)
 		padapter->bSurpriseRemoved = true;
 
@@ -513,14 +454,10 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 	rtw_usb_if1_deinit(padapter);
 
 	usb_dvobj_deinit(pusb_intf);
-
-	DBG_88E("-r871xu_dev_remove, done\n");
 }
 
 static int __init rtw_drv_entry(void)
 {
-	DBG_88E(DRV_NAME " driver version=%s\n", DRIVERVERSION);
-
 	mutex_init(&usb_drv->hw_init_mutex);
 
 	usb_drv->drv_registered = true;
@@ -529,13 +466,10 @@ static int __init rtw_drv_entry(void)
 
 static void __exit rtw_drv_halt(void)
 {
-	DBG_88E("+rtw_drv_halt\n");
-
 	usb_drv->drv_registered = false;
 	usb_deregister(&usb_drv->usbdrv);
 
 	mutex_destroy(&usb_drv->hw_init_mutex);
-	DBG_88E("-rtw_drv_halt\n");
 }
 
 module_init(rtw_drv_entry);
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index d1cb33d3e6a7..50f43770a05e 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -32,8 +32,6 @@ void rtw_read_port_cancel(struct adapter *padapter)
 	int i;
 	struct recv_buf *precvbuf = (struct recv_buf *)padapter->recvpriv.precv_buf;
 
-	DBG_88E("%s\n", __func__);
-
 	padapter->bReadPortCancel = true;
 
 	for (i = 0; i < NR_RECVBUFF; i++) {
@@ -71,32 +69,21 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 	}
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
-	    padapter->bWritePortCancel) {
-		DBG_88E("%s(): TX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bWritePortCancel(%d) pxmitbuf->ext_tag(%x)\n",
-			__func__, padapter->bDriverStopped,
-			padapter->bSurpriseRemoved, padapter->bReadPortCancel,
-			pxmitbuf->ext_tag);
-
+	    padapter->bWritePortCancel)
 		goto check_completion;
-	}
 
 	if (purb->status) {
-		DBG_88E("###=> urb_write_port_complete status(%d)\n", purb->status);
 		if (purb->status == -EINPROGRESS) {
 			goto check_completion;
 		} else if (purb->status == -ENOENT) {
-			DBG_88E("%s: -ENOENT\n", __func__);
 			goto check_completion;
 		} else if (purb->status == -ECONNRESET) {
-			DBG_88E("%s: -ECONNRESET\n", __func__);
 			goto check_completion;
 		} else if (purb->status == -ESHUTDOWN) {
 			padapter->bDriverStopped = true;
 			goto check_completion;
 		} else if ((purb->status != -EPIPE) && (purb->status != -EPROTO)) {
 			padapter->bSurpriseRemoved = true;
-			DBG_88E("bSurpriseRemoved = true\n");
-
 			goto check_completion;
 		}
 	}
@@ -174,7 +161,6 @@ u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 	status = usb_submit_urb(purb, GFP_ATOMIC);
 	if (status) {
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_WRITE_PORT_ERR);
-		DBG_88E("usb_write_port, status =%d\n", status);
 
 		switch (status) {
 		case -ENODEV:
@@ -202,8 +188,6 @@ void rtw_write_port_cancel(struct adapter *padapter)
 	int i, j;
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmitbuf;
 
-	DBG_88E("%s\n", __func__);
-
 	padapter->bWritePortCancel = true;
 
 	for (i = 0; i < NR_XMITBUFF; i++) {
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 088c294f2586..717b980a8c72 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -78,10 +78,8 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
-		if (!pxmitbuf->pxmit_urb[i]) {
-			DBG_88E("pxmitbuf->pxmit_urb[i]==NULL");
+		if (!pxmitbuf->pxmit_urb[i])
 			return _FAIL;
-		}
 	}
 	return _SUCCESS;
 }
@@ -188,14 +186,12 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 			memcpy(newskb->data, psta->hwaddr, 6);
 			res = rtw_xmit(padapter, &newskb);
 			if (res < 0) {
-				DBG_88E("%s()-%d: rtw_xmit() return error!\n", __func__, __LINE__);
 				pxmitpriv->tx_drop++;
 				dev_kfree_skb_any(newskb);
 			} else {
 				pxmitpriv->tx_pkts++;
 			}
 		} else {
-			DBG_88E("%s-%d: skb_copy() failed!\n", __func__, __LINE__);
 			pxmitpriv->tx_drop++;
 
 			spin_unlock_bh(&pstapriv->asoc_list_lock);
-- 
2.34.1

