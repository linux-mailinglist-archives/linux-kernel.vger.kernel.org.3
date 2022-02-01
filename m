Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0784A6620
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242558AbiBAUjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:39:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240590AbiBAUiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Js5JF015035;
        Tue, 1 Feb 2022 20:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fAMxsDN5yAKGq51Ms+DTdSBlc970umAzLdLfup6riRE=;
 b=Y83GSmSLPPPERf0DecLuPFN3BGT5s2DekhDepS0+lVHnnGgxqzK2pB4gMBNFvom0rmDK
 q5s02Thn0TpRwKmainngnhl1XO405nzEGBaak2JmWkbJkrcmfVuxgNLpjM9TQAqrvHbD
 55ezsDALCee5bAFHYrF4xw2/7gZU02Iw1pK6HLBNRjhRyv51BysLQEJLqR8QmHaWSiJZ
 X4OS+0Tf7TvaEh7n4iLpniGzAKjg/i6lX9ftkmjxg0ny1mnOJg6fJirZ15xxSEzsm3RY
 pBP8KGs9LcScEvp4GivfIk++ktKjaLN67fCMHqj4Dg/CYvO63Z95xYi+iJghd5xKETxo +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dybe58q2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:55 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211KbEPl016002;
        Tue, 1 Feb 2022 20:37:55 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dybe58q2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:55 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KWNY4028191;
        Tue, 1 Feb 2022 20:37:54 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3dy0swgmnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211KboQG29425940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69C1FB206B;
        Tue,  1 Feb 2022 20:37:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55887B2070;
        Tue,  1 Feb 2022 20:37:50 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:50 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v10 09/27] ima: Move some IMA policy and filesystem related variables into ima_namespace
Date:   Tue,  1 Feb 2022 15:37:17 -0500
Message-Id: <20220201203735.164593-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qu2BlZEdpjsJbCyBuL1nWA9XM92RxncK
X-Proofpoint-ORIG-GUID: OvoXmehdE6JyYrYqIhR02mauG3YH6osi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the variables ima_write_mutex, ima_fs_flag, and valid_policy, which
are related to updating the IMA policy, into the ima_namespace. This way
each IMA namespace can set these variables independently in its instance
of securityfs.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 security/integrity/ima/ima.h             |  5 ++++
 security/integrity/ima/ima_fs.c          | 32 +++++++++++-------------
 security/integrity/ima/ima_init_ima_ns.c |  4 +++
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 45706836a77b..1092c926daf9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -137,6 +137,11 @@ struct ima_namespace {
 	struct ima_h_table ima_htable;
 	struct list_head ima_measurements;	/* list of all measurements */
 	unsigned long binary_runtime_size;	/* used by init_ima_ns */
+
+	/* securityfs support related variables */
+	struct mutex ima_write_mutex;
+	unsigned long ima_fs_flags;
+	int valid_policy;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 5ef0e2b2cf64..4cf786f0bba8 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -24,8 +24,6 @@
 
 #include "ima.h"
 
-static DEFINE_MUTEX(ima_write_mutex);
-
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -36,8 +34,6 @@ static int __init default_canonical_fmt_setup(char *str)
 }
 __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
-static int valid_policy = 1;
-
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
@@ -338,7 +334,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	result = mutex_lock_interruptible(&ima_write_mutex);
+	result = mutex_lock_interruptible(&ns->ima_write_mutex);
 	if (result < 0)
 		goto out_free;
 
@@ -353,12 +349,12 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	} else {
 		result = ima_parse_add_rule(ns, data);
 	}
-	mutex_unlock(&ima_write_mutex);
+	mutex_unlock(&ns->ima_write_mutex);
 out_free:
 	kfree(data);
 out:
 	if (result < 0)
-		valid_policy = 0;
+		ns->valid_policy = 0;
 
 	return result;
 }
@@ -375,8 +371,6 @@ enum ima_fs_flags {
 	IMA_FS_BUSY,
 };
 
-static unsigned long ima_fs_flags;
-
 #ifdef	CONFIG_IMA_READ_POLICY
 static const struct seq_operations ima_policy_seqops = {
 		.start = ima_policy_start,
@@ -391,6 +385,8 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
+	struct ima_namespace *ns = &init_ima_ns;
+
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
 		return -EACCES;
@@ -402,7 +398,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 		return seq_open(filp, &ima_policy_seqops);
 #endif
 	}
-	if (test_and_set_bit(IMA_FS_BUSY, &ima_fs_flags))
+	if (test_and_set_bit(IMA_FS_BUSY, &ns->ima_fs_flags))
 		return -EBUSY;
 	return 0;
 }
@@ -416,25 +412,25 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	const char *cause = valid_policy ? "completed" : "failed";
 	struct ima_namespace *ns = &init_ima_ns;
+	const char *cause = ns->valid_policy ? "completed" : "failed";
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
-	if (valid_policy && ima_check_policy(ns) < 0) {
+	if (ns->valid_policy && ima_check_policy(ns) < 0) {
 		cause = "failed";
-		valid_policy = 0;
+		ns->valid_policy = 0;
 	}
 
 	pr_info("policy update %s\n", cause);
 	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-			    "policy_update", cause, !valid_policy, 0);
+			    "policy_update", cause, !ns->valid_policy, 0);
 
-	if (!valid_policy) {
+	if (!ns->valid_policy) {
 		ima_delete_rules(ns);
-		valid_policy = 1;
-		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+		ns->valid_policy = 1;
+		clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 		return 0;
 	}
 
@@ -443,7 +439,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	securityfs_remove(ima_policy);
 	ima_policy = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
-	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
 	inode->i_mode &= ~S_IWUSR;
 #endif
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index a7477072c587..425eed1c6838 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -26,6 +26,10 @@ static int ima_init_namespace(struct ima_namespace *ns)
 	else
 		ns->binary_runtime_size = ULONG_MAX;
 
+	mutex_init(&ns->ima_write_mutex);
+	ns->valid_policy = 1;
+	ns->ima_fs_flags = 0;
+
 	return 0;
 }
 
-- 
2.31.1

