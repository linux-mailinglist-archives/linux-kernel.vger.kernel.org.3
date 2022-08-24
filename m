Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CC95A028D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiHXUPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240262AbiHXUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:14:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE4E95
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j21so30243290ejs.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=cg3PC67R0j4dHQzEfUx9lu7ubVMa5PfU8Aw1mhXuvVA=;
        b=nmrx/HiLuVmAieSxcbFe0NogtAI2bA9lATJ9NHSck8s+cWbs+bdAvAvIXvJsauwu2e
         YHnzVcktMNvKyqEKjg8tIVUnA4KmOSfBtJcOj4naR/buLlUdVAuDT+1vaFO/yJOTsoEi
         eDWCLS1euQK0XESymumu2YhJe58/X2Rzq96bnn8jwH8IpasEesbH+SyZErmBTYZ8Jj4X
         FeXAv2K1edEGAIouI6A0kZjxhLnbnfFVJE0+bsRcovXzwOW/wt4WHG/BJSGcLVhYUaop
         A4a9LyyZNi/O+eVi42q3STL53AefwEOYLj5l9AcZIbXI6schXxJ0IYx5VgJtbEqmwcSa
         d9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=cg3PC67R0j4dHQzEfUx9lu7ubVMa5PfU8Aw1mhXuvVA=;
        b=YeikvTwZb6ikQ22DhxdYsITmYpWAKOSK29i/ZOsf9RWikkBGVMVpHgQeN/5Jvk513c
         qV4+QtceyPz+05++5rWSx8OrbezrY1n0c251zLYsCeMNbADViWqqbGfeg1THNVGoCsJH
         uYtM3C7eIhjCPpkuZMtL41gD1zY4cpQihsf5QJAwY8W2OO9IOmr0hdcBqLPRf1Prl94A
         WQvkGdOGfjUo68ZoBqpgN8zHQVe7zzH2H5gODECdNaOjP3zoBWh11e8rj51oQ0egioWM
         V1wvVN6IDefaMAq+dNTkXnn9DMqiiHwftEku1x0OhwS4ph29BmQcEZf/5tPMFbaT5s3o
         Oe2g==
X-Gm-Message-State: ACgBeo2km+Ex7qYbWJmqPM6aCLTNj2/DKL/ZW295jIKon1Cis2esaYgc
        pA8whRYSweyE+FscJ9RYbVc=
X-Google-Smtp-Source: AA6agR7nNU+EIPOu+YgWq0dufAR0llgYfwAxdUiH4TfFIN78TSMyaFt/DFa9xEx0xJVFfNabmrMdww==
X-Received: by 2002:a17:907:7f22:b0:73d:6e2e:5bb8 with SMTP id qf34-20020a1709077f2200b0073d6e2e5bb8mr376127ejc.642.1661372085979;
        Wed, 24 Aug 2022 13:14:45 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id gg19-20020a170906899300b0073cb0801104sm1561585ejc.147.2022.08.24.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:14:45 -0700 (PDT)
Date:   Wed, 24 Aug 2022 22:14:43 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8192e: Remove Unnecessary ftrace-like logging
Message-ID: <5240b86941ebf3a290d384744d117d436e7bad41.1661370978.git.philipp.g.hortmann@gmail.com>
References: <cover.1661370978.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661370978.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "Unnecessary ftrace-like logging" as requested by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 130 ++-----------------
 1 file changed, 9 insertions(+), 121 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ff73b8cff5e8..8462dd9859e8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -143,22 +143,13 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	u16			RFWaitCounter = 0;
 	unsigned long flag;
 
