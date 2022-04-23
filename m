Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA950CA49
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiDWNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiDWNFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:05:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC81F037E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z21so1884617pgj.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=np1VvhGsXveudaC3mg3HWoX7i37C0pM7mdB5fjxU4KQ=;
        b=goU7yWXzuueB/1fmAq5lrcoXVk9YtYy2CfEP9Rqid2PABQEcieOcFNJY2/Xrx3Ih6c
         q1td/X2fODGvpGB754FLsM0kaZdIumqZQsB2yEll/x1Z8EkXV30a/zQaeqi6kjrhPgdZ
         Qxk1734kzv2fjJLqHqMw29wuDOxfsHoBgdZTklP/bmH6qvrcKiQ7fgB/IN8BmtFL/AmJ
         pRDhQgBT0F9DwwAtazpe83HU7qIid4t9z6iVu3oE2bwCfb7x4hv0KeJUA9CTW/BFCoMw
         jAv4MT8J5nVcpYcnDm006wb+zLAXpbj6EyUxst/71wURP7Vvpummp/VSZk8PCKCr/219
         z0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=np1VvhGsXveudaC3mg3HWoX7i37C0pM7mdB5fjxU4KQ=;
        b=WCMtTrJMuc04T6OH+R30AkC5cApfSAYOaNhZsosHkM+eauVhkxczay+CHD89wS/8RR
         awRZ1Z3Vs9kk/a2qwsMfFM+71P2TFDP4GbgmgU8V5fpptMx32/s08Nz2rEBZ90uorHhd
         FSzlr5n45uNjsD9k8ZdHv9W/hthr8Z5q4VH4dZbeWRpcuK4IsOg3ZyfQ42PvvLfA0MiP
         gqDIXG5WhL23pbqFJQK4Xt4zuzHMFEmxbt4CFWxvEBHzNl4mdhW4uYdcjSNhdZmp5NQ6
         mJ42R0ByY15G4Kly1nL7gXgOmHeHbMWcP6CBBMsI/QrcMpMNOWd1ZsOdk+odwRcmSLjO
         zSsg==
X-Gm-Message-State: AOAM530kLxB0Px5XIsRNZ5eZMvupCQcdxaINxKpHnwrAwFXVU0ZepJ7S
        yQxK5JKDcEIrb7l/QNL1NexrFcxBHmUHxg==
X-Google-Smtp-Source: ABdhPJwTx2+Ca+wGjC30X9mxFyzQeAUWP/zAaMHKpZDqef465+5acyngYnNmgsDoTd6btJufAn5Rgw==
X-Received: by 2002:a05:6a00:218a:b0:505:aa03:ba57 with SMTP id h10-20020a056a00218a00b00505aa03ba57mr9996652pfi.84.1650718929480;
        Sat, 23 Apr 2022 06:02:09 -0700 (PDT)
Received: from localhost.localdomain ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id c139-20020a624e91000000b005060cdff4ffsm5808994pfb.129.2022.04.23.06.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:02:09 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH 1/7] staging: rtl8192e: Remove unnecessary u8 assignment cast
Date:   Sat, 23 Apr 2022 21:01:44 +0800
Message-Id: <20220423130150.161903-2-wjsota@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220423130150.161903-1-wjsota@gmail.com>
References: <20220423130150.161903-1-wjsota@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the explicit casts in assignment statements for u8 variables.
Because these variables are declared as u8, there is implicit conversion
to u8 during the assignment, so an explicit cast is unnecessary.

Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  8 ++---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 32 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 16 +++++-----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 18 +++++------
 4 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 52eeb56c5c76..4abec7b42993 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -185,10 +185,10 @@ void rtl92e_set_ofdm_tx_power(struct net_device *dev, u8 powerlevel)
 	for (index = 0; index < 6; index++) {
 		writeVal = (u32)(priv->MCSTxPowerLevelOriginalOffset[index] +
 			   ((index < 2) ? powerBase0 : powerBase1));
-		byte0 = (u8)(writeVal & 0x7f);
-		byte1 = (u8)((writeVal & 0x7f00)>>8);
-		byte2 = (u8)((writeVal & 0x7f0000)>>16);
-		byte3 = (u8)((writeVal & 0x7f000000)>>24);
+		byte0 = writeVal & 0x7f;
+		byte1 = (writeVal & 0x7f00) >> 8;
+		byte2 = (writeVal & 0x7f0000) >> 16;
+		byte3 = (writeVal & 0x7f000000) >> 24;
 		if (byte0 > 0x24)
 			byte0 = 0x24;
 		if (byte1 > 0x24)
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index a45ee95a8e6b..4b31fecde4e6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -321,7 +321,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 		usValue = rtl92e_eeprom_read(dev,
 					     (u16)(EEPROM_Customer_ID>>1)) >> 8;
-		priv->eeprom_CustomerID = (u8)(usValue & 0xff);
+		priv->eeprom_CustomerID = usValue & 0xff;
 		usValue = rtl92e_eeprom_read(dev,
 					     EEPROM_ICVersion_ChannelPlan>>1);
 		priv->eeprom_ChannelPlan = usValue&0xff;
@@ -399,9 +399,9 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 			priv->EEPROMLegacyHTTxPowerDiff);
 
 		if (!priv->AutoloadFailFlag)
