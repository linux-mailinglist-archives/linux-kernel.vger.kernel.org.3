Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE604EB19C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiC2QOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbiC2QOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:14:41 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0118B7A7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648570371;
        bh=ny/ikeyxBUfsIzyeDkKi3cUIlXQE54bwP/fw/f6RqAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RMmTa6BQCASFEOagBCwoBfEgBPJDZC41El/iyFw5wcdx/83p8WL6RHF9/1UMvXztD
         cLDiO4enpgBBrtpYYcFl/gTpntR8ZKuvIDK35kEkkLGFJOOuPKi7RZ5NVuSo2b2WgU
         nYd4WlTg5lFg7Yqys2at9EZPfxUi2+ygax4M128Q=
Received: from localhost.localdomain ([120.245.132.52])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 32C96631; Wed, 30 Mar 2022 00:12:44 +0800
X-QQ-mid: xmsmtpt1648570370tr8pifo23
Message-ID: <tencent_8B7CCCF6F54DCD886D7D1A047A3E68F4210A@qq.com>
X-QQ-XMAILINFO: Md/xSstEnVzNeE4zLi4aHYVzMuLdRhVwAbdqDv/ByC3XpwlBge4e9PW6YoWHPw
         5LjaXQTrGL2sOry7hNTHXQnSowdBqxWIQy85U1NI31ceyUa1ajPgtWA9X4Gh1EmhkrfdmjuuUOZJ
         kAz/hwWAQs6Zqu9bhCsMd8L46mraweMXr/aKyxMyPpePQZUOFwJIaU2pd6PoUJqmGWSqGsxDBoNH
         PH+knG08QPQed1/egaEBkZNqu4BlZD7vK1TReuz9/zsyT2Xvjx/8rBVb6VqRtpH8CCoWZTxv+npA
         nm8he7ifmhSjNkwy7OAF/HmAJteprALgvab1Pbd0IgNChSpP0EB1EGk2fmwn9ilHOhrUXBkMbmAg
         7PHIDQO94KbfBPU7QTInqzyT9wBpPuOX/VpRqtVjEdE8b/tmLMfKkj2N5p9F4XWG8bVGMoGJo1GK
         YC9QUH0CgX2AU5PtizTtiiExAndVTq5JcXOYHISXJn0+BgZm3HpDtf0cEyyYs18NhUiCMBpRRjeq
         3YJ1KnrKSWHI7RZxIsLqc2Q5oampoCahRDOJ5RhYcEcZXRvlCYjLJZyL1Wc3RVM9F6mFpBjeHXCh
         rzG7Aw4CNtNQJWa34anICyRFXaEG11ZIXtZ8Ae3MMHPTXUWWqw5lIIxQkGvq8kPakvpp26PrS9er
         qUB7BhECEaBRL4TL64FzgkVx14bBxio5YUc/glFAKEgl6oiSFthKEMAPocMa8/movTWTrBv9eftf
         oDc8J2qQBHcnaNSLF2TPoLQ2P4jD4HCU1cS+iH4mA4IxyRBC9l+hvHGPaOwZ7WpW25/7CDILpysL
         fb34Iq/cpLq29CIjoqqbCQBCjaKP0ksSIWrMipBcvYzUhDQnRQkPkmvU619HdpUZmxh3Hjq+TbCQ
         JrKHxGsCvh6VwpkCE9OFXe+SLEajkwHZMMFR5EOkn+YNo8L/ioibejtBzjxPVkZ3kYJfOhtCxt3N
         w4BoqFaS4=
From:   Chen Guanqiao <chen.chenchacha@foxmail.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v2 4/4] ipmi: msghandler: Add a interface to clean message queue in sysfs
Date:   Wed, 30 Mar 2022 00:12:42 +0800
X-OQ-MSGID: <20220329161242.76457-5-chen.chenchacha@foxmail.com>
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

The further approach, add a cleanup interface in sysfs. The administrator write
'1' to clean_msg, and ipmi clear the entire message queue.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 81 +++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index a188dc7e7135..58f3e17ee6b2 100644
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
@@ -2809,6 +2812,70 @@ static void get_msg_count(unsigned int *hp_count, unsigned int *count)
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
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
@@ -2998,6 +3065,19 @@ static ssize_t msg_count_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_ADMIN_RO(msg_count);

+static ssize_t clean_msgs_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
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
@@ -3011,6 +3091,7 @@ static struct attribute *bmc_dev_attrs[] = {
 	&dev_attr_guid.attr,
 	&dev_attr_user_count.attr,
 	&dev_attr_msg_count.attr,
+	&dev_attr_clean_msgs.attr,
 	NULL
 };

--
2.25.1

