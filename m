Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C71480377
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhL0Suk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhL0Sui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:50:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61B5C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:50:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6F061121
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02DEC36AE7;
        Mon, 27 Dec 2021 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640631036;
        bh=+2PYW8ndTaAT7pfR0fN74c1HRNjoYkQf4BnYJila/FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAwaCzYabWLCMDJHP7uQt1nK4+43g4eABw/eNdqLAjMs/nJIxUGATdsytZfJjeD87
         rfymHqYqLkGJCFZz+B4oNRtBgsdEtMSN0mLjmyAuUwNOaTrSx5dvDWgA6Jaag6l3D9
         ZB8K25S6+w3/lyKC9NhbdoFThMTCcUbooBEOP+yb81+MKI7qrEc2cokuSTeehMfJ3G
         JOQRUwdfCCciBe0pNBIfYia5hX+FPjRDfbqOY+OEauGApvyyFqkWVNcPFnzVcjrOid
         9J7zEnu8Y8g3Jm3cQ2I/98PR8VA9VieQOMWl8rsF3OEAyw34Dg5NKWNO3gfUbTwr9T
         ubxgtcofcXLSA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Brian Cain <bcain@codeaurora.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/3] h8300: Fix build errors from do_exit() to make_task_dead() transition
Date:   Mon, 27 Dec 2021 11:48:50 -0700
Message-Id: <20211227184851.2297759-3-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227184851.2297759-1-nathan@kernel.org>
References: <20211227184851.2297759-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ARCH=h8300 defconfig:

arch/h8300/kernel/traps.c: In function 'die':
arch/h8300/kernel/traps.c:109:2: error: implicit declaration of function
'make_dead_task' [-Werror=implicit-function-declaration]
  109 |  make_dead_task(SIGSEGV);
      |  ^~~~~~~~~~~~~~

arch/h8300/mm/fault.c: In function 'do_page_fault':
arch/h8300/mm/fault.c:54:2: error: implicit declaration of function
'make_dead_task' [-Werror=implicit-function-declaration]
   54 |  make_dead_task(SIGKILL);
      |  ^~~~~~~~~~~~~~

The function's name is make_task_dead(), change it so there is no more
build error.

Additionally, include linux/sched/task.h in arch/h8300/kernel/traps.c
to avoid the same error because do_exit()'s declaration is in kernel.h
but make_task_dead()'s is in task.h, which is not included in traps.c.

Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/h8300/kernel/traps.c | 3 ++-
 arch/h8300/mm/fault.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
index 3d4e0bde37ae..a92c39e03802 100644
--- a/arch/h8300/kernel/traps.c
+++ b/arch/h8300/kernel/traps.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/task.h>
 #include <linux/mm_types.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -106,7 +107,7 @@ void die(const char *str, struct pt_regs *fp, unsigned long err)
 	dump(fp);
 
 	spin_unlock_irq(&die_lock);
-	make_dead_task(SIGSEGV);
+	make_task_dead(SIGSEGV);
 }
 
 static int kstack_depth_to_print = 24;
diff --git a/arch/h8300/mm/fault.c b/arch/h8300/mm/fault.c
index 0223528565dd..b465441f490d 100644
--- a/arch/h8300/mm/fault.c
+++ b/arch/h8300/mm/fault.c
@@ -51,7 +51,7 @@ asmlinkage int do_page_fault(struct pt_regs *regs, unsigned long address,
 	printk(" at virtual address %08lx\n", address);
 	if (!user_mode(regs))
 		die("Oops", regs, error_code);
-	make_dead_task(SIGKILL);
+	make_task_dead(SIGKILL);
 
 	return 1;
 }
-- 
2.34.1

