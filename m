Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF3C523DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347222AbiEKTr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347141AbiEKTrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D5438DB0;
        Wed, 11 May 2022 12:47:02 -0700 (PDT)
Date:   Wed, 11 May 2022 19:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQVT5BEIMK1RhyayjCZCsZc04BytM9KblTZvHar/5L8=;
        b=1YmWIt7/Gma5J1Iyk++eVSe+9YC7+6WaV52XE5hBKhU/SAbGW9b+Pgj4V58LoVhvSW9885
        Sp89KGzkG8okHPYEvDnTy4vm4dUytOOWJxv10rEBA5voTC19GwVYGiNC7NXgOvRVK3dPdk
        tvxRo6EriE3VpCwqweGEbL0fyPfy0vzDnBKDA8COHyJOMewtxgBADzZHV/wMkwKXAtKEN3
        LESu1X407tvQzk2NHn20jEKF2IZmP/W20xC11q50P35psur6XlyQejw5xRwFibOuddMkfm
        RBXJdFBRrblXkyRpRTQE8u1hmk+tcV1K87ZAdSY+sja0oawqI/fmhXjPncEz6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQVT5BEIMK1RhyayjCZCsZc04BytM9KblTZvHar/5L8=;
        b=PITxXO8M/5tYBnpfCR71SOPHHoxPGnTqHFZAZ0fXgH7mnE4OrqH9e5d/KWvXblsGeOej44
        9FDfl64VY9Q5KiAg==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Use ->is_visible callback for dynamic
 attributes
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220509044914.1473-3-ravi.bangoria@amd.com>
References: <20220509044914.1473-3-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <165229842011.4207.15725983634626537750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2a7a7e658682bfd7501dc6b4c9d365aa6c79788a
Gitweb:        https://git.kernel.org/tip/2a7a7e658682bfd7501dc6b4c9d365aa6c79788a
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 09 May 2022 10:19:08 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:09 +02:00

perf/amd/ibs: Use ->is_visible callback for dynamic attributes

Currently, some attributes are added at build time whereas others
at boot time depending on IBS pmu capabilities. Instead, we can
just add all attribute groups at build time but hide individual
group at boot time using more appropriate ->is_visible() callback.

Also, struct perf_ibs has bunch of fields for pmu attributes which
just pass on the pointer, does not do anything else. Remove them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220509044914.1473-3-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 78 ++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 2704ec1..ece4f6a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -94,10 +94,6 @@ struct perf_ibs {
 	unsigned int			fetch_ignore_if_zero_rip : 1;
 	struct cpu_perf_ibs __percpu	*pcpu;
 
-	struct attribute		**format_attrs;
-	struct attribute_group		format_group;
-	const struct attribute_group	*attr_groups[2];
-
 	u64				(*get_count)(u64 config);
 };
 
@@ -528,16 +524,61 @@ static void perf_ibs_del(struct perf_event *event, int flags)
 
 static void perf_ibs_read(struct perf_event *event) { }
 
+/*
+ * We need to initialize with empty group if all attributes in the
+ * group are dynamic.
+ */
+static struct attribute *attrs_empty[] = {
+	NULL,
+};
+
+static struct attribute_group empty_format_group = {
+	.name = "format",
+	.attrs = attrs_empty,
+};
+
+static const struct attribute_group *empty_attr_groups[] = {
+	&empty_format_group,
+	NULL,
+};
+
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 
-static struct attribute *ibs_fetch_format_attrs[] = {
+static struct attribute *rand_en_attrs[] = {
 	&format_attr_rand_en.attr,
 	NULL,
 };
 
-static struct attribute *ibs_op_format_attrs[] = {
-	NULL,	/* &format_attr_cnt_ctl.attr if IBS_CAPS_OPCNT */
+static struct attribute_group group_rand_en = {
+	.name = "format",
+	.attrs = rand_en_attrs,
+};
+
+static const struct attribute_group *fetch_attr_groups[] = {
+	&group_rand_en,
+	NULL,
+};
+
+static umode_t
+cnt_ctl_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_OPCNT ? attr->mode : 0;
+}
+
+static struct attribute *cnt_ctl_attrs[] = {
+	&format_attr_cnt_ctl.attr,
+	NULL,
+};
+
+static struct attribute_group group_cnt_ctl = {
+	.name = "format",
+	.attrs = cnt_ctl_attrs,
+	.is_visible = cnt_ctl_is_visible,
+};
+
+static const struct attribute_group *op_attr_update[] = {
+	&group_cnt_ctl,
 	NULL,
 };
 
@@ -561,7 +602,6 @@ static struct perf_ibs perf_ibs_fetch = {
 	.max_period		= IBS_FETCH_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
-	.format_attrs		= ibs_fetch_format_attrs,
 
 	.get_count		= get_ibs_fetch_count,
 };
@@ -587,7 +627,6 @@ static struct perf_ibs perf_ibs_op = {
 	.max_period		= IBS_OP_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
-	.format_attrs		= ibs_op_format_attrs,
 
 	.get_count		= get_ibs_op_count,
 };
@@ -757,17 +796,6 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 
 	perf_ibs->pcpu = pcpu;
 
-	/* register attributes */
-	if (perf_ibs->format_attrs[0]) {
-		memset(&perf_ibs->format_group, 0, sizeof(perf_ibs->format_group));
-		perf_ibs->format_group.name	= "format";
-		perf_ibs->format_group.attrs	= perf_ibs->format_attrs;
-
-		memset(&perf_ibs->attr_groups, 0, sizeof(perf_ibs->attr_groups));
-		perf_ibs->attr_groups[0]	= &perf_ibs->format_group;
-		perf_ibs->pmu.attr_groups	= perf_ibs->attr_groups;
-	}
-
 	ret = perf_pmu_register(&perf_ibs->pmu, name, -1);
 	if (ret) {
 		perf_ibs->pcpu = NULL;
@@ -779,7 +807,6 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 
 static __init int perf_event_ibs_init(void)
 {
-	struct attribute **attr = ibs_op_format_attrs;
 	int ret;
 
 	/*
@@ -792,14 +819,14 @@ static __init int perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
 		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
 
+	perf_ibs_fetch.pmu.attr_groups = fetch_attr_groups;
+
 	ret = perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
 	if (ret)
 		return ret;
 
-	if (ibs_caps & IBS_CAPS_OPCNT) {
+	if (ibs_caps & IBS_CAPS_OPCNT)
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
-		*attr++ = &format_attr_cnt_ctl.attr;
-	}
 
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
@@ -807,6 +834,9 @@ static __init int perf_event_ibs_init(void)
 		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
 	}
 
+	perf_ibs_op.pmu.attr_groups = empty_attr_groups;
+	perf_ibs_op.pmu.attr_update = op_attr_update;
+
 	ret = perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
 	if (ret)
 		goto err_op;
