Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FD4C918A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiCARcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiCARcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:32:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347EA5DA48;
        Tue,  1 Mar 2022 09:31:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C435561239;
        Tue,  1 Mar 2022 17:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CABCC340EE;
        Tue,  1 Mar 2022 17:31:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kSUnqs4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646155891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vc1xIBQ1Y9jEN/LhtA0lgOP4L65isWSwshwxlAZspDE=;
        b=kSUnqs4v2IVp+YuDS1e7pn6+F98MVwNpcjppSRzGy7fGds2LOyzaZS/ZFVArBHWJxieIM+
        5ETfadQ7LlOXQgGPRJkrzRSCEFfOhA8bTPIEpbUk6dZKiT6UUQXGu0cOAja/n21jbh+u2H
        y7i0P8HolV9DAXdbcn10tABUEuPNC+Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bae3578b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Mar 2022 17:31:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] PM: notify of PM_POST_VMFORK events from vmgenid
Date:   Tue,  1 Mar 2022 18:31:20 +0100
Message-Id: <20220301173120.297105-1-Jason@zx2c4.com>
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

There's an additional virtual power state that various crypto-oriented
drivers may benefit from being notified of, such as WireGuard: right
after a virtual machine has forked. In WireGuard's case, the PM notifier
there that clears keys pre-suspend will be adjusted to also clear them
post-vmfork. This trivial commit wires up the machinery for that change,
which builds on the recently added vmgenid driver in the random.git
tree.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/virt/vmgenid.c  | 2 ++
 include/linux/suspend.h | 4 ++++
 kernel/power/main.c     | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index 0ae1a39f2e28..4bef3e8b3476 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
 #include <linux/random.h>
 
 ACPI_MODULE_NAME("vmgenid");
@@ -75,6 +76,7 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
 	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
 		return;
 	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
+	pm_notify_vmfork();
 }
 
 static const struct acpi_device_id vmgenid_ids[] = {
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 300273ff40cc..a3836473b87b 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -477,6 +477,7 @@ static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
 #define PM_POST_SUSPEND		0x0004 /* Suspend finished */
 #define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
 #define PM_POST_RESTORE		0x0006 /* Restore failed */
+#define PM_POST_VMFORK		0x0007 /* Virtual machine has just forked */
 
 extern struct mutex system_transition_mutex;
 
@@ -487,6 +488,7 @@ void restore_processor_state(void);
 /* kernel/power/main.c */
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
+extern void pm_notify_vmfork(void);
 extern void ksys_sync_helper(void);
 
 #define pm_notifier(fn, pri) {				\
@@ -525,6 +527,8 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline void pm_notify_vmfork(void) {}
+
 static inline void ksys_sync_helper(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 7e646079fbeb..a64cfb36b1b3 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -94,6 +94,12 @@ int pm_notifier_call_chain(unsigned long val)
 	return blocking_notifier_call_chain(&pm_chain_head, val, NULL);
 }
 
+void pm_notify_vmfork(void)
+{
+	pm_notifier_call_chain(PM_POST_VMFORK);
+}
+EXPORT_SYMBOL_GPL(pm_notify_vmfork);
+
 /* If set, devices may be suspended and resumed asynchronously. */
 int pm_async_enabled = 1;
 
-- 
2.35.1

