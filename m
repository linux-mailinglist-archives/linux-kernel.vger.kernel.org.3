Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1B4D3C79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiCIWA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiCIWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:00:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4A348323
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:59:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EEF0B823DB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099A6C340E8;
        Wed,  9 Mar 2022 21:59:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YsgAYRMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646863161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sTgDlWKYYsSSkOLh7Q7MGF4ob5kDwMXNVdWDqHs3HQ=;
        b=YsgAYRMeYX/WlsyoCY1I7A7y1BcP18ReMTPuniOnDihRYMcV2QY2Hp4exF4+jyKaDxgYbc
        KWDwIo9UW62chagGqKWx5RXe+p0U7NnAzOmBPxVjUY+PiPqTPiizEKAzwTOnuUG3W4Ydli
        TVftuc4ObWRTXos8TlSZLzb9GWA/Erc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a917cd6d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Mar 2022 21:59:20 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Adrian Catangiu <adrian@parity.io>,
        Jann Horn <jannh@google.com>
Subject: [PATCH RFC v2] random: add vm_id sysctl for polling
Date:   Wed,  9 Mar 2022 14:59:07 -0700
Message-Id: <20220309215907.77526-1-Jason@zx2c4.com>
In-Reply-To: <20220302143331.654426-1-Jason@zx2c4.com>
References: <20220302143331.654426-1-Jason@zx2c4.com>
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

This is an RFC, because I'm in no rush to add new userspace APIs without
being quite sure that this is the way forward.

In order to inform userspace of virtual machine forks, this commit adds
a "vm_id" sysctl, which does not return any data, but allows userspace
processes to poll() on it for notification of VM forks.

It avoids exposing the actual vmgenid from the hypervisor to userspace,
in case there is any randomness value in keeping it secret. Rather,
userspace is expected to simply use getrandom() if it wants a fresh
value.

The main purpose of posting this patch is just to have something
concrete to demonstrate the idea, as well as to show how simple this is
to implement. The discussion of races and such is for the thread in the
link below.

Link: https://lore.kernel.org/lkml/Yh4+9+UpanJWAIyZ@zx2c4.com/
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Alexander Graf <graf@amazon.com>
Cc: Adrian Catangiu <adrian@parity.io>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- No need to return any actual data in the file.

 Documentation/admin-guide/sysctl/kernel.rst |  3 ++-
 drivers/char/random.c                       | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 5dd660aac0ae..d3f30fa1fa21 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1039,8 +1039,9 @@ This is a directory, with the following entries:
 * ``write_wakeup_threshold``: when the entropy count drops below this
   (as a number of bits), processes waiting to write to ``/dev/random``
   are woken up. This file is writable for compatibility purposes, but
-  writing to it has no effect on any RNG behavior.
+  writing to it has no effect on any RNG behavior;
 
+* ``vm_id``: unreadable, but can be poll()'d on for VM forks.
 
 randomize_va_space
 ==================
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1273b2cdd1b7..02502e962877 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1163,6 +1163,7 @@ EXPORT_SYMBOL_GPL(add_bootloader_randomness);
 
 #if IS_ENABLED(CONFIG_VMGENID)
 static BLOCKING_NOTIFIER_HEAD(vmfork_chain);
+static DEFINE_CTL_TABLE_POLL(sysctl_vmid_poll);
 
 /*
  * Handle a new unique VM ID, which is unique, not secret, so we
@@ -1177,6 +1178,8 @@ void add_vmfork_randomness(const void *unique_vm_id, size_t size)
 		pr_notice("crng reseeded due to virtual machine fork\n");
 	}
 	blocking_notifier_call_chain(&vmfork_chain, 0, NULL);
+	if (IS_ENABLED(CONFIG_SYSCTL))
+		proc_sys_poll_notify(&sysctl_vmid_poll);
 }
 #if IS_MODULE(CONFIG_VMGENID)
 EXPORT_SYMBOL_GPL(add_vmfork_randomness);
@@ -1625,6 +1628,8 @@ const struct file_operations random_fops = {
  *   It is writable to avoid breaking old userspaces, but writing
  *   to it does not change any behavior of the RNG.
  *
+ * - vm_id - an unreadable file that can be poll()'d on for VM forks.
+ *
  ********************************************************************/
 
 #ifdef CONFIG_SYSCTL
@@ -1678,6 +1683,14 @@ static int proc_do_rointvec(struct ctl_table *table, int write, void *buffer,
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
@@ -1718,6 +1731,14 @@ static struct ctl_table random_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
+#if IS_ENABLED(CONFIG_VMGENID)
+	{
+		.procname	= "vm_id",
+		.mode		= 0444,
+		.poll		= &sysctl_vmid_poll,
+		.proc_handler	= proc_do_nodata,
+	},
+#endif
 	{ }
 };
 
-- 
2.35.1

