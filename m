Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D34EB19F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbiC2QOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiC2QOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:14:36 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99D18A3CA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648570368;
        bh=UD9AGV7S0dnlaF0ygMA6XYvPffRpI5mf5hdlfJggF9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V0f6u1UTi+VOLeODAX760H3KcGqDQTCRJsTzScaV98hqTVdUGXNOFiY/58f9Hr/CX
         5PjIT+tmMlVmHo3b3RdsfvXShc9D/Nw45j2qksYuwXZtcNdQIhtvD3UDAn+cz0nQ6P
         yzQLKif6OGPE3CUlEe0e3ZLKcOB6SpMG0J34ctsA=
Received: from localhost.localdomain ([120.245.132.52])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 32C96631; Wed, 30 Mar 2022 00:12:44 +0800
X-QQ-mid: xmsmtpt1648570367tm9uph8v1
Message-ID: <tencent_ADBE84293031AFCF8E409D87E2BE9B0FF507@qq.com>
X-QQ-XMAILINFO: Mv3le6n+CjtdA9uBreSmaTkKIwE+yRqjVvY7VQCyFQThKBA86m0zs41YIiLQKv
         w+FEv3g5oNGMJV8kPhmNpb4sRpPq2wttYCuI5YqL/Lp2BqtmwfhwZfEjBzNqm+6QmJVm9hzo808Q
         jz2GALOxR4HjarEpma/gN0GeGNYh25TCv+EbASISleoHb79d63XRCYLsSe74WRTKQFpy9ZzGXzbi
         JJBDjFTSranocEHnBCLep5RACPhlrMn1NdjoCyYakjQXofwuuM7dhig6nsiTsrHEM1l6g2dDLCLB
         SKhXNxvGe4YRoA2EPvg+vwkscDFHyJtj89sUyVc7XhXvdYH4eKwh95Umjs1XxLTuryGrKvtk2FyY
         i+ECGdIZ64pZThoUPFDUfod55rOip5f18NkUM5zExNHe4jEVYCdLleBckuvph8h+71zS/nJLa1Fb
         3f7nEBaoBfSBeW8t7foZMLiIWysBZriWAwMbVbTRUToe/RcMvL1EzHVrFryX/cOWdUYBeWQf+n2M
         wfM3Ru0tJawg2rxZJvnDeOXAVe+ILmFQ+f+FZQbJT6XAcOJomua2RLpD5cIfuyDbxEe7cbp8gabj
         H3TmrOhhH+RAhEn3jYDbvxxnwaPrD1CJ6tngYBqA/7fdL6DW3CudkyJ1FW91Zs+pMceWqHVndTyF
         yHHpoQxpbYvrNCqRv2L+m3U5WL4nYI4nXgyp0DzaOUCoXwrUuTEUQgnkqopu9XnOTWH/Ybwa/Nzn
         T31+Kk7DTs6Zyei9c2uYlPb4wwdLD8n0a9oTGrlNO2Fp3oCWvGuJnd6a7aHkuL3sYFQ4N0Y0UgNF
         tT7oX1yvV653q6+nD/7LjcYdVYyX8s8GbBONJuyY7PN4TWPwyLH5hBab/Q99uzilF9r50ie+cvtr
         FBJnKrIt/khfAqzecTklcJJqNteB5UGGvC8vohpR9LF2WRAdCJL0Ny+fyVITBqFauGzXYaXHbA
From:   Chen Guanqiao <chen.chenchacha@foxmail.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v2 2/4] ipmi: msghandler: Add a limit for the number of messages
Date:   Wed, 30 Mar 2022 00:12:40 +0800
X-OQ-MSGID: <20220329161242.76457-3-chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329161242.76457-1-chen.chenchacha@foxmail.com>
References: <20220329161242.76457-1-chen.chenchacha@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The administrator sets the limit for the number of messages by modifying
/sys/module/ipmi_msghandler/parameters/default_max_msgs.

Before create a message, count the number of outstanding messages, if
the number reaches the limit, it will return a busy.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 7886c8337368..80ab88702c5f 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -151,6 +151,12 @@ module_param(default_max_users, uint, 0644);
 MODULE_PARM_DESC(default_max_users,
 		 "The maximum number of users per interface");

+/* The default maximum number of outstanding messages per intf */
+static unsigned int default_max_messages = 100;
+module_param(default_max_messages, uint, 0644);
+MODULE_PARM_DESC(default_max_messages,
+		 "The maximum number of outstanding messages per interface");
+
 /* Call every ~1000 ms. */
 #define IPMI_TIMEOUT_TIME	1000

@@ -916,6 +922,30 @@ unsigned int ipmi_addr_length(int addr_type)
 }
 EXPORT_SYMBOL(ipmi_addr_length);

+static void intf_msg_count(struct ipmi_smi *intf,
+			   unsigned int *hp_count, unsigned int *count)
+{
+	struct ipmi_smi_msg *msg;
+	unsigned long flags;
+	int hp_msg_count = 0, msg_count = 0;
+	int run_to_completion = intf->run_to_completion;
+
+	if (!run_to_completion)
+		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	if (!intf->in_shutdown) {
+		list_for_each_entry(msg, &intf->hp_xmit_msgs, link)
+			hp_msg_count++;
+
+		list_for_each_entry(msg, &intf->xmit_msgs, link)
+			msg_count++;
+	}
+	if (!run_to_completion)
+		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+
+	*hp_count = hp_msg_count;
+	*count = msg_count;
+}
+
 static int deliver_response(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 {
 	int rv = 0;
@@ -2299,6 +2329,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 {
 	struct ipmi_smi_msg *smi_msg;
 	struct ipmi_recv_msg *recv_msg;
+	unsigned hp_msg_count, msg_count;
 	int rv = 0;

 	if (supplied_recv)
@@ -2330,6 +2361,12 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		goto out_err;
 	}

+	intf_msg_count(intf, &hp_msg_count, &msg_count);
+	if ((hp_msg_count + msg_count) > default_max_messages) {
+		rv = -EBUSY;
+		goto out_err;
+	}
+
 	recv_msg->user = user;
 	if (user)
 		/* The put happens when the message is freed. */
--
2.25.1

