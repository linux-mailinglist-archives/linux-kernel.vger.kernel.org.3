Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAEA468A4B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 10:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhLEKCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 05:02:16 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53040
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230470AbhLEKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 05:02:15 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 08EB13F1F9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638698326;
        bh=w6+BoYvnmAnd+GSm1CSG2oy2MCenL4FLdq4APeVFVSU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JIipumdHTrm+xysfZT0pVQNESowyy6Q3j1rnqYZ78NO+ZB82VH07/PGe7Ag9Dg3u4
         Fz75s5TuPb1lbUnHDDYXulYMDzcJM815jhl2Yi4BwPAI2TtD5YwFLafk5b6kyExF00
         2OASB6w+f2TdVHQlFLHIeFeTWND+3dpr3XxgYVnvkhahuKaCE/7hBsEkBb73XmK0J3
         pS7ZwfbG1PjtD3MNY4bRte9jRxT6kubAdcSRJ4j7gBgjdhSsjqBeDODxJYcCx4dk/P
         0Tda3vEA81bGK/29sUSynSsFlTp/lL+6ZdfFe25Zl/XxQcINfYiZjFjD2fhuEBpYQM
         VLhxgRSktF3EA==
Received: by mail-pf1-f197.google.com with SMTP id q82-20020a627555000000b004a4f8cadb6fso4765644pfc.20
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 01:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6+BoYvnmAnd+GSm1CSG2oy2MCenL4FLdq4APeVFVSU=;
        b=11fcO5hrDIQZE85eigUtiJB8vlcvsFqMF7umGsKAGN44WgfnI45wGKidrjWD7Xs320
         kNF1xQcARh0v9BapAmkEHzv0m0l5hBBxU/IwgujQKotGyxtyJo6vg/mLaQRn0GnR863M
         /XeHB5YIKMteclod9et3BEFEO1c3nohxDsMkcdIn5k8yElSB91ipgud0RQDHuuA+vvwU
         JqrsbzAnVQctA0+8PoJdXdrp7SKyfnSV+IRKL24aqjiCzqWIkCDhBACIrCnLQwqtkZDz
         NDLe7LlYtMQ0nQ4od/spW9dC7xpzuGmJ1q1/xon4RxYFpq9fspOzNA49xNDhWDpxZTDK
         K7gA==
X-Gm-Message-State: AOAM5309IrqrOxO7Q7uSSH0v2a+qZpeYFXIYWNW+GxCViZyzbkvj8yVQ
        d4A+qx9VXTeUwtX5Kh6YZWkHJDDNOS1b1xRj5J5F6ndIffQUlmSM8Lzs8TZCUKhj6DANxMA2V4/
        AzR2+8gwbAvA5k+2Gl8Rx/xzrJdFLJsCeyCq+amllfA==
X-Received: by 2002:a17:90b:2309:: with SMTP id mt9mr28922898pjb.213.1638698324297;
        Sun, 05 Dec 2021 01:58:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrc9ZXCA/OWrksKqJj/Yc/lW+qDW0JLGL6vWbPZBjDotrMYhiJGa9oqA+YnQYbTSwbJxyfPg==
X-Received: by 2002:a17:90b:2309:: with SMTP id mt9mr28922872pjb.213.1638698323970;
        Sun, 05 Dec 2021 01:58:43 -0800 (PST)
Received: from localhost.localdomain (2001-b011-3814-fb66-6609-6116-8fb8-c749.dynamic-ip6.hinet.net. [2001:b011:3814:fb66:6609:6116:8fb8:c749])
        by smtp.gmail.com with ESMTPSA id n16sm7028882pja.46.2021.12.05.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 01:58:43 -0800 (PST)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] rtl8xxxu: Improve the A-MPDU retransmission rate with RTS/CTS protection
Date:   Sun,  5 Dec 2021 17:58:36 +0800
Message-Id: <20211205095836.417258-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A-MPDU retransmission rate is always high (> 20%) even in a very
clean environment. However, the vendor driver retransimission rate is
< 10% in the same test bed. The different is the vendor driver starts
the A-MPDU TXOP with initial RTS/CTS handshake which is observed in the
air capture and the TX descriptor. Since there's no related field in
TX descriptor to enable the L-SIG TXOP protection and the duration,
applying the RTS/CTS protection instead helps to lower the retransmission
rate from > 20% to ~12% in the same test setup.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index a42e2081b75f..06d59ffb7444 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4859,7 +4859,7 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	 * rts_rate is zero if RTS/CTS or CTS to SELF are not enabled
 	 */
 	tx_desc->txdw4 |= cpu_to_le32(rts_rate << TXDESC32_RTS_RATE_SHIFT);
-	if (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS) {
+	if (ampdu_enable || (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS)) {
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_RTS_CTS_ENABLE);
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_HW_RTS_ENABLE);
 	} else if (rate_flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
@@ -4930,7 +4930,7 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 	/*
 	 * rts_rate is zero if RTS/CTS or CTS to SELF are not enabled
 	 */
-	if (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS) {
+	if (ampdu_enable || (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS)) {
 		tx_desc40->txdw3 |= cpu_to_le32(TXDESC40_RTS_CTS_ENABLE);
 		tx_desc40->txdw3 |= cpu_to_le32(TXDESC40_HW_RTS_ENABLE);
 	} else if (rate_flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
-- 
2.25.1

