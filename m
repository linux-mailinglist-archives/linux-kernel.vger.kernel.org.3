Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E642B4F7E76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiDGL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiDGL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:56:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBF6D0AAC;
        Thu,  7 Apr 2022 04:54:11 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8D2F9C0008;
        Thu,  7 Apr 2022 11:54:07 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: wacom: Correct power_supply type
Date:   Thu,  7 Apr 2022 13:54:06 +0200
Message-Id: <20220407115406.115112-1-hadess@hadess.net>
X-Mailer: git-send-email 2.35.1
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

POWER_SUPPLY_TYPE_USB seems to only ever be used by USB ports that are
used to charge the machine itself (so a "system" scope), like the
single USB port on a phone, rather than devices.

The wacom_sys driver is the only driver that sets its device battery as
being a USB type, which doesn't seem correct based on its usage, so
switch it to be a battery type like all the other USB-connected devices.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 066c567dbaa2..620fe74f5676 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1777,7 +1777,7 @@ static int __wacom_initialize_battery(struct wacom *wacom,
 	bat_desc->get_property = wacom_battery_get_property;
 	sprintf(battery->bat_name, "wacom_battery_%ld", n);
 	bat_desc->name = battery->bat_name;
-	bat_desc->type = POWER_SUPPLY_TYPE_USB;
+	bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	bat_desc->use_for_apm = 0;
 
 	ps_bat = devm_power_supply_register(dev, bat_desc, &psy_cfg);
-- 
2.35.1

