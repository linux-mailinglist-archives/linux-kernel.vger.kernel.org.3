Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4840C5A1E31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbiHZBb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHZBby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:31:54 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F105FAE8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:31:50 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220826013144epoutp02aec6214ca341e9297e722dfb05b0b496~OwPzfw4k01584015840epoutp02c
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:31:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220826013144epoutp02aec6214ca341e9297e722dfb05b0b496~OwPzfw4k01584015840epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661477504;
        bh=7YWSaAaY196+mgvc+7xItDckKEh7b0FnGVSctrZ62QM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lF6BhQYXGAR1RgUhU0ZM2Txesjs6KUGkNVosF0qjFBzz2b3EnnnDUuHWsdttHsbuF
         R/TxaBQ8xDca63T9tGTI6CPmdE/hHCSkQfBwIid3bLbi/6WwGuxZn+iKqH2WmQJmi7
         llLI/v/fYsv9g3EZ1DpN2mWSinqinF/tCrok+czQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220826013144epcas1p44b2e52d6b6d2b8ec6d7a8fd18ecc8fec~OwPzASnt-1450514505epcas1p42;
        Fri, 26 Aug 2022 01:31:44 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.225]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MDMkS07rpz4x9Q2; Fri, 26 Aug
        2022 01:31:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.8F.15591.F7228036; Fri, 26 Aug 2022 10:31:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220826013143epcas1p36fd947d2f65448f535864329d912f00d~OwPyN6Hzg2963829638epcas1p3W;
        Fri, 26 Aug 2022 01:31:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220826013143epsmtrp2b7e26d8841d76197c2db1eba73093823~OwPyNDlJc1948019480epsmtrp2b;
        Fri, 26 Aug 2022 01:31:43 +0000 (GMT)
X-AuditID: b6c32a35-eabff70000003ce7-4a-6308227f6cb5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.EF.18644.F7228036; Fri, 26 Aug 2022 10:31:43 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220826013143epsmtip212e6d818e2cdba6111828dcc7574a49c~OwPyA4UjH2638426384epsmtip2C;
        Fri, 26 Aug 2022 01:31:43 +0000 (GMT)
From:   Manjong Lee <mj0123.lee@samsung.com>
To:     mj0123.lee@samsung.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        nanich.lee@samsung.com, yt0928.kim@samsung.com,
        junho89.kim@samsung.com, jisoo2146.oh@samsung.com,
        sbeom16.kim@samsung.com
Subject: [PATCH 1/1] blk-mq: added case for cpu offline during send_ipi in
 rq_complete
