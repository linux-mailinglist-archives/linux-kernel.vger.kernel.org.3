Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C7D529CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbiEQIz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbiEQIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:55:00 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E443ECD
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:54:54 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517085452epoutp02594730d7aca411a641377dab54babb3f~v2I3s00El0318503185epoutp02H
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:54:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517085452epoutp02594730d7aca411a641377dab54babb3f~v2I3s00El0318503185epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652777692;
        bh=QNM+bqP1MJqTUVPW/nTvyzcnA31sf4/7oZ/Ysu3iKVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8KMDZLAtZTMhHAA5XzJTgRzrpdQg2kMYvYmimjfuK25agCOo4CkBacX1P8Wu2tYe
         fBDcaHoS+JaJQSexitf4SYlp99vE9fZb1YK84QWHB3ODH4v1wEWbgQhc0wGvo6VhFK
         Kfq8TtmPxZZvBTts+9uzXMushwaTaBMWSDfnelXk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220517085451epcas1p486af25d2b1ba58cfc2544f0d7c9deb77~v2I3GVDro2686926869epcas1p4W;
        Tue, 17 May 2022 08:54:51 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.134]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L2VLL4Ftrz4x9QB; Tue, 17 May
        2022 08:54:50 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.E6.10063.AD263826; Tue, 17 May 2022 17:54:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220517085450epcas1p3601e3fa12dbce84aeee34ae38c7d689f~v2I1n9yEK2200622006epcas1p3P;
        Tue, 17 May 2022 08:54:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517085450epsmtrp28c5c14172b2f4ea1cfec07bb5978c810~v2I1m7lZ_2839828398epsmtrp2I;
        Tue, 17 May 2022 08:54:50 +0000 (GMT)
X-AuditID: b6c32a35-1f1ff7000000274f-da-628362dae861
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.53.08924.9D263826; Tue, 17 May 2022 17:54:49 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220517085449epsmtip2a42124bb94cb2843d4fc4a5fd8a15838~v2I1XxwYm0365503655epsmtip2I;
        Tue, 17 May 2022 08:54:49 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, m.szyprowski@samsung.com,
        saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v5 4/4] PM / devfreq: passive: Keep cpufreq_policy for
 possible cpus
Date:   Tue, 17 May 2022 18:21:08 +0900
Message-Id: <20220517092108.31680-5-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517092108.31680-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmru6tpOYkg00XZC22r3/BanH9y3NW
        iwmt25ktju9fwm5x7FewxdmmN+wWl3fNYbP43HuE0WLtkbvsFp83PGa0uN24gs2i69BfNosZ
        bZdZHXg9ZjdcZPFYsKnUo+XkfhaPvi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6O
        d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlFJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
        YquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ2xd2FxwVfriofvV7I0MPYYdjFyckgI
        mEicbd7O1sXIxSEksINR4v/jj8wQzidGidWzbzNBOJ8ZJQ5eesII07LyzWGoll2MEn0dR6Gc
        L4wS75dsBKtiE9CS2P/iBhuILSJgJXH6fwfYXGaBKUwSF/Z8AUsIC4RJbF45H8xmEVCVOLJ1
        BzOIzQvU8Oj5TnaIdfISqzccAItzClhLfD+8GGybhMBHdolTU6eyQhS5SNx4+5YZwhaWeHV8
        C1SzlMTnd3uhGpoZJRpe3GaEcHoYJY4+62OBqDKW2L90MtCrHED3aUqs36UPEVaU2Pl7Ltg7
        zAJ8Eu++9rCClEgI8Ep0tAlBlChLXH5wlwnClpRY3N7JBmF7SDy9dIcVEix9jBL7eltZJjDK
        zULYsICRcRWjWGpBcW56arFhgSE80pLzczcxglOhlukOxolvP+gdYmTiYDzEKMHBrCTCa1DR
        kCTEm5JYWZValB9fVJqTWnyI0RQYfBOZpUST84HJOK8k3tDE0sDEzMjYxMLQzFBJnHfVtNOJ
        QgLpiSWp2ampBalFMH1MHJxSDUxbJskIMbwNLHuiaP6sWjI8uNSQ6Wl5Vmrs2kcWyvVmASzt
        E+YWbG14+PWhmpiZaDxn6SW++Y07088dfnn0akCXelvFzpOXwzrD7rdeb1mXcf5M+P3cW7Mb
        73M0Hm09+LFjipiR8N71G3x/2ziUfj2wroG17bPEomPzV/LcX2L2d9qrs2v8Fe11Q/gr7J2i
        7POe/vZaMF3g94XDT8/ulE41l48rWhn4NvPuopN70mQy2uythZrkovYtdmDNcv2wKOjy2cNq
        wqvrX87eOjVsyYYVa1wnCJsp/Dg8JTvTfOL7ol8LVjL5iqd+ED3F5q62wT/seFid15X+HfIy
        a12+emfZPi8Va7jjZa3sUx965YgSS3FGoqEWc1FxIgAaNFd0DgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvO6tpOYkg1muFtvXv2C1uP7lOavF
        hNbtzBbH9y9htzj2K9jibNMbdovLu+awWXzuPcJosfbIXXaLzxseM1rcblzBZtF16C+bxYy2
        y6wOvB6zGy6yeCzYVOrRcnI/i0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBl7F1YXPDVuuLh
        +5UsDYw9hl2MnBwSAiYSK98cZuti5OIQEtjBKLHyyR1WiISkxLSLR5m7GDmAbGGJw4eLIWo+
        MUpMbv7JBlLDJqAlsf/FDTBbRMBG4u7iaywgRcwCi5gkLlxcyA6SEBYIkdg65wgLiM0ioCpx
        ZOsOZhCbV8BK4tHznewQy+QlVm84ABbnFLCW+H54MdhQIaCa/Se/s0xg5FvAyLCKUTK1oDg3
        PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4VLW0djDuWfVB7xAjEwfjIUYJDmYlEV6DioYkId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpisrR5OcHxRedag
        zVPF08W2Ze9KBaffifqT+KcuTl+m/emq6syKRWvOx+fcOORl4XEjwnWK/hP+x501zxlSvTey
        zBXkS3U5P9P9yAJPp00iG++fdY75EH62Lezl4+lpltcZ52dYHlgrWXW9ReumcP6hBuUcOfmO
        XRPMBT0kvXftYU+6YTgtlNEvYKXRtUd7rzEXyz80qVLkTTU1Siv81B7Vlnn9Dc9G9/P/VwrN
        UuaMU3oS+sBSQ39R2r5A9T+xXTkHpQ+Ix9k6HlTbtaakRW6NZ9dDM2OVCt+yiFVyh+813LU8
        +u5oQIouN9dmoVkubq2nM3YcfXzu4QamA+mPLd7c2Gvdf0tDsyiVcY7HNCWW4oxEQy3mouJE
        AGYcJxnEAgAA
