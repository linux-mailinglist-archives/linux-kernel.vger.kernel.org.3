Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4254804B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 21:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhL0Uzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 15:55:31 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39688 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhL0Uz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 15:55:29 -0500
Received: from machine.home (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7C98920B717A;
        Mon, 27 Dec 2021 12:55:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C98920B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1640638529;
        bh=FWrILrh31/5tX5t0Mvs8QRc1llDZ4BRjVsAqqkjfKAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4+51dcHAbPWowg7micV1IJDN8Iw1A91J95orq1qjC9ai3Vb51LWB8UDHYq9GBvaK
         GXfYMeGnRYSJWbysEugNE84PjIayZTkl6FK3VWQ0UERq7i9WYZSm638T8hTzK6QK7c
         HxW4l3JsKjFcN/ncDZLC4rfFXD9npFdbgnSU4OLc=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [RFC PATCH v1 1/2] capability: Add cap_strings.
Date:   Mon, 27 Dec 2021 21:54:59 +0100
Message-Id: <20211227205500.214777-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211227205500.214777-1-flaniel@linux.microsoft.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com>
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
 kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

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
index 46a361dde042..5a2e71dcd87b 100644
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
 
+const char *cap_strings[] = {
+	[CAP_CHOWN] = __stringify_1(CAP_CHOWN),
+	[CAP_DAC_OVERRIDE] = __stringify_1(CAP_DAC_OVERRIDE),
+	[CAP_DAC_READ_SEARCH] = __stringify_1(CAP_DAC_READ_SEARCH),
+	[CAP_FOWNER] = __stringify_1(CAP_FOWNER),
+	[CAP_FSETID] = __stringify_1(CAP_FSETID),
+	[CAP_KILL] = __stringify_1(CAP_KILL),
+	[CAP_SETGID] = __stringify_1(CAP_SETGID),
+	[CAP_SETUID] = __stringify_1(CAP_SETUID),
+	[CAP_SETPCAP] = __stringify_1(CAP_SETPCAP),
+	[CAP_LINUX_IMMUTABLE] = __stringify_1(CAP_LINUX_IMMUTABLE),
+	[CAP_NET_BIND_SERVICE] = __stringify_1(CAP_NET_BIND_SERVICE),
+	[CAP_NET_BROADCAST] = __stringify_1(CAP_NET_BROADCAST),
+	[CAP_NET_ADMIN] = __stringify_1(CAP_NET_ADMIN),
+	[CAP_NET_RAW] = __stringify_1(CAP_NET_RAW),
+	[CAP_IPC_LOCK] = __stringify_1(CAP_IPC_LOCK),
+	[CAP_IPC_OWNER] = __stringify_1(CAP_IPC_OWNER),
+	[CAP_SYS_MODULE] = __stringify_1(CAP_SYS_MODULE),
+	[CAP_SYS_RAWIO] = __stringify_1(CAP_SYS_RAWIO),
+	[CAP_SYS_CHROOT] = __stringify_1(CAP_SYS_CHROOT),
+	[CAP_SYS_PTRACE] = __stringify_1(CAP_SYS_PTRACE),
+	[CAP_SYS_PACCT] = __stringify_1(CAP_SYS_PACCT),
+	[CAP_SYS_ADMIN] = __stringify_1(CAP_SYS_ADMIN),
+	[CAP_SYS_BOOT] = __stringify_1(CAP_SYS_BOOT),
+	[CAP_SYS_NICE] = __stringify_1(CAP_SYS_NICE),
+	[CAP_SYS_RESOURCE] = __stringify_1(CAP_SYS_RESOURCE),
+	[CAP_SYS_TIME] = __stringify_1(CAP_SYS_TIME),
+	[CAP_SYS_TTY_CONFIG] = __stringify_1(CAP_SYS_TTY_CONFIG),
+	[CAP_MKNOD] = __stringify_1(CAP_MKNOD),
+	[CAP_LEASE] = __stringify_1(CAP_LEASE),
+	[CAP_AUDIT_WRITE] = __stringify_1(CAP_AUDIT_WRITE),
+	[CAP_AUDIT_CONTROL] = __stringify_1(CAP_AUDIT_CONTROL),
+	[CAP_SETFCAP] = __stringify_1(CAP_SETFCAP),
+	[CAP_MAC_OVERRIDE] = __stringify_1(CAP_MAC_OVERRIDE),
+	[CAP_MAC_ADMIN] = __stringify_1(CAP_MAC_ADMIN),
+	[CAP_SYSLOG] = __stringify_1(CAP_SYSLOG),
+	[CAP_WAKE_ALARM] = __stringify_1(CAP_WAKE_ALARM),
+	[CAP_BLOCK_SUSPEND] = __stringify_1(CAP_BLOCK_SUSPEND),
+	[CAP_AUDIT_READ] = __stringify_1(CAP_AUDIT_READ),
+	[CAP_PERFMON] = __stringify_1(CAP_PERFMON),
+	[CAP_BPF] = __stringify_1(CAP_BPF),
+	[CAP_CHECKPOINT_RESTORE] = __stringify_1(CAP_CHECKPOINT_RESTORE),
+};
+
 int file_caps_enabled = 1;
 
 static int __init file_caps_disable(char *str)
-- 
2.30.2

