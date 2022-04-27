Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD795112A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358920AbiD0HjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358915AbiD0HjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:39:19 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 300959BACF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:36:06 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E25951E80D5E;
        Wed, 27 Apr 2022 15:32:43 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TNAfY1qQKF8J; Wed, 27 Apr 2022 15:32:41 +0800 (CST)
Received: from localhost.localdomain (unknown [117.136.0.154])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id E01EA1E80D2D;
        Wed, 27 Apr 2022 15:32:40 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        elver@google.com
Cc:     oleg@redhat.com, legion@kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] kernel: Optimize unused integer return values
Date:   Wed, 27 Apr 2022 15:34:48 +0800
Message-Id: <20220427073448.10730-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize unused integer return values

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/signal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 30cd1ca43bcd..ae58a966c8de 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3464,7 +3464,7 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
 	return 0;
 }
 
-static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
+static void post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 					 const struct compat_siginfo *from)
 {
 	clear_siginfo(to);
@@ -3548,7 +3548,8 @@ static int __copy_siginfo_from_user32(int signo, struct kernel_siginfo *to,
 		return -EFAULT;
 
 	from.si_signo = signo;
-	return post_copy_siginfo_from_user32(to, &from);
+	post_copy_siginfo_from_user32(to, &from);
+	return 0;
 }
 
 int copy_siginfo_from_user32(struct kernel_siginfo *to,
@@ -3559,7 +3560,8 @@ int copy_siginfo_from_user32(struct kernel_siginfo *to,
 	if (copy_from_user(&from, ufrom, sizeof(struct compat_siginfo)))
 		return -EFAULT;
 
-	return post_copy_siginfo_from_user32(to, &from);
+	post_copy_siginfo_from_user32(to, &from);
+	return 0;
 }
 #endif /* CONFIG_COMPAT */
 
-- 
2.18.2