-	RT_TRACE((COMP_PS | COMP_RF),
-		 "===>%s: StateToSet(%d)\n", __func__, StateToSet);
-
 	while (true) {
 		spin_lock_irqsave(&priv->rf_ps_lock, flag);
 		if (priv->RFChangeInProgress) {
 			spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
-			RT_TRACE((COMP_PS | COMP_RF),
-				 "%s: RF Change in progress! Wait to set..StateToSet(%d).\n",
-				 __func__, StateToSet);
 
 			while (priv->RFChangeInProgress) {
 				RFWaitCounter++;
-				RT_TRACE((COMP_PS | COMP_RF),
-					 "%s: Wait 1 ms (%d times)...\n",
-					 __func__, RFWaitCounter);
 				mdelay(1);
 
 				if (RFWaitCounter > 100) {
@@ -191,12 +182,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 			if (rtState == eRfOff &&
 			    ChangeSource >= RF_CHANGE_BY_HW)
 				bConnectBySSID = true;
-		} else {
-			RT_TRACE((COMP_PS | COMP_RF),
-				 "%s - eRfon reject pMgntInfo->RfOffReason= 0x%x, ChangeSource=0x%X\n",
-				 __func__, priv->rtllib->RfOffReason, ChangeSource);
-	}
-
+		}
 		break;
 
 	case eRfOff:
@@ -229,9 +215,6 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	}
 
 	if (bActionAllowed) {
-		RT_TRACE((COMP_PS | COMP_RF),
-			 "%s: Action is allowed.... StateToSet(%d), RfOffReason(%#X)\n",
-			 __func__, StateToSet, priv->rtllib->RfOffReason);
 		PHY_SetRFPowerState(dev, StateToSet);
 		if (StateToSet == eRfOn) {
 			if (bConnectBySSID && priv->blinked_ingpio) {
@@ -240,17 +223,11 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 				priv->blinked_ingpio = false;
 			}
 		}
-	} else {
-		RT_TRACE((COMP_PS | COMP_RF),
-			 "%s: Action is rejected.... StateToSet(%d), ChangeSource(%#X), RfOffReason(%#X)\n",
-			 __func__, StateToSet, ChangeSource, priv->rtllib->RfOffReason);
 	}
 
 	spin_lock_irqsave(&priv->rf_ps_lock, flag);
 	priv->RFChangeInProgress = false;
 	spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
-
-	RT_TRACE((COMP_PS | COMP_RF), "<===%s\n", __func__);
 	return bActionAllowed;
 }
 
@@ -294,7 +271,6 @@ static void _rtl92e_set_chan(struct net_device *dev, short ch)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	RT_TRACE(COMP_CH, "=====>%s()====ch:%d\n", __func__, ch);
 	if (priv->chan_forced)
 		return;
 
@@ -314,9 +290,6 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 		if (priv->dot11CurrentPreambleMode != PREAMBLE_SHORT) {
 			ShortPreamble = true;
 			priv->dot11CurrentPreambleMode = PREAMBLE_SHORT;
-			RT_TRACE(COMP_DBG,
-				 "%s(): WLAN_CAPABILITY_SHORT_PREAMBLE\n",
-				 __func__);
 			priv->rtllib->SetHwRegHandler(dev, HW_VAR_ACK_PREAMBLE,
 					(unsigned char *)&ShortPreamble);
 		}
@@ -324,9 +297,6 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 		if (priv->dot11CurrentPreambleMode != PREAMBLE_LONG) {
 			ShortPreamble = false;
 			priv->dot11CurrentPreambleMode = PREAMBLE_LONG;
-			RT_TRACE(COMP_DBG,
-				 "%s(): WLAN_CAPABILITY_LONG_PREAMBLE\n",
-				 __func__);
 			priv->rtllib->SetHwRegHandler(dev, HW_VAR_ACK_PREAMBLE,
 					      (unsigned char *)&ShortPreamble);
 		}
@@ -386,8 +356,6 @@ static void _rtl92e_qos_activate(void *data)
 	mutex_lock(&priv->mutex);
 	if (priv->rtllib->state != RTLLIB_LINKED)
 		goto success;
-	RT_TRACE(COMP_QOS,
-		 "qos active process with associate response received\n");
 
 	for (i = 0; i <  QOS_QUEUE_NUM; i++)
 		priv->rtllib->SetHwRegHandler(dev, HW_VAR_AC_PARAM, (u8 *)(&i));
