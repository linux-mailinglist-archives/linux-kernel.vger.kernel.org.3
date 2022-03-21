Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E74E2D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350994AbiCUQPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350873AbiCUQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:14:03 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1558968FA0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=7PuDj/QvUlUETX
        QKpnDRaKbIKjsepWpqguWN/JmA+9c=; b=v38BD8DOtXp5s4tRiDWeEbm0XfBKrl
        UBSa7ZUb1i+/7TZnvziBhbaqcjdwTk7UQnzPKWnKnCBjP967vEKBVLpXy1GPLdRW
        1rftaHJQd+RJguZBa+To+xGqyInOxYno0fJgE7VPzaWCIHBZS6nb5zmXHGX83tjD
        ozRfxZ8ty87dw=
Received: (qmail 957937 invoked from network); 21 Mar 2022 17:12:34 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:34 +0100
X-UD-Smtp-Session: l3s3148p1@kQeYw7zaLtkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 11/15] net: wireless: realtek: rtw88: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:19 +0100
Message-Id: <20220321161223.2837-12-wsa+renesas@sang-engineering.com>
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

 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 35c46e5209de..01e934c7b97f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1476,12 +1476,12 @@ static void rtw8822c_txgapk_read_offset(struct rtw_dev *rtwdev, u8 path)
 	rtw_write32_mask(rtwdev, REG_IQKSTAT, MASKBYTE0, 0x0);
 
 	rtw_write32_mask(rtwdev, REG_TX_TONE_IDX, MASKBYTE0, 0x018);
-	fsleep(1000);
+	usleep_autoyield(1000);
 	if (channel >= 1 && channel <= 14)
 		rtw_write32_mask(rtwdev, REG_R_CONFIG, MASKBYTE0, BIT_2G_SWING);
 	else
 		rtw_write32_mask(rtwdev, REG_R_CONFIG, MASKBYTE0, BIT_5G_SWING);
-	fsleep(1000);
+	usleep_autoyield(1000);
 
 	rtw_write32_mask(rtwdev, REG_NCTL0, MASKDWORD, cfg1_1b00[path]);
 	rtw_write32_mask(rtwdev, REG_NCTL0, MASKDWORD, cfg2_1b00[path]);
@@ -2905,7 +2905,7 @@ static void rtw8822c_do_lck(struct rtw_dev *rtwdev)
 
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_SYN_CTRL, RFREG_MASK, 0x80010);
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_SYN_PFD, RFREG_MASK, 0x1F0FA);
-	fsleep(1);
+	usleep_autoyield(1);
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_AAC_CTRL, RFREG_MASK, 0x80000);
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_SYN_AAC, RFREG_MASK, 0x80001);
 	read_poll_timeout(rtw_read_rf, val, val != 0x1, 1000, 100000,
@@ -2915,7 +2915,7 @@ static void rtw8822c_do_lck(struct rtw_dev *rtwdev)
 
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_FAST_LCK, RFREG_MASK, 0x0f000);
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_FAST_LCK, RFREG_MASK, 0x4f000);
-	fsleep(1);
+	usleep_autoyield(1);
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_FAST_LCK, RFREG_MASK, 0x0f000);
 }
 
-- 
2.34.1

