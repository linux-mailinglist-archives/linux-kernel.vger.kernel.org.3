Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6837047D274
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbhLVMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:50:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46572 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbhLVMua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:50:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 8058B1F444B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1640177428;
        bh=oDPAxVUQHW58K8EMDXUNFmDEBJmgKlUnF1PgJ0K4Z7s=;
        h=Date:From:To:Cc:Subject:From;
        b=LrmGl1POZKrfwBgjYJCKJUs4q1GMjrudA4r8tpnyjEBilmndiHek9EvUZXOM1Vm38
         5/dCWU7d7uDSWAhqpE1tKcecqSzzuHnjQgSlKpNrmx9QldfCzqmgVNSWckyfaBWlzD
         NFQ7wiXSTtAUgBc3OHHl7WPb4mfK1++09I7YXJQhyzawBkCrfjScnHLxrrXn92eLE7
         3t/9DYkXFYiRx2oIUBxG8S2IupsjlgDody2ekQO4GlJDGJUzxBPj2o1oK25OobF6Fo
         bL/KQPnD+Ylxr4rxfawe8Rz4fzYkMKr+XFO74SI8bmqTA7JNWBe3kUEPv9f5IBVmYK
         QmhWCynIs1WUQ==
Date:   Wed, 22 Dec 2021 17:50:20 +0500
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     usama.anjum@collabora.com, ellyjones@chromium.org,
        Kay Sievers <kay@vrfy.org>,
        Roland Eggner <edvx1@systemanalysen.net>,
        Kees Cook <keescook@chromium.org>, kernel@collabora.com,
        krisman@collabora.com
Subject: [PATCH] devtmpfs: mount with noexec and nosuid
Message-ID: <YcMfDOyrg647RCmd@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

devtmpfs is writable. Add the noexec and nosuid as default mount flags
to prevent code execution from /dev. The systems who don't use systemd
and who rely on CONFIG_DEVTMPFS_MOUNT=y are the ones to be protected by
this patch. Other systems are fine with the udev solution.

No sane program should be relying on executing from /dev. So this patch
reduces the attack surface. It doesn't prevent any specific attack, but
it reduces the possibility that someone can use /dev as a place to put
executable code. Chrome OS has been carrying this patch for several
years. It seems trivial and simple solution to improve the protection of
/dev when CONFIG_DEVTMPFS_MOUNT=y.

Original patch:
https://lore.kernel.org/lkml/20121120215059.GA1859@www.outflux.net/

Cc: ellyjones@chromium.org
Cc: Kay Sievers <kay@vrfy.org>
Cc: Roland Eggner <edvx1@systemanalysen.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/base/Kconfig    | 11 +++++++++++
 drivers/base/devtmpfs.c | 10 ++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index ffcbe2bc460e..6f04b831a5c0 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -62,6 +62,17 @@ config DEVTMPFS_MOUNT
 	  rescue mode with init=/bin/sh, even when the /dev directory
 	  on the rootfs is completely empty.
 
+config DEVTMPFS_SAFE
+	bool "Use nosuid,noexec mount options on devtmpfs"
+	depends on DEVTMPFS
+	help
+	  This instructs the kernel to include the MS_NOEXEC and MS_NOSUID mount
+	  flags when mounting devtmpfs.
+
+	  Notice: If enabled, things like /dev/mem cannot be mmapped
+	  with the PROT_EXEC flag. This can break, for example, non-KMS
+	  video drivers.
+
 config STANDALONE
 	bool "Select only drivers that don't need compile-time external firmware"
 	default y
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 8be352ab4ddb..1e2c2d3882e2 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -29,6 +29,12 @@
 #include <uapi/linux/mount.h>
 #include "base.h"
 
+#ifdef CONFIG_DEVTMPFS_SAFE
+#define DEVTMPFS_MFLAGS       (MS_SILENT | MS_NOEXEC | MS_NOSUID)
+#else
+#define DEVTMPFS_MFLAGS       (MS_SILENT)
+#endif
+
 static struct task_struct *thread;
 
 static int __initdata mount_dev = IS_ENABLED(CONFIG_DEVTMPFS_MOUNT);
@@ -363,7 +369,7 @@ int __init devtmpfs_mount(void)
 	if (!thread)
 		return 0;
 
-	err = init_mount("devtmpfs", "dev", "devtmpfs", MS_SILENT, NULL);
+	err = init_mount("devtmpfs", "dev", "devtmpfs", DEVTMPFS_MFLAGS, NULL);
 	if (err)
 		printk(KERN_INFO "devtmpfs: error mounting %i\n", err);
 	else
@@ -412,7 +418,7 @@ static noinline int __init devtmpfs_setup(void *p)
 	err = ksys_unshare(CLONE_NEWNS);
 	if (err)
 		goto out;
-	err = init_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, NULL);
+	err = init_mount("devtmpfs", "/", "devtmpfs", DEVTMPFS_MFLAGS, NULL);
 	if (err)
 		goto out;
 	init_chdir("/.."); /* will traverse into overmounted root */
-- 
2.30.2

