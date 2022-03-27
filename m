Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C130D4E88F8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiC0Qtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiC0Qtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:49:35 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF313D0F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648399671;
        bh=aGbCOIhVGSt1Fp65mIowxPwh1FP/AAKeZhhFmidug4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OlUnvC3lka0EN7LlSSt6vve+bVLMb6EbwXWUcokaY0Zh81WyMJMeKwKKTbRCnehi9
         XC1r2N/Ig7E+vV6D4BAUNhNhg2CcpNdTATC5UEtvgMbi2afETiq/5vagmhVF2CSLEl
         qOwVBSqLnR3qMfZCEHM3z2lRZivH9MlhAoQoAHBg=
Received: from localhost.localdomain ([120.245.132.52])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id BEF2A844; Mon, 28 Mar 2022 00:47:47 +0800
X-QQ-mid: xmsmtpt1648399670teidx7g3p
Message-ID: <tencent_15F1836A9FD7475D1FCED49818CC6778A006@qq.com>
X-QQ-XMAILINFO: ORuEwgb9eurkdC4wUAENY3XBZ0pJZrPkJK/n3IRMG8QGa9y5M0AJB0dASrm3EE
         yQv57yPFwn+ycpb8Xh0EeDr/MjZ/Ghdn3/4yFLtJ8QcKyNMmoAij00DZeMuOlek0cSTU0BfYDtuo
         J+vdnck1v96RwgKcm5Gpa9eDSMtUyicbSZqQ9B5zEerU7O3V17T2wDTgLqFnm+OVlwt5jwwO0VzH
         Ko6Do5Y7IOtm84rHhC4b3ODGNkL4oQ7/MR8r7z8hHmKx3wWtuGDs0nDWfL3EAr9ydkB/0DXlp7g9
         DUb9xRsVfLiXRn+FYt0WLGVs2c6dn2zIBaueI3pkTclkBu5vhYfFQzredwkchzJMoJcT1+DQ26Sc
         3uI5TpDFGjHKX2tMA4bCJkR8bdRUHcf/5hbRvuw5RAiqfTMdCdLitDXFtoboMrtgFn1pIJSV7NvI
         S/5kl3qC5jnoE1wFnkN7nGp6nOhAJ5sjdK/3ouFyCYssDx/Y+PVpa6bIfw6TKOCsnVXf7ha7Pwt5
         aYqd3d1bseK80iH3DKeEomFdeD1b/VwHLlhif8m33eg7/nMg600I6EfZevY3LQ6CeEWGk3lrlJxc
         fZhhheZlsVTQ7pEwKedd3LgNQ15CveSrpiLV0xu24tZjyOsHr3Pt3zNg8n4Q+hEx7tNhiSEdLTGA
         sCekX8p5YwTf0S747wgZtPDc7tV2skwWnlH75/y5zzuOJtRh7N5pd42KPvQm4EY0biSj9KBZ9gqW
         dUJbvKm1rMeZ9fT5EFtOA2i7nmLrFvTyrfjrMelK0pOk841Cdh6+NKt2AAgwj97VflhIjC7CCPXZ
         Vmoc6lws9lk3rJV+F92KL0OAXuF9NE9Zt7ZBvd3AG4IgYdthHEnNlGQxoyjeOotBQ9kKSluso2Wi
         BKvns0YMxV9RKco0V/VYjKy7o0fhTK+pbrD+4voD12R7Hm0wUceLZJW2+yGU5+xJaWetFYyjiNNZ
         gJDYQCQbhubA8MRRBkO+64lLUd484eaXYS1nkoRw8JlzcErLeFSsDCXqUfzZHnpKB8k3Fftn8=
From:   Chen Guanqiao <chen.chenchacha@foxmail.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH 2/3] ipmi: msghandler: Get the number of message through sysfs
Date:   Mon, 28 Mar 2022 00:47:43 +0800
X-OQ-MSGID: <e1875e3eba4f8d6a4f861a6b43613b6f778bd095.1648397283.git.chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648397283.git.chen.chenchacha@foxmail.com>
References: <cover.1648397283.git.chen.chenchacha@foxmail.com>
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

Reads the message_count file corresponding the ipmi device, ipmi traverse all
intf, and count the number of message and high priority message.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e14beb51cae4..0238be81c435 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2729,6 +2729,38 @@ static unsigned int get_user_count(void)
 	return total_count;
 }
 
+static void get_msg_count(unsigned int *hp_count, unsigned int *count)
+{
+	struct ipmi_smi *intf;
+	int index;
+	int hp_msg_count = 0, msg_count = 0;
+
+	index = srcu_read_lock(&ipmi_interfaces_srcu);
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		struct ipmi_smi_msg *msg;
+		unsigned long flags;
+		int run_to_completion = intf->run_to_completion;
+
+		rcu_read_lock();
+		if (!run_to_completion)
+			spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+		if (!intf->in_shutdown) {
+			list_for_each_entry(msg, &intf->hp_xmit_msgs, link)
+				hp_msg_count++;
+
+			list_for_each_entry(msg, &intf->xmit_msgs, link)
+				msg_count++;
+		}
+		if (!run_to_completion)
+			spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+		rcu_read_unlock();
+	}
+	srcu_read_unlock(&ipmi_interfaces_srcu, index);
+
+	*hp_count = msg_count;
+	*count = hp_msg_count;
+}
+
 static ssize_t device_id_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -2907,6 +2939,17 @@ static ssize_t user_count_show(struct device *dev,
 }
 static DEVICE_ATTR_ADMIN_RO(user_count);
 
+static ssize_t msg_count_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	unsigned int hp_count, count;
+
+	get_msg_count(&hp_count, &count);
+
+	return snprintf(buf, 40, "hp msg:%u, msg:%u\n", hp_count, count);
+}
+static DEVICE_ATTR_ADMIN_RO(msg_count);
+
 static struct attribute *bmc_dev_attrs[] = {
 	&dev_attr_device_id.attr,
 	&dev_attr_provides_device_sdrs.attr,
@@ -2919,6 +2962,7 @@ static struct attribute *bmc_dev_attrs[] = {
 	&dev_attr_aux_firmware_revision.attr,
 	&dev_attr_guid.attr,
 	&dev_attr_user_count.attr,
+	&dev_attr_msg_count.attr,
 	NULL
 };
 
-- 
2.25.1

