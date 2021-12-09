Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A702246E2BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhLIGsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:48:03 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:51582 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229657AbhLIGsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:48:03 -0500
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-03 (Coremail) with SMTP id rQCowACHjVmEpbFhgPC7AQ--.42294S2;
        Thu, 09 Dec 2021 14:43:24 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     akpm@linux-foundation.org, pmladek@suse.com,
        valentin.schneider@arm.com, peterz@infradead.org,
        keescook@chromium.org, robdclark@chromium.org,
        samitolvanen@google.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] kthread: potential dereference of null pointer
Date:   Thu,  9 Dec 2021 14:43:14 +0800
Message-Id: <20211209064314.2074885-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjVmEpbFhgPC7AQ--.42294S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4xtrW8CFW8JFy7CFyDWrg_yoW3WrcEga
        nYqr1kCry2ywna9w1Ykw4SqrWvk3W5CF15u3srKFW3tas5Ka4xX3yjqrn8Kry3XrWkCrZr
        Gr1qkrZxW34UKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8AwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjHUDJUUUUU==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of kzalloc() needs to be checked.
To avoid use of null pointer in case of the failure of alloc.

Fixes: dc6a87f5450d ("sched: Make the idle task quack like a per-CPU kthread")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 kernel/kthread.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 08931e525dd9..3feefeff4922 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -101,6 +101,8 @@ void set_kthread_struct(struct task_struct *p)
 		return;
 
 	kthread = kzalloc(sizeof(*kthread), GFP_KERNEL);
+	if (!kthread)
+		return;
 	/*
 	 * We abuse ->set_child_tid to avoid the new member and because it
 	 * can't be wrongly copied by copy_process(). We also rely on fact
-- 
2.25.1

