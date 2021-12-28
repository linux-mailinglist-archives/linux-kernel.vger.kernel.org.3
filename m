Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFF34806C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhL1Grs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:47:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57478 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhL1Grr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:47:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9469A6116B;
        Tue, 28 Dec 2021 06:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7A1C36AE7;
        Tue, 28 Dec 2021 06:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640674066;
        bh=ZzI/rT6HKZOmA3Y4x1O+3DsxjIlTfEeyQcm8s1mUUVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NokJf9tmUbdIp5UDLg7WM0oBeqP2Nwu/Dym+Hdt3GkgzafDDNY71qx4KtSbtFjyyf
         6HWp1ND24SW0rU05VIU7YtOG3wBfG6xAcSB5fOeFGwkwWeugtjMlOaKoF1UrMVMzTq
         FKf5yCBT8eGWR2D2Zvb+7tsVSRr/dBxRDRmlNf6CXPkL1R/GI2cfDRkSRaqXE+5bu1
         zDKXKWbqeoLBia3uM0A5jv9qJN2XkTQ1JYcxND2saZsSg23kp0mhTHUPsggbJxOn/r
         az4hMwxzy+Db/fMMa27vEJdjDGRnUgICZwcKeBYrMvFSbT9jhHk74r/Hae4FMgYx/H
         OR2yiPXSCC7pw==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 1/8] sched: Remove unused TASK_SIZE_OF
Date:   Tue, 28 Dec 2021 14:47:22 +0800
Message-Id: <20211228064730.2882351-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228064730.2882351-1-guoren@kernel.org>
References: <20211228064730.2882351-1-guoren@kernel.org>
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
Signed-off-by: Guo Ren <guoren@kernel.org>
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

