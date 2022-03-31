Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB04ED272
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiCaEQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiCaEQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:16:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3FB16BCED
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:00:39 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220331030338epoutp04879dc79db3570243e37b008bc366f4ad~hWByXj3ow0472804728epoutp04c
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:03:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220331030338epoutp04879dc79db3570243e37b008bc366f4ad~hWByXj3ow0472804728epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648695818;
        bh=atNiTbJQ5upQMrld2+SnKpbR/2YzyUNsEH8o2X9kkdI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ufaKw/moSs9+mixMGD/oFuSvGxYT4L2tlWGKQ7nhqy9sHytm3XctKw0g6Fc2bo+n0
         Jkp8rVYI00tkntrZLTk9bkB0VAOf44eOkBx0E9hZYOp+NegJs1TlxyylShuIq8Vb5e
         Y0vuA9Jx3g5RqgsuZnm7CSLAI9JEnvBSZ7hZaYHE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220331030338epcas1p2a49e06fe56daf7a2c2c5cf5808323b90~hWBx-LJzN2258122581epcas1p2i;
        Thu, 31 Mar 2022 03:03:38 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.241]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KTSmn1dMtz4x9QC; Thu, 31 Mar
        2022 03:03:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.18.28648.90A15426; Thu, 31 Mar 2022 12:03:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220331030336epcas1p3b8bf7b1841d4b246030b57b668312169~hWBw-A0Tw1494514945epcas1p3e;
        Thu, 31 Mar 2022 03:03:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220331030336epsmtrp22cb232d9a8967911c4e27a3551b9981c~hWBw_W5jy2738927389epsmtrp2I;
        Thu, 31 Mar 2022 03:03:36 +0000 (GMT)
X-AuditID: b6c32a39-ff1ff70000006fe8-e1-62451a09818f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.DE.24342.80A15426; Thu, 31 Mar 2022 12:03:36 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220331030336epsmtip1b19966f0ede5198d937ae4fd8e29f34b~hWBw3h7N90211802118epsmtip1R;
        Thu, 31 Mar 2022 03:03:36 +0000 (GMT)
From:   bumwoo lee <bw365.lee@samsung.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     bumwoo lee <bw365.lee@samsung.com>
Subject: [PATCH] extcon: modify extcon device to be created after driver
 data is set
