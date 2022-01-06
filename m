Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D88487514
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346564AbiAGJy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:54:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:43009 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiAGJy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:54:57 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220107095454epoutp049018de6eeb6faaab94cc14d64e0b5999~H9GLxPB6k3123631236epoutp04b
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 09:54:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220107095454epoutp049018de6eeb6faaab94cc14d64e0b5999~H9GLxPB6k3123631236epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641549295;
        bh=0EUpvzWXJPRM0Kl1jaYy3rZSClH2Bw4XoaVDqebiRPQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mDdC8POIGqyF4U4igFsHDkRf2syDG1WwYN8eE0Zq5LVT4rH9Sqltq8bCVb+/44rJu
         K1JB0pNEqOF/Od/zJTxMEmmnKY+/dgGg0o5aJ19uAdHUPJDR1XHgrqm8dbldtMIeYz
         z6JqSO2N7u7fWfqCrv+wL+WAm5w5XZgXdgoazDeQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220107095453epcas2p1c06b86c0c701148537d7a09c7a66a292~H9GKwaxUU0991109911epcas2p1k;
        Fri,  7 Jan 2022 09:54:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JVdqc4ltkz4x9Py; Fri,  7 Jan
        2022 09:54:52 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.07.51767.CED08D16; Fri,  7 Jan 2022 18:54:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912~H9GI5LPY53119431194epcas2p2i;
        Fri,  7 Jan 2022 09:54:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220107095451epsmtrp1e0ab28c947ac4d7c557b4ce11f03be7f~H9GI4ObQm1528415284epsmtrp1B;
        Fri,  7 Jan 2022 09:54:51 +0000 (GMT)
X-AuditID: b6c32a45-447ff7000000ca37-7c-61d80dec3783
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.0C.08738.BED08D16; Fri,  7 Jan 2022 18:54:51 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220107095451epsmtip244aebc901a71c08ef2e5019042e54a4b~H9GIsE-l21849418494epsmtip2k;
        Fri,  7 Jan 2022 09:54:51 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
Date:   Fri,  7 Jan 2022 06:39:24 +0900
Message-Id: <20220106213924.186263-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhe4b3huJBid2K1o8mLeNzWJv2wl2
        i5c/r7JZHHzYyWIx7cNPZotP65exWqxe/IDFYtGNbUwWl3fNYbPovr6DzWL58X9MDtwel694
        e1zu62XymLDoAKPH9/UdbB4fn95i8ejbsorR4/MmOY/2A91MARxR2TYZqYkpqUUKqXnJ+SmZ
        eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIcqKZQl5pQChQISi4uV9O1sivJL
        S1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Izlt7oYS14yl5xrmsfcwPj
        XrYuRk4OCQETiT19TUA2F4eQwA5Gia3L/zKBJIQEPjFKTJpSC5H4zCgx+coBJpiOx4sfMUIk
        djFKbJj/iR3C+cEosb/rGSNIFZuAhsSaY4eYQBIiAt8YJRb/fQHWziygJvH57jIWEFtYwFVi
        z5dLrCA2i4CqxM3+12A1vAJWEmv71rJArJOXWNTwGyouKHFy5hMWiDnyEs1bZzODLJAQ+Msu
        0b97J9AgDiDHRWLRhyqIXmGJV8e3sEPYUhIv+9vYIeqbGSXWz5zDBOFMYZSY++wpK0SVscSs
        Z+2MIIOYBTQl1u/Sh5ipLHHkFtRePomOw3/ZIcK8Eh1tQhCNShJn5t6GCktIHJydAxH2kJgy
        ZzcrJERjJQ5/fsI4gVF+FpJnZiF5ZhbC2gWMzKsYxVILinPTU4uNCgzhkZqcn7uJEZxWtVx3
        ME5++0HvECMTB+MhRgkOZiUR3ql7ryUK8aYkVlalFuXHF5XmpBYfYjQFBu9EZinR5HxgYs8r
        iTc0sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cDEwrzb+nOAgWmNyeSL
        4d+j1j5h1RVSmfkkNphpmXTmdM15AuZ2ksylB1zY/dZ6Wtc4XWY+zpp+ZnoJ14vv+z5Ymu1+
        LevPeHny59hjN+dMvRupHujJXmnzO+nGo3qu57qbFz36sF16r8mL/TM/c1i4nGStNVF4vmr6
        b5m3FUs02BQUkidWnZx4NLriROFCp3vcWvukd8jWWuyRFW89yD2x2mvy0x2zNp4R7Oqv+TLn
        w/8zj4ze7jsrIRK1Y+2vlyZNlX5qaSsOsU3peLzOze7VdaYDInd500SfSvhdXCfGx7GncfrS
        aZNcbV6xftr6/bhxFBPHTvukXq+fGrnZnFI733AujnK997Z14rro2jolJZbijERDLeai4kQA
        8cK0WjQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvO5r3huJBt035CwezNvGZrG37QS7
        xcufV9ksDj7sZLGY9uEns8Wn9ctYLVYvfsBisejGNiaLy7vmsFl0X9/BZrH8+D8mB26Py1e8
        PS739TJ5TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI4oLpuU1JzMstQifbsEroyl
        N3pYC56yV5zr2sfcwLiXrYuRk0NCwETi8eJHjF2MXBxCAjsYJR50dLNAJCQk/i9uYoKwhSXu
        txxhhSj6xiix5c9vsASbgIbEmmOHmEASIgJNTBIbPt8H62YWUJP4fHcZmC0s4Cqx58slVhCb
        RUBV4mb/a7BmXgEribV9a6G2yUssavgNFReUODnzCdQceYnmrbOZJzDyzUKSmoUktYCRaRWj
        ZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnCwa2ntYNyz6oPeIUYmDsZDjBIczEoivFP3
        XksU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgals4u/L
        u+/df3uwo+69luHDNz2Rxwrc1FyOesTdlLpcUrbh8gXmuVLrduU5iaj7uYnyhF1vV1jAm/3D
        kvPJRIPwpZc35klc7WL1P3733Tw/U7MHi5TW58x83LhGq+JE2cP5fUFyj5Pe7ImYdug316Hr
        eeoORtdrV2xYcXPvgZQXQfbbrITFLSMW3I9wEFr2OMdrdtBs/4qYG+tfxwc98rpySzn2/J/i
        vHkJvEUxvW+vLOTn8qnPPX1sXq3Imy+yboLihwWFvrjNnqZ0JqFZ4Jy857bFr3ycZu5Z/Hz/
        pvcWH9zc5rzTdOm/WLk56PC7l6JsHTz2h/ZOehX4yfXK5DUdU7+ZHN79V1jvT6fJ9uKXSizF
        GYmGWsxFxYkAz5nEBuUCAAA=
X-CMS-MailID: 20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912
References: <CGME20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tactive time determine the waiting time before burst
at hibern8 exit and is determined by H/W at linkup state
However, in the case of samsung devices, guided host's Tactive time
+100us for stability.
If the HCI's Tactive time is equal or greater than the device,
+100us should be set.

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1049e41abd5b..460d2b440d2e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7815,7 +7815,7 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
 	peer_pa_tactivate_us = peer_pa_tactivate *
 			     gran_to_us_table[peer_granularity - 1];
 
-	if (pa_tactivate_us > peer_pa_tactivate_us) {
+	if (pa_tactivate_us >= peer_pa_tactivate_us) {
 		u32 new_peer_pa_tactivate;
 
 		new_peer_pa_tactivate = pa_tactivate_us /
-- 
2.26.0

