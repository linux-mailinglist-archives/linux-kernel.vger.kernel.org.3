Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27984BF9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiBVNwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiBVNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:52:23 -0500
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294692D04;
        Tue, 22 Feb 2022 05:51:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id B53D446002C;
        Tue, 22 Feb 2022 15:42:27 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jWeATQLHLol0; Tue, 22 Feb 2022 15:42:25 +0200 (EET)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id A602D46000C;
        Tue, 22 Feb 2022 15:42:25 +0200 (EET)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] xhci: fix uninitialized string returned by xhci_decode_ctrl_ctx()
Date:   Tue, 22 Feb 2022 15:41:17 +0200
Message-Id: <20220222134117.34844-2-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222134117.34844-1-anssi.hannula@bitwise.fi>
References: <20220222134117.34844-1-anssi.hannula@bitwise.fi>
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

xhci_decode_ctrl_ctx() returns the untouched buffer as-is if both "drop"
and "add" parameters are zero.

Fix the function to return an empty string in that case.

It was not immediately clear from the possible call chains whether this
issue is currently actually triggerable or not.

Note that before 4843b4b5ec64 ("xhci: fix even more unsafe memory usage
in xhci tracing") the result effect in the failure case was different as
a static buffer was used here, but the code still worked incorrectly.

Fixes: 90d6d5731da7 ("xhci: Add tracing for input control context")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
 drivers/usb/host/xhci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index ac91647195f6..a2fcefb5a0bb 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2465,6 +2465,8 @@ static inline const char *xhci_decode_ctrl_ctx(char *str,
 	unsigned int	bit;
 	int		ret = 0;
 
+	str[0] = '\0';
+
 	if (drop) {
 		ret = sprintf(str, "Drop:");
 		for_each_set_bit(bit, &drop, 32)
-- 
2.34.1

