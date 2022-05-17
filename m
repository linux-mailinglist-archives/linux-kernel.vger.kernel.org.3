Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9400529D09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiEQIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbiEQIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:55:07 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859C43ED2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:54:54 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220517085450epoutp01d8e31b76a61d0a5ebbc9a47a617ecc2f~v2I2H5nYU1857618576epoutp01b
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:54:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220517085450epoutp01d8e31b76a61d0a5ebbc9a47a617ecc2f~v2I2H5nYU1857618576epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652777690;
        bh=9zyVG5H/gQy7SgFOMnlbheDQmbMtgiHYhAYcsTt1uag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBXYWXHGoFgHGatDof7iBwAjtcQ54+4DPfzvFUXk6xZLEVa+3oH3FZGZDcenWX4co
         2lFfam9QwAZxODFYK8//lzTBPkgnCNWdmqaSDbEFGmni53J3K9Q3bRFOPROfiz34WD
         3/w5Foc3r8jit5NUBzWSquqIJTi42LGDCSL9t4Tc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220517085450epcas1p24c538ba26e91989a3a05e7997eab7cb9~v2I1zkvYI0692906929epcas1p2V;
        Tue, 17 May 2022 08:54:50 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.132]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L2VLK1jywz4x9Ps; Tue, 17 May
        2022 08:54:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.75.10038.9D263826; Tue, 17 May 2022 17:54:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517085448epcas1p46423db24a3211003238b6c5947228923~v2I0ZoDW31991119911epcas1p4N;
        Tue, 17 May 2022 08:54:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517085448epsmtrp1e9b2cc5cfb7c6001c1991e1994526904~v2I0Yg46c1935519355epsmtrp1j;
        Tue, 17 May 2022 08:54:48 +0000 (GMT)
X-AuditID: b6c32a37-111ff70000002736-ff-628362d90862
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.53.08924.8D263826; Tue, 17 May 2022 17:54:48 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220517085448epsmtip2c1442e73a89280b4b8756f95659c3a49~v2I0Gjv_T0365503655epsmtip2H;
        Tue, 17 May 2022 08:54:48 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, m.szyprowski@samsung.com,
        saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 2/4] PM / devfreq: Add cpu based scaling support to
 passive governor
