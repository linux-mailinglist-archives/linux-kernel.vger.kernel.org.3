Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AAF4B7C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245300AbiBPBHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:07:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbiBPBHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:31 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF229F5412
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n8so279382wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mMe++iOVbf6BKH9Qj9kdpFtiJcC5IZovwZdqE71pIg=;
        b=ADfBeuGDD7HxdWrfoZBA2WvnlJ21G5R3anBtDKzPDQ2d5eiR1HnXVKIE/q0KNX3tHV
         0wqe6ebKMiFOjUCMSy2+HtQzw9mjTMx3qgsYWaEW5GNS9HaD/3x/Y08QiXOVmyh6gxSO
         VNJUQY3GKGHJthSqQ3ff3jKAOXUPlGRfmfQcNeDPbkCe52sUg1vwt69gmn0oCS1KNNuP
         U+xSSEk8dr2OdjLH+A1xxwXVTMbWEJmdrD4odUkGAAGkCRjr65abHC3vkGG35u/fflvl
         UerZeWs6p3k4BDdh9vKxYaTICTM/GjpGlxFOyrQI7OYjbnipv3ymf15HkqB42mQw+Dbc
         +QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mMe++iOVbf6BKH9Qj9kdpFtiJcC5IZovwZdqE71pIg=;
        b=phGWCFZm2qfVdzK+K065Q3i+FRK0WJVR9Xfj6NPhZcla7EHNTa0q1iaxDO2kyx1kio
         e3Qeq1WNfe9Jy5Gtdvu1MZVemp9SmORYXCWxifKxEt0dDmfJk4MgmoCRxTt65rrdMo5A
         Ax6coVB47CvRa2d7hwWbnbzcyppgu5QxCFXLDdRMbV2TN2/b88/cVA7WiEcWLw2ThFIb
         CuwDghDXOG/R9kETKEoiwgn+TuBLG0AGXWTMULaDgd2cebU5S7bSlHjGg032B0NiFlLR
         AAKBj/GGKX+cVUxNrQsrH1uIldIJSyymGmhcy6ktArjrBnqDXXmVUNQkkjrz9fiYSxzn
         4wVw==
X-Gm-Message-State: AOAM531U09hl46oh70uv+HuKv23uk5ryc6J0KpBaBEs8CsMu2dwkudZB
        zMMDD9SnRqWBtIsyTAG38Q+Z6w==
X-Google-Smtp-Source: ABdhPJyPLapSvpcTXR+dCjEt3qP+6avaSxFjtj3u7NS1dELnxox30NAfUfKah3ba6rcKbWOgfSYW/Q==
X-Received: by 2002:a1c:35c9:0:b0:37b:edec:4d88 with SMTP id c192-20020a1c35c9000000b0037bedec4d88mr4970082wma.159.1644973637321;
        Tue, 15 Feb 2022 17:07:17 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:16 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 07/15] staging: r8188eu: remove remaining DBG_88E calls from os_dep subdir
Date:   Wed, 16 Feb 2022 01:07:01 +0000
Message-Id: <20220216010709.791-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216010709.791-1-phil@philpotter.co.uk>
References: <20220216010709.791-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all remaining DBG_88E calls from the os_dep subdirectory. After
some thought, it makes more sense to just entirely strip all of these
calls, so that debugging code in the driver can be more consistent and
useful going forwards.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/mlme_linux.c |  4 --
 drivers/staging/r8188eu/os_dep/os_intfs.c   | 24 ---------
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 57 +--------------------
 3 files changed, 1 insertion(+), 84 deletions(-)

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
index ef4ba0f22c09..4230819cbf8c 100644
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
@@ -493,17 +492,14 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 		return _FAIL;
 
 	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
-		DBG_88E("Can't _rtw_init_xmit_priv\n");
 		return _FAIL;
 	}
 
 	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
-		DBG_88E("Can't _rtw_init_recv_priv\n");
 		return _FAIL;
 	}
 
 	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
-		DBG_88E("Can't _rtw_init_sta_priv\n");
 		return _FAIL;
 	}
 
