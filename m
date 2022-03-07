Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1134CFF53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiCGNAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242683AbiCGNAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:00:21 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA769CFA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:59:24 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ADCE73F5F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646657960;
        bh=jMtPmKSRUvUYtvTflv22KoBJEK0aUxzC1RIZwVEFX+k=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IQUzByDbhCwR16i8V6DiRsLPBnKNTB8SU0mBadvb8QCCd+iRwZtlbBQFjSLzempVr
         +gg/Izl2+xPSDcUwzEs1aRD/Wg5pqsb7Wu/JVfnNDIsxIS4R87dYiR3KITPgQS17Tp
         CjeMunELuCqCMUUGGsxC9I6ef+unC4BkDDp140Yp2JcjPY0UoMVuZmOJQS/QmQRw3p
         /8L2Ex7qgPlA6g/Y0Mr0G51YPp1kASeUOek1njpj2DqtkEFpZa6XESk3Vi25u3auQa
         GVWGPTaTYxoZ64MQfQXWjhU9lfJQiGBHaaVkiPAVc6X6QhzusdollPYipPV78iab5P
         frsdStHSODJ7w==
Received: by mail-pl1-f200.google.com with SMTP id l6-20020a170903120600b0014f43ba55f3so7431703plh.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMtPmKSRUvUYtvTflv22KoBJEK0aUxzC1RIZwVEFX+k=;
        b=DrlPM95F3iRifVsOKDHSMRMjEKB5dvztMtTNZS66GB7pxW4+fyuFt3ekENi5i9q0S1
         xMs24lqtEQ5LmXTlUHs+EcRHcfNyNOKJTGn36CXmOSoGH/DnTyuUwwO5+xMmEonBtQ9M
         AIob+5/qPdFOr7nhyov9YbAhlgDZc1RWaby9EQNvx80Tq531aQkzXSbUiI7Nf1byxHYu
         aOVq8blmL3d3J1M0mM32g/ZbsYCLLyAVRjHkhsdLev9BcxdNCtkcvR/DytTIebGRxmyM
         472CnG1W6/B4Gh/2qabj4LsjEi8TkKohONlRDmpXoxS27AMZzE9/qXyL5/UfBRPqpgoB
         CE4w==
X-Gm-Message-State: AOAM530pYrX0YyFSROIWMAwBVEaKepgxsQ5xqI/slX5MHYrqrbGqTkdL
        b+lib38S5wq3Aa4svB7/4aAtUk4enp/+4KicRlpexXXq1/0JC9Q6NNy8G9bgCgc19hgse99hgUf
        k++rMm0tJ8/aN3BJ/kYLnvK19kSTcsAIsCkDYq2oJVg==
X-Received: by 2002:a05:6a00:124f:b0:4c0:6242:c14e with SMTP id u15-20020a056a00124f00b004c06242c14emr12392482pfi.83.1646657958309;
        Mon, 07 Mar 2022 04:59:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUGtcuE9+d9RFrcMdWxp59VW+xrbfIIprtBnMCCjgc9FCOCuS/oZygQdQTPUWW2SQOzqsgIQ==
X-Received: by 2002:a05:6a00:124f:b0:4c0:6242:c14e with SMTP id u15-20020a056a00124f00b004c06242c14emr12392447pfi.83.1646657957964;
        Mon, 07 Mar 2022 04:59:17 -0800 (PST)
Received: from localhost.localdomain (59-115-216-226.dynamic-ip.hinet.net. [59.115.216.226])
        by smtp.gmail.com with ESMTPSA id oj2-20020a17090b4d8200b001bef79ea006sm17545682pjb.29.2022.03.07.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:59:17 -0800 (PST)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH 2/2] rtl8xxxu: fill up txrate info for gen1 chips
