Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6C75332F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbiEXVXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiEXVXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:23:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AEA71A24
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:23:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 36DE91F44798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653427388;
        bh=+4kY50wvvK8xnfpL7EAb+VQqUenC2VyyO6SNi5GVpOE=;
        h=From:To:Cc:Subject:Date:From;
        b=RyqEPqC7N8HkeMwEeJ5oYO9oIji6w9zMNumE8OwDsEls/1s1SLhXRonUSz2oCItTb
         M0uKojoWMkkwjsxx3RfpQdpHCAaqQpuE/aS1UvYGnEpZrnVNjMtVOmAcQFB51ql7qm
         SpEs/Qo0h2pceUDpyCqUQMednqVsNGcIpwzp46J/VZQQo5Xaozn365hlqK+t2r1189
         TmPEZi8xhie3GjGY/Ke1JHN8IjsA79V3JfEqu1xmlEBnlG9roC9WFsHTGqBqPI8y4j
         E0gzC5mBB8Zgo3d/aQlBhSuByw9QQNt2M/ZU5gQESXtt7jLPK5ph0G5cci2p7XLzyM
         kK/cBYHqMRGsg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] kernel/reboot: Change registration order of legacy power-off handler
Date:   Wed, 25 May 2022 00:21:18 +0300
Message-Id: <20220524212118.425702-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're unconditionally registering sys-off handler for the legacy
pm_power_off() callback, this causes problem for platforms that don't
use power-off handlers at all and should be halted. Now reboot syscall
assumes that there is a power-off handler installed and tries to power
off system instead of halting it.

To fix the trouble, move the handler's registration to the reboot syscall
and check the pm_power_off() presence.

Fixes: 0e2110d2e910 ("kernel/reboot: Add kernel_can_power_off()")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 kernel/reboot.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 0bdc64ecf4f6..a091145ee710 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -569,22 +569,6 @@ static int legacy_pm_power_off(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
-/*
- * Register sys-off handlers for legacy PM callbacks. This allows legacy
- * PM callbacks co-exist with the new sys-off API.
- *
- * TODO: Remove legacy handlers once all legacy PM users will be switched
- *       to the sys-off based APIs.
- */
-static int __init legacy_pm_init(void)
-{
-	register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
-				 legacy_pm_power_off, NULL);
-
-	return 0;
-}
-core_initcall(legacy_pm_init);
-
 static void do_kernel_power_off_prepare(void)
 {
 	blocking_notifier_call_chain(&power_off_prep_handler_list, 0, NULL);
@@ -646,6 +630,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		void __user *, arg)
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+	struct sys_off_handler *sys_off = NULL;
 	char buffer[256];
 	int ret = 0;
 
@@ -670,6 +655,21 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	if (ret)
 		return ret;
 
+	/*
+	 * Register sys-off handlers for legacy PM callback. This allows
+	 * legacy PM callbacks temporary co-exist with the new sys-off API.
+	 *
+	 * TODO: Remove legacy handlers once all legacy PM users will be
+	 *       switched to the sys-off based APIs.
+	 */
+	if (pm_power_off) {
+		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+						   SYS_OFF_PRIO_DEFAULT,
+						   legacy_pm_power_off, NULL);
+		if (IS_ERR(sys_off))
+			return PTR_ERR(sys_off);
+	}
+
 	/* Instead of trying to make the power_off code look like
 	 * halt when pm_power_off is not set do it the easy way.
 	 */
@@ -727,6 +727,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		break;
 	}
 	mutex_unlock(&system_transition_mutex);
+	unregister_sys_off_handler(sys_off);
 	return ret;
 }
 
-- 
2.35.3

