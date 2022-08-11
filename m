Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47795590507
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiHKQs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiHKQsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:48:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F83AAA3E6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:21:25 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220811162122epoutp03d2eaefc316ce4e321b055261482911ed~KVtRHmORN1461514615epoutp03E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:21:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220811162122epoutp03d2eaefc316ce4e321b055261482911ed~KVtRHmORN1461514615epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660234882;
        bh=Ne9iUaPDtu+8u7/wT0WYI6Ighrqj1RwlsWCWGL1U9iM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=a6CtLPFyQD3IRS7UQVp5q4JzLqEl5Iuykhf3VqwFw993ZXTdjuiUbIlfyvzO88ulQ
         x/abAtYRn12TmfQqDSWhBAyNuGHbRX7wR7tmKgENLkUEbwxs71gYMovWjiziqUl0Ti
         xU3k+I1V5IHBm3Z6DQ8Kce12wXQ1DvSZk5NUR7zI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220811162121epcas5p330284ed7640d1f16526cf01e4318b22e~KVtQgjO7C2852928529epcas5p32;
        Thu, 11 Aug 2022 16:21:21 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4M3X9q2s7kz4x9Pv; Thu, 11 Aug
        2022 16:21:19 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.71.49477.F7C25F26; Fri, 12 Aug 2022 01:21:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811162118epcas5p2f452b3b425953d47e60e4b29868c03c9~KVtNi-6S63124631246epcas5p2_;
        Thu, 11 Aug 2022 16:21:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220811162118epsmtrp23d2eae6fb88e0ef6a10b665374365cd2~KVtNiMxnR1427614276epsmtrp22;
        Thu, 11 Aug 2022 16:21:18 +0000 (GMT)
X-AuditID: b6c32a49-82dff7000000c145-a1-62f52c7ff20c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.FC.08802.E7C25F26; Fri, 12 Aug 2022 01:21:18 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220811162115epsmtip187aa3b015256f5e3e01f735ade902be3~KVtKeFPLJ0691106911epsmtip1Y;
        Thu, 11 Aug 2022 16:21:14 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, avri.altman@wdc.com,
        bvanassche@acm.org, martin.petersen@oracle.com,
        chanho61.park@samsung.com, linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2] scsi: ufs: host: ufs-exynos: staticize fsd_ufs_drvs
