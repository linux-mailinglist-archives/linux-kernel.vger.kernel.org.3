Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E9525165
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356028AbiELPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356023AbiELPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:37:50 -0400
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9325B07C;
        Thu, 12 May 2022 08:37:49 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id BA68B3C04C0;
        Thu, 12 May 2022 17:37:47 +0200 (CEST)
Received: from localhost.localdomain (10.72.94.11) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 12 May
 2022 17:37:47 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>, Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Naveen kumar Sunkari <naveenkumar.sunkari@in.bosch.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Subject: [PATCH v2] usb: hub: Simplify error and success path in port_over_current_notify
Date:   Thu, 12 May 2022 17:37:14 +0200
Message-ID: <1652369834-4480-1-git-send-email-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.94.11]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>

kasprintf() returns NULL or valid pointer. Since kfree() can handle
NULL pointer condition, simplify error and success paths in function
port_over_current_notify() by removing multiple error path labels.

Signed-off-by: Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---

v2:
 - [Greg Kroah-Hartman] Drop 'exit_path' and keep 'exit' instead

v1: https://lore.kernel.org/linux-usb/1652354127-3499-1-git-send-email-erosca@de.adit-jv.com/
---
 drivers/usb/core/hub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1460857026e0..4a06892f9774 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5511,7 +5511,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 /* Handle notifying userspace about hub over-current events */
 static void port_over_current_notify(struct usb_port *port_dev)
 {
-	char *envp[3];
+	char *envp[3] = { NULL, NULL, NULL };
 	struct device *hub_dev;
 	char *port_dev_path;
 
@@ -5528,20 +5528,18 @@ static void port_over_current_notify(struct usb_port *port_dev)
 
 	envp[0] = kasprintf(GFP_KERNEL, "OVER_CURRENT_PORT=%s", port_dev_path);
 	if (!envp[0])
-		goto exit_path;
+		goto exit;
 
 	envp[1] = kasprintf(GFP_KERNEL, "OVER_CURRENT_COUNT=%u",
 			port_dev->over_current_count);
 	if (!envp[1])
 		goto exit;
 
-	envp[2] = NULL;
 	kobject_uevent_env(&hub_dev->kobj, KOBJ_CHANGE, envp);
 
-	kfree(envp[1]);
 exit:
+	kfree(envp[1]);
 	kfree(envp[0]);
-exit_path:
 	kfree(port_dev_path);
 }
 
-- 
2.36.0

