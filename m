Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BE74AB5A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243040AbiBGHRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351814AbiBGHCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:02:38 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352B4C03FED0;
        Sun,  6 Feb 2022 23:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1644217351; x=1675753351;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=1RD5b1dp9rKhqqXLqTSXNCstBPAr29wABltQ/NzOvLg=;
  b=Uwy/Ps2NG2qpa22880pSC08eLeACbrOf+BSHuxvn9ofcAaFvCyCqVuIt
   PItwNFB4ci/ObhuFqScyR4uoS7ZicCmTkSlBqCTYhUBt3Df1DE3YMZJ2d
   3D2Q5/X3XCVLEYY84t1+H6Ss3LYYne21L4NCsaEGyVeqzmBZzYl3An4ka
   c=;
X-IronPort-AV: E=Sophos;i="5.88,349,1635206400"; 
   d="scan'208";a="174633584"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 07 Feb 2022 07:02:20 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com (Postfix) with ESMTPS id 37E74C0982;
        Mon,  7 Feb 2022 07:02:17 +0000 (UTC)
Received: from u8a88181e7b2355.ant.amazon.com (10.43.161.224) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 7 Feb 2022 07:02:11 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <eduval@amazon.com>,
        <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <farbere@amazon.com>, <hhhawa@amazon.com>
Subject: [RFC PATCH 1/1] rtc: bq32k: update years calculation according century bit
Date:   Mon, 7 Feb 2022 09:01:56 +0200
Message-ID: <20220207070156.19373-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.224]
X-ClientProxiedBy: EX13D19UWA003.ant.amazon.com (10.43.160.170) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tm_year filed hold the number of years since 1900, in case the century
was changed the driver will return invalid year, as it will not
increment the years field by 200.

This change update the years calculation in bq32k_rtc_read_time() and
bq32k_rtc_write_time(). By increasing the years by 100 always, and only
if the century enable bit (BQ32K_CENT_EN) is set and century bit
(BQ32K_CENT) is cleared will increase again by 100 to represent the next
century.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/rtc/rtc-bq32k.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 2235c968842d..09795dd2728b 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -108,8 +108,20 @@ static int bq32k_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mday = bcd2bin(regs.date);
 	tm->tm_wday = bcd2bin(regs.day) - 1;
 	tm->tm_mon = bcd2bin(regs.month) - 1;
-	tm->tm_year = bcd2bin(regs.years) +
-				((regs.cent_hours & BQ32K_CENT) ? 100 : 0);
+	/*
+	 * tm_year is number of years since 1900. Need to increase the years by
+	 * 100 always assuming we are on 20YY and not 19YY.
+	 */
+	tm->tm_year = bcd2bin(regs.years) + 100;
+
+	/*
+	 * If the century enable bit (BQ32K_CENT_EN) is set, and century bit
+	 * (BQ32K_CENT) is cleared, that means we are on the next century, which
+	 * required to increase by 100.
+	 */
+	if ((regs.cent_hours & BQ32K_CENT_EN) &&
+	    !(regs.cent_hours & BQ32K_CENT))
+		tm->tm_year += 100;
 
 	return 0;
 }
@@ -117,6 +129,7 @@ static int bq32k_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int bq32k_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct bq32k_regs regs;
+	int year;
 
 	regs.seconds = bin2bcd(tm->tm_sec);
 	regs.minutes = bin2bcd(tm->tm_min);
@@ -125,11 +138,15 @@ static int bq32k_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	regs.date = bin2bcd(tm->tm_mday);
 	regs.month = bin2bcd(tm->tm_mon + 1);
 
-	if (tm->tm_year >= 100) {
+	/* Assume we are on 20YY and not 19YY */
+	year = tm->tm_year - 100;
+
+	if (year < 100) {
 		regs.cent_hours |= BQ32K_CENT;
-		regs.years = bin2bcd(tm->tm_year - 100);
-	} else
-		regs.years = bin2bcd(tm->tm_year);
+		regs.years = bin2bcd(year);
+	} else {
+		regs.years = bin2bcd(year - 100);
+	}
 
 	return bq32k_write(dev, &regs, 0, sizeof(regs));
 }
-- 
2.17.1

