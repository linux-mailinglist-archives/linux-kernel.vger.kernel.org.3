Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D91569A34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiGGGBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiGGGBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:01:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC853193F;
        Wed,  6 Jul 2022 23:01:30 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2675p1j4028617;
        Thu, 7 Jul 2022 06:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=r+4DyyWIwmB29kB+q0nxSJodNovAfhQsKnsiz6/NTws=;
 b=dhpxReo/vRdRrrT6F5Hb9ieTeqO1rXUT04wTFxkUT2wkzyMgCuchXSt+6IZPHeIlR8N4
 onAyRY3iCeIg/J+EikrqH1lKuv9Ii8okdyxn7KYHxw8gc1kBNMDnu/5rJwt5oakwV6hA
 EAJFTGA1/+ha6+6WBk9IPmSRxM30cjHLQDJ8kDZDQ4wFlxVEYthVi5OJG4euLFLDgZ24
 YMZTl36UoAagKWx7c+9+m+Dcw8r9rDlPwzYXcCfsmVGZS3NIO17icZe2ZFm/Dr6l4Rm2
 n0Kd8k1my3gsTu4AQoACEp2CAmAYH/1R7f45fvexqAbz+BfORkMfcpUUYG4lwt+B3CkF 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5magfh6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 06:01:22 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26760bbN015237;
        Thu, 7 Jul 2022 06:01:22 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5magfh5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 06:01:22 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2675orQI000511;
        Thu, 7 Jul 2022 06:01:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3h4uwp1gx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 06:01:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26761GXN24379712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 06:01:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1DA74C04E;
        Thu,  7 Jul 2022 06:01:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8BE54C04A;
        Thu,  7 Jul 2022 06:01:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Jul 2022 06:01:15 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 99EA1E023B; Thu,  7 Jul 2022 08:01:15 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 1/1] s390/crash: allow multi-segment iterators
Date:   Thu,  7 Jul 2022 08:01:15 +0200
Message-Id: <613f63d652bb4fa6fb3d2bb38762de6bb066b35a.1657172539.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1657172539.git.agordeev@linux.ibm.com>
References: <cover.1657172539.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5JhC1IYHI9yOuwIx1Pstxzxr3LXvPWdN
X-Proofpoint-GUID: c9XmY6TR82sto8V7Z0Ha91EeqNZS0ZIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070023
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
index 28124d0fa1d5..cc1586d64ce2 100644
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
+		({ copy_oldmem_user(base, src + off, len) < 0 ? len : 0; }),
+		({ copy_oldmem_kernel(base, src + off, len) < 0 ? len : 0; })
+	)
 	return csize;
 }
 
-- 
2.34.1

