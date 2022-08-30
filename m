Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1169D5A64A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiH3N01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiH3N0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:26:18 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190F7E00C;
        Tue, 30 Aug 2022 06:26:00 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id ACECE20009;
        Tue, 30 Aug 2022 13:25:55 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [v4 4/5] HID: logitech-hidpp: Fix "Sw. Id." for HID++ 2.0 commands
Date:   Tue, 30 Aug 2022 15:25:48 +0200
Message-Id: <20220830132549.7240-4-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830132549.7240-1-hadess@hadess.net>
References: <20220830132549.7240-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always set a non-zero "Sw. Id." in the lower nibble of the Function/ASE
and Software Identifier byte in HID++ 2.0 commands.

As per the "Protocol HID++2.0 essential features" section in
https://lekensteyn.nl/files/logitech/logitech_hidpp_2.0_specification_draft_2012-06-04.pdf
"
Software identifier (4 bits, unsigned)

A number uniquely defining the software that sends a request. The
firmware must copy the software identifier in the response but does
not use it in any other ways.

0 Do not use (allows to distinguish a notification from a response).
"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215699
Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 98ebedb73d98..e51ccf2c04e3 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -41,6 +41,9 @@ module_param(disable_tap_to_click, bool, 0644);
 MODULE_PARM_DESC(disable_tap_to_click,
 	"Disable Tap-To-Click mode reporting for touchpads (only on the K400 currently).");
 
+/* Define a non-zero software ID to identify our own requests */
+#define LINUX_KERNEL_SW_ID			0x01
+
 #define REPORT_ID_HIDPP_SHORT			0x10
 #define REPORT_ID_HIDPP_LONG			0x11
 #define REPORT_ID_HIDPP_VERY_LONG		0x12
@@ -343,7 +346,7 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	else
 		message->report_id = REPORT_ID_HIDPP_LONG;
 	message->fap.feature_index = feat_index;
-	message->fap.funcindex_clientid = funcindex_clientid;
+	message->fap.funcindex_clientid = funcindex_clientid | LINUX_KERNEL_SW_ID;
 	memcpy(&message->fap.params, params, param_count);
 
 	ret = hidpp_send_message_sync(hidpp, message, response);
-- 
2.37.2

