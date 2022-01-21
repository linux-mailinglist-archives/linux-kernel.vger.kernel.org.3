Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E156496834
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiAUX0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiAUX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:26:18 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05E6C06173B;
        Fri, 21 Jan 2022 15:26:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m4so4079430ejb.9;
        Fri, 21 Jan 2022 15:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCU0SvpwBWqNgpzxHc2heSOx4bLvLb/sHtBDZ1Gl2Cc=;
        b=dYuucwy7B8NsSK/Yls5haOdLoFor30tlQ2n4U3tkdADfEhRd+ntO4xodHu979K86hd
         DG+V5mjZwU+B5GlohGfv9g7C78NfY6EPmYX9cpEKwuuni0OnVpc6OnBsDNBeRJ7SOP5d
         vH2+E0Zv0cT8Sm3dMv99Hg4CU3VSR86FjA8db7YEQbb8LfptYvhKZ9LZaCAM8kFwmOX6
         AX29ergf+QjOrh7WtvsqZAzqDJev1nzB/nbFMRyfUD7eTEpDfE642m6QlyMB3PxArd3/
         2YkcocYxXr7St+1oEeunQMRELw+MCu6M6HQuGlwELHItlv+kOVz0XKzea0yyCWCm9H+E
         sFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCU0SvpwBWqNgpzxHc2heSOx4bLvLb/sHtBDZ1Gl2Cc=;
        b=QDEWdAwnGl0nui1490Qn2nSqMzqH3mjVANVjnB08z/u8pCWiwXz96TLMkT3qknFrk+
         CfQDNvz/QizfnNL5S0GPr9RSbHbNEZ+LEFdzCrfmqMN6Nbd7/UZV3edRrSHKeDA4KrpH
         OXbu4AZoWi/sUokOBcLsT0m9ivLhBoxB4jEzSkDMh4TOMFvMRHrt7jT7ulbFzgEgY2U+
         AYO85WvuOipRnyNzdGTm2hnKxBTdeBvZLGtOcOKsR3pejWlkBG4YR55dLHxglLncGJqh
         +EVSFn4PwnG74Muu4Mck4c/am7l7Ji40s/XEaQHWv8CRmALfW71mK4FYADmdTZ33fOcn
         f3WA==
X-Gm-Message-State: AOAM530S1N0l0PpQcBJ90J3bFXk1WH5546p6bMBeSAkpGBtV6IjkZOz5
        AVgRFQ2EtyAkoD9QG+G6Nuc=
X-Google-Smtp-Source: ABdhPJzUq/HlNkUY9Bz2+wNtKp7xTSqdnO9WFCPCY/AHs+0sFqx4rAadCNs3xfw3qPNKSPL/cp2obQ==
X-Received: by 2002:a17:907:97ca:: with SMTP id js10mr5263243ejc.78.1642807576191;
        Fri, 21 Jan 2022 15:26:16 -0800 (PST)
Received: from localhost.localdomain (mob-5-90-199-161.net.vodafone.it. [5.90.199.161])
        by smtp.gmail.com with ESMTPSA id p13sm2411025ejx.191.2022.01.21.15.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 15:26:15 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usb251xb: add boost-up property support
Date:   Sat, 22 Jan 2022 00:26:12 +0100
Message-Id: <20220121232612.7283-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add u8 property to support boost-up register of usb251xb hub.
boost-up property control USB electrical drive strenght
This register can be set:

 - Normal mode -> 0x00
 - Low         -> 0x01
 - Medium      -> 0x10
 - High        -> 0x11

(Normal Default)

References:
 - http://www.mouser.com/catalog/specsheets/2514.pdf p29

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/usb/misc/usb251xb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 507deef1f709..74fd8ac0c303 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -402,6 +402,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	struct device_node *np = dev->of_node;
 	int len, err;
 	u32 property_u32 = 0;
+	u8 property_u8 = 0;
 	const char *cproperty_char;
 	char str[USB251XB_STRING_BUFSIZE / 2];
 
@@ -543,6 +544,12 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
 		hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
 
+	if (!of_property_read_u8(np, "boost-up", &property_u8)){
+		hub->boost_up = property_u8;
+	} else {
+		hub->boost_up = USB251XB_DEF_BOOST_UP;
+	}
+
 	cproperty_char = of_get_property(np, "manufacturer", NULL);
 	strlcpy(str, cproperty_char ? : USB251XB_DEF_MANUFACTURER_STRING,
 		sizeof(str));
@@ -584,7 +591,6 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	 * may be as soon as needed.
 	 */
 	hub->bat_charge_en = USB251XB_DEF_BATTERY_CHARGING_ENABLE;
-	hub->boost_up = USB251XB_DEF_BOOST_UP;
 	hub->boost_57 = USB251XB_DEF_BOOST_57;
 	hub->boost_14 = USB251XB_DEF_BOOST_14;
 	hub->port_map12 = USB251XB_DEF_PORT_MAP_12;
-- 
2.25.1

