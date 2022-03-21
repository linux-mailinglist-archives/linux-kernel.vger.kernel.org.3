Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C224E2D95
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350904AbiCUQPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350877AbiCUQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:14:04 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287CE68FAB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=+KiW+E9NEMICeV
        K83Xl2pi+C2Euq72aBGI4Tqe0sVeQ=; b=ljR21KweHPVUQu+sGl5UOoVKOKaRjo
        xxC3gYMR+763vr2gJxdzaHOrW76MteKAhyPm8XBkgJDmh+0YZ6HCc8/J1vn1Ioqz
        UfMvWkAlbLGFqS2e7g9FVxXIGslZq0LbSj9l3JaX13ywkD7qtzTEIwEZ3K705KbG
        DbYtku5d0hM8s=
Received: (qmail 957966 invoked from network); 21 Mar 2022 17:12:34 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:34 +0100
X-UD-Smtp-Session: l3s3148p1@dfyfw7zaMNkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 12/15] net: wireless: realtek: rtw89: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:20 +0100
Message-Id: <20220321161223.2837-13-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
References: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function was just renamed to be easier understandable. No functional
change.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
RFC, please do not apply yet

 drivers/net/wireless/realtek/rtw89/fw.c           | 2 +-
 drivers/net/wireless/realtek/rtw89/mac.c          | 6 +++---
 drivers/net/wireless/realtek/rtw89/pci.c          | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c     | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 8 ++++----
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8a57b75b07c0..a357756cf3a5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -396,7 +396,7 @@ static void rtw89_fw_prog_cnt_dump(struct rtw89_dev *rtwdev)
 	for (index = 0; index < 15; index++) {
 		val32 = rtw89_read32(rtwdev, R_AX_DBG_PORT_SEL);
 		rtw89_err(rtwdev, "[ERR]fw PC = 0x%x\n", val32);
-		fsleep(10);
+		usleep_autoyield(10);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b98c47e9ecfe..5fe7e2b9f5f7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -867,7 +867,7 @@ static int rtw89_mac_sub_pwr_seq(struct rtw89_dev *rtwdev, u8 cv_msk,
 			if (cur_cfg->val == PWR_DELAY_US)
 				udelay(cur_cfg->addr);
 			else
-				fsleep(cur_cfg->addr * 1000);
+				usleep_autoyield(cur_cfg->addr * 1000);
 			break;
 		default:
 			return -EINVAL;
@@ -3042,7 +3042,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_hiq_drop(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif);
-	fsleep(BCN_ERLY_SET_DLY);
+	usleep_autoyield(BCN_ERLY_SET_DLY);
 	rtw89_mac_port_cfg_bcn_early(rtwdev, rtwvif);
 
 	return 0;
@@ -3425,7 +3425,7 @@ void rtw89_mac_cfg_sb(struct rtw89_dev *rtwdev, u32 val)
 	      FIELD_PREP(B_MAC_AX_SB_DRV_MASK, val) |
 	      FIELD_PREP(B_MAC_AX_SB_FW_MASK, fw_sb);
 	rtw89_write32(rtwdev, R_AX_SCOREBOARD, val);
-	fsleep(1000); /* avoid BT FW loss information */
+	usleep_autoyield(1000); /* avoid BT FW loss information */
 }
 
 u32 rtw89_mac_get_sb(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 2c94762e4f93..9ab17bcfe8e0 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1509,7 +1509,7 @@ __get_target(struct rtw89_dev *rtwdev, u16 *target, enum rtw89_pcie_phy phy_rate
 	if (ret)
 		return ret;
 
-	fsleep(300);
+	usleep_autoyield(300);
 
 	ret = rtw89_read16_mdio(rtwdev, RAC_CTRL_PPR_V1, phy_rate, &tar);
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 6b75e4bc7352..3e369644680b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1139,7 +1139,7 @@ static void rtw8852a_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 		rtw8852a_dfs_en(rtwdev, false);
 		rtw8852a_tssi_cont_en_phyidx(rtwdev, false, RTW89_PHY_0);
 		rtw8852a_adc_en(rtwdev, false);
-		fsleep(40);
+		usleep_autoyield(40);
 		rtw8852a_bb_reset_en(rtwdev, phy_idx, false);
 	} else {
 		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
@@ -1635,7 +1635,7 @@ static u8 rtw8852a_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x0);
 	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
 
-	fsleep(200);
+	usleep_autoyield(200);
 
 	return (u8)rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index c021e93eb07b..818719935e59 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -836,7 +836,7 @@ static void _iqk_rxk_setting(struct rtw89_dev *rtwdev, u8 path)
 	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
 	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_POW, 0x0);
 	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_POW, 0x1);
-	fsleep(128);
+	usleep_autoyield(128);
 }
 
 static bool _iqk_check_cal(struct rtw89_dev *rtwdev, u8 path, u8 ktype)
@@ -1272,7 +1272,7 @@ static bool _iqk_lok(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), MASKDWORD, itqt);
 	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_COARSE);
 	iqk_info->lok_cor_fail[0][path] = tmp;
-	fsleep(10);
+	usleep_autoyield(10);
 	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), MASKDWORD, itqt);
 	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_FINE);
 	iqk_info->lok_fin_fail[0][path] = tmp;
@@ -1777,7 +1777,7 @@ static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x0);
 	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x1);
 
-	fsleep(600);
+	usleep_autoyield(600);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_ONESHOT_STOP);
 
@@ -2072,7 +2072,7 @@ static void _dpk_lbk_rxiqk(struct rtw89_dev *rtwdev,
 	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_POW, 0x0);
 	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_POW, 0x1);
 
-	fsleep(70);
+	usleep_autoyield(70);
 
 	rtw89_write_rf(rtwdev, path, RR_RXIQGEN, RR_RXIQGEN_ATTL, 0x1f);
 
-- 
2.34.1

