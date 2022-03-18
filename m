Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED414DE482
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiCRXbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCRXbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:31:47 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADF230A8B1;
        Fri, 18 Mar 2022 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1647646228; x=1679182228;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=xwumcGSYcilYb6+k6/WZ9RV1PXr81UV2X4Vb+5HM/wo=;
  b=Ee3xzFMtPShrzLnEqkPoepikoazEbLkggY6CBApFByKx2lEgGsUO2Skp
   sDpm7AheZ5wz+LL515UeDnE0Q2Nt8BSvvtewfrZnQwmJdfld3uBP4Bmd7
   jqm7IT6nQqLYrdkwYT3Lp/t338ROCkj7ehD1aw/bvXUskP6iEznP7NXnv
   k=;
X-IronPort-AV: E=Sophos;i="5.90,192,1643673600"; 
   d="scan'208";a="187295308"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 18 Mar 2022 23:30:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com (Postfix) with ESMTPS id 03A69261674;
        Fri, 18 Mar 2022 23:30:27 +0000 (UTC)
Received: from EX13D05UWB002.ant.amazon.com (10.43.161.50) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 18 Mar 2022 23:30:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D05UWB002.ant.amazon.com (10.43.161.50) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 18 Mar 2022 23:30:26 +0000
Received: from localhost (10.85.222.179) by mail-relay.amazon.com
 (10.43.61.169) with Microsoft SMTP Server id 15.0.1497.32 via Frontend
 Transport; Fri, 18 Mar 2022 23:30:25 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Eduardo Valentin" <evalenti@kernel.org>
Subject: [PATCH 1/1] drivers: hwmon: jc42: add HWMON_C_TZ_REGISTER
Date:   Fri, 18 Mar 2022 16:30:11 -0700
Message-ID: <20220318233011.13980-1-eduval@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a thermal zone interface to the devices added
under jc42 driver. This way, thermal zones described
in device tree can make use of the of nodes of these
devices.

Cc: Guenter Roeck <linux@roeck-us.net> (maintainer:JC42.4 TEMPERATURE SENSOR DRIVER)
Cc: Jean Delvare <jdelvare@suse.com> (maintainer:HARDWARE MONITORING)
Cc: linux-hwmon@vger.kernel.org (open list:JC42.4 TEMPERATURE SENSOR DRIVER)
Cc: linux-kernel@vger.kernel.org (open list)

Signed-off-by: Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Eduardo Valentin <evalenti@kernel.org>
---
 drivers/hwmon/jc42.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index cb347a6bd8d9..f40df2f29d41 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -443,6 +443,8 @@ static int jc42_detect(struct i2c_client *client, struct i2c_board_info *info)
 }
 
 static const struct hwmon_channel_info *jc42_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
 			   HWMON_T_CRIT | HWMON_T_MAX_HYST |
-- 
2.17.1

