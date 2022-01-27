Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9249EEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbiA0XOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiA0XOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:14:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21790C061714;
        Thu, 27 Jan 2022 15:14:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id o12so9631187eju.13;
        Thu, 27 Jan 2022 15:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb5S7h5vEH4j6PLl8gEHgLg2lQPOtkXdbOkCBe3z7nE=;
        b=WV5hov4cWwF7URU6ARLMnwqHJrAkYrwQulOpSzevNnVIx8qMnd65H5gBuDOsX3eZgT
         GTiAeadJVJpWE4j0tE9TE7MGfeg96mBjyGrZOpKChPeS3S0oYlC26Bo4fN2J+6YgWynp
         PYtG09/yLwEgurtI+v76y5a97vmf6Ah/ch45cBi4pPdVeW1Vu7ns36mZuXnx9fVQflvK
         pwBm/5hlXjyFsmhmFXhJ15nj6h6dIUjoB2BRLwycrwoYfx0VRV3fCKmw19FRbnF0W7fl
         xbHYk9cVX6T8cstPhpXo+XsvbuQRigHwrTJ7BfQpFoLglqQ7y/H+G8tPcRIjZzk+p/mG
         rMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb5S7h5vEH4j6PLl8gEHgLg2lQPOtkXdbOkCBe3z7nE=;
        b=bV5wiJa0y6RofauAdmuVXxYdgkGXhQCN62HS/R9ur3vJjxQyjeC5G/segaRNXy96lc
         sg9Exl82IIXyYq1rHu9LkCqrq56VrUVsqJLa24iJggtpza7iizwsi8FdgCNC1mzBhDVA
         dwVlol6cBzCxiC6WcuAKL+kWATO7UIXpECfMnWdXy2nUJkFbErh431IfUwbKuhyW1eSz
         6Lw5p0Lmecc9tAFlNdHpdWX93jy3I7lPa89v9/YyHLuIk0TjN+0mqbHV//flzhBjaA9L
         j2HeHLhxL6ICqDjirRuoMNsKEDuIoY2BM/ny9eiKEA7CakkN5iPDjNVsjdrWLRcGh67n
         edbg==
X-Gm-Message-State: AOAM531rYOH10rk4k3kHO9Rqy5x1vHjNBbj1DNF2cznoFBgXI95a5YVs
        BqV3aQ8qT107sfUayeK8zY8=
X-Google-Smtp-Source: ABdhPJzRksP/JHcuQfynUTc1phJFCHEtp6tGnwBA811y0xvF+pMmmp3m3pB29kEFyygQ+n+FjJssng==
X-Received: by 2002:a17:907:3d9e:: with SMTP id he30mr4672928ejc.625.1643325282682;
        Thu, 27 Jan 2022 15:14:42 -0800 (PST)
Received: from tom-desktop.station (host-87-19-2-173.retail.telecomitalia.it. [87.19.2.173])
        by smtp.gmail.com with ESMTPSA id p23sm11867904edx.86.2022.01.27.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 15:14:42 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: usb251xb: add boost-up property support
Date:   Fri, 28 Jan 2022 00:14:37 +0100
Message-Id: <20220127231437.10893-1-tomm.merciai@gmail.com>
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
Changes since v1:
 - Fix patch as suggested by RLeitner

 drivers/usb/misc/usb251xb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 507deef1f709..b60ab148e6ac 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -543,6 +543,8 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
 		hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
 
+	of_property_read_u8(np, "boost-up", &hub->boost_up))
+
 	cproperty_char = of_get_property(np, "manufacturer", NULL);
 	strlcpy(str, cproperty_char ? : USB251XB_DEF_MANUFACTURER_STRING,
 		sizeof(str));
@@ -584,7 +586,6 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	 * may be as soon as needed.
 	 */
 	hub->bat_charge_en = USB251XB_DEF_BATTERY_CHARGING_ENABLE;
-	hub->boost_up = USB251XB_DEF_BOOST_UP;
 	hub->boost_57 = USB251XB_DEF_BOOST_57;
 	hub->boost_14 = USB251XB_DEF_BOOST_14;
 	hub->port_map12 = USB251XB_DEF_PORT_MAP_12;
-- 
2.25.1

