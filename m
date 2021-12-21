Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FD247C46E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhLURBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35214 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240128AbhLURBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FDB5B817C8;
        Tue, 21 Dec 2021 17:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02DBC36AF1;
        Tue, 21 Dec 2021 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640106071;
        bh=Oy/NR31/F+xIHSgTDjx6GQ7Gg7r+DRliyRChxoAHfB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+2SY3ctNJy2loFboEsO1g1VwFMmfV1vqCzgFiBIAs+nQOxvy14mfPk6ozxvJiD0B
         eg90VAmLXNGCPOo9oB6vWiAiXtJiBS3aQw6asEkpwbbZRLsh0QbyPMz/5HiCv1MTpd
         IPAajqWSbzXDNhuf5QsWfR4GKqaHvQGOOX8oAUUCadtRsuEsG81hDYcWSXE0SDJfUS
         f3zeqKgVzuacH2+clEiw3G/1gOfpdBu8YvQjO8L5lIRyoAdFqjvTUmDM13Onb0pWlO
         yWXPjHR3GYyfgiGta4BbY4xbA66cojMLT2j8WuuzRs5FsgX8G01zNHESnkL4troWbC
         JU9hzS/5ry9ag==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/8] sched: Remove unused TASK_SIZE_OF
Date:   Wed, 22 Dec 2021 01:00:50 +0800
Message-Id: <20211221170057.2637763-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221170057.2637763-1-guoren@kernel.org>
References: <20211221170057.2637763-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux, now. Delete in include/linux/sched.h
and arch's include/asm. This would confuse people who are
implementing the COMPAT feature for architecture.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 include/linux/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..8e5689d06ac8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2166,10 +2166,6 @@ static inline bool vcpu_is_preempted(int cpu)
 extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
 extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 
-#ifndef TASK_SIZE_OF
-#define TASK_SIZE_OF(tsk)	TASK_SIZE
-#endif
-
 #ifdef CONFIG_SMP
 /* Returns effective CPU energy utilization, as seen by the scheduler */
 unsigned long sched_cpu_util(int cpu, unsigned long max);
-- 
2.25.1

