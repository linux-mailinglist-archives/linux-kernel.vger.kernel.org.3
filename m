Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4463510635
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbiDZSGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349973AbiDZSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:06:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D1827CE9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:02:51 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QGhSx6013516;
        Tue, 26 Apr 2022 18:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+iKxtjbBize+7FxPvSlI7lCl5sC17EfaqBFmnZDb4nY=;
 b=diA2FIo15pkTixgnHW6wQxN8SNUlGL86t21KBga70E1htrApin6PuU/hvfjwfOKAPQOu
 3eHdT7kkyJZWvKqTHS3nFtq7b9cBo/M6CaipEel9pjid787biP2mDXknMYyTSvKYfIHC
 jHMODrW00Kv/vnwc3QSmZQrmekm17uoUIZLPSGVlPlPWhnQb3pst/WaFEcb2N50ColMc
 8vn2GfwnxUKapSnwWYCgQClNISrLZSL1gMdV3DvoGT8BJQ1EUP25R5+MDBFcUAY+8V5y
 LJ3xVZABGpmCtmHmYT6jHpfSlksmjfL16d6KHpZtMJbOfPLHVIHa9R2v1IPsAnaXxTXM rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpj9rmwav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 18:02:17 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QHokM9004047;
        Tue, 26 Apr 2022 18:02:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpj9rmw9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 18:02:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QHx9ei010471;
        Tue, 26 Apr 2022 18:02:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938vs6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 18:02:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QI2C9x58982832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 18:02:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C92DAE051;
        Tue, 26 Apr 2022 18:02:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E938AAE045;
        Tue, 26 Apr 2022 18:02:07 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.119.104])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 18:02:07 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     willy@infradead.org, ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, pmladek@suse.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to kstrtobool()
Date:   Tue, 26 Apr 2022 23:32:02 +0530
Message-Id: <20220426180203.70782-1-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5tLog6bKdJuMqYCBHq6hi2V1b8ShjwCE
X-Proofpoint-ORIG-GUID: Iqhq7bIJmgmGZ1M2ZP_P4ywfi-dB0c6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1011 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At many places in kernel, It is necessary to convert sysfs input
to corrosponding bool value e.g. "false" or "0" need to be converted
to bool false, "true" or "1" need to be converted to bool true,
places where such conversion is needed currently check the input
string manually, kstrtobool() can be utilized at such places but
currently it doesn't have support to accept "false"/"true".

Add support to accept "false"/"true" as valid string in kstrtobool().

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
Chnages in v2:
- kstrtobool to kstrtobool() in commit message.
- Split single patch into 2
- Remove strcmp usage from kstrtobool() and instead compare 1st
  character only.

Changes in v3:
- Covert -> Convert in patch 2 subject
- Collected Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

 lib/kstrtox.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 886510d248e5..465e31e4d70d 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -340,7 +340,7 @@ EXPORT_SYMBOL(kstrtos8);
  * @s: input string
  * @res: result
  *
- * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
+ * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or
  * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
  * pointed to by res is updated upon finding a match.
  */
@@ -353,11 +353,15 @@ int kstrtobool(const char *s, bool *res)
 	switch (s[0]) {
 	case 'y':
 	case 'Y':
+	case 't':
+	case 'T':
 	case '1':
 		*res = true;
 		return 0;
 	case 'n':
 	case 'N':
+	case 'f':
+	case 'F':
 	case '0':
 		*res = false;
 		return 0;
-- 
2.35.1

