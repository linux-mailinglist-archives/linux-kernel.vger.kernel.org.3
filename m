Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2ED57FF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiGYMmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiGYMmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:42:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71763EA5;
        Mon, 25 Jul 2022 05:42:14 -0700 (PDT)
Received: from pwmachine.numericable.fr (82.65.121.78.rev.sfr.net [78.121.65.82])
        by linux.microsoft.com (Postfix) with ESMTPSA id 73FE620FE2EF;
        Mon, 25 Jul 2022 05:42:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73FE620FE2EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1658752934;
        bh=eP40915vgoBrG96hKTUVxcYImLSDsKFEvVRuWZFLCaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqCi3j+3MBTonE5wv1O9LN+FyrEtNU2oDfrNWw+iNlYuGfrM9AS1KRx89MSePuHmK
         jC7upqTT2u7ITKmj1wJpgJBKxrAT3NdjbBna+E2YZlrdaJraJhK3uBor7Weoho4hZa
         yQU9a5IloIUNytZu7K/3A9BpXzoUMvPnrE0lC8Xs=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-security-module@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v4 1/2] capability: Add cap_string.
Date:   Mon, 25 Jul 2022 14:41:22 +0200
Message-Id: <20220725124123.12975-2-flaniel@linux.microsoft.com>
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

This string contains on each line the number of the capability associated
to its name.
For example, first line is:
__stringify(CAP_CHOWN) "\tCAP_CHOWN\n"
which the preprocessor will replace by:
"0\tCAP_CHOWN\n"

Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 include/uapi/linux/capability.h |  1 +
 kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 463d1ba2232a..115f4fef00da 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -428,5 +428,6 @@ struct vfs_ns_cap_data {
 #define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 == bits in __u32 */
 #define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed __u32 */
 
+extern const char *cap_string;
 
 #endif /* _UAPI_LINUX_CAPABILITY_H */
diff --git a/kernel/capability.c b/kernel/capability.c
index 765194f5d678..4cd0ce07458b 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/security.h>
+#include <linux/stringify.h>
 #include <linux/syscalls.h>
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
@@ -27,6 +28,50 @@
 const kernel_cap_t __cap_empty_set = CAP_EMPTY_SET;
 EXPORT_SYMBOL(__cap_empty_set);
 
+const char *cap_string =
+	__stringify(CAP_CHOWN) "\tCAP_CHOWN\n"
+	__stringify(CAP_DAC_OVERRIDE) "\tCAP_DAC_OVERRIDE\n"
+	__stringify(CAP_DAC_READ_SEARCH) "\tCAP_DAC_READ_SEARCH\n"
+	__stringify(CAP_FOWNER) "\tCAP_FOWNER\n"
+	__stringify(CAP_FSETID) "\tCAP_FSETID\n"
+	__stringify(CAP_KILL) "\tCAP_KILL\n"
+	__stringify(CAP_SETGID) "\tCAP_SETGID\n"
+	__stringify(CAP_SETUID) "\tCAP_SETUID\n"
+	__stringify(CAP_SETPCAP) "\tCAP_SETPCAP\n"
+	__stringify(CAP_LINUX_IMMUTABLE) "\tCAP_LINUX_IMMUTABLE\n"
+	__stringify(CAP_NET_BIND_SERVICE) "\tCAP_NET_BIND_SERVICE\n"
+	__stringify(CAP_NET_BROADCAST) "\tCAP_NET_BROADCAST\n"
+	__stringify(CAP_NET_ADMIN) "\tCAP_NET_ADMIN\n"
+	__stringify(CAP_NET_RAW) "\tCAP_NET_RAW\n"
+	__stringify(CAP_IPC_LOCK) "\tCAP_IPC_LOCK\n"
+	__stringify(CAP_IPC_OWNER) "\tCAP_IPC_OWNER\n"
+	__stringify(CAP_SYS_MODULE) "\tCAP_SYS_MODULE\n"
+	__stringify(CAP_SYS_RAWIO) "\tCAP_SYS_RAWIO\n"
+	__stringify(CAP_SYS_CHROOT) "\tCAP_SYS_CHROOT\n"
+	__stringify(CAP_SYS_PTRACE) "\tCAP_SYS_PTRACE\n"
+	__stringify(CAP_SYS_PACCT) "\tCAP_SYS_PACCT\n"
+	__stringify(CAP_SYS_ADMIN) "\tCAP_SYS_ADMIN\n"
+	__stringify(CAP_SYS_BOOT) "\tCAP_SYS_BOOT\n"
+	__stringify(CAP_SYS_NICE) "\tCAP_SYS_NICE\n"
+	__stringify(CAP_SYS_RESOURCE) "\tCAP_SYS_RESOURCE\n"
+	__stringify(CAP_SYS_TIME) "\tCAP_SYS_TIME\n"
+	__stringify(CAP_SYS_TTY_CONFIG) "\tCAP_SYS_TTY_CONFIG\n"
+	__stringify(CAP_MKNOD) "\tCAP_MKNOD\n"
+	__stringify(CAP_LEASE) "\tCAP_LEASE\n"
+	__stringify(CAP_AUDIT_WRITE) "\tCAP_AUDIT_WRITE\n"
+	__stringify(CAP_AUDIT_CONTROL) "\tCAP_AUDIT_CONTROL\n"
+	__stringify(CAP_SETFCAP) "\tCAP_SETFCAP\n"
+	__stringify(CAP_MAC_OVERRIDE) "\tCAP_MAC_OVERRIDE\n"
+	__stringify(CAP_MAC_ADMIN) "\tCAP_MAC_ADMIN\n"
+	__stringify(CAP_SYSLOG) "\tCAP_SYSLOG\n"
+	__stringify(CAP_WAKE_ALARM) "\tCAP_WAKE_ALARM\n"
+	__stringify(CAP_BLOCK_SUSPEND) "\tCAP_BLOCK_SUSPEND\n"
+	__stringify(CAP_AUDIT_READ) "\tCAP_AUDIT_READ\n"
+	__stringify(CAP_PERFMON) "\tCAP_PERFMON\n"
+	__stringify(CAP_BPF) "\tCAP_BPF\n"
+	__stringify(CAP_CHECKPOINT_RESTORE) "\tCAP_CHECKPOINT_RESTORE\n"
+;
+
 int file_caps_enabled = 1;
 
 static int __init file_caps_disable(char *str)
-- 
2.25.1

