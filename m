Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38A7467DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbhLCTDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:03:01 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42294 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhLCTDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:03:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3613CE25FC;
        Fri,  3 Dec 2021 18:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B683C53FCD;
        Fri,  3 Dec 2021 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638557973;
        bh=v6upHILxwKRki9NOf8KMMzBsuSghoi0VfD+lJeZOYyE=;
        h=From:To:Cc:Subject:Date:From;
        b=st1VBbjxJpGD3HJQyYny/C0aU3Po3oHaStuJYyLZ2KrYp6WJtWJ7SJGpzwNtSrAb6
         oFHJm8MoYxY0ZnLEyDqbuHpgF0p1rDR1BfJWGzQNFmkWlM2hftiLojrkmfR+7DlRkU
         fcLcN4u93LTgoB5EpxKQN9DGTw8n+iTcSFfdaInaRAcawI5t1Vhi7pub75nQW10w+P
         KDbps4TP47tNkpVXN2prKms+OljsUCkrui7UD9E2VbiaeSAgmzZ/7GT9lRdtqBUb0m
         riOxBuPHZNUbSclge08kHJuM+oPa3HEJb+2skBvE53cQVAPCHgYyTCTneHAYjo97++
         v2Id+d4Y3tCYA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: prodikeys: add USB_HID dependency
Date:   Fri,  3 Dec 2021 19:59:01 +0100
Message-Id: <20211203185928.821497-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Like with the other drivers that recently got fixed, this one
fails to link if USB_HID is disabled or unreachable:

ERROR: modpost: "usb_hid_driver" [drivers/hid/hid-prodikeys.ko] undefined!

Fixes: f237d9028f84 ("HID: add USB_HID dependancy on some USB HID drivers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 74ce789f8636..48d18559670f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -246,7 +246,7 @@ config HID_MACALLY
 
 config HID_PRODIKEYS
 	tristate "Prodikeys PC-MIDI Keyboard support"
-	depends on HID && SND
+	depends on USB_HID && SND
 	select SND_RAWMIDI
 	help
 	Support for Prodikeys PC-MIDI Keyboard device support.
-- 
2.29.2

