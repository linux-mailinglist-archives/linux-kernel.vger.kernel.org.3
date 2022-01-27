Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5C49DDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbiA0JcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:32:04 -0500
Received: from mail.loongson.cn ([114.242.206.163]:35744 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229861AbiA0JcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:32:02 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGuCHZvJhv+AEAA--.14616S2;
        Thu, 27 Jan 2022 17:31:52 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kdump: Add support for crashkernel=auto
Date:   Thu, 27 Jan 2022 17:31:51 +0800
Message-Id: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxGuCHZvJhv+AEAA--.14616S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF43Gr4rJrWfGrWDtF48tFb_yoW5KF43pr
        Z7CryfK34fGFnxG3yxJrn3C34rAw1xua4akas7Ar1FgFsaywn3Kr1Sgr1aqr9Fqr4F9FWY
        vF4Sgrn09a40v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4f
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8KZXUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the reserved memory automatically for the crash kernel based on
architecture.

Most code of this patch come from:
https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-8/-/tree/c8s

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/admin-guide/kdump/kdump.rst       | 13 +++++++++++++
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/crash_core.c                             | 20 ++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index cb30ca3d..8f8a9cc 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -335,6 +335,19 @@ crashkernel syntax
 
             crashkernel=0,low
 
+4) crashkernel=auto
+
+   You can use crashkernel=auto if you have enough memory. The threshold
+   is 1G on x86_64 and s390x, 2G on arm64, ppc64 and ppc64le. If your system
+   memory is less than the threshold crashkernel=auto will not reserve memory.
+
+   The automatically reserved memory size varies based on architecture.
+   The size changes according to system memory size like below:
+       x86_64: 1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M
+       s390x:  1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M
+       arm64:  2G-:448M
+       ppc64:  2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G
+
 Boot into System Kernel
 -----------------------
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f0..14f052d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -783,6 +783,11 @@
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
+	crashkernel=auto
+			[KNL] Set the reserved memory automatically for the crash kernel
+			based on architecture.
+			See Documentation/admin-guide/kdump/kdump.rst for further details.
+
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL] Using kexec, Linux can switch to a 'crash kernel'
 			upon panic. This parameter reserves the physical
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6d..32c51e2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char *cmdline,
 	if (suffix)
 		return parse_crashkernel_suffix(ck_cmdline, crash_size,
 				suffix);
+
+	if (strncmp(ck_cmdline, "auto", 4) == 0) {
+#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
+		ck_cmdline = "1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M";
+#elif defined(CONFIG_ARM64)
+		ck_cmdline = "2G-:448M";
+#elif defined(CONFIG_PPC64)
+		char *fadump_cmdline;
+
+		fadump_cmdline = get_last_crashkernel(cmdline, "fadump=", NULL);
+		fadump_cmdline = fadump_cmdline ?
+				fadump_cmdline + strlen("fadump=") : NULL;
+		if (!fadump_cmdline || (strncmp(fadump_cmdline, "off", 3) == 0))
+			ck_cmdline = "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
+		else
+			ck_cmdline = "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4T-8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G";
+#endif
+		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
+	}
+
 	/*
 	 * if the commandline contains a ':', then that's the extended
 	 * syntax -- if not, it must be the classic syntax
-- 
2.1.0