Date:   Mon,  7 Mar 2022 20:58:52 +0800
Message-Id: <20220307125852.13606-3-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220307125852.13606-1-chris.chiu@canonical.com>
References: <20220307125852.13606-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTL8188CUS/RTL8192CU(gen1) don't support rate adatptive report hence
no real txrate info can be retrieved. The vendor driver reports the
highest rate in HT capabilities from the IEs to avoid empty txrate.
This commit initiates the txrate information with the highest supported
rate negotiated with AP. The gen2 chip keeps update the txrate from
the rate adaptive reports, and gen1 chips at least have non-NULL txrate
after associated.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index d225a1257530..285acf303e3d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4473,6 +4473,35 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 	priv->rx_buf_aggregation = 1;
 }
 
+static struct ieee80211_rate rtl8xxxu_legacy_ratetable[] = {
+	{.bitrate = 10, .hw_value = 0x00,},
+	{.bitrate = 20, .hw_value = 0x01,},
+	{.bitrate = 55, .hw_value = 0x02,},
+	{.bitrate = 110, .hw_value = 0x03,},
+	{.bitrate = 60, .hw_value = 0x04,},
+	{.bitrate = 90, .hw_value = 0x05,},
+	{.bitrate = 120, .hw_value = 0x06,},
+	{.bitrate = 180, .hw_value = 0x07,},
+	{.bitrate = 240, .hw_value = 0x08,},
+	{.bitrate = 360, .hw_value = 0x09,},
+	{.bitrate = 480, .hw_value = 0x0a,},
+	{.bitrate = 540, .hw_value = 0x0b,},
+};
+
+static void rtl8xxxu_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
+{
+	if (rate <= DESC_RATE_54M)
+		return;
+
+	if (rate >= DESC_RATE_MCS0 && rate <= DESC_RATE_MCS15) {
+		if (rate < DESC_RATE_MCS8)
+			*nss = 1;
+		else
+			*nss = 2;
+		*mcs = rate - DESC_RATE_MCS0;
+	}
+}
+
 static void rtl8xxxu_set_basic_rates(struct rtl8xxxu_priv *priv, u32 rate_cfg)
 {
 	struct ieee80211_hw *hw = priv->hw;
@@ -4534,9 +4563,12 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
 	struct ieee80211_sta *sta;
+	struct rtl8xxxu_ra_report *rarpt;
 	u32 val32;
 	u8 val8;
 
+	rarpt = &priv->ra_report;
+
 	if (changed & BSS_CHANGED_ASSOC) {
 		dev_dbg(dev, "Changed ASSOC: %i!\n", bss_conf->assoc);
 
@@ -4545,6 +4577,10 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		if (bss_conf->assoc) {
 			u32 ramask;
 			int sgi = 0;
+			u8 highest_rate;
+			u8 mcs = 0, nss = 0;
+			u32 bit_rate;
+
 
 			rcu_read_lock();
 			sta = ieee80211_find_sta(vif, bss_conf->bssid);
@@ -4569,6 +4605,29 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				sgi = 1;
 			rcu_read_unlock();
 
+			highest_rate = fls(ramask) - 1;
+			if (highest_rate < DESC_RATE_MCS0) {
+				rarpt->txrate.legacy =
+				rtl8xxxu_legacy_ratetable[highest_rate].bitrate;
+			} else {
+				rtl8xxxu_desc_to_mcsrate(highest_rate,
+							 &mcs, &nss);
+				rarpt->txrate.flags |= RATE_INFO_FLAGS_MCS;
+
+				rarpt->txrate.mcs = mcs;
+				rarpt->txrate.nss = nss;
+
+				if (sgi) {
+					rarpt->txrate.flags |=
+						RATE_INFO_FLAGS_SHORT_GI;
+				}
+
+				rarpt->txrate.bw |= RATE_INFO_BW_20;
+			}
+			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
+			rarpt->bit_rate = bit_rate;
+			rarpt->desc_rate = highest_rate;
+
 			priv->vif = vif;
 			priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
 
-- 
2.20.1

