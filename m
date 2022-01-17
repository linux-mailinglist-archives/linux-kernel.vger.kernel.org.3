Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2C490A18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiAQONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:13:30 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54212 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiAQONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:13:23 -0500
Received: from machine.home (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id A6C9920B9132;
        Mon, 17 Jan 2022 06:13:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6C9920B9132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642428802;
        bh=g7N7sfYLlsw3Se/LgOETJWnN/nS4JN3uvztiyC1WyDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIA4T0tCCem2JnWVe3goJY2Mv06pvKGSoPmBqpxqnHj5b1n6C8Q5qbt+OGB0Rjvuc
         8sQF6pTy9UTSdsaUOl1+Lw12kgdR4c7xaqz4NYQX/nt9tXauTYztkxnrWjlI53kRGv
         a+Jsr9YW6xx9IpMvWXYoJNDWU8xKRuvLIHnxTQV4=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [RFC PATCH v2 1/2] capability: Add cap_strings.
Date:   Mon, 17 Jan 2022 15:12:53 +0100
Message-Id: <20220117141254.46278-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220117141254.46278-1-flaniel@linux.microsoft.com>
References: <20220117141254.46278-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This array contains the capability names for the given capabilitiy.
For example, index CAP_BPF contains "CAP_BPF".

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 include/uapi/linux/capability.h |  1 +
 kernel/capability.c             | 44 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 463d1ba2232a..9646654d5111 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -428,5 +428,6 @@ struct vfs_ns_cap_data {
 #define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 == bits in __u32 */
 #define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed __u32 */
 
+extern const char *cap_strings[];
 
 #endif /* _UAPI_LINUX_CAPABILITY_H */
diff --git a/kernel/capability.c b/kernel/capability.c
index 46a361dde042..cd386419f2b7 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -27,6 +27,50 @@
 const kernel_cap_t __cap_empty_set = CAP_EMPTY_SET;
 EXPORT_SYMBOL(__cap_empty_set);
 
+const char *cap_strings[] = {
+	[CAP_CHOWN] = "CAP_CHOWN",
+	[CAP_DAC_OVERRIDE] = "CAP_DAC_OVERRIDE",
+	[CAP_DAC_READ_SEARCH] = "CAP_DAC_READ_SEARCH",
+	[CAP_FOWNER] = "CAP_FOWNER",
+	[CAP_FSETID] = "CAP_FSETID",
+	[CAP_KILL] = "CAP_KILL",
+	[CAP_SETGID] = "CAP_SETGID",
+	[CAP_SETUID] = "CAP_SETUID",
+	[CAP_SETPCAP] = "CAP_SETPCAP",
+	[CAP_LINUX_IMMUTABLE] = "CAP_LINUX_IMMUTABLE",
+	[CAP_NET_BIND_SERVICE] = "CAP_NET_BIND_SERVICE",
+	[CAP_NET_BROADCAST] = "CAP_NET_BROADCAST",
+	[CAP_NET_ADMIN] = "CAP_NET_ADMIN",
+	[CAP_NET_RAW] = "CAP_NET_RAW",
+	[CAP_IPC_LOCK] = "CAP_IPC_LOCK",
+	[CAP_IPC_OWNER] = "CAP_IPC_OWNER",
+	[CAP_SYS_MODULE] = "CAP_SYS_MODULE",
+	[CAP_SYS_RAWIO] = "CAP_SYS_RAWIO",
+	[CAP_SYS_CHROOT] = "CAP_SYS_CHROOT",
+	[CAP_SYS_PTRACE] = "CAP_SYS_PTRACE",
+	[CAP_SYS_PACCT] = "CAP_SYS_PACCT",
+	[CAP_SYS_ADMIN] = "CAP_SYS_ADMIN",
+	[CAP_SYS_BOOT] = "CAP_SYS_BOOT",
+	[CAP_SYS_NICE] = "CAP_SYS_NICE",
+	[CAP_SYS_RESOURCE] = "CAP_SYS_RESOURCE",
+	[CAP_SYS_TIME] = "CAP_SYS_TIME",
+	[CAP_SYS_TTY_CONFIG] = "CAP_SYS_TTY_CONFIG",
+	[CAP_MKNOD] = "CAP_MKNOD",
+	[CAP_LEASE] = "CAP_LEASE",
+	[CAP_AUDIT_WRITE] = "CAP_AUDIT_WRITE",
+	[CAP_AUDIT_CONTROL] = "CAP_AUDIT_CONTROL",
+	[CAP_SETFCAP] = "CAP_SETFCAP",
+	[CAP_MAC_OVERRIDE] = "CAP_MAC_OVERRIDE",
+	[CAP_MAC_ADMIN] = "CAP_MAC_ADMIN",
+	[CAP_SYSLOG] = "CAP_SYSLOG",
+	[CAP_WAKE_ALARM] = "CAP_WAKE_ALARM",
+	[CAP_BLOCK_SUSPEND] = "CAP_BLOCK_SUSPEND",
+	[CAP_AUDIT_READ] = "CAP_AUDIT_READ",
+	[CAP_PERFMON] = "CAP_PERFMON",
+	[CAP_BPF] = "CAP_BPF",
+	[CAP_CHECKPOINT_RESTORE] = "CAP_CHECKPOINT_RESTORE",
+};
+
 int file_caps_enabled = 1;
 
 static int __init file_caps_disable(char *str)
-- 
2.30.2

