Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8865104D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353586AbiDZREp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353588AbiDZREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:04:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AE982D3E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:01:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QEwOnQ035953;
        Tue, 26 Apr 2022 17:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uZLHwpk0BRjHxTvIBr0wnDR/zRIyaEq3tSVHnRYpoAU=;
 b=AYi4hFXopIeGv3tIukuUBvaIr3jibSGpkRGFhESm6l0y0o1t7wv8hllh7Wokjd80m+F2
 0REp9iQ8Fan5vBDiSeD3GJBJ5svytA1KPYqguRt6LjKpcowbFAIw7iQF7IlRd6EsM9LI
 8peS4864btMDPqB9yHbCerZfpHz4fOHrvTFP3YV49DmUHEWw9pSuEq+Mb5qmOLDB2qwY
 dVtFqhPdQa2Hsmc1cye41tJNs65ckycUOdHj5BbLQjY1ppHekaaaR6nGBRDBqEbtDYWF
 x18NldbPF5+tDAZ4MeP5o4j0T/XFloNYkYJuGSmXw5eqquEjVdCR0w0RnSrKSsLI7cUn Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpjy92j2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 17:01:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QGjwlr039005;
        Tue, 26 Apr 2022 17:01:02 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpjy92hyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 17:01:02 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QGwWSf020930;
        Tue, 26 Apr 2022 17:00:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3fm938upsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 17:00:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QH0pKX45089268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 17:00:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0303AE04D;
        Tue, 26 Apr 2022 17:00:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BBB4AE051;
        Tue, 26 Apr 2022 17:00:48 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.22.196])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 17:00:47 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, pmladek@suse.com, ying.huang@intel.com,
        dave.hansen@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v2 2/2] mm: Covert sysfs input to bool using kstrtobool()
Date:   Tue, 26 Apr 2022 22:30:40 +0530
Message-Id: <20220426170040.65487-2-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426170040.65487-1-jvgediya@linux.ibm.com>
References: <20220426170040.65487-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RANTjyTVFUKebb1_PaFwBOAG2tr2UHSa
X-Proofpoint-GUID: UN_ss-OLAKMm83zUZIyqNgTqAOmzW6h_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs input conversion to corrosponding bool value e.g. "false" or "0"
to false, "true" or "1" to true are currently handled through strncmp
at multiple places. Use kstrtobool() to convert sysfs input to bool
value.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
Chnage in v2:
- kstrtobool to kstrtobool() in commit message.
- Split single patch into 2
- Remove strcmp usage and instead compare 1st character only.

 mm/migrate.c    | 6 +-----
 mm/swap_state.c | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6c31ee1e1c9b..1de39bbfd6f9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2523,11 +2523,7 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
 					   struct kobj_attribute *attr,
 					   const char *buf, size_t count)
 {
-	if (!strncmp(buf, "true", 4) || !strncmp(buf, "1", 1))
-		numa_demotion_enabled = true;
-	else if (!strncmp(buf, "false", 5) || !strncmp(buf, "0", 1))
-		numa_demotion_enabled = false;
-	else
+	if (kstrtobool(buf, &numa_demotion_enabled))
 		return -EINVAL;
 
 	return count;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 013856004825..dba10045a825 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -865,11 +865,7 @@ static ssize_t vma_ra_enabled_store(struct kobject *kobj,
 				      struct kobj_attribute *attr,
 				      const char *buf, size_t count)
 {
-	if (!strncmp(buf, "true", 4) || !strncmp(buf, "1", 1))
-		enable_vma_readahead = true;
-	else if (!strncmp(buf, "false", 5) || !strncmp(buf, "0", 1))
-		enable_vma_readahead = false;
-	else
+	if (kstrtobool(buf, &enable_vma_readahead))
 		return -EINVAL;
 
 	return count;
-- 
2.35.1

