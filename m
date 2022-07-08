Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE756B232
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiGHFUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiGHFUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:20:13 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E651B796AC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:20:10 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220708052008epoutp046578fd9cce16a9807771a443e260b180~-wwOe_C3X0732707327epoutp04f
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:20:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220708052008epoutp046578fd9cce16a9807771a443e260b180~-wwOe_C3X0732707327epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657257608;
        bh=nOxZzrylrICb5cSJNRTGIc8Z0MS3siru3oxGpCKZnJc=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=TZ3kMisxDnvPZZH79rWXRSa3mm0mVSDbsU+QlTzfrQuyheHVajnpbYA6+JTFpr6LC
         4lSvyAlcysMQ8xHhFItq6t3fnW8hVojvAHGv8vNGBCel7UQNds0G4cNEl/ZtTzjZIQ
         sJbP88JqlDU/KyrWT+4VaL+Qhoj7QXjNzQIYN1LQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220708052007epcas2p3fc8c22e29a0d4dfd3fe23e0b2af423cf~-wwN22oZl2702827028epcas2p3L;
        Fri,  8 Jul 2022 05:20:07 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LfM6b0bwkz4x9QX; Fri,  8 Jul
        2022 05:20:07 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-ab-62c7be865554
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.68.09642.68EB7C26; Fri,  8 Jul 2022 14:20:06 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: core: Remove UIC_HIBERN8_ENTER_RETRIES
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
Date:   Fri, 08 Jul 2022 14:20:06 +0900
X-CMS-MailID: 20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmuW77vuNJBssNLE4+WcNm8WDeNjaL
        lz+vslkcfNjJYjHtw09mi5eHNC0e3X7GaLHqQbjFohvbmCwu75rDZtF9fQebxfLj/5gceDwu
        X/H2WLznJZPHhEUHGD2+r+9g8/j49BaLR9+WVYwenzfJebQf6GYK4IjKtslITUxJLVJIzUvO
        T8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlVJoSwxpxQoFJBYXKykb2dT
        lF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ2xb8MT9oJZbBWvV35j
        bWCcxdrFyMkhIWAi8X/NKiCbi0NIYAejxNPJ7xm7GDk4eAUEJf7uEAapERZwkuj8vpIZxBYS
        UJLoWriVGSJuILFu+h4wm01AT2LK7zuMIHNEBL4zS+y6dwxqAa/EjPanLBC2tMT25VsZIWwN
        iR/LepkhbFGJm6vfssPY74/Nh6oRkWi9dxaqRlDiwc/dUHFJidYzW9kg7HyJJzf7oebXSCzY
        /hkqri9xrWMjC8QvvhKHb9iCmCwCqhINVx0hKlwk/q3YCHYls4C8xPa3c5hBSpgFNCXW79IH
        MSUElCWO3GKB+aNh4292dDazAJ9Ex+G/cPEd854wQdhqEo8WbIGGgYzExTnnoP7wkHi9/yvb
        BEbFWYhgnoXkhlkINyxgZF7FKJZaUJybnlpsVGAMj9nk/NxNjOAkq+W+g3HG2w96hxiZOBgP
        MUpwMCuJ8MYrH08S4k1JrKxKLcqPLyrNSS0+xGgK9PxEZinR5Hxgms8riTc0sTQwMTMzNDcy
        NTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cAUGdMnonpd7eLDmRtMm+vrfZhCd2WUr0zk
        frD19NKAfcp/0i4sKvwqUS1ZF9zw8nqDiFOTwqG8x3fW+MdMW8+8iLP7eKni43+5S++/d70Q
        l8h+7qb9G0kN3UfXY14GqId82uwtKN+5MPhBsrHTt9+W37btfyFxp+7Uhz3LeM4/N+fYopsV
        bug8M+usjLDGu8cz1NI31nMYLHr/lcdi2aKGbMkHDJq2n0W966qKJwd2tRoq3l1nJ25yyung
        hVkcLnd9lx9bt0zjbQiD1b4jaRxrDc33yx1YOfkY+9HNiRn6F5qeGTCJqt3L/tZ9PNk5aMn6
        04a9P5h6Nr7ZUvFzZ6t//77gvUdEDrJLCvdPnq2lxFKckWioxVxUnAgANd23LTsEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd
References: <CGME20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4db7a2360597 ("scsi: ufs: Fix concurrency of error handler
and other error recovery paths") removed all callers of
UIC_HIBERN8_ENTER_RETRIES. Hence also remove the macro itself.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1d3214e6b364..f6b36d2bfa21 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -64,9 +64,6 @@
 /* maximum number of link-startup retries */
 #define DME_LINKSTARTUP_RETRIES 3
 
-/* Maximum retries for Hibern8 enter */
-#define UIC_HIBERN8_ENTER_RETRIES 3
-
 /* maximum number of reset retries before giving up */
 #define MAX_HOST_RESET_RETRIES 5
 
-- 
2.17.1
