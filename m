Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A65AEF0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiIFPkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiIFPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:39:46 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1F893534
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:50:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 27AEB4157F;
        Tue,  6 Sep 2022 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662474717;
        bh=n9gK6v8a7GQ3TOMqWKjrtAvZjsIH1MMsyRbJOU4kJOc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=i8wUTA7/J1TExbccWiaIZUkbBhyzqPjCLucDuDxfKL7zuEn0EzPRReiNbnwNM1oiJ
         YCx2Ja/xXQW3691DrH+d+cu/n1LY1jubJxFWTEBiAUteS8+vXHxOMhisVzB8i2rkOR
         1HcaGjgMDSRPqfVieu7L8TkzTAI9vMzHVGZcf6DYLjoLtmybQCqOBLVTBALy/iXvvH
         SMPflEbVhYbTsZcb2IUEhZ8nxGhvRWLDjRD47gFyk91BBoKXxSIZ6lWqXXNzN9kHvX
         DRhpSYy4xMkztcZvQKpOAJXahNVxEocNyFJTDWaUXhwzlX6ZnxTDDuOmBWqqHmWW2v
         VU3SqrueCadLA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        tangmeng <tangmeng@uniontech.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: ACPI: reboot: Reinstate S5 for reboot
Date:   Tue,  6 Sep 2022 22:31:07 +0800
Message-Id: <20220906143108.1749183-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
PowerEdge r440 hangs at boot.

The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
system reboot to avoid triggering AER"), so reinstate the patch again.

Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Use do_kernel_power_off_prepare() instead.

 kernel/reboot.c | 55 +++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3c35445bf5ad3..39cbb45afc54a 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -243,28 +243,6 @@ void migrate_to_reboot_cpu(void)
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 }
 
-/**
- *	kernel_restart - reboot the system
- *	@cmd: pointer to buffer containing command to execute for restart
- *		or %NULL
- *
- *	Shutdown everything and perform a clean reboot.
- *	This is not safe to call in interrupt context.
- */
-void kernel_restart(char *cmd)
-{
-	kernel_restart_prepare(cmd);
-	migrate_to_reboot_cpu();
-	syscore_shutdown();
-	if (!cmd)
-		pr_emerg("Restarting system\n");
-	else
-		pr_emerg("Restarting system with command '%s'\n", cmd);
-	kmsg_dump(KMSG_DUMP_SHUTDOWN);
-	machine_restart(cmd);
-}
-EXPORT_SYMBOL_GPL(kernel_restart);
-
 static void kernel_shutdown_prepare(enum system_states state)
 {
 	blocking_notifier_call_chain(&reboot_notifier_list,
@@ -301,6 +279,34 @@ static BLOCKING_NOTIFIER_HEAD(power_off_prep_handler_list);
  */
 static ATOMIC_NOTIFIER_HEAD(power_off_handler_list);
 
+static void do_kernel_power_off_prepare(void)
+{
+	blocking_notifier_call_chain(&power_off_prep_handler_list, 0, NULL);
+}
+
+/**
+ *	kernel_restart - reboot the system
+ *	@cmd: pointer to buffer containing command to execute for restart
+ *		or %NULL
+ *
+ *	Shutdown everything and perform a clean reboot.
+ *	This is not safe to call in interrupt context.
+ */
+void kernel_restart(char *cmd)
+{
+	kernel_restart_prepare(cmd);
+	do_kernel_power_off_prepare();
+	migrate_to_reboot_cpu();
+	syscore_shutdown();
+	if (!cmd)
+		pr_emerg("Restarting system\n");
+	else
+		pr_emerg("Restarting system with command '%s'\n", cmd);
+	kmsg_dump(KMSG_DUMP_SHUTDOWN);
+	machine_restart(cmd);
+}
+EXPORT_SYMBOL_GPL(kernel_restart);
+
 static int sys_off_notify(struct notifier_block *nb,
 			  unsigned long mode, void *cmd)
 {
@@ -606,11 +612,6 @@ static int legacy_pm_power_off(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
-static void do_kernel_power_off_prepare(void)
-{
-	blocking_notifier_call_chain(&power_off_prep_handler_list, 0, NULL);
-}
-
 /**
  *	do_kernel_power_off - Execute kernel power-off handler call chain
  *
-- 
2.36.1