Date:   Thu, 11 Aug 2022 21:40:53 +0530
Message-Id: <20220811161053.54081-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmum69ztckg1nThSwezNvGZvHy51U2
        i2kffjJbXN6vbdH34iGzxabH11gtLu+aw2Yx4/w+Jovu6zvYLJYf/8fkwOVx+Yq3x51re9g8
        Ni+p9/j49BaLR9+WVYwenzfJebQf6GYKYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
        1DW0tDBXUshLzE21VXLxCdB1y8wBOk5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCS
        U2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ3x5apAwVeOiq3b5jE2MC5j72Lk5JAQMJG497sb
        zBYS2M0o8XO9WRcjF5D9iVFiXs9OZgjnM6PE3gOHGWE6fmy4zQKR2MUo0XN7DyOE08wkMePQ
        G2aQKjYBbYm707cwgdgiAikSV/f/ZAIpYha4zCixb851sISwgLvExL53YMtZBFQlzn7fyAJi
        8wrYSBx6/JsNYp28xOoNB8DukBA4xy6x58BVqDtcJH7tvckCYQtLvDq+BeojKYnP7/YCNXMA
        2R4Si/5IQYQzJN4uXw/Vai9x4MocFpASZgFNifW79EHCzAJ8Er2/nzBBdPJKdLQJQVSrSjS/
        uwq1SFpiYnc3K8zwt+cKICEXKzFz2wPGCYwysxBmLmBkXMUomVpQnJueWmxaYJiXWg6PmeT8
        3E2M4ESm5bmD8e6DD3qHGJk4GA8xSnAwK4nwli36nCTEm5JYWZValB9fVJqTWnyI0RQYSBOZ
        pUST84GpNK8k3tDE0sDEzMzMxNLYzFBJnNfr6qYkIYH0xJLU7NTUgtQimD4mDk6pBqatDJOW
        VYe2XTd8d0GJddOGexd491ima824eqrW7ceMndtOHLHpOZtUzbQ23V5t6ivlzdbVJvYzD0pN
        3yeg99mD6d3P/mt57D4W8x87Vc05//mOp0HjH/cNZiz37/3synRLKVohMlci+caF2bNicpd0
        LEuelCFz7OvxeZv2xOV2bur9FGg8rYLNU1ax+tyfJ9uyp+47fUd0SYvKVd7LPHl2NUf8DURK
        Fq3hFzS77RWzszeu7Xv9iu8nlAzCDMqXi87leC8UN5s/uzPKbr7vU33BX6wWi6cG7HxdcCa6
        4Afzkm8b/a+5ePTkLTF/EHr1uM7MO3tcrVdcDOj4YlK55WRzvjRvkY2Kt9WSz0oc5beVWIoz
        Eg21mIuKEwFaLycs7QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsWy7bCSnG6dztckgzcbpSwezNvGZvHy51U2
        i2kffjJbXN6vbdH34iGzxabH11gtLu+aw2Yx4/w+Jovu6zvYLJYf/8fkwOVx+Yq3x51re9g8
        Ni+p9/j49BaLR9+WVYwenzfJebQf6GYKYI/isklJzcksSy3St0vgyvhyVaDgK0fF1m3zGBsY
        l7F3MXJySAiYSPzYcJuli5GLQ0hgB6PErsaPLBAJaYnrGydAFQlLrPz3nB2iqJFJYvKJv0wg
        CTYBbYm707cA2RwcIgJpEt9OqoDUMAvcZpRY9+ETG0iNsIC7xMS+d2CDWARUJc5+3wi2gFfA
        RuLQ499sEAvkJVZvOMA8gZFnASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4IDT
        0trBuGfVB71DjEwcjIcYJTiYlUR4yxZ9ThLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
        QHpiSWp2ampBahFMlomDU6qBqborfBljctaTCTdzq9wVBCK7+5K/7prn8yHWc7n4PJGvaVLm
        rHJVX03NHWctmmPI4eJb/o1RZikDQ/KCJ8ZHvqw72bDJ8673KVvflF2TApuZPQ97dAafChKf
        vHFa2X+TLv3rr8+anFCvFPIK0zdk+Mr6bLL078u3TBwuRG17fKHKadEt4WDHecdY1zT+n+6e
        OVfBd8PHtenr165m/Vmx9K3SOd3UTTWLZERU1s4P/P+w/MSVeSr7OaqzIvZt2GuacPmYhMa9
        YOlH5pOXR2elTJ21M7N85oauBfOka6vWZTvtu3bs1yyrx3ZBt37fXLP9XlOO9Orv652m+bEt
        cmst9mrV3fRY0KZAon/+n40vTJVYijMSDbWYi4oTAU7q3YinAgAA
X-CMS-MailID: 20220811162118epcas5p2f452b3b425953d47e60e4b29868c03c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220811162118epcas5p2f452b3b425953d47e60e4b29868c03c9
References: <CGME20220811162118epcas5p2f452b3b425953d47e60e4b29868c03c9@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct fsd_ufs_drvs is not used outside this file, so made it static.
This fixes sparse warning:

drivers/ufs/host/ufs-exynos.c:1721:28: sparse: sparse:
symbol 'fsd_ufs_drvs' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 216f74e8059a ("scsi: ufs: host: ufs-exynos: Add support for FSD UFS HCI")
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
* Changes since v1
	- Addressed Krzysztof's  review comment

 drivers/ufs/host/ufs-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index eced97538082..c3628a8645a5 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1711,7 +1711,7 @@ static struct exynos_ufs_uic_attr fsd_uic_attr = {
 	.pa_dbg_option_suite		= 0x2E820183,
 };
 
-struct exynos_ufs_drv_data fsd_ufs_drvs = {
+static const struct exynos_ufs_drv_data fsd_ufs_drvs = {
 	.uic_attr               = &fsd_uic_attr,
 	.quirks                 = UFSHCD_QUIRK_PRDT_BYTE_GRAN |
 				  UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR |
-- 
2.25.1