X-CMS-MailID: 20220517085450epcas1p3601e3fa12dbce84aeee34ae38c7d689f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517085450epcas1p3601e3fa12dbce84aeee34ae38c7d689f
References: <20220517092108.31680-1-cw00.choi@samsung.com>
        <CGME20220517085450epcas1p3601e3fa12dbce84aeee34ae38c7d689f@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The passive governor requires the cpu data to get the next target frequency
of devfreq device if depending on cpu. In order to reduce the unnecessary
memory data, keep cpufreq_policy data for possible cpus instead of NR_CPU.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Johnson Wang <johnson.wang@mediatek.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor.h         |  3 ++
 drivers/devfreq/governor_passive.c | 75 +++++++++++++++++++++++-------
 include/linux/devfreq.h            |  4 +-
 3 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 335c4a491254..0adfebc0467a 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -49,6 +49,7 @@
 
 /**
  * struct devfreq_cpu_data - Hold the per-cpu data
+ * @node:	list node
  * @dev:	reference to cpu device.
  * @first_cpu:	the cpumask of the first cpu of a policy.
  * @opp_table:	reference to cpu opp table.
@@ -60,6 +61,8 @@
  * This is auto-populated by the governor.
  */
 struct devfreq_cpu_data {
+	struct list_head node;
+
 	struct device *dev;
 	unsigned int first_cpu;
 
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index ffcce613a48c..7306e943a234 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+	// SPDX-License-Identifier: GPL-2.0-only
 /*
  * linux/drivers/devfreq/governor_passive.c
  *
@@ -18,6 +18,22 @@
 
 #define HZ_PER_KHZ	1000
 
+static struct devfreq_cpu_data *
+get_parent_cpu_data(struct devfreq_passive_data *p_data,
+		    struct cpufreq_policy *policy)
+{
+	struct devfreq_cpu_data *parent_cpu_data;
+
+	if (!p_data || !policy)
+		return NULL;
+
+	list_for_each_entry(parent_cpu_data, &p_data->cpu_data_list, node)
+		if (parent_cpu_data->first_cpu == cpumask_first(policy->related_cpus))
+			return parent_cpu_data;
+
+	return NULL;
+}
+
 static unsigned long get_target_freq_by_required_opp(struct device *p_dev,
 						struct opp_table *p_opp_table,
 						struct opp_table *opp_table,
@@ -51,14 +67,24 @@ static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
 	struct devfreq_passive_data *p_data =
 				(struct devfreq_passive_data *)devfreq->data;
 	struct devfreq_cpu_data *parent_cpu_data;
+	struct cpufreq_policy *policy;
 	unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
 	unsigned long dev_min, dev_max;
 	unsigned long freq = 0;
+	int ret = 0;
 
 	for_each_online_cpu(cpu) {
-		parent_cpu_data = p_data->parent_cpu_data[cpu];
-		if (!parent_cpu_data || parent_cpu_data->first_cpu != cpu)
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy) {
+			ret = -EINVAL;
+			continue;
+		}
+
+		parent_cpu_data = get_parent_cpu_data(p_data, policy);
+		if (!parent_cpu_data) {
+			cpufreq_cpu_put(policy);
 			continue;
+		}
 
 		/* Get target freq via required opps */
 		cpu_cur = parent_cpu_data->cur_freq * HZ_PER_KHZ;
@@ -67,6 +93,7 @@ static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
 					devfreq->opp_table, &cpu_cur);
 		if (freq) {
 			*target_freq = max(freq, *target_freq);
+			cpufreq_cpu_put(policy);
 			continue;
 		}
 
