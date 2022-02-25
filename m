Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB14C4242
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiBYK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiBYK1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:27:14 -0500
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC32384;
        Fri, 25 Feb 2022 02:26:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 8358946002C;
        Fri, 25 Feb 2022 12:26:33 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aPS1rS0NMg1h; Fri, 25 Feb 2022 12:26:31 +0200 (EET)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 6D87C46001C;
        Fri, 25 Feb 2022 12:26:31 +0200 (EET)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 v2] xhci: fix garbage USBSTS being logged in some cases
Date:   Fri, 25 Feb 2022 12:26:02 +0200
Message-Id: <20220225102602.3829106-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fe7381b1-19bc-3b1e-50f3-0ed5c7c39e5e@linux.intel.com>
References: <fe7381b1-19bc-3b1e-50f3-0ed5c7c39e5e@linux.intel.com>
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

Mathias Nyman wrote:
> Maybe this could be the first thing printed out, something like (untested):
[...]

Heh, that's actually pretty close to what I had at one point, not sure
why I didn't go with it. I agree it looks better.

Changed and tested on real HW:

[   11.998832] xhci-hcd xhci-hcd.1.auto: xHCI host not responding to stop endpoint command.
[   12.006925] xhci-hcd xhci-hcd.1.auto: USBSTS: 0x00000000


v2: Improve print format on Mathias Nyman's suggestion.

 drivers/usb/host/xhci.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8a0026ee9524..dd24c09927bd 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2622,8 +2622,11 @@ static inline const char *xhci_decode_usbsts(char *str, u32 usbsts)
 {
 	int ret = 0;
 
+	ret = sprintf(str, " 0x%08x", usbsts);
+
 	if (usbsts == ~(u32)0)
-		return " 0xffffffff";
+		return str;
+
 	if (usbsts & STS_HALT)
 		ret += sprintf(str + ret, " HCHalted");
 	if (usbsts & STS_FATAL)
-- 
2.34.1

