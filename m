Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C14AC1A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382853AbiBGOnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391287AbiBGOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:19:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0BC0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644243580; x=1675779580;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ScF/FjU7SIPIW6IKlvD7x0+luka5z3U8VyiE0YWZd18=;
  b=Co9iq4Qa8bxfuSJanU79kgXG3epWSGtVVjDlM+x+78sLlVPSXPxHkioh
   cnYC6jN+UUAKa5NZ+p4JYXlDUUMtjSOcPS1wy+04oI+hGdewo+s02cT6w
   sQk0cXccpXzHX9hofnN50ue/6Uzju28rnJHal1vq/D+GwuNRTJ+le0fao
   JczaKMfOIjxlVnp1wmYoHywDx0hX5xyb5X200F/emGKcBtoMjTslWJnLO
   xoDcCvexO5Ht7liktk0dvpsiVb/Y3yyxCTuAa/HYiQgbtbzs8F3N9JYpR
   3XQT4tPcwROCbawwWQr0ffAniI2iq09dJUunw2byGNEIH2DDYXZCrFxEI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="229373190"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="229373190"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:19:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="484436275"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2022 06:19:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 02D4D31D; Mon,  7 Feb 2022 16:19:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 1/1] pps: generators: pps_gen_parport: Switch to use module_parport_driver()
Date:   Mon,  7 Feb 2022 16:19:44 +0200
Message-Id: <20220207141944.8707-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---

v4: made sure the proper version is taken into consideration
v3: added Ack (Rodolfo), Cc'ed to Greg for picking it up

 drivers/pps/generators/pps_gen_parport.c | 42 ++++--------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
index 6a1af7664f3b..b3e084b75c23 100644
--- a/drivers/pps/generators/pps_gen_parport.c
+++ b/drivers/pps/generators/pps_gen_parport.c
@@ -20,8 +20,6 @@
 #include <linux/hrtimer.h>
 #include <linux/parport.h>
 
-#define DRVDESC "parallel port PPS signal generator"
-
 #define SIGNAL		0
 #define NO_SIGNAL	PARPORT_CONTROL_STROBE
 
@@ -180,6 +178,11 @@ static void parport_attach(struct parport *port)
 {
 	struct pardev_cb pps_cb;
 
+	if (send_delay > SEND_DELAY_MAX) {
+		pr_err("delay value should be not greater then %d\n", SEND_DELAY_MAX);
+		return;
+	}
+
 	if (attached) {
 		/* we already have a port */
 		return;
@@ -231,39 +234,8 @@ static struct parport_driver pps_gen_parport_driver = {
 	.detach = parport_detach,
 	.devmodel = true,
 };
-
-/* module staff */
-
-static int __init pps_gen_parport_init(void)
-{
-	int ret;
-
-	pr_info(DRVDESC "\n");
-
-	if (send_delay > SEND_DELAY_MAX) {
-		pr_err("delay value should be not greater"
-				" then %d\n", SEND_DELAY_MAX);
-		return -EINVAL;
-	}
-
-	ret = parport_register_driver(&pps_gen_parport_driver);
-	if (ret) {
-		pr_err("unable to register with parport\n");
-		return ret;
-	}
-
-	return  0;
-}
-
-static void __exit pps_gen_parport_exit(void)
-{
-	parport_unregister_driver(&pps_gen_parport_driver);
-	pr_info("hrtimer avg error is %ldns\n", hrtimer_error);
-}
-
-module_init(pps_gen_parport_init);
-module_exit(pps_gen_parport_exit);
+module_parport_driver(pps_gen_parport_driver);
 
 MODULE_AUTHOR("Alexander Gordeev <lasaine@lvk.cs.msu.su>");
-MODULE_DESCRIPTION(DRVDESC);
+MODULE_DESCRIPTION("parallel port PPS signal generator");
 MODULE_LICENSE("GPL");
-- 
2.34.1