Date:   Tue, 17 May 2022 18:21:06 +0900
Message-Id: <20220517092108.31680-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517092108.31680-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTV/dmUnOSweLpnBbb179gtbj+5Tmr
        xYTW7cwWx/cvYbc49ivY4mzTG3aLy7vmsFl87j3CaLH2yF12i88bHjNa3G5cwWbRdegvm8W1
        he9ZLQ5cnMhmMaPtMqsDv8fshossHpf7epk8Fmwq9Wg5uZ/Fo2/LKkaPz5vkAtiism0yUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgC5WUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFugVJ+YWl+al6+WlllgZGhgYmQIVJmRntB3Zwlxw
        vaii+cs/5gbGDXFdjJwcEgImEv/33mDpYuTiEBLYwSixet5/ZpCEkMAnRomexzYQic+MEktn
        /WbrYuQA69i7KwwivotRYv/jE+wQzhdGiQc/zrCBdLMJaEnsf3EDzBYRsJI4/b+DGaSIWeAJ
        k0TftG0sIAlhgUiJZT+usIPYLAKqEvuPr2AEsXmBGp53bmeCuE9eYvWGA2AncQpYS3w/vJgN
        ZJCEQC+HxP4pa1kgilwkrjx6DNUgLPHq+BZ2CFtK4mV/GztEQzOjRMOL24wQTg+jxNFnfVDd
        xhL7l05mAnmOWUBTYv0ufYiwosTO33PBLmIW4JN497WHFeJ/XomONiGIEmWJyw/uQu2VlFjc
        3gkNIg+JznvJkFDpY5R4/GQH4wRGuVkICxYwMq5iFEstKM5NTy02LDCGR1lyfu4mRnCS1DLf
        wTjt7Qe9Q4xMHIyHGCU4mJVEeA0qGpKEeFMSK6tSi/Lji0pzUosPMZoCQ28is5Rocj4wTeeV
        xBuaWBqYmBkZm1gYmhkqifOumnY6UUggPbEkNTs1tSC1CKaPiYNTqoEpYKaV67Zj+9bb5eiY
        mwjs83ou0vW5m02j5bpl8Fx+g1Pme6wjs2oMbENzCuVDll8/rtPLr99l5D5Z6n5FcKltuOYn
        1yf3tz9cPXFuh9ye1FuJjyK2nj/yz8t0m/1UU/bJ8xjVWNLvPCiYeWXKk0/bvilMjbeaEi3y
        z6bxxUTOn6mbik9uaokPzJOJ513jd+/a29dicyO5L0g+YLdkP1895ZrWaQ3uKTx123Qe37sq
        ft/9to3P7i7pmr2hXM5N7asdWZpXTQy5ZV7+0el26YpFLS2tKmf5T/7lvyl3pD+nLEl6O5P8
        tMtfdAKd5YNMv7Zt/ryggTn9FP+NJS/bM2JUp2z++3TR6XNf+jR6C0OVWIozEg21mIuKEwGn
        PHK2GwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSvO6NpOYkg1kdGhbb179gtbj+5Tmr
        xYTW7cwWx/cvYbc49ivY4mzTG3aLy7vmsFl87j3CaLH2yF12i88bHjNa3G5cwWbRdegvm8W1
        he9ZLQ5cnMhmMaPtMqsDv8fshossHpf7epk8Fmwq9Wg5uZ/Fo2/LKkaPz5vkAtiiuGxSUnMy
        y1KL9O0SuDLajmxhLrheVNH85R9zA+OGuC5GDg4JAROJvbvCuhg5OYQEdjBKvN/MDGJLCEhK
        TLt4lBmiRFji8OHiLkYuoJJPjBKzZ39gB6lhE9CS2P/iBhuILSJgI3F38TUWkCJmgS9MEjNX
        XmEESQgLhEu0Hf0KNpRFQFVi//EVYHFeASuJ553bmSCWyUus3nAArIZTwFri++HFbBAHWUns
        P/mdZQIj3wJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMGBrKW1g3HPqg96hxiZ
        OBgPMUpwMCuJ8BpUNCQJ8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUI
        JsvEwSnVwGR2cR7DUSZ+mZdbVq7ccpJvcqnlzFj287F/9/4wCnTwydN1rJpccT2lZsnSoHcb
        j259JjT/xfIsnTuzNy7Lzdk7p+v2nS9PNE6KPTLeZn01YOaiW8KCd45VX2xrNFLb7dbx81P9
        r/ebu3o2nKv0sF92YJvLxzlb++ZtunA7IvVHidHev0WZz47lPbGzUl+W28bbqj7RWbtP5PDZ
        zZ8X3BaZeHxui+r6RG8LO9lXsbkKKgJr2c0LCuYZBXjmurQkzc5hi77CadOxY4vQdK1lfeUl
        uyRlll4PKHO0/37p/MHSzGWh5qEfdRu/xu9+L7Ys2vT4d5XvgqkJLCqzVz7S7s5zaLw5ydak
        QURN1uT/pclKLMUZiYZazEXFiQAioGo40wIAAA==
X-CMS-MailID: 20220517085448epcas1p46423db24a3211003238b6c5947228923
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517085448epcas1p46423db24a3211003238b6c5947228923
References: <20220517092108.31680-1-cw00.choi@samsung.com>
        <CGME20220517085448epcas1p46423db24a3211003238b6c5947228923@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

Many CPU architectures have caches that can scale independent of the
CPUs. Frequency scaling of the caches is necessary to make sure that the
cache is not a performance bottleneck that leads to poor performance and
power. The same idea applies for RAM/DDR.

To achieve this, this patch adds support for cpu based scaling to the
passive governor. This is accomplished by taking the current frequency
of each CPU frequency domain and then adjust the frequency of the cache
(or any devfreq device) based on the frequency of the CPUs. It listens
to CPU frequency transition notifiers to keep itself up to date on the
current CPU frequency.

To decide the frequency of the device, the governor does one of the
following:
* Derives the optimal devfreq device opp from required-opps property of
  the parent cpu opp_table.

* Scales the device frequency in proportion to the CPU frequency. So, if
  the CPUs are running at their max frequency, the device runs at its
  max frequency. If the CPUs are running at their min frequency, the
  device runs at its min frequency. It is interpolated for frequencies
  in between.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Johnson Wang <johnson.wang@mediatek.com>
Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
[Sibi: Integrated cpu-freqmap governor into passive_governor]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
[Chanwoo: Fix conflict with latest code and cleanup code]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor.h         |  22 +++
 drivers/devfreq/governor_passive.c | 298 +++++++++++++++++++++++++++--
 include/linux/devfreq.h            |  17 +-
 3 files changed, 323 insertions(+), 14 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index b0dbfee8bbf2..335c4a491254 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -47,6 +47,28 @@
 #define DEVFREQ_GOV_ATTR_POLLING_INTERVAL		BIT(0)
 #define DEVFREQ_GOV_ATTR_TIMER				BIT(1)
 