@@ -422,18 +390,14 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
 				network->qos_data.param_count;
 			priv->rtllib->wmm_acm = network->qos_data.wmm_acm;
 			schedule_work(&priv->qos_activate);
-			RT_TRACE(COMP_QOS,
-				 "QoS parameters change call qos_activate\n");
 		}
 	} else {
 		memcpy(&priv->rtllib->current_network.qos_data.parameters,
 		       &def_qos_parameters, size);
 
-		if ((network->qos_data.active == 1) && (active_network == 1)) {
+		if ((network->qos_data.active == 1) && (active_network == 1))
 			schedule_work(&priv->qos_activate);
-			RT_TRACE(COMP_QOS,
-				 "QoS was disabled call qos_activate\n");
-		}
+
 		network->qos_data.active = 0;
 		network->qos_data.supported = 0;
 	}
@@ -491,8 +455,6 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv *priv,
 
 	spin_unlock_irqrestore(&priv->rtllib->lock, flags);
 
-	RT_TRACE(COMP_QOS, "%s: network->flags = %d,%d\n", __func__,
-		 network->flags, priv->rtllib->current_network.qos_data.active);
 	if (set_qos_param == 1) {
 		rtl92e_dm_init_edca_turbo(priv->rtllib->dev);
 		schedule_work(&priv->qos_activate);
@@ -711,15 +673,9 @@ void rtl92e_set_wireless_mode(struct net_device *dev, u8 wireless_mode)
 	if ((wireless_mode == WIRELESS_MODE_N_24G) ||
 	    (wireless_mode == WIRELESS_MODE_N_5G)) {
 		priv->rtllib->pHTInfo->bEnableHT = 1;
-		RT_TRACE(COMP_DBG, "%s(), wireless_mode:%x, bEnableHT = 1\n",
-			 __func__, wireless_mode);
 	} else {
 		priv->rtllib->pHTInfo->bEnableHT = 0;
-		RT_TRACE(COMP_DBG, "%s(), wireless_mode:%x, bEnableHT = 0\n",
-			 __func__, wireless_mode);
 	}
-
-	RT_TRACE(COMP_INIT, "Current Wireless Mode is %x\n", wireless_mode);
 	_rtl92e_refresh_support_rate(priv);
 }
 
@@ -737,7 +693,6 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	priv->rtllib->ieee_up = 1;
 
 	priv->up_first_time = 0;
-	RT_TRACE(COMP_INIT, "Bringing up iface");
 	priv->bfirst_init = true;
 	init_status = priv->ops->initialize_adapter(dev);
 	if (!init_status) {
@@ -746,7 +701,6 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 		return -1;
 	}
 
-	RT_TRACE(COMP_INIT, "start adapter finished\n");
 	RT_CLEAR_PS_LEVEL(pPSC, RT_RF_OFF_LEVL_HALT_NIC);
 	priv->bfirst_init = false;
 
@@ -785,7 +739,6 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 	priv->up = 0;
 	priv->rtllib->ieee_up = 0;
 	priv->bfirst_after_down = true;
-	RT_TRACE(COMP_DOWN, "==========>%s()\n", __func__);
 	if (!netif_queue_stopped(dev))
 		netif_stop_queue(dev);
 
@@ -808,9 +761,6 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 			spin_lock_irqsave(&priv->rf_ps_lock, flags);
 			break;
 		}
-		RT_TRACE(COMP_DBG,
-			 "===>%s():RF is in progress, need to wait until rf change is done.\n",
-			 __func__);
 		mdelay(1);
 		RFInProgressTimeOut++;
 		spin_lock_irqsave(&priv->rf_ps_lock, flags);
@@ -824,7 +774,6 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 	udelay(100);
 	memset(&priv->rtllib->current_network, 0,
 	       offsetof(struct rtllib_network, list));
