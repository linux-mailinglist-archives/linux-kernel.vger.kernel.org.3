Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1914E88F9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiC0Qtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiC0Qtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:49:35 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF613D1D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648399672;
        bh=DvwSii+5xmJOQpLDDgt+t39uWXr7culJhCY3W1SQzmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qqQ6aLmSc21ART2LmE8kATJS8C1QnzflIYMoDRnl78kcyajjfHKLMmtM0giC5KqJs
         SBvy8GPreoYmOIe2YCwMA2Z01oTmIzNsfP+GrNzBvzaCCgJ9eB9oHkJ3AUsSicbioJ
         9G9+FcYNqbMwumkH1xEyaGBZ6UrbxQmj27VPvQnE=
Received: from localhost.localdomain ([120.245.132.52])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id BEF2A844; Mon, 28 Mar 2022 00:47:47 +0800
X-QQ-mid: xmsmtpt1648399671t033mo6ba
Message-ID: <tencent_4BC3A56F75CA5B8CE8D32E90FC61A78FFF05@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTAI8iMz2DU92qQIfxOBcGpkpB3mZLyf36XSYXaJrSP90aPsTyUY
         Dn3Oeym1u2Nj8/3a8yFMFbFrHMohGhn6JpCZ+65rBVOClj9EPZaXQ4pGXY8+RBhRJ3qnpQYgppZO
         xgSW24H2gqwl11DriM2cc7uE9d0h+be2183AJs6Tg4XNBQAUqPNct8rd6gWVQQKItRf9EekT0Qcu
         LskRRlnPZZeOdRItXzSnrZZb9uyoLlL3Xylq5QLnLBP5gaA2TppC//erlIC5Qo3SKUBHwblP5x4W
         fRAAa6TyE/Uz+rYrlXOAM31lD2LZ65IwQfNkcYWoXb+ktlE4ODHhhkG62Uj2cFoXvRreY7xnIAAp
         bWC0c77mc3kRM6L67exKOFA2tczMW315bIMrdANqAsPW7r9CEGq5E8m4gkb4fdJGMisGOLy3Lqx4
         9FdtPJR5aE5v2InDV8mtV/jVhq1HmcTAJ49VSk+YIFEs7xghpfQEAnMzZa6rlKxdHxw8vayRug0w
         dNP2Lyq13BYm8zq8EC+mwQR2AEC+xzm5r/4p0rtZ4E433HIN2qZwAmMDSzceU74DOmebjP8CTrX0
         0Sb4ihj9mvbCOOIvxc+cOErlGSoQhyQjUdTDXoMoAmykxw+/bCaihZZBP/MfM9V+YMpP5W7BOq+u
         ieneQEkKrMY87zwhRXBk+1SATbWAnd06rTrAo1j7Cv33uAcFe6Pt30uOg0RTebzcGYwvtjvsXY5f
         U0AMMK6KMXGbPUnCkNazed7+8G27nvejIwPUq96taZlR6HdWBCqE4o0MufpRCVbgrzeLJ7vgBsbq
         gLlhjaIabFQGhvnUXOob1XOXHzY0f8AV5qPm8O4A+ZBp65Avq4BncWjYzYKgSA+nPKZuCpAWd78m
         OLM0rnYvBntOn1mwrV6M93LiFEZZgfbbxmPO81ibPXgjGbeXW0nW6yBZdLILWUY/jVn9a2OHxRIB
         4HzJts0RucX/dxt60/ra0TOG5BNHmtiRYiBc18ZgEjNu4xR2tdpTyCdteYcsJPhQH8OD0W32YhbE
         laaBSOymhG0LppOthj
From:   Chen Guanqiao <chen.chenchacha@foxmail.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH 3/3] ipmi: msghandler: add a interface to clean message queue in sysfs
Date:   Mon, 28 Mar 2022 00:47:44 +0800
X-OQ-MSGID: <9268e77879ce2c970f23d44522a6cc8526e13227.1648397283.git.chen.chenchacha@foxmail.com>
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

