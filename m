Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1E4AC01D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388840AbiBGNua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386900AbiBGNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:16:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4698DC043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644239803; x=1675775803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NVBwUuQV6ckVxuAoKC8BjePGv50m0lO/JPE38dD/qM8=;
  b=CmXvauUjZZbIIfNPVh+k0BShnTLGfzJRBMroGEeS9B/eHH8WlI5ze6V1
   XWSHUThGTkaBVOqVd6SDF+BgB/CC++v8ILzLh5yzNVJuhPdw5pGAu1jUx
   sbDWVyHAzSDrx11L7+mixrOcvih0NEPtVHFpdZFsxAz56poTYHznaCOg8
   Szz/SWZRkXB7Rk57suxbpiB0Afni8J0+lU+WmTKd6Ium/OPtWATstyzXD
   kbe45vRMYRhgN8jvkJ52kbey+CaLXvYtdz4/DPRqRUAJf8fLUuI+lpXYo
   u2FZCWFXHMpqHNLavJCtoZTvZnHZUN8TEGQfHz4WXYHRO9nOKG5I8WOht
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="335115028"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="335115028"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 05:16:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="770630442"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 07 Feb 2022 05:16:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8AB70509; Mon,  7 Feb 2022 15:16:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 1/1] pps: generators: pps_gen_parport: Switch to use module_parport_driver()
Date:   Mon,  7 Feb 2022 15:16:52 +0200
Message-Id: <20220207131652.13316-1-andriy.shevchenko@linux.intel.com>
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
v3: added Ack (Rodolfo), Cc'ed to Greg for picking it up
 drivers/pps/generators/pps_gen_parport.c | 42 ++++--------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
index 6a1af7664f3b..fba6c490977c 100644
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
+		return -EINVAL;
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

