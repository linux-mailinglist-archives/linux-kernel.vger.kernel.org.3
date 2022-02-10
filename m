Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157F34B0F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbiBJNtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:49:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242450AbiBJNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:49:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C335191
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644500985; x=1676036985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lIvj2INUvYXAplToN+KJ93cvCb5urY0UjaKhRcrXWDk=;
  b=Oqw919QeS/8tZsAC7qKbZ9OI+fUnKWedhmVso+PSNvhdll8zpJuPycV/
   zy0jguLnWbOtFyesdg9o7dYUKrHsUy3rBGjSgvbDdUMRUJGnY6JXk+p9Q
   F2MyBrfEfjdc3llQD2qGcmrwl19075R1XlleDm/7V/jD1nuZ6d9eD5v3o
   x++PRqShKu6jzImgVfLrClnP3uzCgo86zYJqcD5ZpBtkd0fD/CJab6+PJ
   NY5o0Kk0Xf/DZFsvu8fBK+0RYcr483hz9OKR4uu/Row62fqOFWv1P1RXc
   TAz1xLpWd6eUiMt5WNodXapvfy0I5/fxBekWA4YJqKp8PZa4fxAryaBPf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249244302"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="249244302"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:49:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="773873681"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2022 05:49:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF5E9366; Thu, 10 Feb 2022 15:49:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 1/1] pps: generators: pps_gen_parport: Switch to use module_parport_driver()
Date:   Thu, 10 Feb 2022 15:49:43 +0200
Message-Id: <20220210134943.62026-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Note, it doesn't matter when we check the module parameter. If it was
writable we even would have more flexibility of changing it at runtime
(when built-in the kernel) after this patch.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---

v5: extended commit message to describe parameter change, based on v1 discussion (Greg)
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

