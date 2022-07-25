Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4743D57FF2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiGYMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiGYMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:42:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04BF5F594;
        Mon, 25 Jul 2022 05:42:17 -0700 (PDT)
Received: from pwmachine.numericable.fr (82.65.121.78.rev.sfr.net [78.121.65.82])
        by linux.microsoft.com (Postfix) with ESMTPSA id 04B5520C144A;
        Mon, 25 Jul 2022 05:42:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04B5520C144A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1658752936;
        bh=2j8Ih/EjSfDlFogjnBWHcfLYq+13KlAkeT4Uf98CxPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lilC8T96j7LLSZvF8awzzMyMyj8jNJ+NsoEuyahBOvr8wIk9ntjjfUab3r+Ntekwt
         JK+RWyjUqGNADBJiXSrKltpkJPzyD+lB5ow89wzFDuOYr3DaaLMLyel3zH1Z2hZbmt
         fQvS4Vt+g2cIUHL7a6mw/DLb+Tj2bQzvtANcI16s=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-security-module@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v4 2/2] security/inode.c: Add capabilities file.
Date:   Mon, 25 Jul 2022 14:41:23 +0200
Message-Id: <20220725124123.12975-3-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725124123.12975-1-flaniel@linux.microsoft.com>
References: <20220725124123.12975-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new read-only file prints the capabilities values with their names:
cat /sys/kernel/security/capabilities
0       CAP_CHOWN
1       CAP_DAC_OVERRIDE
...
40      CAP_CHECKPOINT_RESTORE

Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 security/inode.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..6da87ae5a8d6 100644
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
+	capabilities_dentry = securityfs_create_file("capabilities", 0444, NULL,
+						     NULL, &capabilities_ops);
 	return 0;
 }
 core_initcall(securityfs_init);
-- 
2.25.1

