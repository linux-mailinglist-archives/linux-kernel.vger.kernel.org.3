Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3447510F15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357332AbiD0DET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiD0DEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:04:14 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8633E2E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:00:57 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220427030051epoutp047026342dc143f85ede405c592edf9304~poaENdlWz2909329093epoutp046
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:00:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220427030051epoutp047026342dc143f85ede405c592edf9304~poaENdlWz2909329093epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651028451;
        bh=M+qF4DXxSPrRE9hFKeagdW70MBluH+VPhyv/ruHbtFk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZPSNEyzGhFo2+BL72wZ0TVcQnl5kcrX/8UGGkwnccnFjxN2ytDl/57vkDHUzvzHBL
         338C36tSBEC6CxJOx72CE/PxQWtve6fYAKwt2ngg2MrgCafxhobsiwgsvwLmONd/r3
         hEwWaQYf5LFrrIWhP4QPt9h24fMrdKYaRVyMbTPg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220427030051epcas1p29f7ba0710c568a6890428aaaede4cea0~poaD1ZqqB1652716527epcas1p2S;
        Wed, 27 Apr 2022 03:00:51 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.226]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Kp3R65LLZz4x9Q9; Wed, 27 Apr
        2022 03:00:50 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.0F.10038.2E1B8626; Wed, 27 Apr 2022 12:00:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220427030050epcas1p377eb744ed82b0e4a80747da6229fedca~poaDPkY5P1145211452epcas1p3E;
        Wed, 27 Apr 2022 03:00:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220427030050epsmtrp2f0e0c68b59840001182e56cc8997775e~poaDOqag-2127921279epsmtrp2S;
        Wed, 27 Apr 2022 03:00:50 +0000 (GMT)
X-AuditID: b6c32a37-111ff70000002736-c3-6268b1e2e061
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.79.08924.2E1B8626; Wed, 27 Apr 2022 12:00:50 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220427030050epsmtip115f5c27c8549c2acc80d468540c5f98e~poaC-4Jr42314923149epsmtip1j;
        Wed, 27 Apr 2022 03:00:50 +0000 (GMT)
From:   bumwoo lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     bumwoo lee <bw365.lee@samsung.com>
Subject: [PATCH V1] extcon: modify extcon device to be created after driver
 data is set
Date:   Wed, 27 Apr 2022 12:00:05 +0900
Message-Id: <20220427030005.706-1-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmru6jjRlJBke3a1ucWLOIyeL6l+es
        Fpd3zWGzuN24gs2BxaNvyypGj8+b5AKYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        zAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMz40TmEr+CFa8e3PKpYGxu1CXYwcHBICJhI7+3y7
        GDk5hAR2MEqcO2XYxcgFZH9ilHg+6ycLhPOZUaLr3CV2kCqQhrPdP9khErsYJSZebWKCcH4x
        Shx+coIJpIpNQEPi4sXrzCArRAQKJQ73Z4OEmQXUJP6c6QErERaIlFi/bRcjiM0ioCqxevcc
        sAW8AhYSS84eY4ZYJi/R/e8PC0RcUOLkzCcsEHPkJZq3zoaqWcYu8fl9EITtIrFk/S8mCFtY
        4tXxLVBHS0l8freXDcJOl1h55Q5UPEfi9f12RgjbWOLd27VgJzMLaEqs36UPEVaU2Pl7LiPE
        Wj6Jd197WCEBxyvR0SYEUaIs0f3gBdRWSYnFT+9ATfSQWDH/AiMkcGMlenbNZ5rAKD8LyTOz
        kDwzC2HxAkbmVYxiqQXFuempxYYFxvAYTc7P3cQITmha5jsYp739oHeIkYmD8RCjBAezkgjv
        PcWMJCHelMTKqtSi/Pii0pzU4kOMpsDgncgsJZqcD0ypeSXxhiaWBiZmRiYWxpbGZkrivKum
        nU4UEkhPLEnNTk0tSC2C6WPi4JRqYPL+YGb2ozXlY2VD4/rdq2rUJVNPPFI2PXr6i5p+3Z/j
        jXwu9gUZqz6wlH/+rNxtfzFRY86Exdx37+/Z++rqshsRB7P+qLzu2L33MusyxQLdhTvOd7gu
        /i+01cJt2oL9jz7PmhNhpzX1oekS4cVdV5V1yp7sDK+cmyKk0frj70POHSycv9qm7eB4xiJn
        +Tnvs//1wxJ7kg2kdxg//nA6qnlHglNZr3TAyi+RSRMrth7k7K3/sz37pna47IspDk9/SizI
        /+3JVZxWUF60e3tAqN08uUg/WznnF/yCH2u/Nn3OXO5/eDV7aPxiz00P1jhEvlsUkrx/zpWS
        teZ/JAT9DI8kP7NXFfJ2ulvkvVllzgslluKMREMt5qLiRABjWJ3i8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTvfRxowkg74NwhYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmKC6blNSczLLUIn27BK6MD41T2Ap+iFZ8+7OKpYFx
        u1AXIyeHhICJxNnun+xdjFwcQgI7GCUu/tjNDpGQlDi7/BGQzQFkC0scPlwMUfODUeLe4c3M
        IDVsAhoSFy9eB7NFBIolLhxYzAJiMwuoSfw508ME0issEC5xbncESJhFQFVi9e45YON5BSwk
        lpw9xgyxSl6i+98fFoi4oMTJmU+gxshLNG+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OLDQuM
        8lLL9YoTc4tL89L1kvNzNzGCw0xLawfjnlUf9A4xMnEwHmKU4GBWEuG9p5iRJMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPT5BsP+HbxbLY6lb1tXV3D
        m4gdU1m4p71Vkrj3/0jB681POzQ+3d3Htb+s7umJ5tmnnxYKyl/Q+n+CY8Hc/Puab0s3zf99
        Z/GvH1d8PnW7bfZxUlSzurkt8tfnNw8KzVsVoqaGcMXfXW6S/23/NHstxajvHvLLdldo//6w
        Lv35I/UJngo3BGMzeVN2f6jx/X952j6TSeE3tuZ/jdc96P5D+HPyhM8CAQfcXLvMPSZ42l94
        PWHOIdusaaHlR7ZMXnEl5Xj4oXtzZd/H/+Wdc4hxXpxE7xTZxN+6q7RdXy4qj6oo+v6UbWbw
        7LD9M/X2Bq1Jt7xY1zerXDF2QXSwhLz/wvn60tqmRjv+3+X47BB36JQSS3FGoqEWc1FxIgB2
        y7A1ogIAAA==