-			priv->EEPROMThermalMeter = (u8)(((rtl92e_eeprom_read(dev,
+			priv->EEPROMThermalMeter = ((rtl92e_eeprom_read(dev,
 						   (EEPROM_ThermalMeter>>1))) &
-						   0xff00)>>8);
+						   0xff00) >> 8;
 		else
 			priv->EEPROMThermalMeter = EEPROM_Default_ThermalMeter;
 		RT_TRACE(COMP_INIT, "ThermalMeter = %d\n",
@@ -413,8 +413,8 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 				usValue = rtl92e_eeprom_read(dev,
 					  EEPROM_TxPwDiff_CrystalCap >> 1);
 				priv->EEPROMAntPwDiff = usValue & 0x0fff;
-				priv->EEPROMCrystalCap = (u8)((usValue & 0xf000)
-							 >> 12);
+				priv->EEPROMCrystalCap = (usValue & 0xf000)
+							 >> 12;
 			} else {
 				priv->EEPROMAntPwDiff =
 					 EEPROM_Default_AntTxPowerDiff;
@@ -894,9 +894,8 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 			for (i = 0; i < TxBBGainTableLength; i++) {
 				if (tmpRegA == dm_tx_bb_gain[i]) {
-					priv->rfa_txpowertrackingindex = (u8)i;
-					priv->rfa_txpowertrackingindex_real =
-						 (u8)i;
+					priv->rfa_txpowertrackingindex = i;
+					priv->rfa_txpowertrackingindex_real = i;
 					priv->rfa_txpowertracking_default =
 						 priv->rfa_txpowertrackingindex;
 					break;
@@ -908,7 +907,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 			for (i = 0; i < CCKTxBBGainTableLength; i++) {
 				if (TempCCk == dm_cck_tx_bb_gain[i][0]) {
-					priv->CCKPresentAttentuation_20Mdefault = (u8)i;
+					priv->CCKPresentAttentuation_20Mdefault = i;
 					break;
 				}
 			}
@@ -1303,7 +1302,7 @@ void  rtl92e_fill_tx_cmd_desc(struct net_device *dev, struct tx_desc_cmd *entry,
 				      entry_tmp->Offset);
 		entry_tmp->QueueSelect = QSLT_CMD;
 		entry_tmp->TxFWInfoSize = 0x08;
-		entry_tmp->RATid = (u8)DESC_PACKET_TYPE_INIT;
+		entry_tmp->RATid = DESC_PACKET_TYPE_INIT;
 	}
 	entry->TxBufferSize = skb->len;
 	entry->TxBuffAddr = mapping;
@@ -1613,9 +1612,8 @@ static void _rtl92e_query_rxphystatus(
 				total_rssi += RSSI;
 
 			if (bpacket_match_bssid) {
-				pstats->RxMIMOSignalStrength[i] = (u8)RSSI;
-				precord_stats->RxMIMOSignalStrength[i] =
-								(u8)RSSI;
+				pstats->RxMIMOSignalStrength[i] = RSSI;
+				precord_stats->RxMIMOSignalStrength[i] = RSSI;
 			}
 		}
 
@@ -1661,14 +1659,14 @@ static void _rtl92e_query_rxphystatus(
 
 	if (is_cck_rate) {
 		pstats->SignalStrength = precord_stats->SignalStrength =
-					 (u8)(_rtl92e_signal_scale_mapping(priv,
-					 (long)pwdb_all));
+					 _rtl92e_signal_scale_mapping(priv,
+					 (long)pwdb_all);
 
 	} else {
 		if (rf_rx_num != 0)
 			pstats->SignalStrength = precord_stats->SignalStrength =
-					 (u8)(_rtl92e_signal_scale_mapping(priv,
-					 (long)(total_rssi /= rf_rx_num)));
+					 _rtl92e_signal_scale_mapping(priv,
+					 (long)(total_rssi /= rf_rx_num));
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 411138102948..c7071e0997bc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1299,17 +1299,17 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 			    DIG_ALGO_BY_FALSE_ALARM)
 				rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x8);
 			priv->initgain_backup.xaagccore1 =
-				 (u8)rtl92e_get_bb_reg(dev, rOFDM0_XAAGCCore1,
-						       BitMask);
+				 rtl92e_get_bb_reg(dev, rOFDM0_XAAGCCore1,
+						   BitMask);
 			priv->initgain_backup.xbagccore1 =
-				 (u8)rtl92e_get_bb_reg(dev, rOFDM0_XBAGCCore1,
-						       BitMask);
+				 rtl92e_get_bb_reg(dev, rOFDM0_XBAGCCore1,
+						   BitMask);
 			priv->initgain_backup.xcagccore1 =
-				 (u8)rtl92e_get_bb_reg(dev, rOFDM0_XCAGCCore1,
-						       BitMask);
+				 rtl92e_get_bb_reg(dev, rOFDM0_XCAGCCore1,
+						   BitMask);
 			priv->initgain_backup.xdagccore1 =
-				 (u8)rtl92e_get_bb_reg(dev, rOFDM0_XDAGCCore1,
-						       BitMask);
+				 rtl92e_get_bb_reg(dev, rOFDM0_XDAGCCore1,
+						   BitMask);
 			BitMask = bMaskByte2;
 			priv->initgain_backup.cca = (u8)rtl92e_get_bb_reg(dev,
 						    rCCK0_CCA, BitMask);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index aa942d915992..c85b23415772 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -633,7 +633,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	rtl92e_writeb(dev, FW_Busy_Flag, 0);
 	priv->rtllib->bdynamic_txpower_enable = false;
 
-	powerlevelOFDM24G = (u8)(priv->Pwr_Track>>24);
+	powerlevelOFDM24G = priv->Pwr_Track >> 24;
 	RF_Type = priv->rf_type;
 	Value = (RF_Type<<8) | powerlevelOFDM24G;
 
@@ -833,7 +833,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 					    bMaskDWord);
 		for (i = 0; i < OFDM_Table_Length; i++) {
 			if (tmpRegA == OFDMSwingTable[i]) {
-				priv->OFDM_index[0] = (u8)i;
+				priv->OFDM_index[0] = i;
 				RT_TRACE(COMP_POWER_TRACKING,
 					 "Initial reg0x%x = 0x%x, OFDM_index = 0x%x\n",
 					 rOFDM0_XATxIQImbalance, tmpRegA,
@@ -844,7 +844,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
 		for (i = 0; i < CCK_Table_length; i++) {
 			if (TempCCk == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
-				priv->CCK_index = (u8)i;
+				priv->CCK_index = i;
 				RT_TRACE(COMP_POWER_TRACKING,
 					 "Initial reg0x%x = 0x%x, CCK_index = 0x%x\n",
 					 rCCK0_TxFilter1, TempCCk,
@@ -1041,7 +1041,7 @@ static void _rtl92e_dm_cck_tx_power_adjust_tssi(struct net_device *dev,
 {
 	u32 TempVal;
 	struct r8192_priv *priv = rtllib_priv(dev);
-	u8 attenuation = (u8)priv->CCKPresentAttentuation;
+	u8 attenuation = priv->CCKPresentAttentuation;
 
 	TempVal = 0;
 	if (!bInCH14) {
@@ -1245,10 +1245,10 @@ void rtl92e_dm_backup_state(struct net_device *dev)
 		return;
 
 	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x8);
-	priv->initgain_backup.xaagccore1 = (u8)rtl92e_get_bb_reg(dev, rOFDM0_XAAGCCore1, bit_mask);
-	priv->initgain_backup.xbagccore1 = (u8)rtl92e_get_bb_reg(dev, rOFDM0_XBAGCCore1, bit_mask);
-	priv->initgain_backup.xcagccore1 = (u8)rtl92e_get_bb_reg(dev, rOFDM0_XCAGCCore1, bit_mask);
-	priv->initgain_backup.xdagccore1 = (u8)rtl92e_get_bb_reg(dev, rOFDM0_XDAGCCore1, bit_mask);
+	priv->initgain_backup.xaagccore1 = rtl92e_get_bb_reg(dev, rOFDM0_XAAGCCore1, bit_mask);
+	priv->initgain_backup.xbagccore1 = rtl92e_get_bb_reg(dev, rOFDM0_XBAGCCore1, bit_mask);
+	priv->initgain_backup.xcagccore1 = rtl92e_get_bb_reg(dev, rOFDM0_XCAGCCore1, bit_mask);
+	priv->initgain_backup.xdagccore1 = rtl92e_get_bb_reg(dev, rOFDM0_XDAGCCore1, bit_mask);
 	bit_mask  = bMaskByte2;
 	priv->initgain_backup.cca = (u8)rtl92e_get_bb_reg(dev, rCCK0_CCA, bit_mask);
 
@@ -1535,7 +1535,7 @@ static void _rtl92e_dm_initial_gain(struct net_device *dev)
 
 	if ((dm_digtable.pre_ig_value != dm_digtable.cur_ig_value)
 	    || !initialized || force_write) {
-		initial_gain = (u8)dm_digtable.cur_ig_value;
+		initial_gain = dm_digtable.cur_ig_value;
 		rtl92e_writeb(dev, rOFDM0_XAAGCCore1, initial_gain);
 		rtl92e_writeb(dev, rOFDM0_XBAGCCore1, initial_gain);
 		rtl92e_writeb(dev, rOFDM0_XCAGCCore1, initial_gain);
-- 
2.36.0

