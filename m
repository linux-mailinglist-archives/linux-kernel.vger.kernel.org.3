Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB44E6D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358215AbiCYEf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiCYEfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:35:53 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD7C680B;
        Thu, 24 Mar 2022 21:34:18 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 25 Mar
 2022 12:34:11 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 25 Mar
 2022 12:34:10 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] usb: typec: tcpm: testing array offset 'port->logbuffer_head' before use
Date:   Fri, 25 Mar 2022 12:34:09 +0800
Message-ID: <1648182849-9209-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix possible indexing array of bound for 
port->logbuffer[port->logbuffer_head], where port->logbuffer_head boundary
 check happens later. so we do it before.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5fce795..541e9e4 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -591,6 +591,14 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
 	unsigned long rem_nsec;
 
 	mutex_lock(&port->logbuffer_lock);
+
+	if (port->logbuffer_head < 0 ||
+	    port->logbuffer_head >= LOG_BUFFER_ENTRIES) {
+		dev_warn(port->dev,
+			 "Bad log buffer index %d\n", port->logbuffer_head);
+		goto abort;
+	}
+
 	if (!port->logbuffer[port->logbuffer_head]) {
 		port->logbuffer[port->logbuffer_head] =
 				kzalloc(LOG_BUFFER_ENTRY_SIZE, GFP_KERNEL);
@@ -607,13 +615,6 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
 		strcpy(tmpbuffer, "overflow");
 	}
 
-	if (port->logbuffer_head < 0 ||
-	    port->logbuffer_head >= LOG_BUFFER_ENTRIES) {
-		dev_warn(port->dev,
-			 "Bad log buffer index %d\n", port->logbuffer_head);
-		goto abort;
-	}
-
 	if (!port->logbuffer[port->logbuffer_head]) {
 		dev_warn(port->dev,
 			 "Log buffer index %d is NULL\n", port->logbuffer_head);
-- 
2.7.4