X-CMS-MailID: 20220427030050epcas1p377eb744ed82b0e4a80747da6229fedca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220427030050epcas1p377eb744ed82b0e4a80747da6229fedca
References: <CGME20220427030050epcas1p377eb744ed82b0e4a80747da6229fedca@epcas1p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, someone can invoke the sysfs such as state_show()
intermittently before dev_set_drvdata() is done.
And it can be a cause of kernel Oops because of edev is Null at that time.
So modified the driver registration to after setting drviver data.

- Oops's backtrace.

Backtrace:
[<c067865c>] (state_show) from [<c05222e8>] (dev_attr_show)
[<c05222c0>] (dev_attr_show) from [<c02c66e0>] (sysfs_kf_seq_show)
[<c02c6648>] (sysfs_kf_seq_show) from [<c02c496c>] (kernfs_seq_show)
[<c02c4938>] (kernfs_seq_show) from [<c025e2a0>] (seq_read)
[<c025e11c>] (seq_read) from [<c02c50a0>] (kernfs_fop_read)
[<c02c5064>] (kernfs_fop_read) from [<c0231cac>] (__vfs_read)
[<c0231c5c>] (__vfs_read) from [<c0231ee0>] (vfs_read)
[<c0231e34>] (vfs_read) from [<c0232464>] (ksys_read)
[<c02323f0>] (ksys_read) from [<c02324fc>] (sys_read)
[<c02324e4>] (sys_read) from [<c00091d0>] (__sys_trace_return)

Signed-off-by: bumwoo lee <bw365.lee@samsung.com>
---
 drivers/extcon/extcon.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index d27cd9f88f86..d3a32b806499 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1224,19 +1224,14 @@ int extcon_dev_register(struct extcon_dev *edev)
 		edev->dev.type = &edev->extcon_dev_type;
 	}
 
-	ret = device_register(&edev->dev);
-	if (ret) {
-		put_device(&edev->dev);
-		goto err_dev;
-	}
-
 	spin_lock_init(&edev->lock);
-	edev->nh = devm_kcalloc(&edev->dev, edev->max_supported,
-				sizeof(*edev->nh), GFP_KERNEL);
-	if (!edev->nh) {
-		ret = -ENOMEM;
-		device_unregister(&edev->dev);
-		goto err_dev;
+	if (edev->max_supported) {
+		edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh),
+				GFP_KERNEL);
+		if (!edev->nh) {
+			ret = -ENOMEM;
+			goto err_alloc_nh;
+		}
 	}
 
 	for (index = 0; index < edev->max_supported; index++)
@@ -1247,6 +1242,12 @@ int extcon_dev_register(struct extcon_dev *edev)
 	dev_set_drvdata(&edev->dev, edev);
 	edev->state = 0;
 
+	ret = device_register(&edev->dev);
+	if (ret) {
+		put_device(&edev->dev);
+		goto err_dev;
+	}
+
 	mutex_lock(&extcon_dev_list_lock);
 	list_add(&edev->entry, &extcon_dev_list);
 	mutex_unlock(&extcon_dev_list_lock);
@@ -1254,6 +1255,9 @@ int extcon_dev_register(struct extcon_dev *edev)
 	return 0;
 
 err_dev:
+	if (edev->max_supported)
+		kfree(edev->nh);
+err_alloc_nh:
 	if (edev->max_supported)
 		kfree(edev->extcon_dev_type.groups);
 err_alloc_groups:
@@ -1314,6 +1318,7 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 	if (edev->max_supported) {
 		kfree(edev->extcon_dev_type.groups);
 		kfree(edev->cables);
+		kfree(edev->nh);
 	}
 
 	put_device(&edev->dev);
-- 
2.35.1

