Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDFD529D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbiEQIzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243838AbiEQIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:55:04 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE443ED1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:54:54 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220517085452epoutp0161297118243cc392c5b5cd641b24391c~v2I3_EqUp1938219382epoutp01F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:54:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220517085452epoutp0161297118243cc392c5b5cd641b24391c~v2I3_EqUp1938219382epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652777692;
        bh=aacMw785+xGoiZ5nKOYjkwmAxv+LSHYNa0f7b23X91Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJJuTPaUeYwuEAyWoCmY6k88/d9XnoEClY5e0AR2c6+u/wv+qAfYfmAM+3+afedUR
         bYaOml22P/HksiqvWPROTc6BdApHBxPrMnEF6qzRHogQ0CaeVff/cTqafCElNVMar/
         5s1FkJdtFqNCrjEeHPFG/WQvCntMXhDfmlhCFH4M=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220517085452epcas1p1e725ef5aba9dc7fbc74de538fd09290c~v2I3eTrW60623906239epcas1p1j;
        Tue, 17 May 2022 08:54:52 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.136]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L2VLL4jbcz4x9QJ; Tue, 17 May
        2022 08:54:50 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.75.10038.AD263826; Tue, 17 May 2022 17:54:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517085449epcas1p4a2e53dda3af368e452d9caaa572d71ae~v2I1D2tn42010020100epcas1p4X;
        Tue, 17 May 2022 08:54:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517085449epsmtrp2228d3eb9f5830ae85748ade6c7b977c5~v2I1C-ivo2839828398epsmtrp2H;
        Tue, 17 May 2022 08:54:49 +0000 (GMT)
X-AuditID: b6c32a37-127ff70000002736-0b-628362dad43f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.53.08924.9D263826; Tue, 17 May 2022 17:54:49 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220517085449epsmtip2c4f87af14da502b473f384370c498d9c~v2I0xFq-S0266202662epsmtip2p;
        Tue, 17 May 2022 08:54:49 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, m.szyprowski@samsung.com,
        saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v5 3/4] PM / devfreq: passive: Reduce duplicate code when
 passive_devfreq case
Date:   Tue, 17 May 2022 18:21:07 +0900
Message-Id: <20220517092108.31680-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517092108.31680-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmvu6tpOYkg+uLOCy2r3/BanH9y3NW
        iwmt25ktju9fwm5x7FewxdmmN+wWl3fNYbP43HuE0WLtkbvsFp83PGa0uN24gs2i69BfNosZ
        bZdZHXg9ZjdcZPFYsKnUo+XkfhaPvi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6O
        d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlFJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
        YquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ2xsfUqS8FJuYrOrn3MDYzPJLoYOTkk
        BEwk3t9bzdbFyMUhJLCDUeLPia2MIAkhgU+MEi9bbSASnxklNvXOY4fpOLhnKytEYhejxLwN
        m9ggOr4wSnS114LYbAJaEvtf3ACLiwhYSZz+38EM0sAsMIVJ4sKeL2AJYYEEib+rp7B0MXJw
        sAioSrQvcwUJ8wLV3571mBVimbzE6g0HmEFsTgFrie+HF4OdKiHwk13i19EuRogiF4lZi/9C
        NQhLvDq+BepSKYnP7/ZCNTQzSjS8uM0I4fQwShx91scCUWUssX/pZCaQK5gFNCXW79KHCCtK
        7Pw9F2wBswCfxLuvPawgJRICvBIdbUIQJcoSlx/cZYKwJSUWt3eyQdgeEl29p5khIdTHKLFg
        +zzmCYxysxA2LGBkXMUollpQnJueWmxYYAyPsuT83E2M4DSoZb6DcdrbD3qHGJk4GA8xSnAw
        K4nwGlQ0JAnxpiRWVqUW5ccXleakFh9iNAWG3kRmKdHkfGAiziuJNzSxNDAxMzI2sTA0M1QS
        51017XSikEB6YklqdmpqQWoRTB8TB6dUA9Pp2T6i028fMf80c2PNG6ZA/VvLFO/cOiotEvej
        qDBCdrH0ZXtFAY5JR2dwJ2Z4MH25ZRTHbywiO9+zs/3PQ+liK1nF95crgxefOJBiu1vBderr
        G79efa+88l+Cxy3KYG3Q7VqVLONbIfa5G7JPOTOLLPumkuBy4WnHf+ZPU7pVn8Z9eN51ffb6
        r38bNnGf+vZmVpf3g8Orvh9sYw0MMVEvrf5ypXLyfv6DdvZcOwrYfi+az/blmt5Rh0KlXS+r
        +iXePT7JG2bxwm5W355p4bFyQYvYzXnsDogqpwTnn8vhv9dp8iq6z1qdZ23I3MaEzMU69WVV
        wIy54uLb/enrQ1yCzrA2869Z7j1N4Zf9RSWW4oxEQy3mouJEACVOH70MBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO7NpOYkg/YjYhbb179gtbj+5Tmr
        xYTW7cwWx/cvYbc49ivY4mzTG3aLy7vmsFl87j3CaLH2yF12i88bHjNa3G5cwWbRdegvm8WM
        tsusDrwesxsusngs2FTq0XJyP4tH35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZWxsvcpScFKu
        orNrH3MD4zOJLkZODgkBE4mDe7aydjFycQgJ7GCUWNa6iwkiISkx7eJR5i5GDiBbWOLw4WKI
        mk+MEr2L37KC1LAJaEnsf3GDDcQWEbCRuLv4GgtIEbPAIiaJCxcXsoMkhAXiJJYvaGYHGcQi
        oCrRvswVJMwrYCVxe9ZjVohd8hKrNxxgBrE5Bawlvh9eDDZTCKhm/8nvLBMY+RYwMqxilEwt
        KM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgOVi2tHYx7Vn3QO8TIxMF4iFGCg1lJhNegoiFJ
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqba4yt3e7Q8
        VY9ccbDx/hylsN/fIjtqLhhXFOYybpLfm8pcaJiQtzaph/1IMqubyzlJ4S0n2STyHtYdL/hn
        wn9io8lqDyudm/rrzqtuYOAoVj+xjeNFnko+z5GfszQVP3MYaU7Za2XyK7qykCWyXlhn282e
        3Yc+yk3kqLW737I42vG09CGRpMtn3GfNrzkh+vzryn2fneYuuf5xpbXYgj2Wr4rdd8vHfnju
        fmhedJFKZNK5P0WrHDZsZNp+780xAfYV6Qeq3zBk+D0olGv9tTrx5uu4DWWpgX2i1z6YB5Ua
        pKS43s92qX9XGPWn8KXfhb8f1xWyaOopiFc6NGhPWye6q4nvw4oetgfVTz0SHyixFGckGmox
        FxUnAgBiYoisxQIAAA==
