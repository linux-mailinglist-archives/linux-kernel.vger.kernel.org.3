Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF04D720E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 02:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiCMBJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 20:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiCMBJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:09:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4F136E2C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 17:08:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ADF560B93
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 01:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F388CC340EB;
        Sun, 13 Mar 2022 01:08:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LXMUprHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647133679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jn8um4RcDh8NzJTb22ESFoeySS2YQ9eFYQa/n+O5y2M=;
        b=LXMUprHvZK836lT7SaztGrQOztSEXKH+psZGOtFzVzOBRhwX4m0ZZFOqnRJJcSRcoYZfiJ
        +Tor05Zq6PMcxUTUWNfM0ru/Wp9cxzyMHXKZlZpdgHbl+cH62yjGcNC2+HelNIgTk51dHE
        jdGtI4pRJRQqS6JKNZ3aqD0qRJ+Gprc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 060ec091 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Mar 2022 01:07:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2] wireguard: device: clear keys on VM fork
Date:   Sat, 12 Mar 2022 18:07:16 -0700
Message-Id: <20220313010716.27044-1-Jason@zx2c4.com>
In-Reply-To: <20220301231038.530897-4-Jason@zx2c4.com>
References: <20220301231038.530897-4-Jason@zx2c4.com>
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

When a virtual machine forks, it's important that WireGuard clear
existing sessions so that different plaintexts are not transmitted using
the same key+nonce, which can result in catastrophic cryptographic
failure. To accomplish this, we simply hook into the newly added vmfork
notifier.

As a bonus, it turns out that, like the vmfork registration function,
the PM registration function is stubbed out when CONFIG_PM_SLEEP is not
set, so we can actually just remove the maze of ifdefs, which makes it
really quite clean to support both notifiers at once.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Fundamentally the same as v1, but just refactored into its own function
to be less hacky. Meant to post this 10 days ago as it's been sitting in
my tree being tested like this for a while now; this is what I've got
queued up for 5.18, so posting to the list for completeness.

 drivers/net/wireguard/device.c | 38 ++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index a46067c38bf5..0fad1331303c 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -59,9 +59,7 @@ static int wg_open(struct net_device *dev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int wg_pm_notification(struct notifier_block *nb, unsigned long action,
-			      void *data)
+static int wg_pm_notification(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct wg_device *wg;
 	struct wg_peer *peer;
@@ -92,7 +90,24 @@ static int wg_pm_notification(struct notifier_block *nb, unsigned long action,
 }
 
 static struct notifier_block pm_notifier = { .notifier_call = wg_pm_notification };
-#endif
+
+static int wg_vm_notification(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct wg_device *wg;
+	struct wg_peer *peer;
+
+	rtnl_lock();
+	list_for_each_entry(wg, &device_list, device_list) {
+		mutex_lock(&wg->device_update_lock);
+		list_for_each_entry(peer, &wg->peer_list, peer_list)
+			wg_noise_expire_current_peer_keypairs(peer);
+		mutex_unlock(&wg->device_update_lock);
+	}
+	rtnl_unlock();
+	return 0;
+}
+
+static struct notifier_block vm_notifier = { .notifier_call = wg_vm_notification };
 
 static int wg_stop(struct net_device *dev)
 {
@@ -424,16 +439,18 @@ int __init wg_device_init(void)
 {
 	int ret;
 
-#ifdef CONFIG_PM_SLEEP
 	ret = register_pm_notifier(&pm_notifier);
 	if (ret)
 		return ret;
-#endif
 
-	ret = register_pernet_device(&pernet_ops);
+	ret = register_random_vmfork_notifier(&vm_notifier);
 	if (ret)
 		goto error_pm;
 
+	ret = register_pernet_device(&pernet_ops);
+	if (ret)
+		goto error_vm;
+
 	ret = rtnl_link_register(&link_ops);
 	if (ret)
 		goto error_pernet;
@@ -442,10 +459,10 @@ int __init wg_device_init(void)
 
 error_pernet:
 	unregister_pernet_device(&pernet_ops);
+error_vm:
+	unregister_random_vmfork_notifier(&vm_notifier);
 error_pm:
-#ifdef CONFIG_PM_SLEEP
 	unregister_pm_notifier(&pm_notifier);
-#endif
 	return ret;
 }
 
@@ -453,8 +470,7 @@ void wg_device_uninit(void)
 {
 	rtnl_link_unregister(&link_ops);
 	unregister_pernet_device(&pernet_ops);
-#ifdef CONFIG_PM_SLEEP
+	unregister_random_vmfork_notifier(&vm_notifier);
 	unregister_pm_notifier(&pm_notifier);
-#endif
 	rcu_barrier();
 }
-- 
2.35.1

