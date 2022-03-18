Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493A84DD333
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiCRCod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiCRCoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:44:23 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012BF55C1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:43:03 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B4863F614
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647571381;
        bh=f9EJWx0pz9xYZ/T46QT2nYRC6HKLvwA6csw+2PrRGps=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YLRzvp92GBU4FRz4LgaQrk/bEqU17GjVC9tvxbA1F8IEVJKfY/3HDO7SlvD0giA38
         9te1CQv6x/D4u7io/DbKFWyBmpzEQ8rH8BvyQk39aC+6NlG/aPVgVTnA1RF5vlOOtg
         yYGKt6KvrsON0DH7a+bYWGDlodZnmbAnAE39N2PEVUko3hQlGEfELT9SCeHb/1oYKT
         HF86+kQJElm3J+pztcsxHjli19O65zzgPRYjz4Mqa5j48x2rGvZjKayNSvJgeryPqn
         IUvKGdERb0jHEM1L/tpYew30LYbjWKQ7qCg7jVHt6nXlLniRbH+Ad6qihNF6WZoFAw
         gVp/qwpfM+Hbg==
Received: by mail-pf1-f200.google.com with SMTP id w19-20020aa79553000000b004fa64758b82so1204940pfq.22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9EJWx0pz9xYZ/T46QT2nYRC6HKLvwA6csw+2PrRGps=;
        b=B17ubHQR9USyBXt3mAJm2fJFLr3ir+I42sH8TXXJXo51w5jV1QLF/s9wVN6b5qGNeo
         QXZd3y2um7iL5WLkgldoditqaFrWBe7pZUdi96SA/S+6F3Ri5qROPHHiU7HHAbbWXuj1
         HbYuo8Aq4zTRTbORujYCbJL5cJjDrvhUpHQ/PxLz4Qa9gMM/EiU3w7VqkWzckMNbbM+F
         Qy/gh6bYFtNNoMFCOO7EL6qpsaxveDH/D52Q4Fx2jxy+tH9lkTM/XgZPZJM1Kd+AkJrp
         goKbtlECcnJAUmNEhNkOoe9oY+5TBcNK6eNJ6auNGcpIhPBIhBD4oPFk960LAvF+MJb3
         aSeQ==
X-Gm-Message-State: AOAM530VQukKaaL6AZB0md9kGQ1T/YGaHZ5eUBLAvDUoHyo391ggulJo
        t+FKIC4NRtS/xTvW+Xdu5ERZVKGDbVk0KngckJyEC4mc14GaSth6jN707s+/PaBJrlAApxkZL4Y
        vuK2H7y/OsxfQGnKpMbj0Cyz7zqr86bT0bhZtgB9Ufw==
X-Received: by 2002:a17:902:bd87:b0:153:ceb:3a6d with SMTP id q7-20020a170902bd8700b001530ceb3a6dmr7811838pls.146.1647571379133;
        Thu, 17 Mar 2022 19:42:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykrTwLqVp8lScEdbYiq8EeLrP9LGRMLzx7tFiMg0QnklPTnrHP6GdA0fMNW/PbHzHpC5KKgQ==
X-Received: by 2002:a17:902:bd87:b0:153:ceb:3a6d with SMTP id q7-20020a170902bd8700b001530ceb3a6dmr7811824pls.146.1647571378831;
        Thu, 17 Mar 2022 19:42:58 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e287-a413-5915-32ac-82c3-a966.emome-ip6.hinet.net. [2001:b400:e287:a413:5915:32ac:82c3:a966])
        by smtp.gmail.com with ESMTPSA id v16-20020a056a00149000b004f7ae2cbd3asm8191232pfu.166.2022.03.17.19.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 19:42:58 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     kvalo@kernel.org, Jes.Sorensen@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2 2/2] rtl8xxxu: fill up txrate info for gen1 chips
Date:   Fri, 18 Mar 2022 10:42:16 +0800
Message-Id: <20220318024216.42204-3-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220318024216.42204-1-chris.chiu@canonical.com>
References: <20220318024216.42204-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changelog:
  v2:
   - Use the 'static const' for rtl8xxxu_legacy_ratetable[]

 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index d225a1257530..cc9d14e9c4c4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4473,6 +4473,35 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 	priv->rx_buf_aggregation = 1;
 }
 
+static const struct ieee80211_rate rtl8xxxu_legacy_ratetable[] = {
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