-	RT_TRACE(COMP_DOWN, "<==========%s()\n", __func__);
 
 	return 0;
 }
@@ -1026,7 +975,6 @@ static short _rtl92e_get_channel_map(struct net_device *dev)
 			    "rtl819x_init:Error channel plan! Set to default.\n");
 		priv->ChannelPlan = COUNTRY_CODE_FCC;
 	}
-	RT_TRACE(COMP_INIT, "Channel plan is %d\n", priv->ChannelPlan);
 	dot11d_init(priv->rtllib);
 	dot11d_channel_map(priv->ChannelPlan, priv->rtllib);
 	for (i = 1; i <= 11; i++)
@@ -1066,7 +1014,6 @@ static short _rtl92e_init(struct net_device *dev)
 	}
 
 	priv->irq = dev->irq;
-	RT_TRACE(COMP_INIT, "IRQ %d\n", dev->irq);
 
 	if (_rtl92e_pci_initdescring(dev) != 0) {
 		netdev_err(dev, "Endopoints initialization failed");
@@ -1143,11 +1090,8 @@ static enum reset_type _rtl92e_tx_check_stuck(struct net_device *dev)
 	spin_unlock_irqrestore(&priv->irq_th_lock, flags);
 
 	if (bCheckFwTxCnt) {
-		if (priv->ops->tx_check_stuck_handler(dev)) {
-			RT_TRACE(COMP_RESET,
-				 "TxCheckStuck(): Fw indicates no Tx condition!\n");
+		if (priv->ops->tx_check_stuck_handler(dev))
 			return RESET_TYPE_SILENT;
-		}
 	}
 
 	return RESET_TYPE_NORESET;
@@ -1157,10 +1101,8 @@ static enum reset_type _rtl92e_rx_check_stuck(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->ops->rx_check_stuck_handler(dev)) {
-		RT_TRACE(COMP_RESET, "RxStuck Condition\n");
+	if (priv->ops->rx_check_stuck_handler(dev))
 		return RESET_TYPE_SILENT;
-	}
 
 	return RESET_TYPE_NORESET;
 }
@@ -1206,9 +1148,6 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 	unsigned long flag;
 
 	if (priv->ResetProgress == RESET_TYPE_NORESET) {
-
-		RT_TRACE(COMP_RESET, "=========>Reset progress!!\n");
-
 		priv->ResetProgress = RESET_TYPE_SILENT;
 
 		spin_lock_irqsave(&priv->rf_ps_lock, flag);
@@ -1235,12 +1174,7 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 		}
 		priv->up = 0;
 
-		RT_TRACE(COMP_RESET, "%s():======>start to down the driver\n",
-			  __func__);
 		mdelay(1000);
-		RT_TRACE(COMP_RESET,
-			 "%s():111111111111111111111111======>start to down the driver\n",
-			 __func__);
 
 		if (!netif_queue_stopped(dev))
 			netif_stop_queue(dev);
@@ -1268,16 +1202,8 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 		rtl92e_dm_backup_state(dev);
 
 		mutex_unlock(&priv->wx_mutex);
-		RT_TRACE(COMP_RESET,
-			 "%s():<==========down process is finished\n",
-			 __func__);
-
-		RT_TRACE(COMP_RESET, "%s():<===========up process start\n",
-			 __func__);
 		reset_status = _rtl92e_up(dev, true);
 
-		RT_TRACE(COMP_RESET,
-			 "%s():<===========up process is finished\n", __func__);
 		if (reset_status == -1) {
 			if (reset_times < 3) {
 				reset_times++;
@@ -1326,8 +1252,6 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 		priv->bResetInProgress = false;
 
 		rtl92e_writeb(dev, UFWP, 1);
-		RT_TRACE(COMP_RESET, "Reset finished!! ====>[%d]\n",
-			 priv->reset_count);
 	}
 }
 