@@ -611,8 +607,6 @@ int _netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
-	DBG_88E("+88eu_drv - drv_open, bup =%d\n", padapter->bup);
-
 	if (pwrctrlpriv->ps_flag) {
 		padapter->net_closed = false;
 		goto netdev_open_normal_process;
@@ -661,14 +655,12 @@ int _netdev_open(struct net_device *pnetdev)
 	netdev_br_init(pnetdev);
 
 netdev_open_normal_process:
-	DBG_88E("-88eu_drv - drv_open, bup =%d\n", padapter->bup);
 	return 0;
 
 netdev_open_error:
 	padapter->bup = false;
 	netif_carrier_off(pnetdev);
 	netif_tx_stop_all_queues(pnetdev);
-	DBG_88E("-88eu_drv - drv_open fail, bup =%d\n", padapter->bup);
 	return -1;
 }
 
@@ -687,7 +679,6 @@ static int  ips_netdrv_open(struct adapter *padapter)
 {
 	int status = _SUCCESS;
 	padapter->net_closed = false;
-	DBG_88E("===> %s.........\n", __func__);
 
 	padapter->bDriverStopped = false;
 	padapter->bSurpriseRemoved = false;
@@ -706,31 +697,23 @@ static int  ips_netdrv_open(struct adapter *padapter)
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
 
@@ -738,13 +721,10 @@ void rtw_ips_pwr_down(struct adapter *padapter)
 
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
@@ -763,9 +743,6 @@ int netdev_close(struct net_device *pnetdev)
 	padapter->net_closed = true;
 
 	if (padapter->pwrctrlpriv.rf_pwrstate == rf_on) {
-		DBG_88E("(2)88eu_drv - drv_close, bup =%d, hw_init_completed =%d\n",
-			padapter->bup, padapter->hw_init_completed);
-
 		/* s1. */
 		if (pnetdev) {
 			if (!rtw_netif_queue_stopped(pnetdev))
@@ -792,6 +769,5 @@ int netdev_close(struct net_device *pnetdev)
 	kfree(dvobj->firmware.data);
 	dvobj->firmware.data = NULL;
 
-	DBG_88E("-88eu_drv - drv_close, bup =%d\n", padapter->bup);
 	return 0;
 }
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index ae3750a3f056..79d2d640ddfa 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -145,7 +145,6 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 				 * on sitesurvey for the first time when
 				 * device is up . Reset usb port for sitesurvey
 				 * fail issue. */
-				DBG_88E("usb attached..., try to reset usb device\n");
 				usb_reset_device(interface_to_usbdev(usb_intf));
 			}
 		}
@@ -175,7 +174,6 @@ static void usb_intf_stop(struct adapter *padapter)
 static void rtw_dev_unload(struct adapter *padapter)
 {
 	if (padapter->bup) {
-		DBG_88E("===> rtw_dev_unload\n");
 		padapter->bDriverStopped = true;
 		if (padapter->xmitpriv.ack_tx)
 			rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_DRV_STOP);
@@ -193,8 +191,6 @@ static void rtw_dev_unload(struct adapter *padapter)
 
 		padapter->bup = false;
 	}
-
-	DBG_88E("<=== rtw_dev_unload\n");
 }
 
 static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
@@ -206,16 +202,9 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
 	int ret = 0;
-	u32 start_time = jiffies;
-
-
-	DBG_88E("==> %s (%s:%d)\n", __func__, current->comm, current->pid);
 
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
 	    (padapter->bSurpriseRemoved)) {
-		DBG_88E("padapter->bup=%d bDriverStopped=%d bSurpriseRemoved = %d\n",
-			padapter->bup, padapter->bDriverStopped,
-			padapter->bSurpriseRemoved);
 		goto exit;
 	}
 
@@ -235,13 +224,6 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
 	    check_fwstate(pmlmepriv, _FW_LINKED)) {
-		DBG_88E("%s:%d %s(%pM), length:%d assoc_ssid.length:%d\n",
-			__func__, __LINE__,
-			pmlmepriv->cur_network.network.Ssid.Ssid,
-			pmlmepriv->cur_network.network.MacAddress,
-			pmlmepriv->cur_network.network.Ssid.SsidLength,
-			pmlmepriv->assoc_ssid.SsidLength);
-
 		pmlmepriv->to_roaming = 1;
 	}
 	/* s2-2.  indicate disconnect to os */
@@ -261,9 +243,6 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 		rtw_indicate_disconnect(padapter);
 
 exit:
-	DBG_88E("<===  %s return %d.............. in %dms\n", __func__
-		, ret, rtw_get_passing_time_ms(start_time));
-
 		return ret;
 }
 
