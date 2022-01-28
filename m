Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0C249F47B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346907AbiA1HkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:40:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41426 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346901AbiA1HkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:40:16 -0500
Date:   Fri, 28 Jan 2022 07:40:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643355614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9MSknl794TSjihMC8rAHjUSWpRj5V4NFEk22cJWKM4=;
        b=tKGoYqLxgMQXQAt3qAwcfRR3TC36Mi6t1B66A5JCCVIgV8hQdFMkthUcgOZlnNFKGXsaGu
        ww+hj3rpqL53XhDnKCZKGUmmv9fieYZOhN1Ag2+3KWsSBCiQzr2MJqXT2rkm5g8A5l+KYt
        9BXobmK/nhimsqQYH3h3GtU0aszoSf3W/p3Gkc6zMeBjoP8ECpRM7blNVeh/NMSloqkidH
        w0Vq3USINAMBfRZK50iYPvw0h2oi7bWCC8J/sf2OPXsY31ncbPaw6Nk0oaZ1aj231fTota
        ZbhSTzGqhwisEbEX1sOiQIGbZOVeyZkhk0vYX0/5wNClNq74VUSBnoxfJHKH4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643355614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9MSknl794TSjihMC8rAHjUSWpRj5V4NFEk22cJWKM4=;
        b=jrwtoneHvyuJ9Yw2eYtRHtkI0s1sWfIzYHSjA6pzr0OXLlD1f/V3LEPdpFvsIwB0lP2/ut
        GzlyHCC61jzpDmDg==
From:   "tip-bot2 for Suren Baghdasaryan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Fix "no previous prototype" warnings when
 CONFIG_CGROUPS=n
Cc:     kernel test robot <lkp@intel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220119223940.787748-2-surenb@google.com>
References: <20220119223940.787748-2-surenb@google.com>
MIME-Version: 1.0
Message-ID: <164335561323.16921.12837458753857472708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ec2444530612a886b406e2830d7f314d1a07d4bb
Gitweb:        https://git.kernel.org/tip/ec2444530612a886b406e2830d7f314d1a07d4bb
Author:        Suren Baghdasaryan <surenb@google.com>
AuthorDate:    Wed, 19 Jan 2022 14:39:39 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Jan 2022 12:57:19 +01:00

psi: Fix "no previous prototype" warnings when CONFIG_CGROUPS=n

When CONFIG_CGROUPS is disabled psi code generates the following warnings:

kernel/sched/psi.c:1112:21: warning: no previous prototype for 'psi_trigger_create' [-Wmissing-prototypes]
    1112 | struct psi_trigger *psi_trigger_create(struct psi_group *group,
         |                     ^~~~~~~~~~~~~~~~~~
kernel/sched/psi.c:1182:6: warning: no previous prototype for 'psi_trigger_destroy' [-Wmissing-prototypes]
    1182 | void psi_trigger_destroy(struct psi_trigger *t)
         |      ^~~~~~~~~~~~~~~~~~~
kernel/sched/psi.c:1249:10: warning: no previous prototype for 'psi_trigger_poll' [-Wmissing-prototypes]
    1249 | __poll_t psi_trigger_poll(void **trigger_ptr,
         |          ^~~~~~~~~~~~~~~~

Change declarations of these functions in the header to provide the
prototypes even when they are unused.

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220119223940.787748-2-surenb@google.com
---
 include/linux/psi.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index a70ca83..8279702 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -25,18 +25,17 @@ void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
-
-#ifdef CONFIG_CGROUPS
-int psi_cgroup_alloc(struct cgroup *cgrp);
-void psi_cgroup_free(struct cgroup *cgrp);
-void cgroup_move_task(struct task_struct *p, struct css_set *to);
-
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			char *buf, size_t nbytes, enum psi_res res);
 void psi_trigger_replace(void **trigger_ptr, struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 			poll_table *wait);
+
+#ifdef CONFIG_CGROUPS
+int psi_cgroup_alloc(struct cgroup *cgrp);
+void psi_cgroup_free(struct cgroup *cgrp);
+void cgroup_move_task(struct task_struct *p, struct css_set *to);
 #endif
 
 #else /* CONFIG_PSI */
