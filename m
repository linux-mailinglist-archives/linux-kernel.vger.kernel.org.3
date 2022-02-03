Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ED84A86F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242405AbiBCOuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:50:44 -0500
Received: from smtp-bc0c.mail.infomaniak.ch ([45.157.188.12]:36131 "EHLO
        smtp-bc0c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237993AbiBCOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:50:34 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JqM6J4KLMzMq0wq;
        Thu,  3 Feb 2022 15:50:32 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4JqM6H5hKWzlhMBt;
        Thu,  3 Feb 2022 15:50:31 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1] printk: Fix incorrect __user type in proc_dointvec_minmax_sysadmin()
Date:   Thu,  3 Feb 2022 15:50:29 +0100
Message-Id: <20220203145029.272640-1-mic@digikod.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

The move of proc_dointvec_minmax_sysadmin() from kernel/sysctl.c to
kernel/printk/sysctl.c introduced an incorrect __user attribute to the
buffer argument.  I spotted this change in [1] as well as the kernel
test robot.  Revert this change to please sparse:

kernel/printk/sysctl.c:20:51: warning: incorrect type in argument 3 (different address spaces)
kernel/printk/sysctl.c:20:51:    expected void *
kernel/printk/sysctl.c:20:51:    got void [noderef] __user *buffer

Fixes: faaa357a55e0 ("printk: move printk sysctl to printk/sysctl.c")
Link: https://lore.kernel.org/r/20220104155024.48023-2-mic@digikod.net [1]
Reported-by: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220203145029.272640-1-mic@digikod.net
---
 kernel/printk/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index 653ae04aab7f..c228343eeb97 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -12,7 +12,7 @@
 static const int ten_thousand = 10000;
 
 static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
-				void __user *buffer, size_t *lenp, loff_t *ppos)
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;

base-commit: 88808fbbead481aedb46640a5ace69c58287f56a
-- 
2.34.1

