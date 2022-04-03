Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934FC4F07C8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiDCFY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCFY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:24:56 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DF3B7DC;
        Sat,  2 Apr 2022 22:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1648963383; x=1680499383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rAtvMqa3UEA1I/gQzlxH67hrGaELitMbpfXhAAOLSoU=;
  b=L46yBIMVBoGlrFN9T4cWb6VLINHQi8MR+aEI07Im+WPAUz/OUS3JtOn2
   8u4Ne0X8W4H+iWxPMRjCbu6UrZaGFp0MWDmMwUwlVXm5wX7z/25vbAT1N
   t8unrJcMMhiOyCYFmuJ6Y4lbja0L2tiNcx3jdqSgI8Or0ChTNkBvQsIae
   A=;
X-IronPort-AV: E=Sophos;i="5.90,231,1643673600"; 
   d="scan'208";a="189965259"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 03 Apr 2022 05:22:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com (Postfix) with ESMTPS id 97AA4C0291;
        Sun,  3 Apr 2022 05:22:52 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sun, 3 Apr 2022 05:22:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sun, 3 Apr 2022 05:22:50 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Sun, 3 Apr 2022 05:22:50 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 168431687; Sun,  3 Apr 2022 05:22:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <farbere@amazon.com>,
        <dwmw@amazon.co.uk>
Subject: [PATCH] watchdog: sp805: disable watchdog on remove
Date:   Sun, 3 Apr 2022 05:22:49 +0000
Message-ID: <20220403052249.48784-1-farbere@amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the watchdog if it is active while removing the module.
It is necessary in order to prevent a reset in case watchdog
hw was running before the removal.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/watchdog/sp805_wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index d8876fba686d..d7dc0f3f16ec 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -311,6 +311,9 @@ static int sp805_wdt_remove(struct amba_device *adev)
 {
 	struct sp805_wdt *wdt = amba_get_drvdata(adev);
 
+	if (watchdog_active(&wdt->wdd))
+		wdt_disable(&wdt->wdd);
+
 	watchdog_unregister_device(&wdt->wdd);
 	watchdog_set_drvdata(&wdt->wdd, NULL);
 
-- 
2.32.0

