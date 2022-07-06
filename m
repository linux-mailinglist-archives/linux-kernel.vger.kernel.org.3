Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56584567E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiGFF7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGFF7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:59:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1061612AD2;
        Tue,  5 Jul 2022 22:59:50 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2664ooJA028124;
        Wed, 6 Jul 2022 05:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0vOH6jGpGgt3Gj5yqVmn/Zy0Gay+texlkqj+T8bHMtY=;
 b=I91ohvDPA7zmibfzMyVMoYQmFdEWWFPTFR+FKiYq9HYrbwFHiIeXQFHrOUpYl3+hrK9J
 U21b6hq3wrzqP1cgbfNkqzwx+dJIhdojTt7Rgb0liW+TN9nL1BqrheHfBCQL8iWpCffT
 T45BL01HvGvL0Lycspar6te3LbFxmTu1pLv7YIw/3Bk1mpd/mJUfRqJl0FPo4SKYmmRO
 k3GAVSv/Wo+yaOxPCJNnm5Iyb5FI+af01xRnxUC/MtWsb10gtes3UXz9owzOfY28wCX8
 4qtSPCvnfSYZRjWd+RJnRJIFTzDjMGWJRGoe3JI2NQDOKfF1ZC7oNO0Z12XRgv0t4/nA tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h53qs9cfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 05:59:40 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26659SKH000747;
        Wed, 6 Jul 2022 05:59:40 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h53qs9cf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 05:59:39 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2665q0CH019076;
        Wed, 6 Jul 2022 05:59:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3h4v4jrg9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 05:59:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2665xY8M10748392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 05:59:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47E9942042;
        Wed,  6 Jul 2022 05:59:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3535442041;
        Wed,  6 Jul 2022 05:59:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Jul 2022 05:59:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id D54EEE02F8; Wed,  6 Jul 2022 07:59:33 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 1/1] s390/crash: allow multi-segment iterators
Date:   Wed,  6 Jul 2022 07:59:33 +0200
Message-Id: <3e713ce3865246766feca8397af2860cbe46854d.1657049033.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1657049033.git.agordeev@linux.ibm.com>
References: <cover.1657049033.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MfM3IyYKNa-KKxwMjbZi4PKiuqo5twjL
X-Proofpoint-ORIG-GUID: NS5iKenvfA34x_fQxTDx58bNUelv8WWf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_02,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060020
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework copy_oldmem_page() to allow multi-segment iterators.
Reuse existing iterate_iovec macro as is and only relevant
bits from __iterate_and_advance macro.

Fixes: 49b11524d648 ("s390/crash: add missing iterator advance in copy_oldmem_page())
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/kernel/crash_dump.c | 65 +++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 28124d0fa1d5..ac873245d6f0 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -210,6 +210,52 @@ static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
 	return 0;
 }
 
+#define iterate_iovec(i, n, base, len, off, __p, STEP) {	\
+	size_t off = 0;						\
+	size_t skip = i->iov_offset;				\
+	do {							\
+		len = min(n, __p->iov_len - skip);		\
+		if (likely(len)) {				\
+			base = __p->iov_base + skip;		\
+			len -= (STEP);				\
+			off += len;				\
+			skip += len;				\
+			n -= len;				\
+			if (skip < __p->iov_len)		\
+				break;				\
+		}						\
+		__p++;						\
+		skip = 0;					\
+	} while (n);						\
+	i->iov_offset = skip;					\
+	n = off;						\
+}
+
+#define __iterate_and_advance(i, n, base, len, off, I, K) {	\
+	if (unlikely(i->count < n))				\
+		n = i->count;					\
+	if (likely(n)) {					\
+		if (likely(iter_is_iovec(i))) {			\
+			const struct iovec *iov = i->iov;	\
+			void __user *base;			\
+			size_t len;				\
+			iterate_iovec(i, n, base, len, off,	\
+						iov, (I))	\
+			i->nr_segs -= iov - i->iov;		\
+			i->iov = iov;				\
+		} else if (iov_iter_is_kvec(i)) {		\
+			const struct kvec *kvec = i->kvec;	\
+			void *base;				\
+			size_t len;				\
+			iterate_iovec(i, n, base, len, off,	\
+						kvec, (K))	\
+			i->nr_segs -= kvec - i->kvec;		\
+			i->kvec = kvec;				\
+		}						\
+		i->count -= n;					\
+	}							\
+}
+
 /*
  * Copy one page from "oldmem"
  */
@@ -217,25 +263,14 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
 			 unsigned long offset)
 {
 	unsigned long src;
-	int rc;
 
 	if (!(iter_is_iovec(iter) || iov_iter_is_kvec(iter)))
 		return -EINVAL;
-	/* Multi-segment iterators are not supported */
-	if (iter->nr_segs > 1)
-		return -EINVAL;
-	if (!csize)
-		return 0;
 	src = pfn_to_phys(pfn) + offset;
-
-	/* XXX: pass the iov_iter down to a common function */
-	if (iter_is_iovec(iter))
-		rc = copy_oldmem_user(iter->iov->iov_base, src, csize);
-	else
-		rc = copy_oldmem_kernel(iter->kvec->iov_base, src, csize);
-	if (rc < 0)
-		return rc;
-	iov_iter_advance(iter, csize);
+	__iterate_and_advance(iter, csize, base, len, off,
+		({ copy_oldmem_user(base, src + off, len) < 0 ? csize : 0; }),
+		({ copy_oldmem_kernel(base, src + off, len) < 0 ? csize : 0; })
+	)
 	return csize;
 }
 
-- 
2.34.1

