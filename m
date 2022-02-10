Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1BA4B196B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbiBJX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:27:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345624AbiBJX1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:27:14 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7365F64;
        Thu, 10 Feb 2022 15:27:14 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p63so9373194iod.11;
        Thu, 10 Feb 2022 15:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yuZUTT/rXi5dMjISKVJYU5DzInQNJ+fNjCOO2/f7G8k=;
        b=j55OXYXTjVhdPRBFTmJ0hd/eeXByGxC4t0B3i9rQKb3+0S3rnp8xzD+hSP60/pxcNO
         Be9jAJMFxu9ZbzBlEOboyCGBPjddFJA1TXkBcqAY+z9d3CdxBM5uLsA17zCPm+yi23p/
         gSlhIvQ62GWYaoCo0t7FoT8VN3Q114+NR9c+g5+jWF4I1d9Jspb9+pcEmnD1SDzkq4Z6
         Tf3I6aiau8yOugjCCnnL34w85f4avkSj1tiZzP1lz19DrCs3U9/H4Eqcj1915r+1/LfB
         qOMjkORvNHKFa7feKj7YS2lbBSjbFfOFEUxlI+R9/OPdTHEf6h3Bnl6UeYP7tyc2kNHw
         YQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuZUTT/rXi5dMjISKVJYU5DzInQNJ+fNjCOO2/f7G8k=;
        b=1+rSGKHDnW0ix2VML0ixEzn9tpE7OpM+1+iiBGahwmdzPFYgG7EeYIo0sUaaH1Xzwe
         UK7nCEsAk1g7qXIukzYbO1o56kTBU6UEQ0M8fX8bbgqV4210Bx/0aPvPT+fd1us6dBGp
         3G2zWH9B02FnGloOnmWYzHWQfGq3WkciKWrrZF369SukRcuKcooJ4790ZUu+voCzo9Wg
         n/v0XVDyEjzVXXeCZoQ5vLft823H707V0SIF2wI67hb7Nj2c7EHONiyeokELDLMiLOf9
         dCSAGhnMnA907DbZLBClT421E6ZHtecRUDKN3kJB1VdnMx5JCzOX1hrnjvPsrdfV3hKS
         V07g==
X-Gm-Message-State: AOAM5311UTXUYtHg+BMEDwTCJlJ9WJknQY6///RJmbqDGrma39eN1owh
        d9+9Iw1/ApFxaGrUCftxe8g=
X-Google-Smtp-Source: ABdhPJyuJyeIJ/FFP5Y/oWwaiFFlMwtt8E2cOYzuTD6rFFwrutNggg6s1UO76PCAuQUYz5PAgS7eNQ==
X-Received: by 2002:a05:6638:101:: with SMTP id x1mr859923jao.23.1644535634329;
        Thu, 10 Feb 2022 15:27:14 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id t195sm5516476iof.47.2022.02.10.15.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:27:13 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>, x86@kernel.org,
        nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 16/49] arch/x86: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:49:00 -0800
Message-Id: <20220210224933.379149-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, arch/x86 code calls cpumask_weight() to check if any bit of
a given cpumask is set. We can do it more efficiently with cpumask_empty()
because cpumask_empty() stops traversing the cpumask as soon as it finds
first set bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 14 +++++++-------
 arch/x86/mm/mmio-mod.c                 |  2 +-
 arch/x86/platform/uv/uv_nmi.c          |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b57b3db9a6a7..e23ff03290b8 100644
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
index 933a2ebad471..c3317f0650d8 100644
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
index 1e9ff28bc2e0..ea277fc08357 100644
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
-- 
2.32.0

