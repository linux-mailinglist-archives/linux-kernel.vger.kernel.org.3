Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420E64EB19D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiC2QOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbiC2QOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:14:37 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7779118A7A9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648570370;
        bh=aAXDyKsO8jXDtyhMPTwAZKjc892ePbm35jRlP4haFc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=em5CSPiWKpgx5a3Eucxg/RUypdU76PZpbL7bO7/WK7A6Xy3VMJU9fq/UCHUOkA+ob
         AOJC87mGspcWHbUtpGjvNjdtDn2q7kYEFwk8gD34K86rp9DXpmbYG9ROmhVGmJMWAp
         Tu2Wq+lEwyg4LudZyNQEG9M7kTBW24+AAfU2rV2s=
Received: from localhost.localdomain ([120.245.132.52])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 32C96631; Wed, 30 Mar 2022 00:12:44 +0800
X-QQ-mid: xmsmtpt1648570368tseiwrc1y
Message-ID: <tencent_18DFCE075E9FCD148D18C7676CE0C4836306@qq.com>
X-QQ-XMAILINFO: NfHsM/dq2nWI4ewsMg299y37wdAjrnGr9L5yG7fIszAh32UC9XJ0qYNLPJ/kB6
         jTaz4bb7/au7PNKRl1saTGtxN6w+fR7g7TVvxOIvunBMqV2wEbHvfuwZuTVKGq2S8Vprf7yY+8Uy
         3N+CUISeOqYC6rTu9q2qV+aIWjGO2fzFaNNGkVox8m+LQOQBvQbOcEKUGnSGLr30VJdH4P4z3hpc
         4GzAY0LodAyTb8KGT8Bxu80TS4B2LJXxJh4gkfpv/Gg1eRtlxxzVrJel7cBHQ4qS896zEV7yNpW5
         TyNQrZ22XRD+2LcwNLFNIOPO/QvtN8vo+s51yBlTpqEbh+xBuX7ItA8bkBuBR3B2rrSmuo8xEEDu
         EXPcO1B+3XVM2JVwddS6h5VMujAi9A8S2FChhUG1vAevVjL2i8eI0khttOcvmdc9UPAUmN1Lutti
         Xx6ry/+pZH5BCJIakupvTNLLgUwwvhCPqjYkBRWYChjWFbdYu3ZzUtNGl+jg+XNeSMHgHC8Mrlw8
         77PjYaOuy9i6hZk1F/0FfgMhVVjjAdku6ipVEmN17ya987oYYIuQtTyx8QhIItTHNpE+vgV8M06N
         q4XBI9ftvRGg50IsLvJhr6cBjl7O/c2I+luNuaHhqfGINj3ckX5IO5P4NSy/zHyG0hNm7U7FkNXw
         jjZTeXoS8z9D4L7iYF1aVJVmg/zEkEr22DD3D/0Oi79FirE/Hfrgyt52F1KYuqWHMjhgHen3pxLO
         Wf+LsjFk4m8TtnhNl4lQOufJkHsgm3yqHnlEN9bmi+CIiwPXRYCugsJ+kB+KrhqKNZsi7fqBZwoo
         ZFBzmQiPy59XAbac4NrRoQ2ETG3U0KfpETCNGvmfPdgat1ePmHz5NoQjRN1jT/BLy0UPGWmhjvB5
         LkZsSn2Mz+R7aj6F/b6BId433MiY4GiKkAImRnvEsAGTXBzNNq8AR//2EO71pP76PDgdmZJfPEdY
         6mBCBq/Lx2afIFd7uXew==
From:   Chen Guanqiao <chen.chenchacha@foxmail.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v2 3/4] ipmi: msghandler: Get the number of users and messages through sysfs
Date:   Wed, 30 Mar 2022 00:12:41 +0800
X-OQ-MSGID: <20220329161242.76457-4-chen.chenchacha@foxmail.com>
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

The administrator reads the user_count and msg_count file
corresponding the ipmi device, ipmi traverse all intf, and count
the number of users and messages.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 71 +++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 80ab88702c5f..a188dc7e7135 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -922,6 +922,19 @@ unsigned int ipmi_addr_length(int addr_type)
 }
 EXPORT_SYMBOL(ipmi_addr_length);

+static unsigned int intf_user_count(struct ipmi_smi *intf)
+{
+	struct ipmi_user *user;
+	int index, count = 0;
+
+	index = srcu_read_lock(&intf->users_srcu);
+	list_for_each_entry_rcu(user, &intf->users, link)
+		count++;
+	srcu_read_unlock(&intf->users_srcu, index);
+
+	return count;
+}
+
 static void intf_msg_count(struct ipmi_smi *intf,
 			   unsigned int *hp_count, unsigned int *count)
 {
@@ -2760,6 +2773,42 @@ static int bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
 	return __bmc_get_device_id(intf, bmc, id, guid_set, guid, -1);
 }

+static unsigned int get_user_count(void)
+{
+	struct ipmi_smi *intf;
+	int index;
+	unsigned int count = 0;
+
+	index = srcu_read_lock(&ipmi_interfaces_srcu);
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link)
+		count += intf_user_count(intf);
+	srcu_read_unlock(&ipmi_interfaces_srcu, index);
+
+	return count;
+}
+
+static void get_msg_count(unsigned int *hp_count, unsigned int *count)
+{
+	struct ipmi_smi *intf;
+	int index;
+
+	*hp_count = 0;
+	*count = 0;
+
+	index = srcu_read_lock(&ipmi_interfaces_srcu);
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		int hp_msg_count = 0, msg_count = 0;
+
+		rcu_read_lock();
+		intf_msg_count(intf, &hp_msg_count, &msg_count);
+		rcu_read_unlock();
+
+		*hp_count += hp_msg_count;
+		*count += msg_count;
+	}
+	srcu_read_unlock(&ipmi_interfaces_srcu, index);
+}
+
 static ssize_t device_id_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -2929,6 +2978,26 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(guid);

+static ssize_t user_count_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	unsigned int user_count = get_user_count();
+
+	return snprintf(buf, 20, "%u\n", user_count);
+}
+static DEVICE_ATTR_ADMIN_RO(user_count);
+
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
@@ -2940,6 +3009,8 @@ static struct attribute *bmc_dev_attrs[] = {
 	&dev_attr_product_id.attr,
 	&dev_attr_aux_firmware_revision.attr,
 	&dev_attr_guid.attr,
+	&dev_attr_user_count.attr,
+	&dev_attr_msg_count.attr,
 	NULL
 };

--
2.25.1