@@ -1388,8 +1312,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 			if ((ieee->PowerSaveControl.ReturnPoint ==
 			     IPS_CALLBACK_NONE) &&
 			     (!ieee->bNetPromiscuousMode)) {
-				RT_TRACE(COMP_PS,
-					 "====================>haha: rtl92e_ips_enter()\n");
 				rtl92e_ips_enter(dev);
 			}
 		}
@@ -1425,7 +1347,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 			rtl92e_leisure_ps_leave(dev);
 
 	} else {
-		RT_TRACE(COMP_LPS, "====>no link LPS leave\n");
 		rtl92e_leisure_ps_leave(dev);
 	}
 
@@ -1490,7 +1411,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 
 	if (!priv->bDisableNormalResetCheck && ResetType == RESET_TYPE_NORMAL) {
 		priv->ResetProgress = RESET_TYPE_NORMAL;
-		RT_TRACE(COMP_RESET, "%s(): NOMAL RESET\n", __func__);
 		return;
 	}
 
@@ -1500,7 +1420,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	priv->force_reset = false;
 	priv->bForcedSilentReset = false;
 	priv->bResetInProgress = false;
-	RT_TRACE(COMP_TRACE, " <==RtUsbCheckForHangWorkItemCallback()\n");
 }
 
 static void _rtl92e_watchdog_timer_cb(struct timer_list *t)
@@ -2257,21 +2176,13 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		goto done;
 	}
 
-	if (inta & IMR_TBDOK) {
-		RT_TRACE(COMP_INTR, "beacon ok interrupt!\n");
+	if (inta & IMR_TBDOK)
 		priv->stats.txbeaconokint++;
-	}
 
-	if (inta & IMR_TBDER) {
-		RT_TRACE(COMP_INTR, "beacon ok interrupt!\n");
+	if (inta & IMR_TBDER)
 		priv->stats.txbeaconerr++;
-	}
-
-	if (inta & IMR_BDOK)
-		RT_TRACE(COMP_INTR, "beacon interrupt!\n");
 
 	if (inta  & IMR_MGNTDOK) {
-		RT_TRACE(COMP_INTR, "Manage ok interrupt!\n");
 		priv->stats.txmanageokint++;
 		_rtl92e_tx_isr(dev, MGNT_QUEUE);
 		spin_unlock_irqrestore(&priv->irq_th_lock, flags);
@@ -2298,13 +2209,10 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		tasklet_schedule(&priv->irq_rx_tasklet);
 	}
 
-	if (inta & IMR_BcnInt) {
-		RT_TRACE(COMP_INTR, "prepare beacon for interrupt!\n");
+	if (inta & IMR_BcnInt)
 		tasklet_schedule(&priv->irq_prepare_beacon_tasklet);
-	}
 
 	if (inta & IMR_RDU) {
-		RT_TRACE(COMP_INTR, "rx descriptor unavailable!\n");
 		priv->stats.rxrdu++;
 		rtl92e_writel(dev, INTA_MASK,
 			      rtl92e_readl(dev, INTA_MASK) & ~IMR_RDU);
@@ -2312,7 +2220,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 	}
 
 	if (inta & IMR_RXFOVW) {
-		RT_TRACE(COMP_INTR, "rx overflow !\n");
 		priv->stats.rxoverflow++;
 		tasklet_schedule(&priv->irq_rx_tasklet);
 	}
@@ -2321,21 +2228,18 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		priv->stats.txoverflow++;
 
 	if (inta & IMR_BKDOK) {
-		RT_TRACE(COMP_INTR, "BK Tx OK interrupt!\n");
 		priv->stats.txbkokint++;
 		priv->rtllib->LinkDetectInfo.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, BK_QUEUE);
 	}
 
 	if (inta & IMR_BEDOK) {
-		RT_TRACE(COMP_INTR, "BE TX OK interrupt!\n");
 		priv->stats.txbeokint++;
 		priv->rtllib->LinkDetectInfo.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, BE_QUEUE);
 	}
 
 	if (inta & IMR_VIDOK) {
-		RT_TRACE(COMP_INTR, "VI TX OK interrupt!\n");
 		priv->stats.txviokint++;
 		priv->rtllib->LinkDetectInfo.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, VI_QUEUE);
