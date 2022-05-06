Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84251D93A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392589AbiEFNh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348462AbiEFNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:37:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1465434
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:33:41 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246CMrWk017600;
        Fri, 6 May 2022 13:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WzNHgW5iVxCQdHomxLVtuYuzy8JyzAyqc+xSRsN6EBg=;
 b=gFKMuyZSXmZfFlAyPgnsEzXsy7qQ4LiNI1lfzgET0zNkLc9iYqrY5yU78OZ2m/fkXcXF
 JqxIylm53T8wBBrHCYDHZKWvpGJgo8Frnt5Dss89A5DL2rVZEL/Q+1ZSO0Cq/KLvGkjl
 AjpspWYM7+OCB1ixHAxb7kxGilnQ8pnZ9zb/pnTnOi71pFlae/a6Ckn/xTvXMXfD9MRF
 JAsVNQxOdlzpxYBUJ6/2OjDZ+PkjBCfTe7P2/zXEnd8F5K28uOjMPZXjYaJN8zFBIxF3
 rQtUzKeQ3WSRkW6geNBalrhIUcMW9mZalAjcyHQ9pwS3GfNAvgF/CjiwEVFNnJtSlVkP Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw3mpsewc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 13:33:21 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 246DBqc5031830;
        Fri, 6 May 2022 13:33:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw3mpsevh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 13:33:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 246DSav5017443;
        Fri, 6 May 2022 13:33:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3fvg611bq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 13:33:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246DXGW726608114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 13:33:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17EAD4C044;
        Fri,  6 May 2022 13:33:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 083C24C040;
        Fri,  6 May 2022 13:33:13 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.96.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 May 2022 13:33:12 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org
Cc:     keescook@chromium.org, andriy.shevchenko@linux.intel.com,
        geert@linux-m68k.org, linux@roeck-us.net, adobriyan@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH] kobject: Refactor kobject_set_name_vargs()
Date:   Fri,  6 May 2022 19:03:09 +0530
Message-Id: <20220506133309.36794-1-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tUXogVpOwmLExwNz-TohpRqnHU-eoNAj
X-Proofpoint-ORIG-GUID: 2eDJpC3Q0eMC7kCqAY8stgD8fgbUMtLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_04,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting name as per the format is not only useful for kobjects.
It can also be used to set name for other things for e.g. setting
the name of the struct attribute when multiple same kind of attributes
need to be created with some identifier in name, instead of managing
memory for names at such places case by case, it would be good if
something like current kobject_set_name_vargs() can be utilized.

Refactor kobject_set_name_vargs(), Create a new generic function
set_name_vargs() which can be used for kobjects as well as at
other places.

This patch doesn't introduce any functionality change.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 include/linux/string.h |  1 +
 lib/kobject.c          | 30 +-----------------------------
 mm/util.c              | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b6572aeca2f5..f329962e5ae9 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -9,6 +9,7 @@
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
+int set_name_vargs(const char **name, const char *fmt, va_list vargs);
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
diff --git a/lib/kobject.c b/lib/kobject.c
index 5f0e71ab292c..870d05971e3a 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -249,35 +249,7 @@ static int kobject_add_internal(struct kobject *kobj)
 int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
 				  va_list vargs)
 {
-	const char *s;
-
-	if (kobj->name && !fmt)
-		return 0;
-
-	s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
-	if (!s)
-		return -ENOMEM;
-
-	/*
-	 * ewww... some of these buggers have '/' in the name ... If
-	 * that's the case, we need to make sure we have an actual
-	 * allocated copy to modify, since kvasprintf_const may have
-	 * returned something from .rodata.
-	 */
-	if (strchr(s, '/')) {
-		char *t;
-
-		t = kstrdup(s, GFP_KERNEL);
-		kfree_const(s);
-		if (!t)
-			return -ENOMEM;
-		strreplace(t, '/', '!');
-		s = t;
-	}
-	kfree_const(kobj->name);
-	kobj->name = s;
-
-	return 0;
+	return set_name_vargs(&kobj->name, fmt, vargs);
 }
 
 /**
diff --git a/mm/util.c b/mm/util.c
index 54e5e761a9a9..808d29b17ea7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -112,6 +112,46 @@ char *kstrndup(const char *s, size_t max, gfp_t gfp)
 }
 EXPORT_SYMBOL(kstrndup);
 
+/**
+ * set_name_vargs() - Set the name as per format
+ * @name: pointer to point to the name as per format
+ * @fmt: format string used to build the name
+ * @vargs: vargs to format the string.
+ */
+int set_name_vargs(const char **name, const char *fmt, va_list vargs)
+{
+	const char *s;
+
+	if (*name && !fmt)
+		return 0;
+
+	s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
+	if (!s)
+		return -ENOMEM;
+
+	/*
+	 * ewww... some of these buggers have '/' in the name ... If
+	 * that's the case, we need to make sure we have an actual
+	 * allocated copy to modify, since kvasprintf_const may have
+	 * returned something from .rodata.
+	 */
+	if (strchr(s, '/')) {
+		char *t;
+
+		t = kstrdup(s, GFP_KERNEL);
+		kfree_const(s);
+		if (!t)
+			return -ENOMEM;
+		strreplace(t, '/', '!');
+		s = t;
+	}
+	kfree_const(*name);
+	*name = s;
+
+	return 0;
+}
+EXPORT_SYMBOL(set_name_vargs);
+
 /**
  * kmemdup - duplicate region of memory
  *
-- 
2.35.1