X-CMS-MailID: 20220517085449epcas1p4a2e53dda3af368e452d9caaa572d71ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517085449epcas1p4a2e53dda3af368e452d9caaa572d71ae
References: <20220517092108.31680-1-cw00.choi@samsung.com>
        <CGME20220517085449epcas1p4a2e53dda3af368e452d9caaa572d71ae@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep the consistent coding style between passive_devfreq
and passive_cpufreq, use common code for handling required opp property.
Also remove the unneed conditional statement and unify the comment
of both passive_devfreq and passive_cpufreq when getting the target frequency.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Johnson Wang <johnson.wang@mediatek.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_passive.c | 66 ++++--------------------------
 1 file changed, 8 insertions(+), 58 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 7f30088b500b..ffcce613a48c 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -93,65 +93,16 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp, *p_opp;
 	int i, count;
 
-	/*
-	 * If the devfreq device with passive governor has the specific method
-	 * to determine the next frequency, should use the get_target_freq()
-	 * of struct devfreq_passive_data.
-	 */
-	if (p_data->get_target_freq)
-		return p_data->get_target_freq(devfreq, freq);
+	/* Get target freq via required opps */
+	child_freq = get_target_freq_by_required_opp(parent_devfreq->dev.parent,
+						parent_devfreq->opp_table,
+						devfreq->opp_table, freq);
+	if (child_freq)
+		goto out;
 
-	/*
-	 * If the parent and passive devfreq device uses the OPP table,
-	 * get the next frequency by using the OPP table.
-	 */
-
-	/*
-	 * - parent devfreq device uses the governors except for passive.
-	 * - passive devfreq device uses the passive governor.
-	 *
-	 * Each devfreq has the OPP table. After deciding the new frequency
-	 * from the governor of parent devfreq device, the passive governor
-	 * need to get the index of new frequency on OPP table of parent
-	 * device. And then the index is used for getting the suitable
-	 * new frequency for passive devfreq device.
-	 */
-	if (!devfreq->profile || !devfreq->profile->freq_table
-		|| devfreq->profile->max_state <= 0)
-		return -EINVAL;
-
-	/*
-	 * The passive governor have to get the correct frequency from OPP
-	 * list of parent device. Because in this case, *freq is temporary
-	 * value which is decided by ondemand governor.
-	 */
-	if (devfreq->opp_table && parent_devfreq->opp_table) {
-		p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent,
-						freq, 0);
-		if (IS_ERR(p_opp))
-			return PTR_ERR(p_opp);
-
-		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
-						    devfreq->opp_table, p_opp);
-		dev_pm_opp_put(p_opp);
-
-		if (IS_ERR(opp))
-			goto no_required_opp;
-
-		*freq = dev_pm_opp_get_freq(opp);
-		dev_pm_opp_put(opp);
-
-		return 0;
-	}
-
-no_required_opp:
-	/*
-	 * Get the OPP table's index of decided frequency by governor
-	 * of parent device.
-	 */
+	/* Use interpolation if required opps is not available */
 	for (i = 0; i < parent_devfreq->profile->max_state; i++)
 		if (parent_devfreq->profile->freq_table[i] == *freq)
 			break;
@@ -159,7 +110,6 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 	if (i == parent_devfreq->profile->max_state)
 		return -EINVAL;
 
-	/* Get the suitable frequency by using index of parent device. */
 	if (i < devfreq->profile->max_state) {
 		child_freq = devfreq->profile->freq_table[i];
 	} else {
@@ -167,7 +117,7 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 		child_freq = devfreq->profile->freq_table[count - 1];
 	}
 
-	/* Return the suitable frequency for passive device. */
+out:
 	*freq = child_freq;
 
 	return 0;
-- 
2.17.1