+/**
+ * struct devfreq_cpu_data - Hold the per-cpu data
+ * @dev:	reference to cpu device.
+ * @first_cpu:	the cpumask of the first cpu of a policy.
+ * @opp_table:	reference to cpu opp table.
+ * @cur_freq:	the current frequency of the cpu.
+ * @min_freq:	the min frequency of the cpu.
+ * @max_freq:	the max frequency of the cpu.
+ *
+ * This structure stores the required cpu_data of a cpu.
+ * This is auto-populated by the governor.
+ */
+struct devfreq_cpu_data {
+	struct device *dev;
+	unsigned int first_cpu;
+
+	struct opp_table *opp_table;
+	unsigned int cur_freq;
+	unsigned int min_freq;
+	unsigned int max_freq;
+};
+
 /**
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index fc09324a03e0..7f30088b500b 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -8,11 +8,85 @@
  */
 
 #include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/devfreq.h>
 #include "governor.h"
 
-static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
+#define HZ_PER_KHZ	1000
+
+static unsigned long get_target_freq_by_required_opp(struct device *p_dev,
+						struct opp_table *p_opp_table,
+						struct opp_table *opp_table,
+						unsigned long *freq)
+{
+	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
+	unsigned long target_freq;
+
+	if (!p_dev || !p_opp_table || !opp_table || !freq)
+		return 0;
+
+	p_opp = devfreq_recommended_opp(p_dev, freq, 0);
+	if (IS_ERR(p_opp))
+		return 0;
+
+	opp = dev_pm_opp_xlate_required_opp(p_opp_table, opp_table, p_opp);
+	dev_pm_opp_put(p_opp);
+
+	if (IS_ERR(opp))
+		return 0;
+
+	target_freq = dev_pm_opp_get_freq(opp);
+	dev_pm_opp_put(opp);
+
+	return target_freq;
+}
+
+static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
+					unsigned long *target_freq)
+{
+	struct devfreq_passive_data *p_data =
+				(struct devfreq_passive_data *)devfreq->data;
+	struct devfreq_cpu_data *parent_cpu_data;
+	unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
+	unsigned long dev_min, dev_max;
+	unsigned long freq = 0;
+
+	for_each_online_cpu(cpu) {
+		parent_cpu_data = p_data->parent_cpu_data[cpu];
+		if (!parent_cpu_data || parent_cpu_data->first_cpu != cpu)
+			continue;
+
+		/* Get target freq via required opps */
+		cpu_cur = parent_cpu_data->cur_freq * HZ_PER_KHZ;
+		freq = get_target_freq_by_required_opp(parent_cpu_data->dev,
+					parent_cpu_data->opp_table,
+					devfreq->opp_table, &cpu_cur);
+		if (freq) {
+			*target_freq = max(freq, *target_freq);
+			continue;
+		}
+
+		/* Use interpolation if required opps is not available */
+		devfreq_get_freq_range(devfreq, &dev_min, &dev_max);
+
+		cpu_min = parent_cpu_data->min_freq;
+		cpu_max = parent_cpu_data->max_freq;
+		cpu_cur = parent_cpu_data->cur_freq;
+
+		cpu_percent = ((cpu_cur - cpu_min) * 100) / (cpu_max - cpu_min);
+		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
+
+		*target_freq = max(freq, *target_freq);
+	}
+
+	return 0;
+}
+
+static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 					unsigned long *freq)
 {
 	struct devfreq_passive_data *p_data
@@ -99,6 +173,181 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	return 0;
 }
 
