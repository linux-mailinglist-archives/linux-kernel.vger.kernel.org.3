Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D023538DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbiEaJYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbiEaJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:24:28 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C608B0AC;
        Tue, 31 May 2022 02:24:26 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 31 May
 2022 17:24:26 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 31 May
 2022 17:24:24 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Haowen Bai <baihaowen@meizu.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86: system76_acpi: use dev_get_drvdata
Date:   Tue, 31 May 2022 17:24:23 +0800
Message-ID: <1653989063-20180-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate direct accesses to the driver_data field.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/platform/x86/system76_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 7299ad08c838..958df41ad509 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -339,7 +339,7 @@ static ssize_t kb_led_color_show(
 	struct led_classdev *led;
 	struct system76_data *data;
 
-	led = (struct led_classdev *)dev->driver_data;
+	led = dev_get_drvdata(dev);
 	data = container_of(led, struct system76_data, kb_led);
 	return sysfs_emit(buf, "%06X\n", data->kb_color);
 }
@@ -356,7 +356,7 @@ static ssize_t kb_led_color_store(
 	unsigned int val;
 	int ret;
 
-	led = (struct led_classdev *)dev->driver_data;
+	led = dev_get_drvdata(dev);
 	data = container_of(led, struct system76_data, kb_led);
 	ret = kstrtouint(buf, 16, &val);
 	if (ret)
-- 
2.7.4

