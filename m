Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73A50F13F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245472AbiDZGnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245469AbiDZGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:43:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B953F65BC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:40:32 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q5ix1N020783;
        Tue, 26 Apr 2022 06:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NWqmAoCx25RXlrFYj/b2cYqlm2/7aRzSFJoALrjpqAQ=;
 b=lz9UW2IatHOjDEPS5xXcidEw1oUPa/ZKJIY3soZFj5rOu25T2ddyNWsO803oVcVuUZbt
 n2BMY7I7TjEYl0YKPf5i7hFIgXHNHRja/OTNmfifSYaFQe/O5pNwZGIjE/qT81CGXojG
 M9BPxtsQOx3W3loQlZpUSf5gHL6PrmO102Faw3vY6IVq477kYfU9aj5m0bQp9fC1NQuY
 CdnjZnkJ5+aW6YjT4WDG2ZUNdsIPZSWUmPNAJugdbjl12yT32DFPYHGe0jdTdQeEqVfS
 b/nYVg3iIjmI6aGd4+joR40Pd+EdL9OVMhSaWzVvEf9Vb/zLAFfBQ7JiVqXTdRX7/9YW CQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpav30xbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 06:40:23 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q6cOZB011563;
        Tue, 26 Apr 2022 06:40:21 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj3rbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 06:40:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q6eIMU44368148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 06:40:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 991A0AE04D;
        Tue, 26 Apr 2022 06:40:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FE66AE045;
        Tue, 26 Apr 2022 06:40:15 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.82.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 06:40:15 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     ying.huang@intel.com, dave.hansen@intel.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2] lib/kstrtox.c: Add "false"/"true" support to kstrtobool
Date:   Tue, 26 Apr 2022 12:10:01 +0530
Message-Id: <20220426064001.14241-1-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YVc7XaHVGxqbkxg8V64KbB2WpeNm2Y3e
X-Proofpoint-GUID: YVc7XaHVGxqbkxg8V64KbB2WpeNm2Y3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260042
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
string manually, kstrtobool can be utilized at such places but
currently kstrtobool doesn't have support to "false"/"true".

Add "false"/"true" support to kstrtobool while string conversion
to bool. Modify existing manual sysfs conversions to use kstrtobool().

This patch doesn't have any functionality change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
change in v2:
Modified kstrtobool to handle "false"/"true". Removed
new function sysfs_strbool introduced in v1.

 lib/kstrtox.c   | 7 +++++++
 mm/migrate.c    | 6 +-----
 mm/swap_state.c | 6 +-----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 886510d248e5..3a5e29557838 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -377,6 +377,13 @@ int kstrtobool(const char *s, bool *res)
 		}
 		break;
 	default:
+		if (!strncmp(s, "true", 4)) {
+			*res = true;
+			return 0;
+		} else if (!strncmp(s, "false", 5)) {
+			*res = false;
+			return 0;
+		}
 		break;
 	}
 
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

