Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0E151C7C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiEESch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384134AbiEESX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:23:57 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 11:17:11 PDT
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C5C5EBEE
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1651774036; bh=Sv0gairPZCvJcETF74arcxG7IPuoEuc9W1XozjergCE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=R/hxUUGsq8oFMGmXzwg6AmJtGw1hK25Z7lPYq6s/Iova6QY5ldiZ7dbkRfoNq0sCc
         o685hfuHDWsIonvqpzrktfa+rskZ+Vx7VrrEl4QytvkejoLCsHPoXjPDixMI325LW+
         z3/JcnR6dxNdwzSx+Ynewi5d8VXN5P/h4fjiuMeouPBcrwfMKBRovLpsHNuasYgJM7
         xFp/wprDMcmht5fZmkq0Z/Sn1S/DlEVEB/VCemVc0lfc1wRzvgAaDVSgb8ZY0qO6Oh
         HyvsITbmzQ7TbZgw/AA2TP6mVo8HcAPAZEyqXMTzdWMKJ5eGiqNdU1MhL3OyFdviVi
         QyX022h0+CQgQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id 4B7A18071D;
        Thu,  5 May 2022 18:07:16 +0000 (UTC)
From:   Dan Moulding <dmoulding@me.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, corbet@lwn.net,
        Dan Moulding <dmoulding@me.com>
Subject: [PATCH 1/1] init: Add "hostname" kernel parameter
Date:   Thu,  5 May 2022 12:06:51 -0600
Message-Id: <20220505180651.22849-2-dmoulding@me.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505180651.22849-1-dmoulding@me.com>
References: <20220505180651.22849-1-dmoulding@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X3NDRHDIs7pX8M3aaDuMEpjHW1IxvI5-
X-Proofpoint-ORIG-GUID: X3NDRHDIs7pX8M3aaDuMEpjHW1IxvI5-
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gethostname system call returns the hostname for the current
machine. However, the kernel has no mechanism to initially set the
current machine's name in such a way as to guarantee that the first
userspace process to call gethostname will receive a meaningful
result. It relies on some unspecified userspace process to first call
sethostname before gethostname can produce a meaningful name.

Traditionally the machine's hostname is set from userspace by the init
system. The init system, in turn, often relies on a configuration file
(say, /etc/hostname) to provide the value that it will supply in the
call to sethostname. Consequently, the file system containing
/etc/hostname usually must be available before the hostname will be
set. There may, however, be earlier userspace processes that could
call gethostname before the file system containing /etc/hostname is
mounted. Such a process will get some other, likely meaningless, name
from gethostname (such as "(none)", "localhost", or "darkstar").

A real-world example where this can happen, and lead to undesirable
results, is with mdadm. When assembling arrays, mdadm distinguishes
between "local" arrays and "foreign" arrays. A local array is one that
properly belongs to the current machine, and a foreign array is one
that is (possibly temporarily) attached to the current machine, but
properly belongs to some other machine. To determine if an array is
local or foreign, mdadm may compare the "homehost" recorded on the
array with the current hostname. If mdadm is run before the root file
system is mounted, perhaps because the root file system itself resides
on an md-raid array, then /etc/hostname isn't yet available and the
init system will not yet have called sethostname, causing mdadm to
incorrectly conclude that all of the local arrays are foreign.

Solving this problem *could* be delegated to the init system. It could
be left up to the init system (including any init system that starts
within an initramfs, if one is in use) to ensure that sethostname is
called before any other userspace process could possibly call
gethostname. However, it may not always be obvious which processes
could call gethostname (for example, udev itself might not call
gethostname, but it could via udev rules invoke processes that
do). Additionally, the init system has to ensure that the hostname
configuration value is stored in some place where it will be readily
accessible during early boot. Unfortunately, every init system will
attempt to (or has already attempted to) solve this problem in a
different, possibly incorrect, way. This makes getting consistently
working configurations harder for users.

I believe it is better for the kernel to provide the means by which
the hostname may be set early, rather than making this a problem for
the init system to solve. The option to set the hostname during early
startup, via a kernel parameter, provides a simple, reliable way to
solve this problem. It also could make system configuration easier for
some embedded systems.

Signed-off-by: Dan Moulding <dmoulding@me.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 init/version.c                                  | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..873481d72e94 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1615,6 +1615,19 @@
 			Valid parameters: "on", "off"
 			Default: "on"
 
+	hostname=	[KNL] Set the hostname (aka UTS nodename).
+			Format: <string>
+			This allows setting the system's hostname during early
+			startup. This sets the name returned by gethostname.
+			Using this parameter to set the hostname makes it
+			possible to ensure the hostname is correctly set before
+			any userspace processes run, avoiding the possibility
+			that a process may call gethostname before the hostname
+			has been explicitly set, resulting in the calling
+			process getting an incorrect result. The string must
+			not exceed the maximum allowed hostname length (usually
+			64 characters) and will be truncated otherwise.
+
 	hlt		[BUGS=ARM,SH]
 
 	hpet=		[X86-32,HPET] option to control HPET usage
diff --git a/init/version.c b/init/version.c
index 1a356f5493e8..66d237d5629c 100644
--- a/init/version.c
+++ b/init/version.c
@@ -11,6 +11,8 @@
 #include <linux/build-salt.h>
 #include <linux/elfnote-lto.h>
 #include <linux/export.h>
+#include <linux/init.h>
+#include <linux/printk.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <generated/utsrelease.h>
@@ -35,6 +37,21 @@ struct uts_namespace init_uts_ns = {
 };
 EXPORT_SYMBOL_GPL(init_uts_ns);
 
+static int __init early_hostname(char *arg)
+{
+	size_t bufsize = sizeof(init_uts_ns.name.nodename);
+	size_t maxlen  = bufsize - 1;
+
+	strncpy(init_uts_ns.name.nodename, arg, bufsize);
+	if (strlen(arg) > maxlen) {
+		pr_warn("hostname parameter exceeds %zd characters and will be truncated",
+			maxlen);
+		init_uts_ns.name.nodename[maxlen] = '\0';
+	}
+	return 0;
+}
+early_param("hostname", early_hostname);
+
 /* FIXED STRINGS! Don't touch! */
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-- 
2.35.1

