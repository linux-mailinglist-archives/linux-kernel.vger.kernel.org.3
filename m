Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE62053ECB9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiFFRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFFRJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:09:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1098EE01;
        Mon,  6 Jun 2022 09:57:40 -0700 (PDT)
Received: from dimapc.. (109-252-138-163.dynamic.spd-mgts.ru [109.252.138.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60BFF6601C72;
        Mon,  6 Jun 2022 17:57:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654534658;
        bh=FIM8GIMepvfnT4TQY6iQ3wpMknXZhv7KK8TRc4lbx5s=;
        h=From:To:Cc:Subject:Date:From;
        b=YONWZn/EaULMwx0P2lLlZ6TNlQne7C9taGsOhCqpOvnf/WD5a+7HtSra1qVT8PzO5
         ojtHkBlPKFJ7IswrQoiHmRsp4hGCVBCGLefXiJ5hX46H848bwPCdDFxkw0hC0II95d
         mFLlTR17jOKfrUYCPn0q905VuZ2WfEErlUGYqbDAGHPpMXexGYXEFjCR3rGDff7bW5
         Mmko2QII3kn72nAvQLANVJimNKekHDYoDJUT7AJ+VKfHd/SOAvwHqAC53na/UYrxqg
         SuRCTnfA0MEreVTueWYbJZaA6NpF6flNj1j+5Tyd5gEfPQc9Kgit/hIBKsUcDJ3S8/
         BALJPxR8zhZPw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1] kernel/reboot: Fix powering off using a non-syscall code paths
Date:   Mon,  6 Jun 2022 19:56:40 +0300
Message-Id: <20220606165640.634811-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are other methods of powering off machine than the reboot syscall.
Previously we missed to coved those methods and it created power-off
regression for some machines, like the PowerPC e500. Fix this problem
by moving the legacy sys-off handler registration to the latest phase
of power-off process and making the kernel_can_power_off() to check the
legacy pm_power_off presence.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> # ppce500
Reported-by: Michael Ellerman <mpe@ellerman.id.au> # ppce500
Fixes: da007f171fc9 ("kernel/reboot: Change registration order of legacy power-off handler")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 kernel/reboot.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3b19b123efec..b5a71d1ff603 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -320,6 +320,7 @@ static struct sys_off_handler platform_sys_off_handler;
 static struct sys_off_handler *alloc_sys_off_handler(int priority)
 {
 	struct sys_off_handler *handler;
+	gfp_t flags;
 
 	/*
 	 * Platforms like m68k can't allocate sys_off handler dynamically
@@ -330,7 +331,12 @@ static struct sys_off_handler *alloc_sys_off_handler(int priority)
 		if (handler->cb_data)
 			return ERR_PTR(-EBUSY);
 	} else {
-		handler = kzalloc(sizeof(*handler), GFP_KERNEL);
+		if (system_state > SYSTEM_RUNNING)
+			flags = GFP_ATOMIC;
+		else
+			flags = GFP_KERNEL;
+
+		handler = kzalloc(sizeof(*handler), flags);
 		if (!handler)
 			return ERR_PTR(-ENOMEM);
 	}
@@ -440,7 +446,7 @@ void unregister_sys_off_handler(struct sys_off_handler *handler)
 {
 	int err;
 
-	if (!handler)
+	if (IS_ERR_OR_NULL(handler))
 		return;
 
 	if (handler->blocking)
@@ -615,7 +621,23 @@ static void do_kernel_power_off_prepare(void)
  */
 void do_kernel_power_off(void)
 {
+	struct sys_off_handler *sys_off = NULL;
+
+	/*
+	 * Register sys-off handlers for legacy PM callback. This allows
+	 * legacy PM callbacks temporary co-exist with the new sys-off API.
+	 *
+	 * TODO: Remove legacy handlers once all legacy PM users will be
+	 *       switched to the sys-off based APIs.
+	 */
+	if (pm_power_off)
+		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+						   SYS_OFF_PRIO_DEFAULT,
+						   legacy_pm_power_off, NULL);
+
 	atomic_notifier_call_chain(&power_off_handler_list, 0, NULL);
+
+	unregister_sys_off_handler(sys_off);
 }
 
 /**
@@ -626,7 +648,8 @@ void do_kernel_power_off(void)
  */
 bool kernel_can_power_off(void)
 {
-	return !atomic_notifier_call_chain_is_empty(&power_off_handler_list);
+	return !atomic_notifier_call_chain_is_empty(&power_off_handler_list) ||
+		pm_power_off;
 }
 EXPORT_SYMBOL_GPL(kernel_can_power_off);
 
@@ -661,7 +684,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		void __user *, arg)
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
-	struct sys_off_handler *sys_off = NULL;
 	char buffer[256];
 	int ret = 0;
 
@@ -686,21 +708,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	if (ret)
 		return ret;
 
-	/*
-	 * Register sys-off handlers for legacy PM callback. This allows
-	 * legacy PM callbacks temporary co-exist with the new sys-off API.
-	 *
-	 * TODO: Remove legacy handlers once all legacy PM users will be
-	 *       switched to the sys-off based APIs.
-	 */
-	if (pm_power_off) {
-		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
-						   SYS_OFF_PRIO_DEFAULT,
-						   legacy_pm_power_off, NULL);
-		if (IS_ERR(sys_off))
-			return PTR_ERR(sys_off);
-	}
-
 	/* Instead of trying to make the power_off code look like
 	 * halt when pm_power_off is not set do it the easy way.
 	 */
@@ -758,7 +765,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		break;
 	}
 	mutex_unlock(&system_transition_mutex);
-	unregister_sys_off_handler(sys_off);
 	return ret;
 }
 
-- 
2.35.3

