Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2619F523DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbiEKTrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347128AbiEKTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA563983D;
        Wed, 11 May 2022 12:47:01 -0700 (PDT)
Date:   Wed, 11 May 2022 19:46:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhGwjYORh0f0vj0dGR5K/ogmDUMeuJ8lTHGvQnbSDWk=;
        b=HaWR0Smu/kNC5k1VCUXsj9UWZXZmUgKcUB78ZppZ+ozvZLm5ls6uBgOdcW18Nlhwd+mQwB
        VHpZha532urFMCexi+//YkoRLgf9HspY5UER0zymymKos9yFfwaid1heOqKwdeoJjUpeNB
        +Ke/PduVToRLmB0LIW94oPEFtwjbNS/5bSTFr3T6FES9uTFz24zUQ1G7MF6DUxIoWBQh3N
        ES8fPiuDJw4qGhN6mcrhywMu43rBh7YR0mEPMpmovJiKRbr8NV1pJ0C52GNC5+Qf7e/PU6
        AmTd6+JjWaHx+ALDhVxOETD/eZQseDjHkAuSoAo+DDFJEv9nw4lmX2JczZm4VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhGwjYORh0f0vj0dGR5K/ogmDUMeuJ8lTHGvQnbSDWk=;
        b=rQFToBugIfK+JB48Fz9vpI9K2J2Gre5VtLMtFJnXRwPJRvT1L3BRvZQOSO4tqSjkkoKhD8
        vgs0F5oD74k4uxDA==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Add support for L3 miss filtering
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220509044914.1473-4-ravi.bangoria@amd.com>
References: <20220509044914.1473-4-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <165229841918.4207.13872364668994762998.tip-bot2@tip-bot2>
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

Commit-ID:     ba5d35b442c65f32d38ef61f732218274c6dcf4c
Gitweb:        https://git.kernel.org/tip/ba5d35b442c65f32d38ef61f732218274c6dcf4c
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 09 May 2022 10:19:09 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:10 +02:00

perf/amd/ibs: Add support for L3 miss filtering

IBS L3 miss filtering works by tagging an instruction on IBS counter
overflow and generating an NMI if the tagged instruction causes an L3
miss. Samples without an L3 miss are discarded and counter is reset
with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
This helps in reducing sampling overhead when user is interested only
in such samples. One of the use case of such filtered samples is to
feed data to page-migration daemon in tiered memory systems.

Add support for L3 miss filtering in IBS driver via new pmu attribute
"l3missonly". Example usage:

  # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220509044914.1473-4-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c         | 67 ++++++++++++++++++++++++++----
 arch/x86/include/asm/perf_event.h |  3 +-
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index ece4f6a..2dc8b7e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -544,22 +544,46 @@ static const struct attribute_group *empty_attr_groups[] = {
 
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
+PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
+PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
+
+static umode_t
+zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_ZEN4 ? attr->mode : 0;
+}
 
 static struct attribute *rand_en_attrs[] = {
 	&format_attr_rand_en.attr,
 	NULL,
 };
 
+static struct attribute *fetch_l3missonly_attrs[] = {
+	&fetch_l3missonly.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_rand_en = {
 	.name = "format",
 	.attrs = rand_en_attrs,
 };
 
+static struct attribute_group group_fetch_l3missonly = {
+	.name = "format",
+	.attrs = fetch_l3missonly_attrs,
+	.is_visible = zen4_ibs_extensions_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_rand_en,
 	NULL,
 };
 
+static const struct attribute_group *fetch_attr_update[] = {
+	&group_fetch_l3missonly,
+	NULL,
+};
+
 static umode_t
 cnt_ctl_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -571,14 +595,26 @@ static struct attribute *cnt_ctl_attrs[] = {
 	NULL,
 };
 
+static struct attribute *op_l3missonly_attrs[] = {
+	&op_l3missonly.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_cnt_ctl = {
 	.name = "format",
 	.attrs = cnt_ctl_attrs,
 	.is_visible = cnt_ctl_is_visible,
 };
 
+static struct attribute_group group_op_l3missonly = {
+	.name = "format",
+	.attrs = op_l3missonly_attrs,
+	.is_visible = zen4_ibs_extensions_is_visible,
+};
+
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
+	&group_op_l3missonly,
 	NULL,
 };
 
@@ -805,10 +841,8 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 	return ret;
 }
 
-static __init int perf_event_ibs_init(void)
+static __init int perf_ibs_fetch_init(void)
 {
-	int ret;
-
 	/*
 	 * Some chips fail to reset the fetch count when it is written; instead
 	 * they need a 0-1 transition of IbsFetchEn.
@@ -819,12 +853,17 @@ static __init int perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
 		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
 
+	if (ibs_caps & IBS_CAPS_ZEN4)
+		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
+
 	perf_ibs_fetch.pmu.attr_groups = fetch_attr_groups;
+	perf_ibs_fetch.pmu.attr_update = fetch_attr_update;
 
-	ret = perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
-	if (ret)
-		return ret;
+	return perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
+}
 
+static __init int perf_ibs_op_init(void)
+{
 	if (ibs_caps & IBS_CAPS_OPCNT)
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
 
@@ -834,10 +873,24 @@ static __init int perf_event_ibs_init(void)
 		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
 	}
 
+	if (ibs_caps & IBS_CAPS_ZEN4)
+		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
+
 	perf_ibs_op.pmu.attr_groups = empty_attr_groups;
 	perf_ibs_op.pmu.attr_update = op_attr_update;
 
-	ret = perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
+	return perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
+}
+
+static __init int perf_event_ibs_init(void)
+{
+	int ret;
+
+	ret = perf_ibs_fetch_init();
+	if (ret)
+		return ret;
+
+	ret = perf_ibs_op_init();
 	if (ret)
 		goto err_op;
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 7aa1d42..409725e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -410,6 +410,7 @@ struct pebs_xmm {
 #define IBS_CAPS_OPBRNFUSE		(1U<<8)
 #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
 #define IBS_CAPS_OPDATA4		(1U<<10)
+#define IBS_CAPS_ZEN4			(1U<<11)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\
@@ -423,6 +424,7 @@ struct pebs_xmm {
 #define IBSCTL_LVT_OFFSET_MASK		0x0F
 
 /* IBS fetch bits/masks */
+#define IBS_FETCH_L3MISSONLY	(1ULL<<59)
 #define IBS_FETCH_RAND_EN	(1ULL<<57)
 #define IBS_FETCH_VAL		(1ULL<<49)
 #define IBS_FETCH_ENABLE	(1ULL<<48)
@@ -439,6 +441,7 @@ struct pebs_xmm {
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
+#define IBS_OP_L3MISSONLY	(1ULL<<16)
 #define IBS_OP_MAX_CNT		0x0000FFFFULL
 #define IBS_OP_MAX_CNT_EXT	0x007FFFFFULL	/* not a register bit mask */
 #define IBS_OP_MAX_CNT_EXT_MASK	(0x7FULL<<20)	/* separate upper 7 bits */
