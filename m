Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15C0548274
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiFMI30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiFMI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:29:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B211ADAB;
        Mon, 13 Jun 2022 01:29:07 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:29:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655108946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNqLpmLyN3tqXwBGYAuDFghM9ximSEXwd7awrM6bOE8=;
        b=G22q4hF2MxefbzTXTvIT6xchyIyMV359+P3BW/67TU2yZKCVa/zM72w/qMJcO5a6xDxbp0
        gftjPNvoxzmQD0sgN8gKZjbfDdWUc8Vr0ReW7V7v9gwARfYyxOv1vxDL08ejDIjLuYyotc
        zZvn2DKcLxY86hR37jM3deuAsuhHo73WF9ZL9bt39zXF1G+O2EiUMNceBmNNUPuwvHw1wR
        /OKzV+ZD/l6qrdO6KRBiOfGx/eAu4p4FAH+9PJMdRYpZIZVCuKjtvtB6mXtC/o3y6CJlkE
        K9Jcpx9jO7XXn7+7JOtgLAvVKDn3iVwhIVGSPSyz1XeuCxYeQdsFIa0bxwhcQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655108946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNqLpmLyN3tqXwBGYAuDFghM9ximSEXwd7awrM6bOE8=;
        b=xeiyTdvUmM+I2PlPQDWmpPnfdAprIeKy2uc4GkHTuJtQ8JlW4X1/bpSeCEennNyef+Znnu
        wuE9ML4GHdOu+YDA==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Use attr_update for format attributes
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca5e4f4dd5c459199fc497e82b858ba09dc91c064=2E16529?=
 =?utf-8?q?54372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ca5e4f4dd5c459199fc497e82b858ba09dc91c064=2E165295?=
 =?utf-8?q?4372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165510894478.4207.7366247232784156655.tip-bot2@tip-bot2>
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

Commit-ID:     847f3268bb644ee852732f8e3b5748e4319244b7
Gitweb:        https://git.kernel.org/tip/847f3268bb644ee852732f8e3b5748e4319244b7
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 19 May 2022 15:33:31 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:15:13 +02:00

perf/x86/amd/uncore: Use attr_update for format attributes

Use the update_attrs attribute group introduced by commit
f3a3a8257e5a ("perf/core: Add attr_groups_update into struct
pmu") and the is_visible() callback to populate the family
specifc attributes for uncore events.

The changes apply to attributes that are unique to families
such as slicemask for Family 17h and coreid for Family 19h.
The addition of common attributes such as event and umask,
whose formats change across families, remain unchanged.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/a5e4f4dd5c459199fc497e82b858ba09dc91c064.1652954372.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 68 +++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 8dfcf93..c3e218d 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -246,6 +246,19 @@ static int amd_uncore_event_init(struct perf_event *event)
 	return 0;
 }
 
+static umode_t
+amd_f17h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return boot_cpu_data.x86 >= 0x17 && boot_cpu_data.x86 < 0x19 ?
+	       attr->mode : 0;
+}
+
+static umode_t
+amd_f19h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return boot_cpu_data.x86 >= 0x19 ? attr->mode : 0;
+}
+
 static ssize_t amd_uncore_attr_show_cpumask(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
@@ -296,20 +309,33 @@ DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3
 DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
 
+/* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
-	&format_attr_event12.attr, /* event14 if F17h+ */
-	&format_attr_umask.attr,
+	&format_attr_event12.attr,	/* event */
+	&format_attr_umask.attr,	/* umask */
 	NULL,
 };
 
+/* Common L2 and L3 attributes */
 static struct attribute *amd_uncore_l3_format_attr[] = {
-	&format_attr_event12.attr, /* event8 if F17h+ */
-	&format_attr_umask.attr,
-	NULL, /* slicemask if F17h,	coreid if F19h */
-	NULL, /* threadmask8 if F17h,	enallslices if F19h */
-	NULL, /*			enallcores if F19h */
-	NULL, /*			sliceid if F19h */
-	NULL, /*			threadmask2 if F19h */
+	&format_attr_event12.attr,	/* event */
+	&format_attr_umask.attr,	/* umask */
+	NULL,				/* threadmask */
+	NULL,
+};
+
+/* F17h unique L3 attributes */
+static struct attribute *amd_f17h_uncore_l3_format_attr[] = {
+	&format_attr_slicemask.attr,	/* slicemask */
+	NULL,
+};
+
+/* F19h unique L3 attributes */
+static struct attribute *amd_f19h_uncore_l3_format_attr[] = {
+	&format_attr_coreid.attr,	/* coreid */
+	&format_attr_enallslices.attr,	/* enallslices */
+	&format_attr_enallcores.attr,	/* enallcores */
+	&format_attr_sliceid.attr,	/* sliceid */
 	NULL,
 };
 
@@ -323,6 +349,18 @@ static struct attribute_group amd_uncore_l3_format_group = {
 	.attrs = amd_uncore_l3_format_attr,
 };
 
+static struct attribute_group amd_f17h_uncore_l3_format_group = {
+	.name = "format",
+	.attrs = amd_f17h_uncore_l3_format_attr,
+	.is_visible = amd_f17h_uncore_is_visible,
+};
+
+static struct attribute_group amd_f19h_uncore_l3_format_group = {
+	.name = "format",
+	.attrs = amd_f19h_uncore_l3_format_attr,
+	.is_visible = amd_f19h_uncore_is_visible,
+};
+
 static const struct attribute_group *amd_uncore_df_attr_groups[] = {
 	&amd_uncore_attr_group,
 	&amd_uncore_df_format_group,
@@ -335,6 +373,12 @@ static const struct attribute_group *amd_uncore_l3_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *amd_uncore_l3_attr_update[] = {
+	&amd_f17h_uncore_l3_format_group,
+	&amd_f19h_uncore_l3_format_group,
+	NULL,
+};
+
 static struct pmu amd_nb_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
 	.attr_groups	= amd_uncore_df_attr_groups,
@@ -352,6 +396,7 @@ static struct pmu amd_nb_pmu = {
 static struct pmu amd_llc_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
 	.attr_groups	= amd_uncore_l3_attr_groups,
+	.attr_update	= amd_uncore_l3_attr_update,
 	.name		= "amd_l2",
 	.event_init	= amd_uncore_event_init,
 	.add		= amd_uncore_add,
@@ -632,15 +677,10 @@ static int __init amd_uncore_init(void)
 		if (boot_cpu_data.x86 >= 0x19) {
 			*l3_attr++ = &format_attr_event8.attr;
 			*l3_attr++ = &format_attr_umask.attr;
-			*l3_attr++ = &format_attr_coreid.attr;
-			*l3_attr++ = &format_attr_enallslices.attr;
-			*l3_attr++ = &format_attr_enallcores.attr;
-			*l3_attr++ = &format_attr_sliceid.attr;
 			*l3_attr++ = &format_attr_threadmask2.attr;
 		} else if (boot_cpu_data.x86 >= 0x17) {
 			*l3_attr++ = &format_attr_event8.attr;
 			*l3_attr++ = &format_attr_umask.attr;
-			*l3_attr++ = &format_attr_slicemask.attr;
 			*l3_attr++ = &format_attr_threadmask8.attr;
 		}
 
