Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228615A623B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiH3LlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiH3Lki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:40:38 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED2786042;
        Tue, 30 Aug 2022 04:39:15 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id C991120000F;
        Tue, 30 Aug 2022 11:39:12 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [v3 4/5] HID: logitech-hidpp: Fix "Sw. Id." for HID++ 2.0 commands
Date:   Tue, 30 Aug 2022 13:39:06 +0200
Message-Id: <20220830113907.4886-4-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830113907.4886-1-hadess@hadess.net>
References: <20220830113907.4886-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 98ebedb73d98..9c8088d8879e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -41,6 +41,9 @@ module_param(disable_tap_to_click, bool, 0644);
 MODULE_PARM_DESC(disable_tap_to_click,
 	"Disable Tap-To-Click mode reporting for touchpads (only on the K400 currently).");
 
+/* Define a non-zero software ID to identify our own requests */
+#define LINUX_KERNEL_SW_ID			0x06
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

