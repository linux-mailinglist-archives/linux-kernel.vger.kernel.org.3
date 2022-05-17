Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C87529D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiEQIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiEQIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:54:57 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2743EC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:54:53 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517085450epoutp02a8c79046ebbf83ba7989e29608f30944~v2I173Jjb0089200892epoutp02R
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:54:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517085450epoutp02a8c79046ebbf83ba7989e29608f30944~v2I173Jjb0089200892epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652777690;
        bh=C1Bw0QoZP2RPrR0PfQjlAYeLWCes/VSSVrUJ1oLkv2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9f+LG20BuvMMYpu7FV9d9UqWf4TLStR1cxbCYXAAMCHOth40oid+cJeLvwcIj4Yx
         bAdcwgcHu3Im9be+MdLaT2ievFrveCYHAB8O1uNM8UnMH1ue7dsUUi1iLdBWvFkQQv
         0RZZGX1nTiKEBbfQ/sbpJRNcQfsv8mo8bXCqTcW0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220517085449epcas1p1a4fc97395fe4a74555d88720006002cd~v2I0-xhHx0807508075epcas1p1s;
        Tue, 17 May 2022 08:54:49 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.135]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4L2VLJ2qySz4x9QS; Tue, 17 May
        2022 08:54:48 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.66.09785.8D263826; Tue, 17 May 2022 17:54:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517085447epcas1p486bdbfab57211a12409e590abee05556~v2IzgDR_C2687326873epcas1p4G;
        Tue, 17 May 2022 08:54:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517085447epsmtrp284d26af1c6a57532d8dbd837819a0b66~v2IzeEyMY2839828398epsmtrp2F;
        Tue, 17 May 2022 08:54:47 +0000 (GMT)
X-AuditID: b6c32a36-c87ff70000002639-6c-628362d881f5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.18.11276.7D263826; Tue, 17 May 2022 17:54:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220517085447epsmtip28e684f5d985b988be56e0b90b78c2a83~v2IzPcNYi0293502935epsmtip2f;
        Tue, 17 May 2022 08:54:47 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, m.szyprowski@samsung.com,
        saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v5 1/4] PM / devfreq: Export devfreq_get_freq_range symbol
 within devfreq
Date:   Tue, 17 May 2022 18:21:05 +0900
Message-Id: <20220517092108.31680-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517092108.31680-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmnu6NpOYkg5X/BS22r3/BanH9y3NW
        iwmt25ktju9fwm5x7FewxdmmN+wWl3fNYbP43HuE0WLtkbvsFp83PGa0uN24gs2i69BfNosZ
        bZdZHXg9ZjdcZPFYsKnUo+XkfhaPvi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6O
        d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlFJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
        YquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ1xbuUltoLbChXPXig2MG6T7mLk4JAQ
        MJHY/7uki5GLQ0hgB6PE7CU3WSCcT4wSnW+72CCcb4wSlxftZO9i5ATr+HJgISNEYi+jxIaX
        W5khnC+MEi97zrCBVLEJaEnsf3EDzBYRsJI4/b8DrIhZYAqTxIU9X8ASwgLREq2nboCNZRFQ
        lZjw5RkTiM0L1DD96Q4miHXyEqs3HGAGsTkFrCW+H17MBhH/yi6x6UI8xBMuEns3c0OEhSVe
        Hd8CdamUxOd3e8FekBBoZpRoeHGbEcLpYZQ4+qyPBaLKWGL/0slMIIOYBTQl1u/ShwgrSuz8
        PZcRxGYW4JN497WHFWIXr0RHmxBEibLE5Qd3oc6UlFjc3gl1mofEit6dTJBA6WOU6F0/i20C
        o9wshA0LGBlXMYqlFhTnpqcWGxYYwWMsOT93EyM4CWqZ7WCc9PaD3iFGJg7GQ4wSHMxKIrwG
        FQ1JQrwpiZVVqUX58UWlOanFhxhNgYE3kVlKNDkfmIbzSuINTSwNTMyMjE0sDM0MlcR5V007
        nSgkkJ5YkpqdmlqQWgTTx8TBKdXAZO8q9ddr1p0G8eJb5+WOszDlGDTrlfRxhJ3w6VgkWcjp
        c6lU6+uF1UevVq4uNvtrf/3RzYUnbFZJi1o2HX3CsdNw2aaTMZ0TUzkCt6564bLMr9PsRfJe
        S1bFjCUrS+Mny+zkiv3zMGotU8uHHP6ktoT6qFUuXVIOCg+8PGa99HSaLpL1ZlfxkiPVK/5H
        PeHf9e3XluV3rjzpXcM9pfKD6qnmbxqnd311LHEXOzpn5s1DzNqCEp+ZvLot1cI2KMdxT80y
        Xq0Tu44n6JaP22qNp88OfuXqLHrycy5bsanMie1Oh/W+n6xbNlOQJcD0b3Lmv5e5m5cqmq6Z
        9zpneYwnk9bDhuiU3o1PBPa+PFvupMRSnJFoqMVcVJwIACNkj5QLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO71pOYkgyvPdCy2r3/BanH9y3NW
        iwmt25ktju9fwm5x7FewxdmmN+wWl3fNYbP43HuE0WLtkbvsFp83PGa0uN24gs2i69BfNosZ
        bZdZHXg9ZjdcZPFYsKnUo+XkfhaPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyji38hJbwW2F
        imcvFBsYt0l3MXJySAiYSHw5sJCxi5GLQ0hgN6PE1ENv2CESkhLTLh5l7mLkALKFJQ4fLoao
        +cQo8eHmayaQGjYBLYn9L26wgdgiAjYSdxdfYwEpYhZYxCRx4eJCsEHCApESnz7vZQGxWQRU
        JSZ8eQbWzCtgJTH96Q4miGXyEqs3HGAGsTkFrCW+H14MNlQIqGb/ye8sExj5FjAyrGKUTC0o
        zk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5WLc0djNtXfdA7xMjEwXiIUYKDWUmE16CiIUmI
        NyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpsqpyUr/I33X
        TIrfr3pMyzyiRUsrpHP/Pdmn399o8DmvNfx1Lv65Ide6hZJHS3I6/SqqPwQd+Zl584wA8xIZ
        5dNvd7XdYRCIsHDi2lnYLso3MSjyFl9cyByLw7dYHoQe4+Tt3MK07N2yP2ryJx6e3Xlkq1/+
        9N+vVGtFWVp2xvNOr1m8RVnu8e+ui8H/cz9x3jdIe2avblvD8lp9qcuqm+uM/+v+XpVaV61b
        xb48Xf2gMdtM5uW71l76Hz3p89qfNiFpX8znqKR+XH9KovHzMknejqgz1f7sd8XrzyQZT2zb
        NE1167LlE9rYDPr+dIoocjzMbfgskmm8RTfhJ/cV7j3fF7h7HN1x7Nqy/Z5i5UosxRmJhlrM
        RcWJANTrTA3FAgAA
