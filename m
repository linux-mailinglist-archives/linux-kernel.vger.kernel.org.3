Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55AD4953D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbiATSCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:02:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56248 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiATSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:02:06 -0500
Received: from machine.home (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6652520B8010;
        Thu, 20 Jan 2022 10:02:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6652520B8010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642701726;
        bh=nw21DXI5tw2hIoJNvKpVyoLMBzMbxA4gDPPYMtT2PCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fErZozI/eGIYLMHCe7f+RAxe+mi/01XEhEB6ltGDnsh2tq8Avao10gdWhvGQLGhCf
         03mkLXghDl+WgV8drRQqDK4sPFqQp2Or/zApz6YDm2FYJgyxJ/ua6ZsEnkQ5a2sQ1c
         0sJWt8uHR2silGAkqKy+YPRSQ0n5+H6XdFKyzqrM=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [RFC PATCH v3 2/2] security/inode.c: Add capabilities file.
Date:   Thu, 20 Jan 2022 19:01:16 +0100
Message-Id: <20220120180116.167702-3-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120180116.167702-1-flaniel@linux.microsoft.com>
References: <20220120180116.167702-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new read-only file prints the capabilities values with their names:
cat /sys/kernel/security/capabilities
0       CAP_CHOWN
1       CAP_DAC_OVERRIDE
...
40      CAP_CHECKPOINT_RESTORE

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 security/inode.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..cef78b497bab 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -21,6 +21,7 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include <linux/capability.h>
 
 static struct vfsmount *mount;
 static int mount_count;
@@ -328,6 +329,19 @@ static const struct file_operations lsm_ops = {
 };
 #endif
 
+static struct dentry *capabilities_dentry;
+static ssize_t capabilities_read(struct file *unused, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	return simple_read_from_buffer(buf, count, ppos, cap_string,
+				       strlen(cap_string));
+}
+
+static const struct file_operations capabilities_ops = {
+	.read = capabilities_read,
+	.llseek = generic_file_llseek,
+};
+
 static int __init securityfs_init(void)
 {
 	int retval;
@@ -345,6 +359,8 @@ static int __init securityfs_init(void)
 	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
 						&lsm_ops);
 #endif
+	capabilities_dentry = securityfs("capabilities", 0444, NULL, NULL,
+					 capabilities_ops);
 	return 0;
 }
 core_initcall(securityfs_init);
-- 
2.30.2

