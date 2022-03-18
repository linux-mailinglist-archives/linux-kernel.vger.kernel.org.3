Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E44DD332
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiCRCoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiCRCoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:44:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4C2C74B1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:43:00 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1C56E3F1D2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647571377;
        bh=IsQNvnrYzFlByVho6HFj26Mu5PXAjpXD97Wru1aaDTM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Q/bTcGQrI2ntRSQUP5/O5IB6Pe8MaHpDYBytW0dEBlkf/hp7LbqZQgij08fbYjfDh
         IxJIN5iWSK4ux+eB2LNsIfITmqqQtuvjEdITpRv3R93Mtd7YXoiCoZqOGrEQRUZj26
         UF/JPAXIwdCsreXPTg9/KFbc9injf5kfzQyyEVAVU151q7s0Ks8Wy+lq7TZqCqPzfU
         4vQZoXtynO4Lz/VWdV+kRnjfapQq4c5zqLSWkT6DD/RvnXiwLrK0Fxki7ehcZgmT86
         YMM9Ndhfo/QZtazT4VOR4PvFRlKFvFI53ou4/+hKgP9tVdHfDqaceW8R1/pSMnrCKB
         szbgh9Z3Z3yKA==
Received: by mail-pj1-f72.google.com with SMTP id o6-20020a17090a9f8600b001c640fa1499so4295240pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IsQNvnrYzFlByVho6HFj26Mu5PXAjpXD97Wru1aaDTM=;
        b=RKbx2HtUbl3T/zZHh7O5FvJu6XOjdZ0JWRa4+L7Bm3zBpDZPzDja5Fm18qdhf0SGJW
         SZ4vlWBMaw/VVPGSMlrIE2X0yb+hSWmyBNQRs/Uwi57hbqap4KQpelvskzoGNS0r6kiZ
         Sax8hmnAUQbIJkBq7FdVwVjlipWCdpaolI36CkuAFvRRMOlkIx+zJEwnI63nNqivGFDH
         tjXT0bf67D8pxpo0AI9Bv7qMtx2z+mdXZoUJ3awWZ2QAGnUImHLsYTMPD3WMq3pG2dQG
         my6QRgxvYjyQFkBMoGnpkhit+cs8HFnjpFSwS2nsVjf2uU1pYkS+KrEEsI1NHJyP11zA
         lhVA==
X-Gm-Message-State: AOAM533uJkV7dHPW6s1aCrtgL2vkdWONfYMOBd8/b8JOaJ5I3AVLx+AH
        fmQMgmtIMOix6UVc6MAb9pQv05gK1vmbyxbGub9KLd6f1ZM+n5xa+Lklx14tvRW2I6nH/ZsoEXW
        QnEkqCzu4tA0ZiYv74Fj8uiKkJidNbrxlZR3MYlUJRg==
X-Received: by 2002:a17:902:be14:b0:14f:ce67:d0a1 with SMTP id r20-20020a170902be1400b0014fce67d0a1mr7647159pls.29.1647571375717;
        Thu, 17 Mar 2022 19:42:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWDlX7R0u3bbFhyd2lD9L026rsWS+K74zpJKVsaJKOqtXpz80a93XUCWWuMOjElFNq5i7sfw==
X-Received: by 2002:a17:902:be14:b0:14f:ce67:d0a1 with SMTP id r20-20020a170902be1400b0014fce67d0a1mr7647141pls.29.1647571375385;
        Thu, 17 Mar 2022 19:42:55 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e287-a413-5915-32ac-82c3-a966.emome-ip6.hinet.net. [2001:b400:e287:a413:5915:32ac:82c3:a966])
        by smtp.gmail.com with ESMTPSA id v16-20020a056a00149000b004f7ae2cbd3asm8191232pfu.166.2022.03.17.19.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 19:42:55 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     kvalo@kernel.org, Jes.Sorensen@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2 1/2] rtl8xxxu: feed antenna information for cfg80211
Date:   Fri, 18 Mar 2022 10:42:15 +0800
Message-Id: <20220318024216.42204-2-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220318024216.42204-1-chris.chiu@canonical.com>
References: <20220318024216.42204-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill up the available TX/RX antenna so the iw commands can show
correct antenna information for different chips.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 06d59ffb7444..d225a1257530 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1607,6 +1607,7 @@ static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
 static int rtl8xxxu_identify_chip(struct rtl8xxxu_priv *priv)
 {
 	struct device *dev = &priv->udev->dev;
+	struct ieee80211_hw *hw = priv->hw;
 	u32 val32, bonding;
 	u16 val16;
 
@@ -1684,6 +1685,9 @@ static int rtl8xxxu_identify_chip(struct rtl8xxxu_priv *priv)
 		priv->has_wifi = 1;
 	}
 
+	hw->wiphy->available_antennas_tx = BIT(priv->tx_paths) - 1;
+	hw->wiphy->available_antennas_rx = BIT(priv->rx_paths) - 1;
+
 	switch (priv->rtl_chip) {
 	case RTL8188E:
 	case RTL8192E:
@@ -4282,6 +4286,17 @@ static void rtl8xxxu_cam_write(struct rtl8xxxu_priv *priv,
 	rtl8xxxu_debug = tmp_debug;
 }
 
+static
+int rtl8xxxu_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	*tx_ant = BIT(priv->tx_paths) - 1;
+	*rx_ant = BIT(priv->rx_paths) - 1;
+
+	return 0;
+}
+
 static void rtl8xxxu_sw_scan_start(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif, const u8 *mac)
 {
@@ -6472,6 +6487,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.set_key = rtl8xxxu_set_key,
 	.ampdu_action = rtl8xxxu_ampdu_action,
 	.sta_statistics = rtl8xxxu_sta_statistics,
+	.get_antenna = rtl8xxxu_get_antenna,
 };
 
 static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
-- 
2.20.1

