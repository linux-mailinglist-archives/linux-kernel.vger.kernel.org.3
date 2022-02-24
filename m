Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB54C36CF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiBXUW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiBXUWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:22:53 -0500
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A066217583D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:22:22 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id NKd1nAsn8eKJJNKd1n2zDl; Thu, 24 Feb 2022 21:22:20 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 24 Feb 2022 21:22:20 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jorgen Hansen <jhansen@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dtor@vmware.com>,
        Andy King <acking@vmware.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        pv-drivers@vmware.com
Subject: [PATCH v2 1/3] VMCI: Fix the description of vmci_check_host_caps()
Date:   Thu, 24 Feb 2022 21:22:17 +0100
Message-Id: <c181bec88aab1145d3868d61b7e52d53923f8206.1645734041.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmci_check_host_caps() doesn't return a bool but an int.
Fix the description accordingly.

Fixes: 	782f24453536 ("VMCI: fix error handling path when registering guest driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Vishnu Dasa <vdasa@vmware.com>
---
v2:
   - no change
---
 drivers/misc/vmw_vmci/vmci_guest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index aa61a687b3e2..1a1858742f75 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -253,9 +253,9 @@ static void vmci_guest_cid_update(u32 sub_id,
 
 /*
  * Verify that the host supports the hypercalls we need. If it does not,
- * try to find fallback hypercalls and use those instead.  Returns
- * true if required hypercalls (or fallback hypercalls) are
- * supported by the host, false otherwise.
+ * try to find fallback hypercalls and use those instead.  Returns 0 if
+ * required hypercalls (or fallback hypercalls) are supported by the host,
+ * an error code otherwise.
  */
 static int vmci_check_host_caps(struct pci_dev *pdev)
 {
-- 
2.32.0

