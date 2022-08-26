Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97475A31EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345222AbiHZWSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345268AbiHZWQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:16:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD2FE8689;
        Fri, 26 Aug 2022 15:16:13 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:16:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbbaEcZ1mvZm4QJIWHnvG77EWtxW0Gs9KQL7MQQKj6M=;
        b=qrpffA+ajDcjeZrF/qVNd5pSiZc3somM5ppRxnFfvuxH67uHhCO4TvnvozyFlU1/UX0IXL
        5GaJAg71eapb5ENfIuw2TFy3HvhneIvXKwyn8ZTfApA8mSLmgU1HnC1eNwQ5IvWLvrkm4t
        DK9bHcB6S3FhhcMAMjU+Grte8NDbwsHPdaRs4xnq9dosNCxqI/C91CnR8iSm4ly6TwQAXT
        149IGhXmRmbf3vdQVqHoexMUBP2NufOV13qkkwTTVAlCuNV/6gubzsk8tkqTcP+gNVBRDF
        GCTwLqk4SCVO3htYiquA3/m1TCuTbgPgE4tWu5aPd1+Gm2hGDf8hdgmGz9JQ0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbbaEcZ1mvZm4QJIWHnvG77EWtxW0Gs9KQL7MQQKj6M=;
        b=rOTylBtpjaMpGvrD6PBU3u9+nLYwjK0GqMILrCQvwmKriPRsFR0eiMHyShLnp8EOEMhmym
        aCO1OXj+maoTm0CA==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/core: Refactor branch attributes
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cba4a4cde6db79b1c65c49834027bbdb8a915546b=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cba4a4cde6db79b1c65c49834027bbdb8a915546b=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155217004.401.16064823148891742860.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9603aa79e851c652f6da873205c92213af36b24f
Gitweb:        https://git.kernel.org/tip/9603aa79e851c652f6da873205c92213af36b24f
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 17:59:50 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:42 +02:00

perf/x86/amd/core: Refactor branch attributes

AMD processors that are capable of recording branches support either Branch
Sampling (BRS) or Last Branch Record (LBR). In preparation for adding Last
Branch Record Extension Version 2 (LbrExtV2) support, reuse the "branches"
capability to advertise information about both BRS and LBR but make the
"branch-brs" event exclusive to Family 19h processors that support BRS.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/ba4a4cde6db79b1c65c49834027bbdb8a915546b.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e32a278..2f524cf 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1247,23 +1247,25 @@ static ssize_t branches_show(struct device *cdev,
 
 static DEVICE_ATTR_RO(branches);
 
-static struct attribute *amd_pmu_brs_attrs[] = {
+static struct attribute *amd_pmu_branches_attrs[] = {
 	&dev_attr_branches.attr,
 	NULL,
 };
 
 static umode_t
-amd_brs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+amd_branches_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
 	return x86_pmu.lbr_nr ? attr->mode : 0;
 }
 
-static struct attribute_group group_caps_amd_brs = {
+static struct attribute_group group_caps_amd_branches = {
 	.name  = "caps",
-	.attrs = amd_pmu_brs_attrs,
-	.is_visible = amd_brs_is_visible,
+	.attrs = amd_pmu_branches_attrs,
+	.is_visible = amd_branches_is_visible,
 };
 
+#ifdef CONFIG_PERF_EVENTS_AMD_BRS
+
 EVENT_ATTR_STR(branch-brs, amd_branch_brs,
 	       "event=" __stringify(AMD_FAM19H_BRS_EVENT)"\n");
 
@@ -1272,15 +1274,26 @@ static struct attribute *amd_brs_events_attrs[] = {
 	NULL,
 };
 
+static umode_t
+amd_brs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return static_cpu_has(X86_FEATURE_BRS) && x86_pmu.lbr_nr ?
+	       attr->mode : 0;
+}
+
 static struct attribute_group group_events_amd_brs = {
 	.name       = "events",
 	.attrs      = amd_brs_events_attrs,
 	.is_visible = amd_brs_is_visible,
 };
 
+#endif	/* CONFIG_PERF_EVENTS_AMD_BRS */
+
 static const struct attribute_group *amd_attr_update[] = {
-	&group_caps_amd_brs,
+	&group_caps_amd_branches,
+#ifdef CONFIG_PERF_EVENTS_AMD_BRS
 	&group_events_amd_brs,
+#endif
 	NULL,
 };
 