+static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
+					   unsigned long *freq)
+{
+	struct devfreq_passive_data *p_data =
+				(struct devfreq_passive_data *)devfreq->data;
+	int ret;
+
+	if (!p_data)
+		return -EINVAL;
+
+	/*
+	 * If the devfreq device with passive governor has the specific method
+	 * to determine the next frequency, should use the get_target_freq()
+	 * of struct devfreq_passive_data.
+	 */
+	if (p_data->get_target_freq)
+		return p_data->get_target_freq(devfreq, freq);
+
+	switch (p_data->parent_type) {
+	case DEVFREQ_PARENT_DEV:
+		ret = get_target_freq_with_devfreq(devfreq, freq);
+		break;
+	case CPUFREQ_PARENT_DEV:
+		ret = get_target_freq_with_cpufreq(devfreq, freq);
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(&devfreq->dev, "Invalid parent type\n");
+		break;
+	}
+
+	return ret;
+}
+
+static int cpufreq_passive_notifier_call(struct notifier_block *nb,
+					 unsigned long event, void *ptr)
+{
+	struct devfreq_passive_data *p_data =
+			container_of(nb, struct devfreq_passive_data, nb);
+	struct devfreq *devfreq = (struct devfreq *)p_data->this;
+	struct devfreq_cpu_data *parent_cpu_data;
+	struct cpufreq_freqs *freqs = ptr;
+	unsigned int cur_freq;
+	int ret;
+
+	if (event != CPUFREQ_POSTCHANGE || !freqs ||
+		!p_data->parent_cpu_data[freqs->policy->cpu])
+		return 0;
+
+	parent_cpu_data = p_data->parent_cpu_data[freqs->policy->cpu];
+	if (parent_cpu_data->cur_freq == freqs->new)
+		return 0;
+
+	cur_freq = parent_cpu_data->cur_freq;
+	parent_cpu_data->cur_freq = freqs->new;
+
+	mutex_lock(&devfreq->lock);
+	ret = devfreq_update_target(devfreq, freqs->new);
+	mutex_unlock(&devfreq->lock);
+	if (ret) {
+		parent_cpu_data->cur_freq = cur_freq;
+		dev_err(&devfreq->dev, "failed to update the frequency.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct devfreq_cpu_data *parent_cpu_data;
+	int cpu, ret;
+
+	if (p_data->nb.notifier_call) {
+		ret = cpufreq_unregister_notifier(&p_data->nb,
+					CPUFREQ_TRANSITION_NOTIFIER);
+		if (ret < 0)
+			return ret;
+	}
+
+	for_each_possible_cpu(cpu) {
+		parent_cpu_data = p_data->parent_cpu_data[cpu];
+		if (!parent_cpu_data)
+			continue;
+
+		if (parent_cpu_data->opp_table)
+			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
+		kfree(parent_cpu_data);
+	}
+
+	return 0;
+}
+
+static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct device *dev = devfreq->dev.parent;
+	struct opp_table *opp_table = NULL;
+	struct devfreq_cpu_data *parent_cpu_data;
+	struct cpufreq_policy *policy;
+	struct device *cpu_dev;
+	unsigned int cpu;
+	int ret;
+
+	p_data->nb.notifier_call = cpufreq_passive_notifier_call;
+	ret = cpufreq_register_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret) {
+		dev_err(dev, "failed to register cpufreq notifier\n");
+		p_data->nb.notifier_call = NULL;
+		goto err;
+	}
+
+	for_each_possible_cpu(cpu) {
+		if (p_data->parent_cpu_data[cpu])
+			continue;
+
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy) {
+			ret = -EPROBE_DEFER;
+			goto err;
+		}
+
+		parent_cpu_data = kzalloc(sizeof(*parent_cpu_data),
+						GFP_KERNEL);
+		if (!parent_cpu_data) {
+			ret = -ENOMEM;
+			goto err_put_policy;
+		}
+
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			dev_err(dev, "failed to get cpu device\n");
+			ret = -ENODEV;
+			goto err_free_cpu_data;
+		}
+
+		opp_table = dev_pm_opp_get_opp_table(cpu_dev);
+		if (IS_ERR(opp_table)) {
+			dev_err(dev, "failed to get opp_table of cpu%d\n", cpu);
+			ret = PTR_ERR(opp_table);
+			goto err_free_cpu_data;
+		}
+
+		parent_cpu_data->dev = cpu_dev;
+		parent_cpu_data->opp_table = opp_table;
+		parent_cpu_data->first_cpu = cpumask_first(policy->related_cpus);
+		parent_cpu_data->cur_freq = policy->cur;
+		parent_cpu_data->min_freq = policy->cpuinfo.min_freq;
+		parent_cpu_data->max_freq = policy->cpuinfo.max_freq;
+
+		p_data->parent_cpu_data[cpu] = parent_cpu_data;
+		cpufreq_cpu_put(policy);
+	}
+
+	mutex_lock(&devfreq->lock);
+	ret = devfreq_update_target(devfreq, 0L);
+	mutex_unlock(&devfreq->lock);
+	if (ret)
+		dev_err(dev, "failed to update the frequency\n");
+
+	return ret;
+
+err_free_cpu_data:
+	kfree(parent_cpu_data);
+err_put_policy:
+	cpufreq_cpu_put(policy);
+err:
+	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
+
+	return ret;
+}
+
 static int devfreq_passive_notifier_call(struct notifier_block *nb,
 				unsigned long event, void *ptr)
 {
@@ -131,30 +380,55 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static int devfreq_passive_event_handler(struct devfreq *devfreq,
-				unsigned int event, void *data)
+static int devfreq_passive_unregister_notifier(struct devfreq *devfreq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct devfreq *parent = (struct devfreq *)p_data->parent;
+	struct notifier_block *nb = &p_data->nb;
+
+	return devfreq_unregister_notifier(parent, nb, DEVFREQ_TRANSITION_NOTIFIER);
+}
+
+static int devfreq_passive_register_notifier(struct devfreq *devfreq)
 {
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent = (struct devfreq *)p_data->parent;
 	struct notifier_block *nb = &p_data->nb;
-	int ret = 0;
 
 	if (!parent)
 		return -EPROBE_DEFER;
 
+	nb->notifier_call = devfreq_passive_notifier_call;
+	return devfreq_register_notifier(parent, nb, DEVFREQ_TRANSITION_NOTIFIER);
+}
+
+static int devfreq_passive_event_handler(struct devfreq *devfreq,
+				unsigned int event, void *data)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	int ret = -EINVAL;
+
+	if (!p_data)
+		return -EINVAL;
+
+	if (!p_data->this)
+		p_data->this = devfreq;
+
 	switch (event) {
 	case DEVFREQ_GOV_START:
-		if (!p_data->this)
-			p_data->this = devfreq;
-
-		nb->notifier_call = devfreq_passive_notifier_call;
-		ret = devfreq_register_notifier(parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER);
+		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
+			ret = devfreq_passive_register_notifier(devfreq);
+		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
+			ret = cpufreq_passive_register_notifier(devfreq);
 		break;
 	case DEVFREQ_GOV_STOP:
-		WARN_ON(devfreq_unregister_notifier(parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER));
+		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
+			WARN_ON(devfreq_passive_unregister_notifier(devfreq));
+		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
+			WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
 		break;
 	default:
 		break;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 142474b4af96..b1e4a6f796ce 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -38,6 +38,7 @@ enum devfreq_timer {
 
 struct devfreq;
 struct devfreq_governor;
+struct devfreq_cpu_data;
 struct thermal_cooling_device;
 
 /**
@@ -288,6 +289,11 @@ struct devfreq_simple_ondemand_data {
 #endif
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+enum devfreq_parent_dev_type {
+	DEVFREQ_PARENT_DEV,
+	CPUFREQ_PARENT_DEV,
+};
+
 /**
  * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
  *	and devfreq_add_device
@@ -299,8 +305,11 @@ struct devfreq_simple_ondemand_data {
  *			using governors except for passive governor.
  *			If the devfreq device has the specific method to decide
  *			the next frequency, should use this callback.
- * @this:	the devfreq instance of own device.
- * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
+ * @parent_type:	the parent type of the device.
+ * @this:		the devfreq instance of own device.
+ * @nb:			the notifier block for DEVFREQ_TRANSITION_NOTIFIER or
+ *			CPUFREQ_TRANSITION_NOTIFIER list.
+ * @parent_cpu_data:	the state min/max/current frequency of all online cpu's.
  *
  * The devfreq_passive_data have to set the devfreq instance of parent
  * device with governors except for the passive governor. But, don't need to
@@ -314,9 +323,13 @@ struct devfreq_passive_data {
 	/* Optional callback to decide the next frequency of passvice device */
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 
+	/* Should set the type of parent device */
+	enum devfreq_parent_dev_type parent_type;
+
 	/* For passive governor's internal use. Don't need to set them */
 	struct devfreq *this;
 	struct notifier_block nb;
+	struct devfreq_cpu_data *parent_cpu_data[NR_CPUS];
 };
 #endif
 
-- 
2.17.1

