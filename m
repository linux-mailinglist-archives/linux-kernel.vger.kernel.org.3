Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A785B4BF9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiBVNw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiBVNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:52:23 -0500
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 05:51:57 PST
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EDB92874;
        Tue, 22 Feb 2022 05:51:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 0D08746001C;
        Tue, 22 Feb 2022 15:42:21 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ckYSdGZrp2TM; Tue, 22 Feb 2022 15:42:19 +0200 (EET)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id F313246000C;
        Tue, 22 Feb 2022 15:42:18 +0200 (EET)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] xhci: fix garbage USBSTS being logged in some cases
Date:   Tue, 22 Feb 2022 15:41:16 +0200
Message-Id: <20220222134117.34844-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci_decode_usbsts() is expected to return a zero-terminated string by
its only caller, xhci_stop_endpoint_command_watchdog(), which directly
logs the return value:

  xhci_warn(xhci, "USBSTS:%s\n", xhci_decode_usbsts(str, usbsts));

However, if no recognized bits are set in usbsts, the function will
return without having called any sprintf() and therefore return an
untouched non-zero-terminated caller-provided buffer, causing garbage
to be output to log.

Fix that by always including the raw value in the output.

Note that before 4843b4b5ec64 ("xhci: fix even more unsafe memory usage
in xhci tracing") the result effect in the failure case was different as
a static buffer was used here, but the code still worked incorrectly.

Fixes: 9c1aa36efdae ("xhci: Show host status when watchdog triggers and host is assumed dead.")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---

Noticed this while debugging a USB issue. Let me know if you prefer a
different fix.

 drivers/usb/host/xhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8a0026ee9524..ac91647195f6 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2642,6 +2642,7 @@ static inline const char *xhci_decode_usbsts(char *str, u32 usbsts)
 		ret += sprintf(str + ret, " CNR");
 	if (usbsts & STS_HCE)
 		ret += sprintf(str + ret, " HCE");
+	ret += sprintf(str + ret, " (0x%08x)", usbsts);
 
 	return str;
 }
-- 
2.34.1

