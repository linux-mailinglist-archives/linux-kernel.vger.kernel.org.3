Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFC2502805
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352147AbiDOKPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiDOKPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:15:47 -0400
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 03:13:18 PDT
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0180BA330;
        Fri, 15 Apr 2022 03:13:18 -0700 (PDT)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 2840520E0A;
        Fri, 15 Apr 2022 10:07:01 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 8BD71206D3;
        Fri, 15 Apr 2022 10:06:57 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 31FDF2000D;
        Fri, 15 Apr 2022 10:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 2440D2A7E6;
        Fri, 15 Apr 2022 10:06:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OuEKGbB-6jHn; Fri, 15 Apr 2022 10:06:54 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 15 Apr 2022 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [121.33.113.66])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 47B2D405CE;
        Fri, 15 Apr 2022 10:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1650017213; bh=Q/Ove5tJqs+Tr496dhIgfjb8Pyl80BkiMfu2H5/DRtA=;
        h=From:To:Cc:Subject:Date:From;
        b=BLW4TZN+tyuH1XcvpgGK4QaPUEeuvjd+Bu+EUntOHytE9wiaAx/xoQS0g4+6yrI6A
         3k0lUpBE4vPJKvUPLzL/R1/8+e+nPwn9WdK+mR1NuKxxyTCC5Ph+11zHJXdDYP6E/f
         jdd15hkRtmMHfbSpHCTRVB8trj4td8gxlyiLHa/w=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     "Daniel J . Ogorchock" <djogorchock@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] HID: nintendo: deregister home LED when it fails
Date:   Fri, 15 Apr 2022 18:04:32 +0800
Message-Id: <20220415100432.23453-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Pro Controller compatible controllers do not support home LED, and
will fail when setting it. Currently this leads to probe failure.

Change the code that fails probing to deregistering home LED.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/hid/hid-nintendo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 2204de889739..ed93287c3afc 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -1900,9 +1900,8 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 		/* Set the home LED to 0 as default state */
 		ret = joycon_home_led_brightness_set(led, 0);
 		if (ret) {
-			hid_err(hdev, "Failed to set home LED dflt; ret=%d\n",
-									ret);
-			return ret;
+			hid_warn(hdev, "Failed to set home LED dflt, unregistering home LED");
+			devm_led_classdev_unregister(&hdev->dev, led);
 		}
 	}
 
-- 
2.35.1

