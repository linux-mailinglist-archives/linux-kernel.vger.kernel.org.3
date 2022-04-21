Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1050A0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386954AbiDUNjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387094AbiDUNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:38:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E943703C;
        Thu, 21 Apr 2022 06:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F0C61CD7;
        Thu, 21 Apr 2022 13:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C004EC385A5;
        Thu, 21 Apr 2022 13:35:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GoqJAm4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650548156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBF8XmsRCiIUYjI80Gf8USuRO0jyBLOQW0ghuIzMUfs=;
        b=GoqJAm4Cu0KTquqP5gqWtOhdH6rMAGoykUEHa4E3FJVRieAjwJsYSQLGrNH/OPTdgQ712G
        wibc9dDaaTdJWUhf/4vWAtNO0Fj31CIvGnoEi6D0jy151tSLvZXy507joUUvU0FOvzIPqW
        IF507Sg3e50aFwVGBF1oZ8tnC6jHztk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e7f28a6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 21 Apr 2022 13:35:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>, Jann Horn <jannh@google.com>
Subject: [PATCH v2] random: add fork_event sysctl for polling VM forks
Date:   Thu, 21 Apr 2022 15:35:42 +0200
Message-Id: <20220421133542.277768-1-Jason@zx2c4.com>
In-Reply-To: <20220419160407.1740458-1-Jason@zx2c4.com>
References: <20220419160407.1740458-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to inform userspace of virtual machine forks, this commit adds
a "fork_event" sysctl, which does not return any data, but allows
userspace processes to poll() on it for notification of VM forks.

It avoids exposing the actual vmgenid from the hypervisor to userspace,
in case there is any randomness value in keeping it secret. Rather,
userspace is expected to simply use getrandom() if it wants a fresh
value.

For example, the following snippet can be used to print a message every
time a VM forks, after the RNG has been reseeded:

  struct pollfd fd = { .fd = open("/proc/sys/kernel/random/fork_event", O_RDONLY)  };
  assert(fd.fd >= 0);
  for (;;) {
    assert(poll(&fd, 1, -1) > 0);
    puts("vm fork detected");
  }

Various programs and libraries that utilize cryptographic operations
depending on fresh randomness can invalidate old keys or take other
appropriate actions when receiving that event. While this is racier than
allowing userspace to mmap/vDSO the vmgenid itself, it's an incremental
step forward that's not as heavyweight.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Alexander Graf <graf@amazon.com>
Cc: Jann Horn <jannh@google.com>
Cc: Colm MacCarthaigh <colmmacc@amazon.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Alex/Colm - Could you guys let me know if this satisfies what you'd need
it for at Amazon?

Changes v1->v2:
- Some small fixes with the CONFIG_SYSCTL ifdef.

 Documentation/admin-guide/sysctl/kernel.rst |  6 ++++--
 drivers/char/random.c                       | 24 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1144ea3229a3..ddbd603f0be7 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1001,7 +1001,7 @@ This is a directory, with the following entries:
 * ``urandom_min_reseed_secs``: obsolete (used to determine the minimum
   number of seconds between urandom pool reseeding). This file is
   writable for compatibility purposes, but writing to it has no effect
-  on any RNG behavior.
+  on any RNG behavior;
 
 * ``uuid``: a UUID generated every time this is retrieved (this can
   thus be used to generate UUIDs at will);
@@ -1009,8 +1009,10 @@ This is a directory, with the following entries:
 * ``write_wakeup_threshold``: when the entropy count drops below this
   (as a number of bits), processes waiting to write to ``/dev/random``
   are woken up. This file is writable for compatibility purposes, but
-  writing to it has no effect on any RNG behavior.
+  writing to it has no effect on any RNG behavior;
 
+* ``fork_event``: unreadable, but can be poll()'d on for notifications
+  delivered after the RNG reseeds following a virtual machine fork.
 
 randomize_va_space
 ==================
diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf89c6f27a19..36196e463b90 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1187,6 +1187,9 @@ EXPORT_SYMBOL_GPL(add_bootloader_randomness);
 
 #if IS_ENABLED(CONFIG_VMGENID)
 static BLOCKING_NOTIFIER_HEAD(vmfork_chain);
+#ifdef CONFIG_SYSCTL
+static DEFINE_CTL_TABLE_POLL(sysctl_fork_event_poll);
+#endif
 
 /*
  * Handle a new unique VM ID, which is unique, not secret, so we
@@ -1201,6 +1204,9 @@ void add_vmfork_randomness(const void *unique_vm_id, size_t size)
 		pr_notice("crng reseeded due to virtual machine fork\n");
 	}
 	blocking_notifier_call_chain(&vmfork_chain, 0, NULL);
+#ifdef CONFIG_SYSCTL
+	proc_sys_poll_notify(&sysctl_fork_event_poll);
+#endif
 }
 #if IS_MODULE(CONFIG_VMGENID)
 EXPORT_SYMBOL_GPL(add_vmfork_randomness);
@@ -1655,6 +1661,8 @@ const struct file_operations urandom_fops = {
  *   It is writable to avoid breaking old userspaces, but writing
  *   to it does not change any behavior of the RNG.
  *
+ * - fork_event - an unreadable file that can be poll()'d on for VM forks.
+ *
  ********************************************************************/
 
 #ifdef CONFIG_SYSCTL
@@ -1708,6 +1716,14 @@ static int proc_do_rointvec(struct ctl_table *table, int write, void *buffer,
 	return write ? 0 : proc_dointvec(table, 0, buffer, lenp, ppos);
 }
 
+#if IS_ENABLED(CONFIG_VMGENID)
+static int proc_do_nodata(struct ctl_table *table, int write, void *buffer,
+			  size_t *lenp, loff_t *ppos)
+{
+	return -ENODATA;
+}
+#endif
+
 static struct ctl_table random_table[] = {
 	{
 		.procname	= "poolsize",
@@ -1748,6 +1764,14 @@ static struct ctl_table random_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
+#if IS_ENABLED(CONFIG_VMGENID)
+	{
+		.procname	= "fork_event",
+		.mode		= 0444,
+		.poll		= &sysctl_fork_event_poll,
+		.proc_handler	= proc_do_nodata,
+	},
+#endif
 	{ }
 };
 
-- 
2.35.1

