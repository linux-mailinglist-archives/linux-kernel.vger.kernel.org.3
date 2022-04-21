Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A82750A3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389936AbiDUPMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389916AbiDUPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:12:38 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2DF018E0F;
        Thu, 21 Apr 2022 08:09:47 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id F09491E80D0B;
        Thu, 21 Apr 2022 23:07:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BJ2ut5KzTnUR; Thu, 21 Apr 2022 23:07:12 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.255.56])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 013811E80CF9;
        Thu, 21 Apr 2022 23:07:11 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] ipmi: remove unnecessary type castings
Date:   Thu, 21 Apr 2022 08:09:41 -0700
Message-Id: <20220421150941.7659-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 6 +++---
 drivers/char/ipmi/ipmi_ssif.c       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index c59265146e9c..6e6aee19c39d 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2296,7 +2296,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	recv_msg->user_msg_data = user_msg_data;
 
 	if (supplied_smi)
-		smi_msg = (struct ipmi_smi_msg *) supplied_smi;
+		smi_msg = supplied_smi;
 	else {
 		smi_msg = ipmi_alloc_smi_msg();
 		if (smi_msg == NULL) {
@@ -3989,7 +3989,7 @@ static int handle_ipmb_direct_rcv_rsp(struct ipmi_smi *intf,
 	struct ipmi_recv_msg *recv_msg;
 	struct ipmi_ipmb_direct_addr *daddr;
 
-	recv_msg = (struct ipmi_recv_msg *) msg->user_data;
+	recv_msg = msg->user_data;
 	if (recv_msg == NULL) {
 		dev_warn(intf->si_dev,
 			 "IPMI message received with no owner. This could be because of a malformed message, or because of a hardware error.  Contact your hardware vendor for assistance.\n");
@@ -4407,7 +4407,7 @@ static int handle_bmc_rsp(struct ipmi_smi *intf,
 	struct ipmi_recv_msg *recv_msg;
 	struct ipmi_system_interface_addr *smi_addr;
 
-	recv_msg = (struct ipmi_recv_msg *) msg->user_data;
+	recv_msg = msg->user_data;
 	if (recv_msg == NULL) {
 		dev_warn(intf->si_dev,
 			 "IPMI message received with no owner. This could be because of a malformed message, or because of a hardware error.  Contact your hardware vendor for assistance.\n");
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index f199cc194844..e8ee195a33cf 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1053,7 +1053,7 @@ static void start_next_msg(struct ssif_info *ssif_info, unsigned long *flags)
 static void sender(void                *send_info,
 		   struct ipmi_smi_msg *msg)
 {
-	struct ssif_info *ssif_info = (struct ssif_info *) send_info;
+	struct ssif_info *ssif_info = send_info;
 	unsigned long oflags, *flags;
 
 	BUG_ON(ssif_info->waiting_msg);
@@ -1090,7 +1090,7 @@ static int get_smi_info(void *send_info, struct ipmi_smi_info *data)
  */
 static void request_events(void *send_info)
 {
-	struct ssif_info *ssif_info = (struct ssif_info *) send_info;
+	struct ssif_info *ssif_info = send_info;
 	unsigned long oflags, *flags;
 
 	if (!ssif_info->has_event_buffer)
@@ -1107,7 +1107,7 @@ static void request_events(void *send_info)
  */
 static void ssif_set_need_watch(void *send_info, unsigned int watch_mask)
 {
-	struct ssif_info *ssif_info = (struct ssif_info *) send_info;
+	struct ssif_info *ssif_info = send_info;
 	unsigned long oflags, *flags;
 	long timeout = 0;
 
-- 
2.25.1

