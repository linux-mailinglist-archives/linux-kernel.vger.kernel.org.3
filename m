Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEA47F1DD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 05:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhLYEzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 23:55:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45208 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhLYEy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 23:54:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2FDFB80B1E;
        Sat, 25 Dec 2021 04:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AA4C36AE5;
        Sat, 25 Dec 2021 04:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640408096;
        bh=jpwlZy74jLxlc+3k0tEIOwESvdOFLV/hmaQv6rvtTf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTiTOAE/i8mYfhq5M2YknTISehplcyImD+5pTyLaWy6f88ZA8IjjqNZEc+cBp+OqA
         K7Ri9LpvxrcGeRL6lbMnDweGduUWtwQII/NjRuY0iHc/SUgkQWS1V9S1YkDqmCiAdh
         69ylv6NGIaZb2sqKJrUzzJSiV3J5CfMiv8IbFdOozK+K8WdX0HaT1LUlDLt/c2Kssg
         yC+33xAKliaqHiqrrBzUhvQMeEXonINn4OnpDwUGmy9EtKYt3HO1JXBEMK/9FXHhzp
         zfLF4zR/4SS3LV8d868AhDEuqzieDZsjLRJVBvswgJ3Cq7+NuXFB7M/v/nS5ACxqvW
         ToIZu1sCn/CvQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 1/8] sched: Remove unused TASK_SIZE_OF
Date:   Sat, 25 Dec 2021 12:54:23 +0800
Message-Id: <20211225045430.2868608-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211225045430.2868608-1-guoren@kernel.org>
References: <20211225045430.2868608-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux, now. Delete in include/linux/sched.h
and arch's include/asm. This would confuse people who are
implementing the COMPAT feature for architecture.

Here is the comment by Arnd:
Looking through the git history, I see commit a06db751c321 ("pagemap:
check permissions and capabilities at open time") removing the last
user.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
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