Date:   Fri, 26 Aug 2022 10:31:36 +0900
Message-Id: <20220826013136.16763-1-mj0123.lee@samsung.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTV7deiSPZYNlKS4vVd/vZLHqeNLFa
        fH1YbLH3lrbF5V1z2Cymb57DbHHt/hl2izn/77FanDv5idVi3mMHi/V7f7I5cHtcPlvq0bdl
        FaPH501yAcxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
        bpk5QMcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMCvSKE3OLS/PS9fJSS6wM
        DQyMTIEKE7Izpi5YwF7wlq9i9znWBsbFPF2MnBwSAiYSR5pvMXcxcnEICexglFh34iU7hPOJ
        UWJBx2NGCOczo8SO7+vYYFo2HjkF1bKLUWLuwclscFX7dr1mAaliE9CSWP7sAjuILSKQIXHp
        0QSwDmaQJbNnLANLCAtESHS+XcsMYrMIqEo8friAEcTmFbCW+LxsBjvEOnmJU8sOMkHEBSVO
        znwCtoAZKN68dTbYUAmBa+wS959fhmpwkfg2eT8LhC0s8er4Fqi4lMTnd3uhfiiW2HJrMlAN
        B5BdIdHbFQsRNpb49PkzI0iYWUBTYv0ufYiwosTO33MZIdbySbz72sMK0ckr0dEmBFGiIrG7
        +RvcojevDjBC2B4Su08cAbOFBGIlNj6byjyBUX4WkmdmIXlmFsLiBYzMqxjFUguKc9NTiw0L
        DOGRmpyfu4kRnB61THcwTnz7Qe8QIxMH4yFGCQ5mJRFeq2MsyUK8KYmVValF+fFFpTmpxYcY
        TYHBO5FZSjQ5H5ig80riDU0sDUzMjEwsjC2NzZTEefW0GZOFBNITS1KzU1MLUotg+pg4OKUa
        mKyMi2vUXx9fvVP09H7FVdGT752Jj3rerLfmE4fqZZaMN42nD/I282elufTs3V7natylKJFR
        KqnukH8wQIz3ydRKgSVzyxV439i96jM8puch8H2vbNauy3ltGVze3P7hOtxH2aVusdmueRHv
        /4vx8WxJKw1pNdfwW8dkIoK5HFiZJX+s2R73faf7BuH3q9ab+bQyXZ+eYXcglLtqqaBA5Gv5
        x5/DYzYU72qe4cSsd+rkY0PeQ5vW7ghJVM7bwaBXLReTm/XykaPq6rxJ3MZp+q9mWojfsu/j
        WyDJ8Xnj65ZjDEcnT//yROdqxLM9h5gzztjfYbRaHvbJWPiYcDnnZ/cbpev65u9Ibz5lXV+v
        xFKckWioxVxUnAgAKJcoghgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvG69EkeywaQj4har7/azWfQ8aWK1
        +Pqw2GLvLW2Ly7vmsFlM3zyH2eLa/TPsFnP+32O1OHfyE6vFvMcOFuv3/mRz4Pa4fLbUo2/L
        KkaPz5vkApijuGxSUnMyy1KL9O0SuDKmLljAXvCWr2L3OdYGxsU8XYycHBICJhIbj5xiBrGF
        BHYwSnRPq4aIS0nMW9vA1sXIAWQLSxw+XNzFyAVU8pFRYt29CWD1bAJaEsufXWAHsUUEciQ+
        tq9iByliFjjAKNF18RYTSEJYIEyibUcXWBGLgKrE44cLGEFsXgFric/LZrBDLJOXOLXsIBNE
        XFDi5MwnLCA2M1C8eets5gmMfLOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66X
        nJ+7iREcrlpaOxj3rPqgd4iRiYPxEKMEB7OSCK/VMZZkId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpjcttt5b1wqKePcbrbPfqGpvULwCtFULaMQXacS
        hbQy3oa1jEE9x7IPp2uFsawWcG0t/+hiKvhI7MPBLa8m3pQ9k7fsAdtqsy/bnrI9Y04VLbM/
        +cFVdtLVsjezY5pCqibOMv/ufuDvHPPS//E77v80de/s59dS5eJje5q1dMf6MNfsXmG5i+LO
        7P+L7Pre8ViU1RZyMq37JPTT8+VN3XTXcz0OK6+UGp++Fz5p3/OzoaePV0yeF3GOK971lZ+y
        gaRkul2KgcXPBz6tW6JU3daGb1nxw/Z5Wbnuyifpy1YfYD2VlXLip7dd8VTzx2ffWseGbDNm
        ZfqxJk0m9mrNHMlw1W2utSm6c5axrup6psRSnJFoqMVcVJwIAOrO9AXGAgAA
X-CMS-MailID: 20220826013143epcas1p36fd947d2f65448f535864329d912f00d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220826013143epcas1p36fd947d2f65448f535864329d912f00d
References: <CGME20220826013143epcas1p36fd947d2f65448f535864329d912f00d@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a request complete then send ipi to original cpu which issued request.
If cpu offline during this process, send_ipi might fail.
However, there is currently no code to handle this error case.
This may cause in missing request complete.
Therefore, if send_ipi fails due to cpu offline, the request complete
has to be processed directly from the cpu where it is running.

Signed-off-by: Manjong Lee <mj0123.lee@samsung.com>
Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
Signed-off-by: Junho Kim <junho89.kim@samsung.com>
---
 block/blk-mq.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3c1e6b6d991d..f2ce79708c5e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1064,17 +1064,22 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	return cpu_online(rq->mq_ctx->cpu);
 }
 
-static void blk_mq_complete_send_ipi(struct request *rq)
+static int blk_mq_complete_send_ipi(struct request *rq)
 {
 	struct llist_head *list;
 	unsigned int cpu;
+	int ret = 0;
 
 	cpu = rq->mq_ctx->cpu;
 	list = &per_cpu(blk_cpu_done, cpu);
 	if (llist_add(&rq->ipi_list, list)) {
 		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(cpu, &rq->csd);
+		ret = smp_call_function_single_async(cpu, &rq->csd);
+		if (ret)
+			llist_del_all(list);
 	}
+
+	return ret;
 }
 
 static void blk_mq_raise_softirq(struct request *rq)
@@ -1099,10 +1104,9 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	if (rq->cmd_flags & REQ_POLLED)
 		return false;
 
-	if (blk_mq_complete_need_ipi(rq)) {
-		blk_mq_complete_send_ipi(rq);
-		return true;
-	}
+	if (blk_mq_complete_need_ipi(rq))
+		if (!blk_mq_complete_send_ipi(rq))
+			return true;
 
 	if (rq->q->nr_hw_queues == 1) {
 		blk_mq_raise_softirq(rq);
-- 
2.32.0

