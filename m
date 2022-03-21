Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C44E2D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350932AbiCUQOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350770AbiCUQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:13:59 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC8176299
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=cunoTtoK2oBcz7
        VzEx0UYPGYOFgkoQ8XHd1+3sWASlQ=; b=Aohll0Vd/p4kbzsZ+4UQT12OrIw22L
        aS2TiZhaIBJuEwJnJcGDT7IMbHWog/mbrvAzV0ng45Xccx1julWgTPwRmi8vR1Nz
        EWid0qYB+OVQ3g+WVuENoSTN9Kh9kyvpZGfFFE6OQ8Z4CsAu/Nc64xiuSFUW4nOo
        yO3HmrFlRktnk=
Received: (qmail 957867 invoked from network); 21 Mar 2022 17:12:32 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:32 +0100
X-UD-Smtp-Session: l3s3148p1@GTuAw7zaKNkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 08/15] net: ethernet: realtek: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:16 +0100
Message-Id: <20220321161223.2837-9-wsa+renesas@sang-engineering.com>
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

 drivers/net/ethernet/realtek/r8169_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 19e2621e0645..ec39b5b98cfb 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -727,7 +727,7 @@ static bool rtl_loop_wait(struct rtl8169_private *tp, const struct rtl_cond *c,
 	for (i = 0; i < n; i++) {
 		if (c->check(tp) == high)
 			return true;
-		fsleep(usecs);
+		usleep_autoyield(usecs);
 	}
 
 	if (net_ratelimit())
@@ -2468,7 +2468,7 @@ static void rtl_wait_txrx_fifo_empty(struct rtl8169_private *tp)
 static void rtl_enable_rxdvgate(struct rtl8169_private *tp)
 {
 	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | RXDV_GATED_EN);
-	fsleep(2000);
+	usleep_autoyield(2000);
 	rtl_wait_txrx_fifo_empty(tp);
 }
 
@@ -3972,11 +3972,11 @@ static void rtl8169_cleanup(struct rtl8169_private *tp, bool going_down)
 		break;
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_63:
 		rtl_enable_rxdvgate(tp);
-		fsleep(2000);
+		usleep_autoyield(2000);
 		break;
 	default:
 		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
-		fsleep(100);
+		usleep_autoyield(100);
 		break;
 	}
 
-- 
2.34.1

