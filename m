Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B934B5630E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiGAKC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiGAKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:02:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4776F72EEE;
        Fri,  1 Jul 2022 03:02:21 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2619k4ro029640;
        Fri, 1 Jul 2022 10:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wh+fhr8nZolJDLmLCry384wHxe5PRc0fzXZJIkpax6U=;
 b=AbUBYsi1+WeoBfm1D5RyLpaQg71N199g8k8iWAO/+Wk1k6yLv4bMIhWQakFBFQmOalMm
 +TpuE0/IFyXhSSLs3aMSeXkf+TbXnP7cRdy0Uu2ZRnMZeMZv4+sxgNKpV3fWqSi7YHCC
 fG2HnIGzEfNCp6Jvudm/O8m8J2ak3jdV3lPsn2fgINd6W1KImFAqDWq9zXeIgw+z0PnP
 G+7ZyS84L29R31KxfZQoFemeH6UsIwFItDXdw3CFjRbvJY1IExEEu3C8XrQRcjqgv1S5
 6PRAhMjlNpI3FTAJ+McyY5tB2zEBkpJXpOGjwsrjeiDBN1LcKwoiKago6cht26MmCXoo gQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1xk68cc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 10:02:19 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2619pOC0000645;
        Fri, 1 Jul 2022 10:02:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt091gd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 10:02:16 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 261A2Ebt22806982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 10:02:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B76AE045;
        Fri,  1 Jul 2022 10:02:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45561AE04D;
        Fri,  1 Jul 2022 10:02:13 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 10:02:13 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH 2/2] drivers/s390/char/uvdevice: Autoload module based on CPU feature
Date:   Fri,  1 Jul 2022 12:02:10 +0200
Message-Id: <20220701100210.5482-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701100210.5482-1-seiden@linux.ibm.com>
References: <20220701100210.5482-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O8NYqIyYeptVFbhOsqTYSiVe9MfqVqWC
X-Proofpoint-GUID: O8NYqIyYeptVFbhOsqTYSiVe9MfqVqWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch the uvdevice will be automatically loaded when the
HWCAP_UV bit is set.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 drivers/s390/char/uvdevice.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 66505d7166a6..fddbfc1e27a2 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -27,6 +27,7 @@
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/cpufeature.h>
 
 #include <asm/uvdevice.h>
 #include <asm/uv.h>
@@ -244,12 +245,10 @@ static void __exit uvio_dev_exit(void)
 
 static int __init uvio_dev_init(void)
 {
-	if (!test_facility(158))
-		return -ENXIO;
 	return misc_register(&uvio_dev_miscdev);
 }
 
-module_init(uvio_dev_init);
+module_cpu_feature_match(UV, uvio_dev_init);
 module_exit(uvio_dev_exit);
 
 MODULE_AUTHOR("IBM Corporation");
-- 
2.35.3

