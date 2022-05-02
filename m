Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CA9517140
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiEBOKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiEBOJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BC41400C;
        Mon,  2 May 2022 07:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CC3D60BFA;
        Mon,  2 May 2022 14:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F545C385A4;
        Mon,  2 May 2022 14:06:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ToodEXVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651500384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rQyMSFgEv+4ufdK4+v7Jn/jBRu7ub8truRsxBLGJnY=;
        b=ToodEXVkPPJyogpMTevfBu1SPw40YAa9483Edxagibx4FeiWHpSzdlzCjkpijcqPkPeIHH
        vsxt8HT6WZtPTbQ+IR/PluKp853rGzx1FneLGujl8y+06PMoq+VoN8YaOrYNFmjmFJ8NRx
        7KBQhVVwIPRjMyCVqwsPLI2hU9awgj8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b98596b2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 14:06:24 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Date:   Mon,  2 May 2022 16:06:02 +0200
Message-Id: <20220502140602.130373-2-Jason@zx2c4.com>
In-Reply-To: <20220502140602.130373-1-Jason@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
    read(fd.fd, NULL, 0);
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
Cc: Colm MacCarthaigh <colmmacc@amazon.com>
Cc: Torben Hansen <htorben@amazon.co.uk>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
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
index bffc8682d6b8..39eda91b07ec 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1213,6 +1213,9 @@ EXPORT_SYMBOL_GPL(add_bootloader_randomness);
 
 #if IS_ENABLED(CONFIG_VMGENID)
 static BLOCKING_NOTIFIER_HEAD(vmfork_chain);
+#ifdef CONFIG_SYSCTL
+static DEFINE_CTL_TABLE_POLL(sysctl_fork_event_poll);
+#endif
 
 /*
  * Handle a new unique VM ID, which is unique, not secret, so we
@@ -1227,6 +1230,9 @@ void add_vmfork_randomness(const void *unique_vm_id, size_t size)
 		pr_notice("crng reseeded due to virtual machine fork\n");
 	}
 	blocking_notifier_call_chain(&vmfork_chain, 0, NULL);
+#ifdef CONFIG_SYSCTL
+	proc_sys_poll_notify(&sysctl_fork_event_poll);
+#endif
 }
 #if IS_MODULE(CONFIG_VMGENID)
 EXPORT_SYMBOL_GPL(add_vmfork_randomness);
@@ -1694,6 +1700,8 @@ const struct file_operations urandom_fops = {
  *   It is writable to avoid breaking old userspaces, but writing
  *   to it does not change any behavior of the RNG.
  *
+ * - fork_event - an unreadable file that can be poll()'d on for VM forks.
+ *
  ********************************************************************/
 
 #ifdef CONFIG_SYSCTL
@@ -1747,6 +1755,14 @@ static int proc_do_rointvec(struct ctl_table *table, int write, void *buffer,
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
@@ -1787,6 +1803,14 @@ static struct ctl_table random_table[] = {
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

