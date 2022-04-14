Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD75005A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiDNFpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiDNFpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:45:13 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537A24A92A;
        Wed, 13 Apr 2022 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1649914970; x=1681450970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kt5nspYjRt8wh1mWWFLNQsJk52QOffqs+u6TEiueePQ=;
  b=igWRcbusW/CKPlrumnyZMFmtOoHgRzkZgNkGHTmaGVmNsv5r0BAaaIK0
   0RSawy69k7Owo3HAxIxxBXOH5OT4eKKvyn1MQMS0sc3HrySM5AVDXBTS4
   g97MXs/jiVPP3Kc2MHN5EHWkCG6yV0j7yWw5x/rqEB89mxbVMxXLhcAU1
   8=;
X-IronPort-AV: E=Sophos;i="5.90,258,1643673600"; 
   d="scan'208";a="79538830"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-9938edb1.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 14 Apr 2022 05:42:35 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-9938edb1.us-west-2.amazon.com (Postfix) with ESMTPS id 50A0981B71;
        Thu, 14 Apr 2022 05:42:34 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Thu, 14 Apr 2022 05:42:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Thu, 14 Apr 2022 05:42:33 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Thu, 14 Apr 2022 05:42:33
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 446272E6C; Thu, 14 Apr 2022 05:42:33 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <farbere@amazon.com>,
        <dwmw@amazon.co.uk>
Subject: [PATCH v2 1/1] watchdog: sp805: disable watchdog on remove
Date:   Thu, 14 Apr 2022 05:42:33 +0000
Message-ID: <20220414054233.1357-2-farbere@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414054233.1357-1-farbere@amazon.com>
References: <20220414054233.1357-1-farbere@amazon.com>
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
 drivers/watchdog/sp805_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index d8876fba686d..69a6182c2dfe 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -273,6 +273,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 	watchdog_set_restart_priority(&wdt->wdd, 128);
+	watchdog_stop_on_unregister(&wdt->wdd);
 
 	/*
 	 * If 'timeout-sec' devicetree property is specified, use that.
-- 
2.32.0

