Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB92D4E88FF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiC0Qw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbiC0Qw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:52:56 -0400
X-Greylist: delayed 126 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Mar 2022 09:51:16 PDT
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E253527B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648399874;
        bh=1GEBiGQAyrtXMxo13rUvg78furDdVDIl83iCaIGMI1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UxfiQr0mz9T1HuyYbX+n46ZXUODxUBabu4jToUPTZ0SkYfbB31CW0OLr6r5birh7w
         odsPk0cMxJZDmdr7VmK5kCjhcsPASW92GMo/5B5U3gHdBNEO9KyYE5C0gAoaWqiyIK
         3Nm9gbHGRKz/k5s/JGugjZPzZ7/zzrb3fPQnLdM8=
Received: from localhost.localdomain ([120.245.132.52])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id BEF2A844; Mon, 28 Mar 2022 00:47:47 +0800
X-QQ-mid: xmsmtpt1648399669tvx86oryx
Message-ID: <tencent_FF9ED8FF677BA0DB0345DFDFC7705FE3D406@qq.com>
X-QQ-XMAILINFO: MKeP4aHkmE0NsWw2kkSuc8SEXlOwFqqZScH84Frk/w/Q56/+U7kvZr6nwmorvX
         X+cjKN/3mmuAJ0yzoS8FmEG+NxRIc10Tu40re70XoaDn1SAc/VcPIihg6QZB9EP7BPAfrNIMveJx
         bpVJz0HkxJWgUEF7QoJO0efZoldENGRUk1hdm6LkmYD8Oh2rqQJH3oC6Zi28lpYfWM45XoM91TN+
         CQuwN47MNrnRnv4N9gANxSFz8XVG/J/3BkHQ4zK5vjcblHTiaNxatgcjaHoPpV9FPIuzjqXWRQZE
         vy3M1yfkg+e8bKKhx3Dix6dNUOc/pBMERy0kLUjdsnYMHm+TWJIb9HkD6I+YDh2Ga9uMIvYGPjLP
         yNmec/pfXI3BMs6id2CbJnMzog+X39q0PIRyAx2loShKTbLRHJQV2xEYRBTKTbMKDmIdTUNIQQkn
         GGVTLb5T7W3AoHV481Dj/AbiPHzdxRF3EuTGRfofrz8XZ4zeHuyliclx/Q0ieMTBAN/9lYfsBO/4
         ahApK9IJ960MpSAkkw4Kxw8kzEEiesitoJfvtoTWYX8/TnplOg48Ax6h+C84IpeVYw5DPePRCjsS
         ktLaIJd7nZ3SotrO3bcP7kB1i0PaFPSdRUmvGGWkABrE7zxduh9nWNOuLZeaLK9hd0gWVFid74bR
         dGZMKghMWfWhn9k5iiu7OmaXOqxJaeCNQd0X/4N5OI7SDPgjLkWA2D5hwZWYSfiC6kHG7HGNtkwG
         CT0wnLH5eVdd51pYxwmSyfyw2qIbl801lyctwv4/1kyyKLhJ5UsaLludmIok8XW4kN9UCnnR15r+
         AEsiBd6+ztzje+hP5/A9ppLySj3ZaItKrDCAyvL+1MzY2IVeX2IYlli7l5g6A+z9q+TdAtn1qr7e
         UrxPCfEdECqFLJQmPSHVMlZymlAXFCGkLlI37XEl99VtUW6H01uzo2tde4m9Wgn5l9xkMUFQJfez
         8HdmzZ860M8NIcpQou7tLY0Uuy2jqiu2hXI5N+zQyVDUsE5ZQhjg==
From:   Chen Guanqiao <chen.chenchacha@foxmail.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH 1/3] ipmi: msghandler: Get the number of user through sysfs
Date:   Mon, 28 Mar 2022 00:47:42 +0800
X-OQ-MSGID: <8cf886947890bb6d4d2c8b61a96676e404423c36.1648397283.git.chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648397283.git.chen.chenchacha@foxmail.com>
References: <cover.1648397283.git.chen.chenchacha@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The administrator reads the user_count file corresponding the ipmi device, ipmi
traverse all intf, and count the number of user.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index c59265146e9c..e14beb51cae4 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2706,6 +2706,29 @@ static int bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
 	return __bmc_get_device_id(intf, bmc, id, guid_set, guid, -1);
 }
 
+static unsigned int get_user_count(void)
+{
+	struct ipmi_smi *intf;
+	int index;
+	unsigned int total_count = 0;
+
+	index = srcu_read_lock(&ipmi_interfaces_srcu);
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		struct ipmi_user *user;
+		int intf_index, count = 0;
+
+		intf_index = srcu_read_lock(&intf->users_srcu);
+		list_for_each_entry_rcu(user, &intf->users, link)
+			count++;
+		srcu_read_unlock(&intf->users_srcu, intf_index);
+
+		total_count += count;
+	}
+	srcu_read_unlock(&ipmi_interfaces_srcu, index);
+
+	return total_count;
+}
+
 static ssize_t device_id_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -2875,6 +2898,15 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(guid);
 
+static ssize_t user_count_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	unsigned int user_count = get_user_count();
+
+	return snprintf(buf, 20, "%u\n", user_count);
+}
+static DEVICE_ATTR_ADMIN_RO(user_count);
+
 static struct attribute *bmc_dev_attrs[] = {
 	&dev_attr_device_id.attr,
 	&dev_attr_provides_device_sdrs.attr,
@@ -2886,6 +2918,7 @@ static struct attribute *bmc_dev_attrs[] = {
 	&dev_attr_product_id.attr,
 	&dev_attr_aux_firmware_revision.attr,
 	&dev_attr_guid.attr,
+	&dev_attr_user_count.attr,
 	NULL
 };
 
-- 
2.25.1