The further approach, add a cleanup interface in sysfs. The administrator write
'1' to clean_msg, and ipmi clear the entire message queue.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 82 +++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 0238be81c435..29d6779a569f 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -46,6 +46,9 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf);
 static void need_waiter(struct ipmi_smi *intf);
 static int handle_one_recv_msg(struct ipmi_smi *intf,
 			       struct ipmi_smi_msg *msg);
+static void deliver_smi_err_response(struct ipmi_smi *intf,
+				     struct ipmi_smi_msg *msg,
+				     unsigned char err);
 
 static bool initialized;
 static bool drvregistered;
@@ -2761,6 +2764,71 @@ static void get_msg_count(unsigned int *hp_count, unsigned int *count)
 	*count = hp_msg_count;
 }
 
+static void __cleanup_msgs_queue(struct ipmi_smi *intf)
+{
+	int i;
+	unsigned long flags;
+	int run_to_completion = intf->run_to_completion;
+
+	rcu_read_lock();
+	if (!run_to_completion)
+		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	if (!intf->in_shutdown) {
+		struct ipmi_smi_msg *msg;
+		struct list_head *entry = NULL;
+
+		while (!list_empty(&intf->xmit_msgs)) {
+			if (!list_empty(&intf->hp_xmit_msgs))
+				entry = intf->hp_xmit_msgs.next;
+			else if (!list_empty(&intf->xmit_msgs))
+				entry = intf->xmit_msgs.next;
+
+			if (!entry)
+				continue;
+
+			list_del(entry);
+			msg = list_entry(entry, struct ipmi_smi_msg, link);
+			deliver_smi_err_response(intf, msg,
+						 IPMI_ERR_UNSPECIFIED);
+		}
+	}
+	if (!run_to_completion)
+		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+	rcu_read_unlock();
+
+	spin_lock_irqsave(&intf->seq_lock, flags);
+	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
+		struct seq_table *ent = &intf->seq_table[i];
+
+		if (!ent->inuse)
+			continue;
+		deliver_err_response(intf, ent->recv_msg, IPMI_ERR_UNSPECIFIED);
+	}
+	spin_unlock_irqrestore(&intf->seq_lock, flags);
+}
+
+static void cleanup_msgs_queue(void)
+{
+	struct ipmi_smi *intf;
+	int index;
+
+	index = srcu_read_lock(&ipmi_interfaces_srcu);
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		struct bmc_device *bmc = intf->bmc;
+
+		kref_get(&intf->refcount);
+		mutex_lock(&intf->bmc_reg_mutex);
+		mutex_lock(&bmc->dyn_mutex);
+
+		__cleanup_msgs_queue(intf);
+
+		mutex_unlock(&bmc->dyn_mutex);
+		mutex_unlock(&intf->bmc_reg_mutex);
+		kref_put(&intf->refcount, intf_free);
+	}
+	srcu_read_unlock(&ipmi_interfaces_srcu, index);
+}
+
 static ssize_t device_id_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -2950,6 +3018,19 @@ static ssize_t msg_count_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_ADMIN_RO(msg_count);
 
+static ssize_t clean_msgs_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	if (!sysfs_streq(buf, "1"))
+		return -EINVAL;
+
+	cleanup_msgs_queue();
+
+	return count;
+}
+static DEVICE_ATTR_WO(clean_msgs);
+
 static struct attribute *bmc_dev_attrs[] = {
 	&dev_attr_device_id.attr,
 	&dev_attr_provides_device_sdrs.attr,
@@ -2963,6 +3044,7 @@ static struct attribute *bmc_dev_attrs[] = {
 	&dev_attr_guid.attr,
 	&dev_attr_user_count.attr,
 	&dev_attr_msg_count.attr,
+	&dev_attr_clean_msgs.attr,
 	NULL
 };
 
-- 
2.25.1