@@ -2343,7 +2247,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 
 	if (inta & IMR_VODOK) {
 		priv->stats.txvookint++;
-		RT_TRACE(COMP_INTR, "Vo TX OK interrupt!\n");
 		priv->rtllib->LinkDetectInfo.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, VO_QUEUE);
 	}
@@ -2379,8 +2282,6 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 	int err = -ENOMEM;
 	u8 revision_id;
 
-	RT_TRACE(COMP_INIT, "Configuring chip resources");
-
 	if (pci_enable_device(pdev)) {
 		dev_err(&pdev->dev, "Failed to enable PCI device");
 		return -EIO;
@@ -2459,13 +2360,9 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 	dev->type = ARPHRD_ETHER;
 	dev->watchdog_timeo = HZ * 3;
 
-	if (dev_alloc_name(dev, ifname) < 0) {
-		RT_TRACE(COMP_INIT,
-			 "Oops: devname already taken! Trying wlan%%d...\n");
+	if (dev_alloc_name(dev, ifname) < 0)
 		dev_alloc_name(dev, ifname);
-	}
 
-	RT_TRACE(COMP_INIT, "Driver probe completed1\n");
 	if (_rtl92e_init(dev) != 0) {
 		netdev_warn(dev, "Initialization failed");
 		goto err_free_irq;
@@ -2476,12 +2373,10 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 
 	if (register_netdev(dev))
 		goto err_free_irq;
-	RT_TRACE(COMP_INIT, "dev name: %s\n", dev->name);
 
 	if (priv->polling_timer_on == 0)
 		rtl92e_check_rfctrl_gpio_timer(&priv->gpio_polling_timer);
 
-	RT_TRACE(COMP_INIT, "Driver probe completed\n");
 	return 0;
 
 err_free_irq:
@@ -2536,7 +2431,6 @@ static void _rtl92e_pci_disconnect(struct pci_dev *pdev)
 	}
 
 	pci_disable_device(pdev);
-	RT_TRACE(COMP_DOWN, "wlan driver removed\n");
 }
 
 bool rtl92e_enable_nic(struct net_device *dev)
@@ -2552,7 +2446,6 @@ bool rtl92e_enable_nic(struct net_device *dev)
 		return false;
 	}
 
-	RT_TRACE(COMP_PS, "===========>%s()\n", __func__);
 	priv->bfirst_init = true;
 	init_status = priv->ops->initialize_adapter(dev);
 	if (!init_status) {
@@ -2560,13 +2453,11 @@ bool rtl92e_enable_nic(struct net_device *dev)
 		priv->bdisable_nic = false;
 		return false;
 	}
-	RT_TRACE(COMP_INIT, "start adapter finished\n");
 	RT_CLEAR_PS_LEVEL(pPSC, RT_RF_OFF_LEVL_HALT_NIC);
 	priv->bfirst_init = false;
 
 	rtl92e_irq_enable(dev);
 	priv->bdisable_nic = false;
-	RT_TRACE(COMP_PS, "<===========%s()\n", __func__);
 	return init_status;
 }
 
@@ -2575,7 +2466,6 @@ bool rtl92e_disable_nic(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 tmp_state = 0;
 
-	RT_TRACE(COMP_PS, "=========>%s()\n", __func__);
 	priv->bdisable_nic = true;
 	tmp_state = priv->rtllib->state;
 	rtllib_softmac_stop_protocol(priv->rtllib, 0, false);
@@ -2584,8 +2474,6 @@ bool rtl92e_disable_nic(struct net_device *dev)
 	rtl92e_irq_disable(dev);
 
 	priv->ops->stop_adapter(dev, false);
-	RT_TRACE(COMP_PS, "<=========%s()\n", __func__);
-
 	return true;
 }
 
-- 
2.37.2

