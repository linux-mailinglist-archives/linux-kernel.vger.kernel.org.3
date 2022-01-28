Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D6B49FFFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbiA1SRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiA1SRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:17:19 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C2C061714;
        Fri, 28 Jan 2022 10:17:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id h7so18792107ejf.1;
        Fri, 28 Jan 2022 10:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8O3rGjC38oQUzyX/XJmlUBZVdUYy2/jQimRxEDGlr8=;
        b=es7Bpri9Zwuwrxwo/wQ5YeVCjf59sgdN8no2PZlAC12u9GKRQbhzFix9s/7Tb6fdSp
         JA+iNskxWfQdytT7+KKdx+b8pWuXNfswSFoCaL334qfvivPaGm9m++LPP2sjna8KOkKn
         9copo2gJ0m7huB6j/mThrCh+ilbkzjwVvuRCmPgz5nQB87xw8HAkJMw6RpGcT1I5OqnM
         6oDMAVTYdJ68J5vwgNuJsrEx2QZzTFpedSf25b93T3IX7KsB2mAXzQzHbmfHjxROJaDo
         0hE86RrZAXo2E6p01eKT+Pk8DiZyY8gQamnHn6gy+9FNXI0I9hDEG0hne3iQhjqa7hPx
         uxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8O3rGjC38oQUzyX/XJmlUBZVdUYy2/jQimRxEDGlr8=;
        b=f+WyX+Afa0kFwYdn2DlBJ2H2KWBU2elOjRZr5K3ghF84JGYiVwvHpq+o4nk3VBUi+N
         xfAT93PS0UPvKfiMqsnfk4FpW7TqbrbuXn3RYfzixdmBuvebj3bt4ImePUsOnBS3CTOP
         WNdlinI6nhXZl5zaExo6z1ELK2PZN8W+2tDgVEINXwzAGsGDB6Yi8nhNMYgvwlfbJSV1
         mn/4tGjoR1n1gVQKEeKIKFom+M4kBcGENgvh6w/5M98Rew+XbROnIdyty1CxoLrY5WSA
         dQaP1+FVe9B4s0EhkbEojEVQzACgqhsGbSBkwHg/n7WXkFp2D18Ew4KHdZC057gaL1zz
         O4iw==
X-Gm-Message-State: AOAM533EY0lwS9HN4EaSAXGS1qAJoJQHFMou4nt0uJIpNYInOD8uEh4i
        98Aws43RialjnZaWgL2tyRkXJ6EyEho=
X-Google-Smtp-Source: ABdhPJyztTf8rpQnXUP4NO3iVfHd+BWSxR+UryNk4UFhdIZDpbvghmKsn5AGHz9dbYBjdiqyJMdrIw==
X-Received: by 2002:a17:907:3f9f:: with SMTP id hr31mr7736927ejc.584.1643393837012;
        Fri, 28 Jan 2022 10:17:17 -0800 (PST)
Received: from tom-desktop.station (net-188-217-50-123.cust.vodafonedsl.it. [188.217.50.123])
        by smtp.gmail.com with ESMTPSA id m13sm10219615eja.160.2022.01.28.10.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 10:17:16 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: usb251xb: add boost-up property support
Date:   Fri, 28 Jan 2022 19:17:13 +0100
Message-Id: <20220128181713.96856-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for boost-up register of usb251xb hub.
boost-up property control USB electrical drive strength
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
Changes since v1:
 - Fix patch as suggested by RLeitner

Changes since v2:
 - Fix commit body as suggested by Shtylyov
 - Fix commit msg
 - Fix patch as suggested by RLeitner and Shtylyov

 drivers/usb/misc/usb251xb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 507deef1f709..04c4e3fed094 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -543,6 +543,9 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
 		hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
 
+	if (of_property_read_u8(np, "boost-up", &hub->boost_up))
+		hub->boost_up = USB251XB_DEF_BOOST_UP;
+
 	cproperty_char = of_get_property(np, "manufacturer", NULL);
 	strlcpy(str, cproperty_char ? : USB251XB_DEF_MANUFACTURER_STRING,
 		sizeof(str));
@@ -584,7 +587,6 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	 * may be as soon as needed.
 	 */
 	hub->bat_charge_en = USB251XB_DEF_BATTERY_CHARGING_ENABLE;
-	hub->boost_up = USB251XB_DEF_BOOST_UP;
 	hub->boost_57 = USB251XB_DEF_BOOST_57;
 	hub->boost_14 = USB251XB_DEF_BOOST_14;
 	hub->port_map12 = USB251XB_DEF_PORT_MAP_12;
-- 
2.25.1

