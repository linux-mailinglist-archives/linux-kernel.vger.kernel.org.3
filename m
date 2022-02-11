Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17C4B25EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiBKMgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:36:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350201AbiBKMg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:36:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD39FC6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:36:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 749F161D69
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783A0C340E9;
        Fri, 11 Feb 2022 12:36:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bfaYytb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644582982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HUlSTdAvSnpP+trRFyAY30tAXEfW/0+t8cww6KDvIw=;
        b=bfaYytb2rMbbJq5+eMcKANtkCa/+TZLn6ofkPnHlVr5raz7oVl2pXBCBuWRDCFZb6SAfzA
        C/fdc68/yxlEnB8rzN361hnT5TyMJSf+Xf7BoCNtkPnYE0/K5m1jJ3EUcjZXz/ZvZpyhei
        ydvXL9+6USu43RnS7CYGHFoy3DC9p/A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 57cb0514 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 12:36:22 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 9/9] random: group sysctl functions
Date:   Fri, 11 Feb 2022 13:35:46 +0100
Message-Id: <20220211123546.474952-10-Jason@zx2c4.com>
In-Reply-To: <20220211123546.474952-1-Jason@zx2c4.com>
References: <20220211123546.474952-1-Jason@zx2c4.com>
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

This pulls all of the sysctl-focused functions into the sixth labeled
section.

No functional changes.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a4229474d7fa..bff77654910c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1537,7 +1537,25 @@ const struct file_operations urandom_fops = {
 
 /********************************************************************
  *
- * Sysctl interface
+ * Sysctl interface.
+ *
+ * These are mostly unused legacy knobs with dummy values to not break
+ * userspace. Still in use, however, are:
+ *
+ * - /proc/sys/kernel/random/boot_id - a UUID representing the current
+ *   boot.
+ *
+ * - /proc/sys/kernel/random/uuid - a random UUID, fresh each time.
+ *
+ * - /proc/sys/kernel/random/poolsize - the total amount of entropy
+ *   that the input pool can hold.
+ *
+ * - /proc/sys/kernel/random/write_wakeup_threshold - the amount of
+ *   entropy in the input pool below which write polls to
+ *   /dev/random will unblock, requesting more entropy. This is
+ *   currently the same value as the previous "poolsize" sysctl. It
+ *   is writable to avoid breaking old userspaces, but writing to it
+ *   does not change any behavior of the RNG.
  *
  ********************************************************************/
 
@@ -1545,8 +1563,8 @@ const struct file_operations urandom_fops = {
 
 #include <linux/sysctl.h>
 
-static int random_min_urandom_seed = 60;
-static int random_write_wakeup_bits = POOL_MIN_BITS;
+static int sysctl_random_min_urandom_seed = 60;
+static int sysctl_random_write_wakeup_bits = POOL_MIN_BITS;
 static int sysctl_poolsize = POOL_BITS;
 static char sysctl_bootid[16];
 
@@ -1603,14 +1621,14 @@ static struct ctl_table random_table[] = {
 	},
 	{
 		.procname	= "write_wakeup_threshold",
-		.data		= &random_write_wakeup_bits,
+		.data		= &sysctl_random_write_wakeup_bits,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
 	{
 		.procname	= "urandom_min_reseed_secs",
-		.data		= &random_min_urandom_seed,
+		.data		= &sysctl_random_min_urandom_seed,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
@@ -1641,4 +1659,4 @@ static int __init random_sysctls_init(void)
 	return 0;
 }
 device_initcall(random_sysctls_init);
-#endif	/* CONFIG_SYSCTL */
+#endif
-- 
2.35.0

