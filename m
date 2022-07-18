Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3275783FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiGRNmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiGRNmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:42:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352C9205EF;
        Mon, 18 Jul 2022 06:42:00 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ID4Yqw010853;
        Mon, 18 Jul 2022 13:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=z3tJjdpL0+XtAbdTT02pUJH7mrIRQOS4RQYVy9mn/+I=;
 b=cTf7/sOlWyDN/lzV78asG0qmDk+n48znGE8sOBQbr6JLzn4G3WEBVY5rrMTp8o3MkSmi
 CSLck0DhMoSFo5/Yu1xe8x4w0oxFUHfXrP5QQSy+A/DiLPgTNLiFLbU3hKQgqaaZuwEK
 xnIdrOYLIXJrTarQ7OJlpMO4AhFb9BIbZ6X++BjJ1JBQ83FPQ+C5RkD5aeQzDZXnUhJV
 2tOH1BrMERNzjy6QaUrW4ZmjfhkE83JpbQXlgKzEFjrB2DmsRq2HY6vo1jxJaTMQRZVn
 APSKC8Ucagv3pG+RLyANUSal58NgtoSlXmtbpGdHZU5OiU5jFcbFZUbhFyz+wjpR5TKW 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd8371q7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:52 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26ID4oUg017721;
        Mon, 18 Jul 2022 13:41:43 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd8371pg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:43 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26IDLXsV005080;
        Mon, 18 Jul 2022 13:41:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3hbmy8j1ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26IDfNns16777598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:41:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F8CC42041;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B6C14203F;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 7293FE02A8; Mon, 18 Jul 2022 15:32:41 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 2/3] s390/crash: use static swap buffer for copy_to_user_real()
Date:   Mon, 18 Jul 2022 15:32:40 +0200
Message-Id: <77d50b4a2359d1791835b6111edaa155eb11c5ea.1658148067.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658148067.git.agordeev@linux.ibm.com>
References: <cover.1658148067.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mnfQqe1d_wwsOKUeIcZD9zKGoEoT8pNW
X-Proofpoint-GUID: KeznBNHQoCe01GpFto3CN86eUVD_w23B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180058
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
 arch/s390/kernel/crash_dump.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 8d7332d4444c..fd9fe93e48b6 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -53,6 +53,7 @@ struct save_area {
 };
 
 static LIST_HEAD(dump_save_areas);
+static char memcpy_real_buf[PAGE_SIZE];
 
 /*
  * Allocate a save area
@@ -179,23 +180,18 @@ int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
 static int copy_to_user_real(void __user *dest, unsigned long src, unsigned long count)
 {
 	int offs = 0, size, rc;
-	char *buf;
 
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
 	rc = -EFAULT;
 	while (offs < count) {
 		size = min(PAGE_SIZE, count - offs);
-		if (memcpy_real(buf, src + offs, size))
+		if (memcpy_real(memcpy_real_buf, src + offs, size))
 			goto out;
-		if (copy_to_user(dest + offs, buf, size))
+		if (copy_to_user(dest + offs, memcpy_real_buf, size))
 			goto out;
 		offs += size;
 	}
 	rc = 0;
 out:
-	free_page((unsigned long)buf);
 	return rc;
 }
 
-- 
2.34.1

