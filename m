Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6427C51421A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354348AbiD2GCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiD2GCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:02:20 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D008B18B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:59:02 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220429055858epoutp01d20a4cce72839e03bcf0a0c6c4248b62~qSIJwvfyX2999129991epoutp018
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:58:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220429055858epoutp01d20a4cce72839e03bcf0a0c6c4248b62~qSIJwvfyX2999129991epoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651211938;
        bh=7VNqedSgdU0I1pkagRB5zQzJa9VgyyV3FEglDrDcLpU=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=sBXN48SyXpYLCAWu3fAceiJvLeris7/SuwyDCU2LDidx9J1pmHjte1rqAXvCIrICf
         h0G0Fgkvo1kxdiqle2nNXyuvzb8K92JaVScJx0swkoIUeYEi9FHuLgN9nYQNeE4stm
         VZ3jOe+n5h5apxM7EzS13jbqgTRpxo9amUSpalqQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220429055857epcas2p27b4e3b79a24ff7ae70863ef86dd8f8cc~qSIJHYWxF0125601256epcas2p2t;
        Fri, 29 Apr 2022 05:58:57 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KqMHg2Vs5z4x9QV; Fri, 29 Apr
        2022 05:58:55 +0000 (GMT)
X-AuditID: b6c32a46-f8bff70000002624-7a-626b7e9f94b0
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.54.09764.F9E7B626; Fri, 29 Apr 2022 14:58:55 +0900 (KST)
Mime-Version: 1.0
Subject: [RESEND PATCH v2] block-map: added error handling for
 bio_copy_kern()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220429055854epcms2p7e5045065a4732fb59b0fb1345c348a45@epcms2p7>
Date:   Fri, 29 Apr 2022 14:58:54 +0900
X-CMS-MailID: 20220429055854epcms2p7e5045065a4732fb59b0fb1345c348a45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmhe78uuwkg+UvuSxW3+1ns3h5SNPi
        RstjZotHt58xWpyesIjJord/K5vF3lvaFpd3zWFz4PDYvELL4/LZUo++LasYPT5vkgtgicq2
        yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6QUmhLDGn
        FCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQndF1
        8jVbwV+eiv1/5rA0MB7i6mLk5JAQMJHYsPkoexcjF4eQwA5Gie7XX9i6GDk4eAUEJf7uEAap
        ERYIkNg6ZzsLiC0koCRxbs0sRpASYQEDiVu95iBhNgE9iZ9LZrCBjBERWM4ocXj9TUaQBLOA
        tsTvo49YIXbxSsxof8oCYUtLbF++lRHC1pD4sayXGcIWlbi5+i07jP3+2HyoGhGJ1ntnoWoE
        JR783A0Vl5Q4dOgr2MkSAvkSGw4EQoRrJN4uPwBVoi9xrWMj2FpeAV+JtSungdksAqoSf74c
        gqpxkejaCXOyvMT2t3OYQUYyC2hKrN+lDzFdWeLILRaYRxo2/mZHZzML8El0HP4LF98x7wkT
        RKuaxKImI4iwjMTXw/PZJzAqzUKE8iwka2chrF3AyLyKUSy1oDg3PbXYqMAIHrHJ+bmbGMEp
        UcttB+OUtx/0DjEycTAeYpTgYFYS4f2yOyNJiDclsbIqtSg/vqg0J7X4EKMp0MMTmaVEk/OB
        STmvJN7QxNLAxMzM0NzI1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwenVAPTVMOGnbatu8Rq
        9lyN+5r1t5ThcyK/h8qTMAdNMZcjKd/sHVWLV66am/nE+LRL44OG3yH1jB8KKpZ1fN2yW3DC
        87k8mkLb7sqx2y2MehiZInLr6lbNWG7ZEIkjuvmNTNusl1c/0baYteVddLTwb6fOPY0pv7XN
        0mP4/bSfVbo8vvawZPb9g4JLL8z/f6Dxt5jsHKP9KRPDcy7c7dVftCz6LLvGp7iU2R48CzbP
        WCQteEphff0SkaM1Vf7d74vDVqVnT5t5fz67wltXh+PVf+37qyNMC8RVNujsvO15+ZVP1Tbn
        LIn1ia97VBYEZuT5K85tjD696OejnsdxJxu/6b1w3tAxWZ+Nj0d8hY/pOz4lluKMREMt5qLi
        RADE6GqkEgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220429055854epcms2p7e5045065a4732fb59b0fb1345c348a45
References: <CGME20220429055854epcms2p7e5045065a4732fb59b0fb1345c348a45@epcms2p7>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When new pages are allocated to bio through alloc_page() in
bio_copy_kern(), the pages must be freed in error handling after that.

There is little chance of an error occurring in blk_rq_append_bio(), but
in the code flow, pages additionally allocated to bio must be released.

V2:
	- replace int with bool

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/blk-map.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index df8b066cd548..613990fa87e1 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -637,6 +637,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
 	int reading = rq_data_dir(rq) == READ;
 	unsigned long addr = (unsigned long) kbuf;
 	struct bio *bio;
+	bool do_copy;
 	int ret;
 
 	if (len > (queue_max_hw_sectors(q) << 9))
@@ -644,8 +645,9 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
 	if (!len || !kbuf)
 		return -EINVAL;
 
-	if (!blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf) ||
-	    blk_queue_may_bounce(q))
+	do_copy = !blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf) ||
+		blk_queue_may_bounce(q);
+	if (do_copy)
 		bio = bio_copy_kern(q, kbuf, len, gfp_mask, reading);
 	else
 		bio = bio_map_kern(q, kbuf, len, gfp_mask);
@@ -658,6 +660,8 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
 
 	ret = blk_rq_append_bio(rq, bio);
 	if (unlikely(ret)) {
+		if (do_copy)
+			bio_free_pages(bio);
 		bio_uninit(bio);
 		kfree(bio);
 	}
-- 
2.25.1
