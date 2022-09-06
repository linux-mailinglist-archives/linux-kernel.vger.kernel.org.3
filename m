Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09945AE2D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiIFIf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbiIFIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:34:50 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C9167C7;
        Tue,  6 Sep 2022 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662453289; x=1693989289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6OOJ9Of/ZaB/riGWD/k+rcsqkFt3FkV7A/+oQh8Vrs=;
  b=Kwjpt5T+WBtBdxQCStWUrzA3mm9ihN1fxMrGR35ssxQ9UQ9dai4Kkf1w
   PBB/VfOz4xd4fjG7zOQiBFQfnwEjHLKE/iHUE4bff/Ivjrw9So47NpsZu
   A7jBVUiDTIK44J797ti+IpE43tP5wq5yL7yslOw9IFNfbFzQXqI9kQKPL
   g=;
X-IronPort-AV: E=Sophos;i="5.93,293,1654560000"; 
   d="scan'208";a="241387494"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-0bfdb89e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:34:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-0bfdb89e.us-east-1.amazon.com (Postfix) with ESMTPS id D4FF6E0E73;
        Tue,  6 Sep 2022 08:34:34 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 08:33:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 6 Sep 2022 08:33:58 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 6 Sep 2022 08:33:57 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id C81384D83; Tue,  6 Sep 2022 08:33:56 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 07/21] hwmon: (mr75203) enable polling for all VM channels
Date:   Tue, 6 Sep 2022 08:33:42 +0000
Message-ID: <20220906083356.21067-8-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

V4 -> V3:
- Replace GENMASK(pvt->c_num - 1, 0)  with (BIT(pvt->c_num) - 1).

 drivers/hwmon/mr75203.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 69f38c05b02d..5f2b11a2bf5f 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -388,6 +388,19 @@ static int pvt_init(struct pvt_device *pvt)
 		if (ret)
 			return ret;
 
+		val = (BIT(pvt->c_num) - 1) | VM_CH_INIT |
+		      IP_POLL << SDIF_ADDR_SFT | SDIF_WRN_W | SDIF_PROG;
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