Date:   Thu, 31 Mar 2022 12:03:24 +0900
Message-Id: <20220331030324.42621-1-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmni6nlGuSwd8l3BYn1ixisrj+5Tmr
        xeVdc9gsbjeuYHNg8ejbsorR4/MmuQCmqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0Nd
        Q0sLcyWFvMTcVFslF58AXbfMHKBFSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        swK94sTc4tK8dL281BIrQwMDI1OgwoTsjO/nGtkKdglUPJy9hbWB8TNvFyMnh4SAicSG1fcY
        uxi5OIQEdjBKrG34wgzhfGKUmLBrAwuE841R4u+PDvYuRg6wlj+vKiHiexkl/nSfZIJwfjFK
        3Jp1nQlkLpuAhsTFi9eZQRpEBAolDvdng4SZBdQk/pzpASsRFgiT2NnxjA3EZhFQlWj89wHM
        5hWwkri7eA0bxHnyEt3//rBAxAUlTs58wgIxR16ieetssEslBJaxSzw6+ZAV4jgXidYVAhC9
        whKvjm9hh7ClJD6/2ws1M11i5ZU7UPEcidf32xkhbGOJd2/Xgp3MLKApsX6XPkRYUWLn77mM
        EGv5JN597YHaxCvR0SYEUaIs0f3gBROELSmx+OkdqIkeEp1TFoJdLCQQK3H7w0HGCYzys5A8
        MwvJM7MQFi9gZF7FKJZaUJybnlpsWGAKj9Lk/NxNjOCUpmW5g3H62w96hxiZOBgPMUpwMCuJ
        8H486JwkxJuSWFmVWpQfX1Sak1p8iNEUGLwTmaVEk/OBSTWvJN7QxNLAxMzIxMLY0thMSZx3
        1bTTiUIC6YklqdmpqQWpRTB9TBycUg1Mmw8LWZkeVxJp+PZy59oF/SofOa43HZx1+Himudel
        7oLVAfoaZo81xC2z1/7YcllUzm/OpiLhh65qbJYSizLvWy368mTagXj9qczJO/4yv1zvMS3j
        mvac+MVfdpUYdrp0yN+6u9g/wOiL3/X1b0TNu7mLFl7L3m25gnubLcPUNPa2uY53PWb8fj07
        PW3D9MIZ3xYcOjQzKpWVIX1JwvJVE4IKfVYzSD2XSu9iOz3Jp2jB/NlPJhzZlR3g/9s7eWfN
        vgOSbqssbkrs3OM98ZJ2uPrTzhnhvmElf/6vsV5YHXdOvv7fyQ/80aunzzvoxb1qwnmFJcu1
        NvKfyeW2/3FjVq/Y8zWGa8ou7RWrWzjPpkWJpTgj0VCLuag4EQAXBGK08gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTpdDyjXJ4Nl3U4sTaxYxWVz/8pzV
        4vKuOWwWtxtXsDmwePRtWcXo8XmTXABTFJdNSmpOZllqkb5dAlfG93ONbAW7BCoezt7C2sD4
        mbeLkYNDQsBE4s+ryi5GLg4hgd2MEnOmvmftYuQEiktKnF3+iB2iRlji8OFiiJofjBIPWj6z
        g9SwCWhIXLx4nRnEFhEolrhwYDELiM0soCbx50wPE4gtLBAisWTSBbAaFgFVicZ/H9hAbF4B
        K4m7i9ewQeySl+j+94cFIi4ocXLmE6g58hLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GLD
        AsO81HK94sTc4tK8dL3k/NxNjOAw09Lcwbh91Qe9Q4xMHIyHGCU4mJVEeD8edE4S4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgcn8i8CFvuvRpcE6nNf8
        9q7VPfPBavrj7/mJjz3eX3deWO3o1Pb1mtJlg8cZXPwCp2dn7VRk453kdU/08uLo4NP7704s
        NnoovHji0xKjK5+OVXxvtOT0CGcPa++cGfbcpUVEfcPa5S8n3r4ctCfPvOZ249Ee6TT3fcH3
        1O13vOps05zBtfANX8WN7FyDtwe3yJj+9/hluHDiNruU9tTS+9l7LI2sq/qlQ80eamtof7AJ
        9Ah74WyV9+kg36f16+wizCKFFL+odZq/v6N/d8HvT1ppr+ZmbJzwge/ozZ0XH1UXCLMKLPQR
        /+MQbVuxn0O3r03g2CaGydEbt55e03ZUftoyi4Msokf2+K34xur54pASS3FGoqEWc1FxIgBv
        +6nbogIAAA==
X-CMS-MailID: 20220331030336epcas1p3b8bf7b1841d4b246030b57b668312169
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220331030336epcas1p3b8bf7b1841d4b246030b57b668312169
References: <CGME20220331030336epcas1p3b8bf7b1841d4b246030b57b668312169@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, someone can invoke the sysfs such as state_show()
intermittently before set_drvdata() is done.
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
 drivers/extcon/extcon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index d27cd9f88f86..74fee04bd764 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1224,18 +1224,13 @@ int extcon_dev_register(struct extcon_dev *edev)
 		edev->dev.type = &edev->extcon_dev_type;
 	}
 
-	ret = device_register(&edev->dev);
-	if (ret) {
-		put_device(&edev->dev);
-		goto err_dev;
-	}
+	device_initialize(&edev->dev);
 
 	spin_lock_init(&edev->lock);
 	edev->nh = devm_kcalloc(&edev->dev, edev->max_supported,
 				sizeof(*edev->nh), GFP_KERNEL);
 	if (!edev->nh) {
 		ret = -ENOMEM;
-		device_unregister(&edev->dev);
 		goto err_dev;
 	}
 
@@ -1251,9 +1246,14 @@ int extcon_dev_register(struct extcon_dev *edev)
 	list_add(&edev->entry, &extcon_dev_list);
 	mutex_unlock(&extcon_dev_list_lock);
 
+	ret = device_add(&edev->dev);
+	if (ret)
+		goto err_dev;
+
 	return 0;
 
 err_dev:
+	put_device(&edev->dev);
 	if (edev->max_supported)
 		kfree(edev->extcon_dev_type.groups);
 err_alloc_groups:
-- 
2.32.0