@@ -81,9 +108,10 @@ static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
 		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
 
 		*target_freq = max(freq, *target_freq);
+		cpufreq_cpu_put(policy);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int get_target_freq_with_devfreq(struct devfreq *devfreq,
@@ -168,12 +196,11 @@ static int cpufreq_passive_notifier_call(struct notifier_block *nb,
 	unsigned int cur_freq;
 	int ret;
 
-	if (event != CPUFREQ_POSTCHANGE || !freqs ||
-		!p_data->parent_cpu_data[freqs->policy->cpu])
+	if (event != CPUFREQ_POSTCHANGE || !freqs)
 		return 0;
 
-	parent_cpu_data = p_data->parent_cpu_data[freqs->policy->cpu];
-	if (parent_cpu_data->cur_freq == freqs->new)
+	parent_cpu_data = get_parent_cpu_data(p_data, freqs->policy);
+	if (!parent_cpu_data || parent_cpu_data->cur_freq == freqs->new)
 		return 0;
 
 	cur_freq = parent_cpu_data->cur_freq;
@@ -196,7 +223,7 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq_cpu_data *parent_cpu_data;
-	int cpu, ret;
+	int cpu, ret = 0;
 
 	if (p_data->nb.notifier_call) {
 		ret = cpufreq_unregister_notifier(&p_data->nb,
@@ -206,16 +233,26 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
 	}
 
 	for_each_possible_cpu(cpu) {
-		parent_cpu_data = p_data->parent_cpu_data[cpu];
-		if (!parent_cpu_data)
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+		if (!policy) {
+			ret = -EINVAL;
 			continue;
+		}
 
+		parent_cpu_data = get_parent_cpu_data(p_data, policy);
+		if (!parent_cpu_data) {
+			cpufreq_cpu_put(policy);
+			continue;
+		}
+
+		list_del(&parent_cpu_data->node);
 		if (parent_cpu_data->opp_table)
 			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
 		kfree(parent_cpu_data);
+		cpufreq_cpu_put(policy);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
@@ -230,6 +267,9 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 	unsigned int cpu;
 	int ret;
 
+	p_data->cpu_data_list
+		= (struct list_head)LIST_HEAD_INIT(p_data->cpu_data_list);
+
 	p_data->nb.notifier_call = cpufreq_passive_notifier_call;
 	ret = cpufreq_register_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
 	if (ret) {
@@ -239,15 +279,18 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 	}
 
 	for_each_possible_cpu(cpu) {
-		if (p_data->parent_cpu_data[cpu])
-			continue;
-
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy) {
 			ret = -EPROBE_DEFER;
 			goto err;
 		}
 
+		parent_cpu_data = get_parent_cpu_data(p_data, policy);
+		if (parent_cpu_data) {
+			cpufreq_cpu_put(policy);
+			continue;
+		}
+
 		parent_cpu_data = kzalloc(sizeof(*parent_cpu_data),
 						GFP_KERNEL);
 		if (!parent_cpu_data) {
@@ -276,7 +319,7 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 		parent_cpu_data->min_freq = policy->cpuinfo.min_freq;
 		parent_cpu_data->max_freq = policy->cpuinfo.max_freq;
 
-		p_data->parent_cpu_data[cpu] = parent_cpu_data;
+		list_add_tail(&parent_cpu_data->node, &p_data->cpu_data_list);
 		cpufreq_cpu_put(policy);
 	}
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index b1e4a6f796ce..dc10bee75a72 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -309,7 +309,7 @@ enum devfreq_parent_dev_type {
  * @this:		the devfreq instance of own device.
  * @nb:			the notifier block for DEVFREQ_TRANSITION_NOTIFIER or
  *			CPUFREQ_TRANSITION_NOTIFIER list.
- * @parent_cpu_data:	the state min/max/current frequency of all online cpu's.
+ * @cpu_data_list:	the list of cpu frequency data for all cpufreq_policy.
  *
  * The devfreq_passive_data have to set the devfreq instance of parent
  * device with governors except for the passive governor. But, don't need to
@@ -329,7 +329,7 @@ struct devfreq_passive_data {
 	/* For passive governor's internal use. Don't need to set them */
 	struct devfreq *this;
 	struct notifier_block nb;
-	struct devfreq_cpu_data *parent_cpu_data[NR_CPUS];
+	struct list_head cpu_data_list;
 };
 #endif
 
-- 
2.17.1

