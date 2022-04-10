Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674D34FB035
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbiDJUor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbiDJUom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:44:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101B2BC2;
        Sun, 10 Apr 2022 13:42:31 -0700 (PDT)
Date:   Sun, 10 Apr 2022 20:42:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649623349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6BBnVu8wzaCIqJ1ur2LhpDFOZ8Llfg8Elmbox5Ubp8=;
        b=yE/1/j+ZB2kEjRWkKB4ihQpdqUn6Yk7yZa8pN1Ci1QqHJ5/3Jn72BZ98CoMKJE8zlaLxX4
        TyX2hborFbjgjJSF9H1E93ca2RLrdqXkzB2aMIDzB7fvX+Kia2nFJ1MsZrDgn21T39rTZJ
        UV/QYWvYVRjuNeFbByfJwj0GgQnHv537Zfs7YVORi8cfrK605Vk9pVZhhnN8s1JwqNAYpK
        FsbKc6v3gRLI2PpkJyK2hqtG7cwpcPJPn8W6axasQRN82yqQf8bIM0CbnaM8qnKcNt7tDr
        71Tmch/UD1PXHyyT3jvncDPkg4q0dZWfCZk532ay2oNivezY3TgYUM/vYabwKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649623349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6BBnVu8wzaCIqJ1ur2LhpDFOZ8Llfg8Elmbox5Ubp8=;
        b=vKU4ijpTkHuRFk0KX8w6LRUDZbp9ZjlL/RI3cnx0A/BfRJ3JoSP3pxCLYs/nYBC5Q1yGch
        ebchjh+FPfBrBUAA==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Replace cpumask_weight() with
 cpumask_empty() where appropriate
Cc:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220210224933.379149-17-yury.norov@gmail.com>
References: <20220210224933.379149-17-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <164962334860.4207.11115767621323928557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3a5ff1f6dd50f5e1c2aa87491910dd6d275af24b
Gitweb:        https://git.kernel.org/tip/3a5ff1f6dd50f5e1c2aa87491910dd6d275af24b
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Thu, 10 Feb 2022 14:49:00 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 22:35:38 +02:00

x86: Replace cpumask_weight() with cpumask_empty() where appropriate

In some cases, x86 code calls cpumask_weight() to check if any bit of a
given cpumask is set.

This can be done more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220210224933.379149-17-yury.norov@gmail.com

---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 14 +++++++-------
 arch/x86/mm/mmio-mod.c                 |  2 +-
 arch/x86/platform/uv/uv_nmi.c          |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 83f901e..f276aff 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -341,14 +341,14 @@ static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
 
 	/* Check whether cpus belong to parent ctrl group */
 	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
-	if (cpumask_weight(tmpmask)) {
+	if (!cpumask_empty(tmpmask)) {
 		rdt_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n");
 		return -EINVAL;
 	}
 
 	/* Check whether cpus are dropped from this group */
 	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
-	if (cpumask_weight(tmpmask)) {
+	if (!cpumask_empty(tmpmask)) {
 		/* Give any dropped cpus to parent rdtgroup */
 		cpumask_or(&prgrp->cpu_mask, &prgrp->cpu_mask, tmpmask);
 		update_closid_rmid(tmpmask, prgrp);
@@ -359,7 +359,7 @@ static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
 	 * and update per-cpu rmid
 	 */
 	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
-	if (cpumask_weight(tmpmask)) {
+	if (!cpumask_empty(tmpmask)) {
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
 			if (crgrp == rdtgrp)
@@ -394,7 +394,7 @@ static int cpus_ctrl_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
 
 	/* Check whether cpus are dropped from this group */
 	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
-	if (cpumask_weight(tmpmask)) {
+	if (!cpumask_empty(tmpmask)) {
 		/* Can't drop from default group */
 		if (rdtgrp == &rdtgroup_default) {
 			rdt_last_cmd_puts("Can't drop CPUs from default group\n");
@@ -413,12 +413,12 @@ static int cpus_ctrl_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
 	 * and update per-cpu closid/rmid.
 	 */
 	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
-	if (cpumask_weight(tmpmask)) {
+	if (!cpumask_empty(tmpmask)) {
 		list_for_each_entry(r, &rdt_all_groups, rdtgroup_list) {
 			if (r == rdtgrp)
 				continue;
 			cpumask_and(tmpmask1, &r->cpu_mask, tmpmask);
-			if (cpumask_weight(tmpmask1))
+			if (!cpumask_empty(tmpmask1))
 				cpumask_rdtgrp_clear(r, tmpmask1);
 		}
 		update_closid_rmid(tmpmask, rdtgrp);
@@ -488,7 +488,7 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
 
 	/* check that user didn't specify any offline cpus */
 	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
-	if (cpumask_weight(tmpmask)) {
+	if (!cpumask_empty(tmpmask)) {
 		ret = -EINVAL;
 		rdt_last_cmd_puts("Can only assign online CPUs\n");
 		goto unlock;
diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index 933a2eb..c3317f0 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -400,7 +400,7 @@ static void leave_uniprocessor(void)
 	int cpu;
 	int err;
 
-	if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
+	if (!cpumask_available(downed_cpus) || cpumask_empty(downed_cpus))
 		return;
 	pr_notice("Re-enabling CPUs...\n");
 	for_each_cpu(cpu, downed_cpus) {
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 1e9ff28..ea277fc 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -985,7 +985,7 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
 
 	/* Clear global flags */
 	if (master) {
-		if (cpumask_weight(uv_nmi_cpu_mask))
+		if (!cpumask_empty(uv_nmi_cpu_mask))
 			uv_nmi_cleanup_mask();
 		atomic_set(&uv_nmi_cpus_in_nmi, -1);
 		atomic_set(&uv_nmi_cpu, -1);
