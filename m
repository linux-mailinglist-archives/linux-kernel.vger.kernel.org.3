Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A94579271
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiGSF0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiGSF0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:26:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237913F60;
        Mon, 18 Jul 2022 22:26:41 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J4xkaI017833;
        Tue, 19 Jul 2022 05:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NFJpky4uco3lbQValaNSmJG54/jhmHCftSq6cGqKwPo=;
 b=Lf5TqBfwXMMsm4Xxg0p8Ng2DxusTn1NR/8xc1LQvOVxtlxqeWsCVHuqi+QVqn72IywdN
 szVCjsRtaB8vrny0HUWogTlee2XE1XaXODPOBk2dDxPLDVYYMcOv6svvs2pJ0ldbx7v9
 pP8mFjjaQEjSnL0gVjsSsP3NZIJOzxsgJcfAW1T9TmYc8l8S/ZLELoCvSkgO6ZRdPWma
 7Hf1w253UugThcVntatp1w1k46vnuW5LEUg98beX6saPW3BabqRcn8idGRCSjbDHumZ7
 7rmyHnsH8JgHzjkR8s40AbUsZeXZywtFWtg/djLsZ6cDBV/KdMm4VlGSNhAMS6LMnRRZ YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdp2wgjky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:32 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26J55XLT010333;
        Tue, 19 Jul 2022 05:26:31 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdp2wgjkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26J5KmH4016644;
        Tue, 19 Jul 2022 05:26:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3hbmkj3hbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:29 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26J5QQj014156184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 05:26:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0666411C054;
        Tue, 19 Jul 2022 05:26:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7CA211C04C;
        Tue, 19 Jul 2022 05:26:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jul 2022 05:26:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 81E65E04D8; Tue, 19 Jul 2022 07:16:36 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 3/4] s390/crash: use static swap buffer for copy_to_user_real()
Date:   Tue, 19 Jul 2022 07:16:35 +0200
Message-Id: <334ed359680c4d45dd32feb104909f610312ef0f.1658206891.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658206891.git.agordeev@linux.ibm.com>
References: <cover.1658206891.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gTSrczo0b3qgh1GEf65CMgfLJ7878cQz
X-Proofpoint-ORIG-GUID: 9WeZ8ZgoP8roDIsHMbuxaCevs4HG48cp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a temporary page-size buffer is allocated for copying
oldmem to user space. That limits copy_to_user_real() operation
only to stages when virtual memory is available and still makes
it possible to fail while the system is being dumped.

Instead of reallocating single page on each copy_oldmem_page()
iteration use a statically allocated buffer.

This also paves the way for a further memcpy_real() rework where
no swap buffer is needed altogether.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/kernel/crash_dump.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 8d7332d4444c..1662f1d81abe 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -53,6 +53,8 @@ struct save_area {
 };
 
 static LIST_HEAD(dump_save_areas);
+static DEFINE_MUTEX(memcpy_real_mutex);
+static char memcpy_real_buf[PAGE_SIZE];
 
 /*
  * Allocate a save area
@@ -178,25 +180,21 @@ int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
  */
 static int copy_to_user_real(void __user *dest, unsigned long src, unsigned long count)
 {
-	int offs = 0, size, rc;
-	char *buf;
+	unsigned long offs = 0, size;
 
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	rc = -EFAULT;
+	mutex_lock(&memcpy_real_mutex);
 	while (offs < count) {
 		size = min(PAGE_SIZE, count - offs);
-		if (memcpy_real(buf, src + offs, size))
-			goto out;
-		if (copy_to_user(dest + offs, buf, size))
-			goto out;
+		if (memcpy_real(memcpy_real_buf, src + offs, size))
+			break;
+		if (copy_to_user(dest + offs, memcpy_real_buf, size))
+			break;
 		offs += size;
 	}
-	rc = 0;
-out:
-	free_page((unsigned long)buf);
-	return rc;
+	mutex_unlock(&memcpy_real_mutex);
+	if (offs < count)
+		return -EFAULT;
+	return 0;
 }
 
 /*
-- 
2.34.1

