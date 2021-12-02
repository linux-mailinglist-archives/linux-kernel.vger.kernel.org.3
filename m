Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6F9465E29
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhLBGV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:21:28 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27333 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhLBGV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:21:27 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J4Qjv5rnHzbhyQ;
        Thu,  2 Dec 2021 14:17:55 +0800 (CST)
Received: from huawei.com (10.67.174.47) by dggeme755-chm.china.huawei.com
 (10.3.19.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Thu, 2
 Dec 2021 14:18:03 +0800
From:   He Ying <heying24@huawei.com>
To:     <rmk+kernel@armlinux.org.uk>, <arnd@arndb.de>, <ardb@kernel.org>,
        <akpm@linux-foundation.org>, <maninder1.s@samsung.com>,
        <wangkefeng.wang@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: Show real address of stack limit in __die()
Date:   Thu, 2 Dec 2021 01:19:16 -0500
Message-ID: <20211202061916.204718-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing real address of stack limit makes debug easier.
And system is dying, there is no security risk to show real
address.

Signed-off-by: He Ying <heying24@huawei.com>
---
 arch/arm/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 195dff58bafc..7d7c86d00482 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -273,7 +273,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	print_modules();
 	__show_regs(regs);
 	__show_regs_alloc_free(regs);
-	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
+	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%px)\n",
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
-- 
2.17.1

