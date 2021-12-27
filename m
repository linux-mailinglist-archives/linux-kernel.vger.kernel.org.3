Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562D84804B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhL0Uze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 15:55:34 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39704 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhL0Uzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 15:55:32 -0500
Received: from machine.home (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id CE8B820B717B;
        Mon, 27 Dec 2021 12:55:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE8B820B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1640638531;
        bh=21h2IU25StSfVm+H1A8EsuYeCqu3xLP7bthO+pzdaTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsJz99IQ/EXnSMrp16cwYHGOIA2dxtNP2AHykh430Bt9XMgRjW0XO6XbPSXPZNnaU
         vDVnSaReMRlfZhrcoMCc3ylenXDa2O0wpfDK8ZUHpFNIcfOPSFSZRmN+d5/hyCS++L
         HtF1OjJ8qPyVzJSCFCIbrkQvOIk8duD7ug+u6EeQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [RFC PATCH v1 2/2] kernel/ksysfs.c: Add capabilities attribute.
Date:   Mon, 27 Dec 2021 21:55:00 +0100
Message-Id: <20211227205500.214777-3-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211227205500.214777-1-flaniel@linux.microsoft.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com>
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