X-CMS-MailID: 20220517085447epcas1p486bdbfab57211a12409e590abee05556
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517085447epcas1p486bdbfab57211a12409e590abee05556
References: <20220517092108.31680-1-cw00.choi@samsung.com>
        <CGME20220517085447epcas1p486bdbfab57211a12409e590abee05556@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get frequency range within devfreq governors,
export devfreq_get_freq_range symbol within devfreq.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Johnson Wang <johnson.wang@mediatek.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c  | 20 ++++++++++++--------
 drivers/devfreq/governor.h |  2 ++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a525a609dfc6..01474daf4548 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -112,16 +112,16 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
 }
 
 /**
- * get_freq_range() - Get the current freq range
+ * devfreq_get_freq_range() - Get the current freq range
  * @devfreq:	the devfreq instance
  * @min_freq:	the min frequency
  * @max_freq:	the max frequency
  *
  * This takes into consideration all constraints.
  */
-static void get_freq_range(struct devfreq *devfreq,
-			   unsigned long *min_freq,
-			   unsigned long *max_freq)
+void devfreq_get_freq_range(struct devfreq *devfreq,
+			    unsigned long *min_freq,
+			    unsigned long *max_freq)
 {
 	unsigned long *freq_table = devfreq->profile->freq_table;
 	s32 qos_min_freq, qos_max_freq;
@@ -158,6 +158,7 @@ static void get_freq_range(struct devfreq *devfreq,
 	if (*min_freq > *max_freq)
 		*min_freq = *max_freq;
 }
+EXPORT_SYMBOL(devfreq_get_freq_range);
 
 /**
  * devfreq_get_freq_level() - Lookup freq_table for the frequency
@@ -418,7 +419,7 @@ int devfreq_update_target(struct devfreq *devfreq, unsigned long freq)
 	err = devfreq->governor->get_target_freq(devfreq, &freq);
 	if (err)
 		return err;
-	get_freq_range(devfreq, &min_freq, &max_freq);
+	devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
 
 	if (freq < min_freq) {
 		freq = min_freq;
@@ -785,6 +786,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 {
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
+	unsigned long min_freq, max_freq;
 	int err = 0;
 
 	if (!dev || !profile || !governor_name) {
@@ -849,6 +851,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_dev;
 	}
 
+	devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
+
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
 	if (IS_ERR(devfreq->opp_table))
@@ -1587,7 +1591,7 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 	unsigned long min_freq, max_freq;
 
 	mutex_lock(&df->lock);
-	get_freq_range(df, &min_freq, &max_freq);
+	devfreq_get_freq_range(df, &min_freq, &max_freq);
 	mutex_unlock(&df->lock);
 
 	return sprintf(buf, "%lu\n", min_freq);
@@ -1641,7 +1645,7 @@ static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 	unsigned long min_freq, max_freq;
 
 	mutex_lock(&df->lock);
-	get_freq_range(df, &min_freq, &max_freq);
+	devfreq_get_freq_range(df, &min_freq, &max_freq);
 	mutex_unlock(&df->lock);
 
 	return sprintf(buf, "%lu\n", max_freq);
@@ -1955,7 +1959,7 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 
 		mutex_lock(&devfreq->lock);
 		cur_freq = devfreq->previous_freq;
-		get_freq_range(devfreq, &min_freq, &max_freq);
+		devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
 		timer = devfreq->profile->timer;
 
 		if (IS_SUPPORTED_ATTR(devfreq->governor->attrs, POLLING_INTERVAL))
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 002a7d67e39d..b0dbfee8bbf2 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -89,6 +89,8 @@ int devm_devfreq_add_governor(struct device *dev,
 
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
 int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
+void devfreq_get_freq_range(struct devfreq *devfreq, unsigned long *min_freq,
+			    unsigned long *max_freq);
 
 static inline int devfreq_update_stats(struct devfreq *df)
 {
-- 
2.17.1

