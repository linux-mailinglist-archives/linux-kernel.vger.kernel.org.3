Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2762F46DE4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbhLHWX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:23:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240637AbhLHWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:22:13 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8LCFsw012038;
        Wed, 8 Dec 2021 22:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lWf9SHsR2PkBp5VZmLFG+KU7bbZmrVh1EERQWWp9idk=;
 b=FPnm0GKluU3GQ5DSjA3JH+nILWdKxpK4E5Wg0y//qOnJu7K4vGC5J3dKF4EGBDqu1f+z
 GuCb2VFmYlYNht2yieVYdULpblc0im0IFz7zBs5fjOSxYGnUQCPbQjUfg0tW3neOKb9m
 bmu9sljUZxlhytrkVXNmUoSp6b0d3AciJQ4WuJsiilEpAEF8cc0eMkmKBWU7fzSFSrWd
 U5GFYV+9V0Z2PVKYVXmiQfi7xD5MJnl0f2zAfU+I26u4l9dCqmwCj1bgTQ3nH946Yw+g
 Gw4/kOEOtso+QRlb5NZv2ZTBT1ufgpB2EP1xF70KNjecAOU9phXAJLv+Isw74xuOQO5q oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cu4dr11q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:28 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8MELZf012934;
        Wed, 8 Dec 2021 22:18:27 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cu4dr11pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:27 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MDu59020083;
        Wed, 8 Dec 2021 22:18:27 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3cqyycykce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:26 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8MIPm816646670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 22:18:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8023C28060;
        Wed,  8 Dec 2021 22:18:25 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 653CA2805C;
        Wed,  8 Dec 2021 22:18:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 22:18:25 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 15/16] ima: Move dentries into ima_namespace
Date:   Wed,  8 Dec 2021 17:18:17 -0500
Message-Id: <20211208221818.1519628-16-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208221818.1519628-1-stefanb@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: smyRqOyxM3yjVtrMjxqTEyhKAcNLo_u6
X-Proofpoint-ORIG-GUID: 5XeSqDwOV7qQNV11ishVH5EivY9HJwvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the dentries into the ima_namespace for reuse by virtualized
SecurityFS. Implement function freeing the dentries in order of
files and symlinks before directories.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h             | 13 ++++++
 security/integrity/ima/ima_fs.c | 72 ++++++++++++++++++---------------
 2 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 3aaf6e806db4..4dd64e318b15 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -220,6 +220,17 @@ struct ima_h_table {
 	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
 };
 
+enum {
+	IMAFS_DENTRY_DIR = 0,
+	IMAFS_DENTRY_SYMLINK,
+	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
+	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
+	IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT,
+	IMAFS_DENTRY_VIOLATIONS,
+	IMAFS_DENTRY_IMA_POLICY,
+	IMAFS_DENTRY_LAST
+};
+
 struct ima_namespace {
 	struct kref kref;
 	struct user_namespace *user_ns;
@@ -266,6 +277,8 @@ struct ima_namespace {
 	struct mutex ima_write_mutex;
 	unsigned long ima_fs_flags;
 	int valid_policy;
+
+	struct dentry *dentry[IMAFS_DENTRY_LAST];
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index a749a3e79304..3810d11fb463 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -360,14 +360,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	return result;
 }
 
-static struct dentry *ima_dir;
-static struct dentry *ima_symlink;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
-static struct dentry *runtime_measurements_count;
-static struct dentry *violations;
-static struct dentry *ima_policy;
-
 enum ima_fs_flags {
 	IMA_FS_BUSY,
 };
@@ -437,8 +429,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	securityfs_remove(ima_policy);
-	ima_policy = NULL;
+	securityfs_remove(ns->dentry[IMAFS_DENTRY_IMA_POLICY]);
+	ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -455,58 +447,72 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-int __init ima_fs_init(void)
+static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
 {
-	ima_dir = securityfs_create_dir("ima", integrity_dir);
-	if (IS_ERR(ima_dir))
+	int i;
+
+	for (i = IMAFS_DENTRY_LAST - 1; i >= 0; i--)
+		securityfs_remove(ns->dentry[i]);
+
+	memset(ns->dentry, 0, sizeof(ns->dentry));
+}
+
+static int __init ima_securityfs_init(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns = user_ns->ima_ns;
+	struct dentry *ima_dir;
+
+	ns->dentry[IMAFS_DENTRY_DIR] = securityfs_create_dir("ima", integrity_dir);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_DIR]))
 		return -1;
+	ima_dir = ns->dentry[IMAFS_DENTRY_DIR];
 
-	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
-						NULL);
-	if (IS_ERR(ima_symlink))
+	ns->dentry[IMAFS_DENTRY_SYMLINK] =
+	    securityfs_create_symlink("ima", NULL, "integrity/ima", NULL);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_SYMLINK]))
 		goto out;
 
-	binary_runtime_measurements =
+	ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS] =
 	    securityfs_create_file("binary_runtime_measurements",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_ops);
-	if (IS_ERR(binary_runtime_measurements))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS]))
 		goto out;
 
-	ascii_runtime_measurements =
+	ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS] =
 	    securityfs_create_file("ascii_runtime_measurements",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_ascii_measurements_ops);
-	if (IS_ERR(ascii_runtime_measurements))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS]))
 		goto out;
 
-	runtime_measurements_count =
+	ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT] =
 	    securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_count_ops);
-	if (IS_ERR(runtime_measurements_count))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT]))
 		goto out;
 
-	violations =
+	ns->dentry[IMAFS_DENTRY_VIOLATIONS] =
 	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
 				   ima_dir, NULL, &ima_htable_violations_ops);
-	if (IS_ERR(violations))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_VIOLATIONS]))
 		goto out;
 
-	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
+	ns->dentry[IMAFS_DENTRY_IMA_POLICY] =
+	    securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
 					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_IMA_POLICY]))
 		goto out;
 
 	return 0;
 out:
-	securityfs_remove(violations);
-	securityfs_remove(runtime_measurements_count);
-	securityfs_remove(ascii_runtime_measurements);
-	securityfs_remove(binary_runtime_measurements);
-	securityfs_remove(ima_symlink);
-	securityfs_remove(ima_dir);
-	securityfs_remove(ima_policy);
+	ima_fs_ns_free_dentries(ns);
 	return -1;
 }
+
+int __init ima_fs_init(void)
+{
+	return ima_securityfs_init(&init_user_ns);
+}
-- 
2.31.1

