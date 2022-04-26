Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C545104D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353612AbiDZREs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353595AbiDZREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:04:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4426A84EE1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:01:25 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QGDmQV024917;
        Tue, 26 Apr 2022 17:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WDCGK/IcpWNs6OkJN2DBsMDyG2tp3v74t5AXVLXHQOk=;
 b=acXBBq/kwnl/NGGLVB6ePS/Bsbwcbr5+e0VkUo7WpwW0+eAgdMMHS8qL6OaTnn3IdEfo
 b1Il5JgZVEHohBOiOHudZVYfmIkyTOhxnC+ki2ubLmEp+0B4bQW3REifqCXn3M+nv0Qs
 GjLSduiAqwuODzDGoh7/E5/ovKCAvtebJ4md4sDzmp1+PXjAU3Ids0qalK5hM/Vmp2ii
 YRAi5delJNvyGxvEeAsLpMoB5XYA8ezXs5dyarNN+EgLutmR0ktJjNMGAYEXTv+aQN5V
 IQENmDWtfQFbsyvdx1Etl2RiIWkhcdfQyYVUkysdXfEbwNEd0bip2mhWUFRLUulpQT7P vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpm2v8uqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 17:00:52 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QGlaUI021701;
        Tue, 26 Apr 2022 17:00:52 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpm2v8upn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 17:00:52 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QGwrHu027314;
        Tue, 26 Apr 2022 17:00:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3fm938uqap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 17:00:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QH0lK730081392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 17:00:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AED9EAE053;
        Tue, 26 Apr 2022 17:00:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56FACAE04D;
        Tue, 26 Apr 2022 17:00:43 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.22.196])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 17:00:43 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, pmladek@suse.com, ying.huang@intel.com,
        dave.hansen@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v2 1/2] lib/kstrtox.c: Add "false"/"true" support to  kstrtobool()
Date:   Tue, 26 Apr 2022 22:30:39 +0530
Message-Id: <20220426170040.65487-1-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AsBBaTYPSUo1s4s95IviQVD6AfI1fw8N
X-Proofpoint-ORIG-GUID: JKz3zSfmsyjYG71kQVhqdMuSvLn7gfQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260105
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
---
Chnage in v2:
- kstrtobool to kstrtobool() in commit message.
- Split single patch into 2
- Remove strcmp usage and instead compare 1st character only.

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

