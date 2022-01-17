Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144AA490A19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiAQONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:13:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54228 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiAQON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:13:26 -0500
Received: from machine.home (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id ED07A20B9135;
        Mon, 17 Jan 2022 06:13:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED07A20B9135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642428805;
        bh=21h2IU25StSfVm+H1A8EsuYeCqu3xLP7bthO+pzdaTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvJHVtjvEb0KCB6u4zmB6B/NN5V6AUu3oGF6oUeP9RdOl/s/OBkjgfxXJtrjS4NKH
         cGBRcG4rjxZZqATKDRhmg3eGQAPfGCEaHq68w10ow8miw+8RfepegGUCmAFVUsUvrH
         CD65BJ8AdGT9EWPAb6J5lXasZkdocfzUrLoRvVFc=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [RFC PATCH v2 2/2] kernel/ksysfs.c: Add capabilities attribute.
Date:   Mon, 17 Jan 2022 15:12:54 +0100
Message-Id: <20220117141254.46278-3-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220117141254.46278-1-flaniel@linux.microsoft.com>
References: <20220117141254.46278-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new read-only attribute prints the capabilities values with their names:
0       CAP_CHOWN
1       CAP_DAC_OVERRIDE
...
39      CAP_BPF

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 kernel/ksysfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 35859da8bd4f..7d39794a55bc 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -182,6 +182,23 @@ static ssize_t rcu_normal_store(struct kobject *kobj,
 KERNEL_ATTR_RW(rcu_normal);
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+static ssize_t capabilities_show(struct kobject *unused0,
+				struct kobj_attribute *unused1, char *buf)
+{
+	int at = 0;
+	int i;
+
+	for (i = 0; i < CAP_LAST_CAP; i++) {
+		if (at >= PAGE_SIZE)
+			return at;
+
+		at += sysfs_emit_at(buf, at, "%d\t%s\n", i, cap_strings[i]);
+	}
+
+	return at;
+}
+KERNEL_ATTR_RO(capabilities);
+
 /*
  * Make /sys/kernel/notes give the raw contents of our kernel .notes section.
  */
@@ -229,6 +246,7 @@ static struct attribute * kernel_attrs[] = {
 	&rcu_expedited_attr.attr,
 	&rcu_normal_attr.attr,
 #endif
+	&capabilities_attr.attr,
 	NULL
 };
 
-- 
2.30.2

