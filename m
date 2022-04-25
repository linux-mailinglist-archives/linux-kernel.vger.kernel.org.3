Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4C050DBB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiDYI4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiDYIz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:55:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F06E0DB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:52:54 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P6AuXc016852;
        Mon, 25 Apr 2022 08:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=07zn5sdc5RwJAHIT/a4gQPJf5/nDCu2e2UAv7dWlQlU=;
 b=cFPVZ0H65KLflGUMCAASjhvmwpL1z6v80vU/n0frbSBKjrfg0E8awK1De2iIJiEoWbhG
 j6nV6ToMuFHYw8sOqX2ncbiJd/ZCtTHBVTuGBUsHlTYUzjrRvdZbrzjmMyHrTD2aAEAR
 E+vDi6Hy8MovZfIlubdhnyHU9j/169gS51gs31PnY+lq5khvIwBtVatquKxQtCrNYSU8
 Sya/Q5NshiLFA6QoFHUMUfpG0ErS9Eru/7iLFjrZLQtnKlHchsmkyGXqFGwEUkFw9rVQ
 Ii5bl7z/vADIW6UNisoKnJLlcuKpRogaNlmeSl/NmQbYaQHbvkmbyyp7fqdOADEQr/Ck vw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmuddm1ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 08:52:43 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23P8nZOH019260;
        Mon, 25 Apr 2022 08:52:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fm8qhhpyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 08:52:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23P8qcWZ42139974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 08:52:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1AF952050;
        Mon, 25 Apr 2022 08:52:38 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.47.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5AC605204E;
        Mon, 25 Apr 2022 08:52:36 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     andy@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     minchan@kernel.org, ying.huang@intel.com, dave.hansen@intel.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [RESEND PATCH] string_helpers: sysfs: Add helper to get bool from string
Date:   Mon, 25 Apr 2022 14:22:33 +0530
Message-Id: <20220425085233.82576-1-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eXeCMTjS6e25Q_eAbBxKa14A7imBUKkG
X-Proofpoint-GUID: eXeCMTjS6e25Q_eAbBxKa14A7imBUKkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_05,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204250038
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
string manually. Also, such conversions compare sysfs input using
strncmp functions so even if certain number of character match in the
beginning, they assume the string as valid bool, which is not the
right semantic e.g. false is bool but falseX is not.

Introduce new string helper function to convert sysfs input to
corrosponding bool value. Modify existing such conversions to use
this new function.

logs,
$ cat /sys/kernel/mm/numa/demotion_enabled
false
$ echo true > /sys/kernel/mm/numa/demotion_enabled
$ cat demotion_enabled
true
$ echo truex > /sys/kernel/mm/numa/demotion_enabled
-bash: echo: write error: Invalid argument
$ echo 10 > /sys/kernel/mm/numa/demotion_enabled
-bash: echo: write error: Invalid argument
$ echo false > /sys/kernel/mm/numa/demotion_enabled
$ cat demotion_enabled
false
$ echo falseabc > /sys/kernel/mm/numa/demotion_enabled
-bash: echo: write error: Invalid argument
$ echo 1 > /sys/kernel/mm/numa/demotion_enabled
$ cat demotion_enabled
true
$ echo 0 > /sys/kernel/mm/numa/demotion_enabled
$ cat demotion_enabled
false

This patch doesn't have any functionality change.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
Resending as initially forgot to add linux-mm in recipients.

 include/linux/string.h |  1 +
 lib/string_helpers.c   | 20 ++++++++++++++++++++
 mm/migrate.c           |  7 ++-----
 mm/swap_state.c        |  6 +-----
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b6572aeca2f5..3c00991b456a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -170,6 +170,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *s, char old, char new);
+int sysfs_strbool(const char *s, bool *output);
 
 extern void kfree_const(const void *x);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 4f877e9551d5..cd3580b7ea06 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -967,6 +967,26 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
 }
 EXPORT_SYMBOL(memcpy_and_pad);
 
+/**
+ * sysfs_strbool - Get bool value corrosponding to string
+ * @s: The string to operate on.
+ * @output: Pointer to fill resulting bool value
+ *
+ * Returns 1 if string represents bool value, 0 otherwise
+ */
+int sysfs_strbool(const char *s, bool *output)
+{
+	if (sysfs_streq(s, "1") || sysfs_streq(s, "true"))
+		*output = true;
+	else if (sysfs_streq(s, "0") || sysfs_streq(s, "false"))
+		*output = false;
+	else
+		return 0;
+
+	return 1;
+}
+EXPORT_SYMBOL(sysfs_strbool);
+
 #ifdef CONFIG_FORTIFY_SOURCE
 /* These are placeholders for fortify compile-time warnings. */
 void __read_overflow2_field(size_t avail, size_t wanted) { }
diff --git a/mm/migrate.c b/mm/migrate.c
index 6c31ee1e1c9b..a5b105144016 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -49,6 +49,7 @@
 #include <linux/oom.h>
 #include <linux/memory.h>
 #include <linux/random.h>
+#include <linux/string.h>
 #include <linux/sched/sysctl.h>
 
 #include <asm/tlbflush.h>
@@ -2523,11 +2524,7 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
 					   struct kobj_attribute *attr,
 					   const char *buf, size_t count)
 {
-	if (!strncmp(buf, "true", 4) || !strncmp(buf, "1", 1))
-		numa_demotion_enabled = true;
-	else if (!strncmp(buf, "false", 5) || !strncmp(buf, "0", 1))
-		numa_demotion_enabled = false;
-	else
+	if (!sysfs_strbool(buf, &numa_demotion_enabled))
 		return -EINVAL;
 
 	return count;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 013856004825..4f439845d176 100644
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
+	if (!sysfs_strbool(buf, &enable_vma_readahead))
 		return -EINVAL;
 
 	return count;
-- 
2.35.1