@@ -274,9 +253,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	struct net_device *pnetdev;
 	struct pwrctrl_priv *pwrpriv = NULL;
 	int ret = -1;
-	u32 start_time = jiffies;
-
-	DBG_88E("==> %s (%s:%d)\n", __func__, current->comm, current->pid);
 
 	pnetdev = padapter->pnetdev;
 	pwrpriv = &padapter->pwrctrlpriv;
@@ -286,7 +262,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	if (pwrpriv)
 		pwrpriv->bkeepfwalive = false;
 
-	DBG_88E("bkeepfwalive(%x)\n", pwrpriv->bkeepfwalive);
 	if (netdev_open(pnetdev) != 0) {
 		mutex_unlock(&pwrpriv->lock);
 		goto exit;
@@ -298,7 +273,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 	mutex_unlock(&pwrpriv->lock);
 
 	if (padapter->pid[1] != 0) {
-		DBG_88E("pid[1]:%d\n", padapter->pid[1]);
 		rtw_signal_process(padapter->pid[1], SIGUSR2);
 	}
 
@@ -308,9 +282,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 exit:
 	if (pwrpriv)
 		pwrpriv->bInSuspend = false;
-	DBG_88E("<===  %s return %d.............. in %dms\n", __func__,
-		ret, rtw_get_passing_time_ms(start_time));
-
 
 	return ret;
 }
@@ -379,40 +350,27 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 		dvobj->pusbdev->do_remote_wakeup = 1;
 		pusb_intf->needs_remote_wakeup = 1;
 		device_init_wakeup(&pusb_intf->dev, 1);
-		DBG_88E("\n  padapter->pwrctrlpriv.bSupportRemoteWakeup~~~[%d]~~~\n",
-			device_may_wakeup(&pusb_intf->dev));
 	}
 #endif
 
 	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
 	 * suspend influence */
 	if (usb_autopm_get_interface(pusb_intf) < 0)
-			DBG_88E("can't get autopm:\n");
+		;
 
 	/*  alloc dev name after read efuse. */
 	if (rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname) < 0) {
-		DBG_88E("rtw_init_netdev_name failed, ifname:%s\n",
-			padapter->registrypriv.ifname);
 		goto free_drv_sw;
 	}
 	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);
 	rtw_init_wifidirect_addrs(padapter, padapter->eeprompriv.mac_addr,
 				  padapter->eeprompriv.mac_addr);
 	eth_hw_addr_set(pnetdev, padapter->eeprompriv.mac_addr);
-	DBG_88E("MAC Address from pnetdev->dev_addr =  %pM\n",
-		pnetdev->dev_addr);
 
 	/* step 6. Tell the network stack we exist */
 	if (register_netdev(pnetdev) != 0)
 		goto free_drv_sw;
 
-	DBG_88E("bDriverStopped:%d, bSurpriseRemoved:%d, bup:%d, hw_init_completed:%d\n"
-		, padapter->bDriverStopped
-		, padapter->bSurpriseRemoved
-		, padapter->bup
-		, padapter->hw_init_completed
-	);
-
 	return padapter;
 
 free_drv_sw:
@@ -446,8 +404,6 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
 	rtw_cancel_all_timer(if1);
 
 	rtw_dev_unload(if1);
-	DBG_88E("+r871xu_dev_remove, hw_init_completed=%d\n",
-		if1->hw_init_completed);
 	rtw_handle_dualmac(if1, 0);
 	rtw_free_drv_sw(if1);
 	if (pnetdev)
@@ -466,12 +422,10 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 
 	if1 = rtw_usb_if1_init(dvobj, pusb_intf);
 	if (!if1) {
-		DBG_88E("rtw_init_primarystruct adapter Failed!\n");
 		goto free_dvobj;
 	}
 
 	if (ui_pid[1] != 0) {
-		DBG_88E("ui_pid[1]:%d\n", ui_pid[1]);
 		rtw_signal_process(ui_pid[1], SIGUSR2);
 	}
 
@@ -492,8 +446,6 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
 	struct adapter *padapter = dvobj->if1;
 
-	DBG_88E("+rtw_dev_remove\n");
-
 	if (usb_drv->drv_registered)
 		padapter->bSurpriseRemoved = true;
 
@@ -505,14 +457,10 @@ static void rtw_dev_remove(struct usb_interface *pusb_intf)
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
@@ -521,13 +469,10 @@ static int __init rtw_drv_entry(void)
 
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
-- 
2.34.1

