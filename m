Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE794E6CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbiCYD7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347333AbiCYD7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:59:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1FDC55B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:57:57 -0700 (PDT)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5E6B03F19D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648180674;
        bh=sBm+dzND20zvV48a+5lKby5znKuzcId45M5VCBIr4Hk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VLLmtYt6o+k0PKfzkW9SWONeLDZryqh0/ZHvob5p4q3G/7Zlg2VhtbUTgj5ZrBCvx
         QMTRCpAn7gvSR9xAjfjcD6CX37jy1VvYB7FdekeE+un2fMt7a1OGMBzphlkR1vTdO0
         +t12SrhkFYvG56U7SZBTTALaLA+Bm6MgbJhVdMRXHXqiEfRpzFkwNgJXo93AANByWa
         b+YQbrcLJRh2B1bu7eijSV96xvkgeJ2Sd9I1hY1pPM7FBB92gXzbMU94lOwmvqZd32
         700iN5j1whoankADdwqbujsmAQ6oCRkgAvbk5hI8JjxySDLeMReGoVci5oeS7brSmg
         as4cTMEqpQF4w==
Received: by mail-pl1-f199.google.com with SMTP id b4-20020a170902e94400b0015309b5c481so3550737pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBm+dzND20zvV48a+5lKby5znKuzcId45M5VCBIr4Hk=;
        b=64wXDkDbIv55bZnIBvnahAgrnZP1BgEBbJAq0V6Q866jY06I0Lj+6wVxXJc2R/YBk2
         nzJwK6CzYf/BppUA/EtenLn1YIKPLvK3NN4xaWMciaf0iTP0Qg32i/PrifYe21ZPQfgz
         iBHy2JXYL/MPSjr7mXWKcAVRVxN+4WZeaR+gvTsSC48RgAUxb9hUzM0cTRPlgd6XSW4z
         FGWjyUGanm1PlDEIgqxXmOQ+UQA1x9vZ5AKVYfNC8FgP/1YI5uca+xzkEKqHr/KKb0aW
         F/atEKOvlnBwUHh2RrM6U8/QAtYReYqpvM66dvW5EYevg0VUvu3udhLsPCahwNkqnRqe
         xnBA==
X-Gm-Message-State: AOAM533YxYIOiLy2H4wLmptkL+kY8xemKoUJqE+H7yRXCW1Y/5ejrryT
        7jrFMmb5XS8uh1noIpUp30WqgwNgGSoLchGD6VBapS1KGq8waqaWZq20r7N5P1jfmzM3ubdVXAW
        A316021OLFCGxHiR2yht5QErnRO/cXq1OpgzZYwgVZQ==
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id j15-20020a056a00234f00b004faf52b46a1mr5114519pfj.32.1648180672961;
        Thu, 24 Mar 2022 20:57:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/IuahQpQ0LUgvUGC1C+LbOiyBqHg4NscrDf4ccSD492uSz6kUcrRNBVv3Md3kTWuzNsvIGw==
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id j15-20020a056a00234f00b004faf52b46a1mr5114500pfj.32.1648180672642;
        Thu, 24 Mar 2022 20:57:52 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e286-bae1-8fdb-11c6-cf63-1f23.emome-ip6.hinet.net. [2001:b400:e286:bae1:8fdb:11c6:cf63:1f23])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm3825801pgb.11.2022.03.24.20.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:57:52 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     kvalo@kernel.org, Jes.Sorensen@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v3 1/2] rtl8xxxu: feed antenna information for cfg80211
Date:   Fri, 25 Mar 2022 11:57:34 +0800
Message-Id: <20220325035735.4745-2-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325035735.4745-1-chris.chiu@canonical.com>
References: <20220325035735.4745-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.25.1

