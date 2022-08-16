Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22078595E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiHPOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiHPOo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:44:27 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4495552E41;
        Tue, 16 Aug 2022 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1660661063;
  x=1692197063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z5emoo7NBWj2lZE555Og82r9rkmvgnhnuQSLaJvTEog=;
  b=A3VzGtynkhLlLX7SEuVoeijVHQtfpAtJ8EJ02/XRTl/lY9dLyZENJuCK
   L3gZ0qP/JehCIOJH6U06RgnJa7DYDeW/ErML+PMqnk4c200/myLbxnMi8
   1zkwpkLf/hDAJcOLv3EdMaMsbjaLIc7BOv+toinwLh3ytfjVn6jn/nD4p
   2mpYlUnkNe6DAxR+hsybVrVRgBAsEs7tuySBa54OyzQ5CapmScbsvkOrv
   JFP4WlpceDJBgAWVxC/mhi8fiuD86GpTPlukgBE+9cB/wLAw/Ix2/KYIz
   yGYIS8G4ZXvj9G6xBX9nlkmF6Z5ZcKZFWAfV+xPYFlAvaeiE1oZIMtNEn
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: (pmbus) Fix vout margin caching
Date:   Tue, 16 Aug 2022 16:44:14 +0200
Message-ID: <20220816144414.2358974-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code currently uses a zero margin to mean not cached, but this
results in the cache being bypassed if the (low) margin is set to zero,
leading to lots of unnecessary SMBus transactions in that case.  Use a
negative value instead.

Fixes: 07fb76273db89d93 ("hwmon: (pmbus) Introduce and use cached vout margins")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index f10bac8860fc..d06b04543fd8 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2861,7 +2861,7 @@ static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
 		.data = -1,
 	};
 
-	if (!data->vout_low[page]) {
+	if (data->vout_low[page] < 0) {
 		if (pmbus_check_word_register(client, page, PMBUS_MFR_VOUT_MIN))
 			s.data = _pmbus_read_word_data(client, page, 0xff,
 						       PMBUS_MFR_VOUT_MIN);
@@ -2887,7 +2887,7 @@ static int pmbus_regulator_get_high_margin(struct i2c_client *client, int page)
 		.data = -1,
 	};
 
-	if (!data->vout_high[page]) {
+	if (data->vout_high[page] < 0) {
 		if (pmbus_check_word_register(client, page, PMBUS_MFR_VOUT_MAX))
 			s.data = _pmbus_read_word_data(client, page, 0xff,
 						       PMBUS_MFR_VOUT_MAX);
@@ -3320,6 +3320,7 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
 	struct pmbus_data *data;
 	size_t groups_num = 0;
 	int ret;
+	int i;
 	char *name;
 
 	if (!info)
@@ -3353,6 +3354,11 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
 	data->currpage = -1;
 	data->currphase = -1;
 
+	for (i = 0; i < ARRAY_SIZE(data->vout_low); i++) {
+		data->vout_low[i] = -1;
+		data->vout_high[i] = -1;
+	}
+
 	ret = pmbus_init_common(client, data, info);
 	if (ret < 0)
 		return ret;
-- 
2.34.1

