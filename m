Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4485A6D21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiH3TWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiH3TWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:22:35 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78F379ECC;
        Tue, 30 Aug 2022 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661887354; x=1693423354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7/V2KgNUUkyeEZdK4TEB8Ma46trE3WXZnGJEBdvfnUo=;
  b=fB2hSouuf6k9p117l5GbbQWD2pSfOLVXWX9Vsa37ooGk0FmJyZfslhNM
   Lgu/MBVNPM+9HPIewX6bdz7dR6XPh2xUdt60kEKJFa6ulf6avjnO3LPUL
   EsI/JuaN/Ie7BJUIejix8huHsjAj7eslXNJkzS2j40II8kBeIte66X6Xm
   E=;
X-IronPort-AV: E=Sophos;i="5.93,275,1654560000"; 
   d="scan'208";a="254493396"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:22:17 +0000
Received: from EX13D44EUC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com (Postfix) with ESMTPS id 0E541C02CA;
        Tue, 30 Aug 2022 19:22:16 +0000 (UTC)
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D44EUC001.ant.amazon.com (10.43.164.236) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 30 Aug 2022 19:22:15 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 30 Aug 2022 19:22:14
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 61BA24D3F; Tue, 30 Aug 2022 19:22:12 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <ronenk@amazon.com>,
        <itamark@amazon.com>, <shellykz@amazon.com>, <shorer@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>, <dkl@amazon.com>,
        <rahul.tanwar@linux.intel.com>, <andriy.shevchenko@intel.com>
Subject: [PATCH v3 07/19] hwmon: (mr75203) enable polling for all VM channels
Date:   Tue, 30 Aug 2022 19:22:00 +0000
Message-ID: <20220830192212.28570-8-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830192212.28570-1-farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure ip-polling register to enable polling for all voltage monitor
channels.
This enables reading the voltage values for all inputs other than just
input 0.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V3 -> V2:
- Move configuration of ip-polling register from previous patch to a
  separate commit.

 drivers/hwmon/mr75203.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 639f5a300170..f561806c400d 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -388,6 +388,20 @@ static int pvt_init(struct pvt_device *pvt)
 		if (ret)
 			return ret;
 
+		val = GENMASK(pvt->c_num - 1, 0) | VM_CH_INIT |
+		      IP_POLL << SDIF_ADDR_SFT |
+		      SDIF_WRN_W | SDIF_PROG;
+		ret = regmap_write(v_map, SDIF_W, val);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
+					       val, !(val & SDIF_BUSY),
+					       PVT_POLL_DELAY_US,
+					       PVT_POLL_TIMEOUT_US);
+		if (ret)
+			return ret;
+
 		val = CFG1_VOL_MEAS_MODE | CFG1_PARALLEL_OUT |
 		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
 		      SDIF_WRN_W | SDIF_PROG;
-- 
2.37.1

