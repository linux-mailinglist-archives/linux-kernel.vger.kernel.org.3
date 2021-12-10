Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521A6470AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbhLJTv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:51:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44074 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343728AbhLJTvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:51:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAHoFqI015775;
        Fri, 10 Dec 2021 19:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K9CKjm/05lDUWN+xhUrovSaJlvVCdDLF9tV3fRb7JPg=;
 b=iWeiKxmsHTjVceUF+5YosBH1udwmrWTtNPTiRYw3CC0ARiyktOa+C5IzQojt2JDnrk1q
 3wcK7Zfd+/rpMz1E9XXHOLpf1d9V6QAxgJQi2HBsln2vwnXAFD05LJwpeXgLk9sK5KGV
 7yznkz+GdXtikh6evnSKR9XCVrF8jLG4T6HBsWDbN/DWBOD0NL7r7OZWgeXh5IpezICr
 EWP4OtblwxTlnxaYluBoATsq1yiTu6Bj/wUG1RA1XvmGd5eY/bSKvYBgoRIpZSPbsTxo
 RdbqZNdT88uFNt/Bhf7tJqVXIZM7Y4GrPET/YAikgrKDpL5+e56uiuJJ0mkvA5n2jsXR ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvavkubh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:42 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAJlTYv010342;
        Fri, 10 Dec 2021 19:47:41 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvavkubgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:41 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJc5xs011579;
        Fri, 10 Dec 2021 19:47:40 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3cqyyekvyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:40 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAJlcaS42991872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 19:47:38 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE87EAE067;
        Fri, 10 Dec 2021 19:47:38 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CD7FAE064;
        Fri, 10 Dec 2021 19:47:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 19:47:38 +0000 (GMT)
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
Subject: [PATCH v6 06/17] ima: Move policy related variables into ima_namespace
Date:   Fri, 10 Dec 2021 14:47:25 -0500
Message-Id: <20211210194736.1538863-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210194736.1538863-1-stefanb@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zQ_uicBC1YfbojJTRbtVOCNws-OGEAdt
X-Proofpoint-GUID: u8EVmTS1Wdb_rdGrKtby6rvPCrzqDzhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move variables related to the IMA policy into the ima_namespace. This way
the IMA policy of an IMA namespace can be set and displayed using a
front-end like SecurityFS.

Implement ima_free_policy_rules() that frees the policy rules on
ima_namespace deletion.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                          |  10 ++
 security/integrity/ima/ima.h                 |  35 ++---
 security/integrity/ima/ima_api.c             |   8 +-
 security/integrity/ima/ima_appraise.c        |  26 ++--
 security/integrity/ima/ima_asymmetric_keys.c |   3 +-
 security/integrity/ima/ima_fs.c              |  10 +-
 security/integrity/ima/ima_init.c            |   8 +-
 security/integrity/ima/ima_init_ima_ns.c     |   6 +
 security/integrity/ima/ima_main.c            |  83 +++++++-----
 security/integrity/ima/ima_ns.c              |   1 +
 security/integrity/ima/ima_policy.c          | 132 +++++++++++--------
 security/integrity/ima/ima_queue_keys.c      |   2 +-
 12 files changed, 196 insertions(+), 128 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 41b6d7d4c312..7a81e2d9fef0 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -237,9 +237,19 @@ struct ima_namespace {
 	long ima_key_queue_timeout;
 	bool timer_expired;
 #endif
+
+	struct list_head ima_default_rules;
+	/* ns's policy rules */
+	struct list_head ima_policy_rules;
+	struct list_head ima_temp_rules;
+	/* Pointer to ns's current policy */
+	struct list_head __rcu *ima_rules;
+	/* current content of the policy */
+	int ima_policy_flag;
 };
 
 extern struct ima_namespace init_ima_ns;
+extern struct list_head ima_default_rules;
 
 #ifdef CONFIG_IMA_NS
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 97eb03376855..e295141f2478 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -43,9 +43,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
-/* current content of the policy */
-extern int ima_policy_flag;
-
 /* bitset of digests algorithms allowed in the setxattr hook */
 extern atomic_t ima_setxattr_allowed_hash_algorithms;
 
@@ -265,7 +262,8 @@ static inline void ima_process_queued_keys(struct ima_namespace *ns) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
 
 /* LIM API function definitions */
-int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_get_action(struct ima_namespace *ns,
+		   struct user_namespace *mnt_userns, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
@@ -279,7 +277,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
-int process_buffer_measurement(struct user_namespace *mnt_userns,
+int process_buffer_measurement(struct ima_namespace *ns,
+			       struct user_namespace *mnt_userns,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
@@ -297,17 +296,19 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_match_policy(struct ima_namespace *ns,
+		     struct user_namespace *mnt_userns, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos);
-void ima_init_policy(void);
+void ima_init_policy(struct ima_namespace *ns);
 void ima_update_policy(struct ima_namespace *ns);
-void ima_update_policy_flags(void);
-ssize_t ima_parse_add_rule(char *);
-void ima_delete_rules(void);
-int ima_check_policy(void);
+void ima_update_policy_flags(struct ima_namespace *ns);
+ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
+void ima_delete_rules(struct ima_namespace *ns);
+int ima_check_policy(struct ima_namespace *ns);
+void ima_free_policy_rules(struct ima_namespace *ns);
 void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
@@ -323,14 +324,16 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
-int ima_check_blacklist(struct integrity_iint_cache *iint,
+int ima_check_blacklist(struct ima_namespace *ns,
+			struct integrity_iint_cache *iint,
 			const struct modsig *modsig, int pcr);
 int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
 			     int xattr_len, const struct modsig *modsig);
-int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_must_appraise(struct ima_namespace *ns,
+		      struct user_namespace *mnt_userns, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
@@ -341,7 +344,8 @@ int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value);
 
 #else
-static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
+static inline int ima_check_blacklist(struct ima_namespace *ns,
+				      struct integrity_iint_cache *iint,
 				      const struct modsig *modsig, int pcr)
 {
 	return 0;
@@ -358,7 +362,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 	return INTEGRITY_UNKNOWN;
 }
 
-static inline int ima_must_appraise(struct user_namespace *mnt_userns,
+static inline int ima_must_appraise(struct ima_namespace *ns,
+				    struct user_namespace *mnt_userns,
 				    struct inode *inode, int mask,
 				    enum ima_hooks func)
 {
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 8f7bab17b784..808aec56dbb6 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -14,6 +14,7 @@
 #include <linux/xattr.h>
 #include <linux/evm.h>
 #include <linux/iversion.h>
+#include <linux/ima.h>
 
 #include "ima.h"
 
@@ -185,7 +186,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_get_action(struct ima_namespace *ns,
+		   struct user_namespace *mnt_userns, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
@@ -193,9 +195,9 @@ int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
-	flags &= ima_policy_flag;
+	flags &= ns->ima_policy_flag;
 
-	return ima_match_policy(mnt_userns, inode, cred, secid, func, mask,
+	return ima_match_policy(ns, mnt_userns, inode, cred, secid, func, mask,
 				flags, pcr, template_desc, func_data,
 				allowed_algos);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index dbba51583e7c..b0c1992d8c4b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -68,7 +68,8 @@ bool is_ima_appraise_enabled(void)
  *
  * Return 1 to appraise or hash
  */
-int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_must_appraise(struct ima_namespace *ns,
+		      struct user_namespace *mnt_userns, struct inode *inode,
 		      int mask, enum ima_hooks func)
 {
 	u32 secid;
@@ -77,7 +78,7 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
 		return 0;
 
 	security_task_getsecid_subj(current, &secid);
-	return ima_match_policy(mnt_userns, inode, current_cred(), secid,
+	return ima_match_policy(ns, mnt_userns, inode, current_cred(), secid,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
 				NULL, NULL, NULL);
 }
@@ -341,7 +342,8 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
  *
  * Returns -EPERM if the hash is blacklisted.
  */
-int ima_check_blacklist(struct integrity_iint_cache *iint,
+int ima_check_blacklist(struct ima_namespace *ns,
+			struct integrity_iint_cache *iint,
 			const struct modsig *modsig, int pcr)
 {
 	enum hash_algo hash_algo;
@@ -357,7 +359,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 
 		rc = is_binary_blacklisted(digest, digestsize);
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
-			process_buffer_measurement(&init_user_ns, NULL, digest, digestsize,
+			process_buffer_measurement(ns, &init_user_ns, NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
 						   pcr, NULL, false, NULL, 0);
 	}
@@ -527,14 +529,15 @@ void ima_inode_post_setattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	int action;
 
-	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
+	if (!(ns->ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
 	    || !(inode->i_opflags & IOP_XATTR))
 		return;
 
-	action = ima_must_appraise(mnt_userns, inode, MAY_ACCESS, POST_SETATTR);
+	action = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS, POST_SETATTR);
 	iint = integrity_iint_find(inode);
 	if (iint) {
 		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
@@ -559,11 +562,12 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
 	return 0;
 }
 
-static void ima_reset_appraise_flags(struct inode *inode, int digsig)
+static void ima_reset_appraise_flags(struct ima_namespace *ns,
+				     struct inode *inode, int digsig)
 {
 	struct integrity_iint_cache *iint;
 
-	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode))
+	if (!(ns->ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode))
 		return;
 
 	iint = integrity_iint_find(inode);
@@ -641,6 +645,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len)
 {
 	const struct evm_ima_xattr_data *xvalue = xattr_value;
+	struct ima_namespace *ns = get_current_ns();
 	int digsig = 0;
 	int result;
 
@@ -658,18 +663,19 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		if (result)
 			return result;
 
-		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
+		ima_reset_appraise_flags(ns, d_backing_inode(dentry), digsig);
 	}
 	return result;
 }
 
 int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
 {
+	struct ima_namespace *ns = get_current_ns();
 	int result;
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		ima_reset_appraise_flags(ns, d_backing_inode(dentry), 0);
 		if (result == 1)
 			result = 0;
 	}
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index b20e82eda8f4..959e9f2f6c26 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -61,7 +61,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 * if the IMA policy is configured to measure a key linked
 	 * to the given keyring.
 	 */
-	process_buffer_measurement(&init_user_ns, NULL, payload, payload_len,
+	process_buffer_measurement(ns, &init_user_ns, NULL,
+				   payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
 				   keyring->description, false, NULL, 0);
 }
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 5cff3d6c3dc7..25f85c58ebef 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -274,6 +274,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
 
 static ssize_t ima_read_policy(char *path)
 {
+	struct ima_namespace *ns = get_current_ns();
 	void *data = NULL;
 	char *datap;
 	size_t size;
@@ -297,7 +298,7 @@ static ssize_t ima_read_policy(char *path)
 	datap = data;
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
 		pr_debug("rule: %s\n", p);
-		rc = ima_parse_add_rule(p);
+		rc = ima_parse_add_rule(ns, p);
 		if (rc < 0)
 			break;
 		size -= rc;
@@ -315,6 +316,7 @@ static ssize_t ima_read_policy(char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
+	struct ima_namespace *ns = get_current_ns();
 	char *data;
 	ssize_t result;
 
@@ -345,7 +347,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				    1, 0);
 		result = -EACCES;
 	} else {
-		result = ima_parse_add_rule(data);
+		result = ima_parse_add_rule(ns, data);
 	}
 	mutex_unlock(&ima_write_mutex);
 out_free:
@@ -416,7 +418,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
-	if (valid_policy && ima_check_policy() < 0) {
+	if (valid_policy && ima_check_policy(ns) < 0) {
 		cause = "failed";
 		valid_policy = 0;
 	}
@@ -426,7 +428,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 			    "policy_update", cause, !valid_policy, 0);
 
 	if (!valid_policy) {
-		ima_delete_rules();
+		ima_delete_rules(ns);
 		valid_policy = 1;
 		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
 		return 0;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 24848373a061..d78f8faf6dcd 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -104,15 +104,15 @@ static int __init ima_add_boot_aggregate(void)
 #ifdef CONFIG_IMA_LOAD_X509
 void __init ima_load_x509(void)
 {
-	int unset_flags = ima_policy_flag & IMA_APPRAISE;
+	int unset_flags = init_ima_ns.ima_policy_flag & IMA_APPRAISE;
 
-	ima_policy_flag &= ~unset_flags;
+	init_ima_ns.ima_policy_flag &= ~unset_flags;
 	integrity_load_x509(INTEGRITY_KEYRING_IMA, CONFIG_IMA_X509_PATH);
 
 	/* load also EVM key to avoid appraisal */
 	evm_load_x509();
 
-	ima_policy_flag |= unset_flags;
+	init_ima_ns.ima_policy_flag |= unset_flags;
 }
 #endif
 
@@ -149,7 +149,7 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
-	ima_init_policy();
+	ima_init_policy(&init_ima_ns);
 
 	rc = ima_fs_init();
 	if (rc != 0)
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index d2a36b5251cd..db7de6811fcc 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -34,6 +34,12 @@ int ima_init_namespace(struct ima_namespace *ns)
 		ima_init_key_queue(ns);
 #endif
 
+	INIT_LIST_HEAD(&ns->ima_default_rules);
+	INIT_LIST_HEAD(&ns->ima_policy_rules);
+	INIT_LIST_HEAD(&ns->ima_temp_rules);
+	ns->ima_rules = (struct list_head __rcu *)(&ns->ima_default_rules);
+	ns->ima_policy_flag = 0;
+
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4386010a480e..897304046ba4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -185,10 +185,11 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
  */
 void ima_file_free(struct file *file)
 {
+	struct ima_namespace *ns = get_current_ns();
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint;
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
 	iint = integrity_iint_find(inode);
@@ -198,11 +199,11 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct file *file, const struct cred *cred,
+static int process_measurement(struct ima_namespace *ns,
+			       struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct ima_namespace *ns = get_current_ns();
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
 	struct ns_status *status = NULL;
@@ -220,18 +221,18 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	unsigned int allowed_algos = 0;
 	unsigned long flags;
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
 
 	/* Return an IMA_MEASURE, IMA_APPRAISE, IMA_AUDIT action
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(file_mnt_user_ns(file), inode, cred, secid,
+	action = ima_get_action(ns, file_mnt_user_ns(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
-			   (ima_policy_flag & IMA_MEASURE));
+			   (ns->ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
 		return 0;
 
@@ -357,7 +358,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				      xattr_value, xattr_len, modsig, pcr,
 				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
-		rc = ima_check_blacklist(iint, modsig, pcr);
+		rc = ima_check_blacklist(ns, iint, modsig, pcr);
 		if (rc != -EPERM) {
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
@@ -416,12 +417,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
  */
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
+	struct ima_namespace *ns = get_current_ns();
 	u32 secid;
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid_subj(current, &secid);
-		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+		return process_measurement(ns, file, current_cred(), secid,
+					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
 	return 0;
@@ -441,6 +443,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
+	struct ima_namespace *ns = get_current_ns();
 	struct ima_template_desc *template = NULL;
 	struct file *file = vma->vm_file;
 	char filename[NAME_MAX];
@@ -453,13 +456,13 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
-	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
+	if (!(ns->ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
 	security_task_getsecid_subj(current, &secid);
 	inode = file_inode(vma->vm_file);
-	action = ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
+	action = ima_get_action(ns, file_mnt_user_ns(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
 				&pcr, &template, NULL, NULL);
 
@@ -495,17 +498,18 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
  */
 int ima_bprm_check(struct linux_binprm *bprm)
 {
+	struct ima_namespace *ns = get_current_ns();
 	int ret;
 	u32 secid;
 
 	security_task_getsecid_subj(current, &secid);
-	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+	ret = process_measurement(ns, bprm->file, current_cred(), secid, NULL,
+				  0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
-	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
+	return process_measurement(ns, bprm->file, bprm->cred, secid, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
 
@@ -521,21 +525,23 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
+	struct ima_namespace *ns = get_current_ns();
 	u32 secid;
 
 	security_task_getsecid_subj(current, &secid);
-	return process_measurement(file, current_cred(), secid, NULL, 0,
+	return process_measurement(ns, file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
-static int __ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
+static int __ima_inode_hash(struct ima_namespace *ns,
+			    struct inode *inode, char *buf, size_t buf_size)
 {
 	struct integrity_iint_cache *iint;
 	int hash_algo;
 
-	if (!ima_policy_flag)
+	if (!ns->ima_policy_flag)
 		return -EOPNOTSUPP;
 
 	iint = integrity_iint_find(inode);
@@ -585,10 +591,12 @@ static int __ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
  */
 int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
+	struct ima_namespace *ns = get_current_ns();
+
 	if (!file)
 		return -EINVAL;
 
-	return __ima_inode_hash(file_inode(file), buf, buf_size);
+	return __ima_inode_hash(ns, file_inode(file), buf, buf_size);
 }
 EXPORT_SYMBOL_GPL(ima_file_hash);
 
@@ -612,10 +620,12 @@ EXPORT_SYMBOL_GPL(ima_file_hash);
  */
 int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
+	struct ima_namespace *ns = get_current_ns();
+
 	if (!inode)
 		return -EINVAL;
 
-	return __ima_inode_hash(inode, buf, buf_size);
+	return __ima_inode_hash(ns, inode, buf, buf_size);
 }
 EXPORT_SYMBOL_GPL(ima_inode_hash);
 
@@ -631,13 +641,14 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
 void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 			     struct inode *inode)
 {
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
-	must_appraise = ima_must_appraise(mnt_userns, inode, MAY_ACCESS,
+	must_appraise = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS,
 					  FILE_CHECK);
 	if (!must_appraise)
 		return;
@@ -663,14 +674,15 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 void ima_post_path_mknod(struct user_namespace *mnt_userns,
 			 struct dentry *dentry)
 {
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
-	must_appraise = ima_must_appraise(mnt_userns, inode, MAY_ACCESS,
+	must_appraise = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS,
 					  FILE_CHECK);
 	if (!must_appraise)
 		return;
@@ -699,6 +711,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 		  bool contents)
 {
+	struct ima_namespace *ns = get_current_ns();
 	enum ima_hooks func;
 	u32 secid;
 
@@ -721,7 +734,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &secid);
-	return process_measurement(file, current_cred(), secid, NULL,
+	return process_measurement(ns, file, current_cred(), secid, NULL,
 				   0, MAY_READ, func);
 }
 
@@ -749,6 +762,7 @@ const int read_idmap[READING_MAX_ID] = {
 int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
+	struct ima_namespace *ns = get_current_ns();
 	enum ima_hooks func;
 	u32 secid;
 
@@ -764,7 +778,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
+	return process_measurement(ns, file, current_cred(), secid, buf, size,
 				   MAY_READ, func);
 }
 
@@ -870,7 +884,8 @@ int ima_post_load_data(char *buf, loff_t size,
  * has been written to the passed location but not added to a measurement entry,
  * a negative value otherwise.
  */
-int process_buffer_measurement(struct user_namespace *mnt_userns,
+int process_buffer_measurement(struct ima_namespace *ns,
+			       struct user_namespace *mnt_userns,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
@@ -898,7 +913,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	if (digest && digest_len < digest_hash_len)
 		return -EINVAL;
 
-	if (!ima_policy_flag && !digest)
+	if (!ns->ima_policy_flag && !digest)
 		return -ENOENT;
 
 	template = ima_template_desc_buf();
@@ -917,7 +932,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	 */
 	if (func) {
 		security_task_getsecid_subj(current, &secid);
-		action = ima_get_action(mnt_userns, inode, current_cred(),
+		action = ima_get_action(ns, mnt_userns, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
 					func_data, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
@@ -954,7 +969,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	if (digest)
 		memcpy(digest, iint.ima_hash->digest, digest_hash_len);
 
-	if (!ima_policy_flag || (func && !(action & IMA_MEASURE)))
+	if (!ns->ima_policy_flag || (func && !(action & IMA_MEASURE)))
 		return 1;
 
 	ret = ima_alloc_init_template(&event_data, &entry, template);
@@ -988,6 +1003,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
  */
 void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 {
+	struct ima_namespace *ns = get_current_ns();
 	struct fd f;
 
 	if (!buf || !size)
@@ -997,7 +1013,8 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	if (!f.file)
 		return;
 
-	process_buffer_measurement(file_mnt_user_ns(f.file), file_inode(f.file),
+	process_buffer_measurement(ns,
+				   file_mnt_user_ns(f.file), file_inode(f.file),
 				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
 				   NULL, false, NULL, 0);
 	fdput(f);
@@ -1027,10 +1044,12 @@ int ima_measure_critical_data(const char *event_label,
 			      const void *buf, size_t buf_len,
 			      bool hash, u8 *digest, size_t digest_len)
 {
+	struct ima_namespace *ns = get_current_ns();
+
 	if (!event_name || !event_label || !buf || !buf_len)
 		return -ENOPARAM;
 
-	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
+	return process_buffer_measurement(ns, &init_user_ns, NULL, buf, buf_len,
 					  event_name, CRITICAL_DATA, 0,
 					  event_label, hash, digest,
 					  digest_len);
@@ -1063,7 +1082,7 @@ static int __init init_ima(void)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
 	if (!error)
-		ima_update_policy_flags();
+		ima_update_policy_flags(&init_ima_ns);
 
 	return error;
 }
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 155126038809..9d97f45fa8e4 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -54,6 +54,7 @@ int create_ima_ns(struct user_namespace *user_ns)
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
 	pr_debug("DESTROY ima_ns: 0x%p\n", ns);
+	ima_free_policy_rules(ns);
 	free_ns_status_cache(ns);
 	kmem_cache_free(imans_cachep, ns);
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e5aef287d14d..4d6d3a39f65e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -52,7 +52,6 @@
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (sizeof_field(struct integrity_iint_cache, measured_pcrs) * 8))
 
-int ima_policy_flag;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
 
@@ -233,11 +232,6 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
 /* An array of architecture specific rules */
 static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 
-static LIST_HEAD(ima_default_rules);
-static LIST_HEAD(ima_policy_rules);
-static LIST_HEAD(ima_temp_rules);
-static struct list_head __rcu *ima_rules = (struct list_head __rcu *)(&ima_default_rules);
-
 static int ima_policy __initdata;
 
 static int __init default_measure_policy_setup(char *str)
@@ -454,12 +448,12 @@ static bool ima_rule_contains_lsm_cond(struct ima_rule_entry *entry)
  * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
  * the reloaded LSM policy.
  */
-static void ima_lsm_update_rules(void)
+static void ima_lsm_update_rules(struct ima_namespace *ns)
 {
 	struct ima_rule_entry *entry, *e;
 	int result;
 
-	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
+	list_for_each_entry_safe(entry, e, &ns->ima_policy_rules, list) {
 		if (!ima_rule_contains_lsm_cond(entry))
 			continue;
 
@@ -474,10 +468,12 @@ static void ima_lsm_update_rules(void)
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data)
 {
+	struct ima_namespace *ns = get_current_ns();
+
 	if (event != LSM_POLICY_CHANGE)
 		return NOTIFY_DONE;
 
-	ima_lsm_update_rules();
+	ima_lsm_update_rules(ns);
 	return NOTIFY_OK;
 }
 
@@ -688,7 +684,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_match_policy(struct ima_namespace *ns,
+		     struct user_namespace *mnt_userns, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
@@ -702,7 +699,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 		*template_desc = ima_template_desc_current();
 
 	rcu_read_lock();
-	ima_rules_tmp = rcu_dereference(ima_rules);
+	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 
 		if (!(entry->action & actmask))
@@ -760,14 +757,14 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
  *
  * Context: called after a policy update and at system initialization.
  */
-void ima_update_policy_flags(void)
+void ima_update_policy_flags(struct ima_namespace *ns)
 {
 	struct ima_rule_entry *entry;
 	int new_policy_flag = 0;
 	struct list_head *ima_rules_tmp;
 
 	rcu_read_lock();
-	ima_rules_tmp = rcu_dereference(ima_rules);
+	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		/*
 		 * SETXATTR_CHECK rules do not implement a full policy check
@@ -797,7 +794,7 @@ void ima_update_policy_flags(void)
 	if (!ima_appraise)
 		new_policy_flag &= ~IMA_APPRAISE;
 
-	ima_policy_flag = new_policy_flag;
+	ns->ima_policy_flag = new_policy_flag;
 }
 
 static int ima_appraise_flag(enum ima_hooks func)
@@ -813,7 +810,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 	return 0;
 }
 
-static void add_rules(struct ima_rule_entry *entries, int count,
+static void add_rules(struct ima_namespace *ns,
+		      struct ima_rule_entry *entries, int count,
 		      enum policy_rule_list policy_rule)
 {
 	int i = 0;
@@ -822,7 +820,7 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 		struct ima_rule_entry *entry;
 
 		if (policy_rule & IMA_DEFAULT_POLICY)
-			list_add_tail(&entries[i].list, &ima_default_rules);
+			list_add_tail(&entries[i].list, &ns->ima_default_rules);
 
 		if (policy_rule & IMA_CUSTOM_POLICY) {
 			entry = kmemdup(&entries[i], sizeof(*entry),
@@ -830,7 +828,7 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 			if (!entry)
 				continue;
 
-			list_add_tail(&entry->list, &ima_policy_rules);
+			list_add_tail(&entry->list, &ns->ima_policy_rules);
 		}
 		if (entries[i].action == APPRAISE) {
 			if (entries != build_appraise_rules)
@@ -843,9 +841,10 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 	}
 }
 
-static int ima_parse_rule(char *rule, struct ima_rule_entry *entry);
+static int ima_parse_rule(struct ima_namespace *ns,
+			  char *rule, struct ima_rule_entry *entry);
 
-static int __init ima_init_arch_policy(void)
+static int __init ima_init_arch_policy(struct ima_namespace *ns)
 {
 	const char * const *arch_rules;
 	const char * const *rules;
@@ -873,7 +872,7 @@ static int __init ima_init_arch_policy(void)
 		result = strscpy(rule, *rules, sizeof(rule));
 
 		INIT_LIST_HEAD(&arch_policy_entry[i].list);
-		result = ima_parse_rule(rule, &arch_policy_entry[i]);
+		result = ima_parse_rule(ns, rule, &arch_policy_entry[i]);
 		if (result) {
 			pr_warn("Skipping unknown architecture policy rule: %s\n",
 				rule);
@@ -891,23 +890,23 @@ static int __init ima_init_arch_policy(void)
  *
  * ima_rules points to either the ima_default_rules or the new ima_policy_rules.
  */
-void __init ima_init_policy(void)
+void __init ima_init_policy(struct ima_namespace *ns)
 {
 	int build_appraise_entries, arch_entries;
 
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
-		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
+		add_rules(ns, dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
 			  IMA_DEFAULT_POLICY);
 
 	switch (ima_policy) {
 	case ORIGINAL_TCB:
-		add_rules(original_measurement_rules,
+		add_rules(ns, original_measurement_rules,
 			  ARRAY_SIZE(original_measurement_rules),
 			  IMA_DEFAULT_POLICY);
 		break;
 	case DEFAULT_TCB:
-		add_rules(default_measurement_rules,
+		add_rules(ns, default_measurement_rules,
 			  ARRAY_SIZE(default_measurement_rules),
 			  IMA_DEFAULT_POLICY);
 		break;
@@ -921,11 +920,11 @@ void __init ima_init_policy(void)
 	 * and custom policies, prior to other appraise rules.
 	 * (Highest priority)
 	 */
-	arch_entries = ima_init_arch_policy();
+	arch_entries = ima_init_arch_policy(ns);
 	if (!arch_entries)
 		pr_info("No architecture policies found\n");
 	else
-		add_rules(arch_policy_entry, arch_entries,
+		add_rules(ns, arch_policy_entry, arch_entries,
 			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 
 	/*
@@ -933,7 +932,7 @@ void __init ima_init_policy(void)
 	 * signatures, prior to other appraise rules.
 	 */
 	if (ima_use_secure_boot)
-		add_rules(secure_boot_rules, ARRAY_SIZE(secure_boot_rules),
+		add_rules(ns, secure_boot_rules, ARRAY_SIZE(secure_boot_rules),
 			  IMA_DEFAULT_POLICY);
 
 	/*
@@ -945,32 +944,32 @@ void __init ima_init_policy(void)
 	build_appraise_entries = ARRAY_SIZE(build_appraise_rules);
 	if (build_appraise_entries) {
 		if (ima_use_secure_boot)
-			add_rules(build_appraise_rules, build_appraise_entries,
+			add_rules(ns, build_appraise_rules, build_appraise_entries,
 				  IMA_CUSTOM_POLICY);
 		else
-			add_rules(build_appraise_rules, build_appraise_entries,
+			add_rules(ns, build_appraise_rules, build_appraise_entries,
 				  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 	}
 
 	if (ima_use_appraise_tcb)
-		add_rules(default_appraise_rules,
+		add_rules(ns, default_appraise_rules,
 			  ARRAY_SIZE(default_appraise_rules),
 			  IMA_DEFAULT_POLICY);
 
 	if (ima_use_critical_data)
-		add_rules(critical_data_rules,
+		add_rules(ns, critical_data_rules,
 			  ARRAY_SIZE(critical_data_rules),
 			  IMA_DEFAULT_POLICY);
 
 	atomic_set(&ima_setxattr_allowed_hash_algorithms, 0);
 
-	ima_update_policy_flags();
+	ima_update_policy_flags(ns);
 }
 
 /* Make sure we have a valid policy, at least containing some rules. */
-int ima_check_policy(void)
+int ima_check_policy(struct ima_namespace *ns)
 {
-	if (list_empty(&ima_temp_rules))
+	if (list_empty(&ns->ima_temp_rules))
 		return -EINVAL;
 	return 0;
 }
@@ -988,14 +987,14 @@ int ima_check_policy(void)
  */
 void ima_update_policy(struct ima_namespace *ns)
 {
-	struct list_head *policy = &ima_policy_rules;
+	struct list_head *policy = &ns->ima_policy_rules;
 
-	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
+	list_splice_tail_init_rcu(&ns->ima_temp_rules, policy, synchronize_rcu);
 
-	if (ima_rules != (struct list_head __rcu *)policy) {
-		ima_policy_flag = 0;
+	if (ns->ima_rules != (struct list_head __rcu *)policy) {
+		ns->ima_policy_flag = 0;
 
-		rcu_assign_pointer(ima_rules, policy);
+		rcu_assign_pointer(ns->ima_rules, policy);
 		/*
 		 * IMA architecture specific policy rules are specified
 		 * as strings and converted to an array of ima_entry_rules
@@ -1004,7 +1003,7 @@ void ima_update_policy(struct ima_namespace *ns)
 		 */
 		kfree(arch_policy_entry);
 	}
-	ima_update_policy_flags();
+	ima_update_policy_flags(ns);
 
 	/* Custom IMA policy has been loaded */
 	ima_process_queued_keys(ns);
@@ -1077,7 +1076,8 @@ static const match_table_t policy_tokens = {
 	{Opt_err, NULL}
 };
 
-static int ima_lsm_rule_init(struct ima_rule_entry *entry,
+static int ima_lsm_rule_init(struct ima_namespace *ns,
+			     struct ima_rule_entry *entry,
 			     substring_t *args, int lsm_rule, int audit_type)
 {
 	int result;
@@ -1097,7 +1097,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
-		if (ima_rules == (struct list_head __rcu *)(&ima_default_rules)) {
+		if (ns->ima_rules == (struct list_head __rcu *)(&ns->ima_default_rules)) {
 			kfree(entry->lsm[lsm_rule].args_p);
 			entry->lsm[lsm_rule].args_p = NULL;
 			result = -EINVAL;
@@ -1324,7 +1324,8 @@ static unsigned int ima_parse_appraise_algos(char *arg)
 	return res;
 }
 
-static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
+static int ima_parse_rule(struct ima_namespace *ns,
+			  char *rule, struct ima_rule_entry *entry)
 {
 	struct audit_buffer *ab;
 	char *from;
@@ -1674,37 +1675,37 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			break;
 		case Opt_obj_user:
 			ima_log_string(ab, "obj_user", args[0].from);
-			result = ima_lsm_rule_init(entry, args,
+			result = ima_lsm_rule_init(ns, entry, args,
 						   LSM_OBJ_USER,
 						   AUDIT_OBJ_USER);
 			break;
 		case Opt_obj_role:
 			ima_log_string(ab, "obj_role", args[0].from);
-			result = ima_lsm_rule_init(entry, args,
+			result = ima_lsm_rule_init(ns, entry, args,
 						   LSM_OBJ_ROLE,
 						   AUDIT_OBJ_ROLE);
 			break;
 		case Opt_obj_type:
 			ima_log_string(ab, "obj_type", args[0].from);
-			result = ima_lsm_rule_init(entry, args,
+			result = ima_lsm_rule_init(ns, entry, args,
 						   LSM_OBJ_TYPE,
 						   AUDIT_OBJ_TYPE);
 			break;
 		case Opt_subj_user:
 			ima_log_string(ab, "subj_user", args[0].from);
-			result = ima_lsm_rule_init(entry, args,
+			result = ima_lsm_rule_init(ns, entry, args,
 						   LSM_SUBJ_USER,
 						   AUDIT_SUBJ_USER);
 			break;
 		case Opt_subj_role:
 			ima_log_string(ab, "subj_role", args[0].from);
-			result = ima_lsm_rule_init(entry, args,
+			result = ima_lsm_rule_init(ns, entry, args,
 						   LSM_SUBJ_ROLE,
 						   AUDIT_SUBJ_ROLE);
 			break;
 		case Opt_subj_type:
 			ima_log_string(ab, "subj_type", args[0].from);
-			result = ima_lsm_rule_init(entry, args,
+			result = ima_lsm_rule_init(ns, entry, args,
 						   LSM_SUBJ_TYPE,
 						   AUDIT_SUBJ_TYPE);
 			break;
@@ -1810,7 +1811,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
  * Avoid locking by allowing just one writer at a time in ima_write_policy()
  * Returns the length of the rule parsed, an error code on failure
  */
-ssize_t ima_parse_add_rule(char *rule)
+ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 {
 	static const char op[] = "update_policy";
 	char *p;
@@ -1834,7 +1835,7 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
-	result = ima_parse_rule(p, entry);
+	result = ima_parse_rule(ns, p, entry);
 	if (result) {
 		ima_free_rule(entry);
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
@@ -1843,7 +1844,7 @@ ssize_t ima_parse_add_rule(char *rule)
 		return result;
 	}
 
-	list_add_tail(&entry->list, &ima_temp_rules);
+	list_add_tail(&entry->list, &ns->ima_temp_rules);
 
 	return len;
 }
@@ -1854,12 +1855,24 @@ ssize_t ima_parse_add_rule(char *rule)
  * different from the active one.  There is also only one user of
  * ima_delete_rules() at a time.
  */
-void ima_delete_rules(void)
+void ima_delete_rules(struct ima_namespace *ns)
 {
 	struct ima_rule_entry *entry, *tmp;
 
 	temp_ima_appraise = 0;
-	list_for_each_entry_safe(entry, tmp, &ima_temp_rules, list) {
+	list_for_each_entry_safe(entry, tmp, &ns->ima_temp_rules, list) {
+		list_del(&entry->list);
+		ima_free_rule(entry);
+	}
+}
+
+void ima_free_policy_rules(struct ima_namespace *ns)
+{
+	struct ima_rule_entry *entry, *tmp;
+
+	ima_delete_rules(ns);
+
+	list_for_each_entry_safe(entry, tmp, &ns->ima_policy_rules, list) {
 		list_del(&entry->list);
 		ima_free_rule(entry);
 	}
@@ -1885,12 +1898,13 @@ static const char *const mask_tokens[] = {
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
+	struct ima_namespace *ns = get_current_ns();
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
 
 	rcu_read_lock();
-	ima_rules_tmp = rcu_dereference(ima_rules);
+	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (!l--) {
 			rcu_read_unlock();
@@ -1904,14 +1918,15 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct ima_rule_entry *entry = v;
+	struct ima_namespace *ns = get_current_ns();
 
 	rcu_read_lock();
 	entry = list_entry_rcu(entry->list.next, struct ima_rule_entry, list);
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&entry->list == &ima_default_rules ||
-		&entry->list == &ima_policy_rules) ? NULL : entry;
+	return (&entry->list == &ns->ima_default_rules ||
+		&entry->list == &ns->ima_policy_rules) ? NULL : entry;
 }
 
 void ima_policy_stop(struct seq_file *m, void *v)
@@ -2166,6 +2181,7 @@ int ima_policy_show(struct seq_file *m, void *v)
  */
 bool ima_appraise_signature(enum kernel_read_file_id id)
 {
+	struct ima_namespace *ns = get_current_ns();
 	struct ima_rule_entry *entry;
 	bool found = false;
 	enum ima_hooks func;
@@ -2177,7 +2193,7 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	func = read_idmap[id] ?: FILE_CHECK;
 
 	rcu_read_lock();
-	ima_rules_tmp = rcu_dereference(ima_rules);
+	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (entry->action != APPRAISE)
 			continue;
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 9e5e9a178253..14f334272160 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -142,7 +142,7 @@ void ima_process_queued_keys(struct ima_namespace *ns)
 
 	list_for_each_entry_safe(entry, tmp, &ns->ima_keys, list) {
 		if (!ns->timer_expired)
-			process_buffer_measurement(&init_user_ns, NULL,
+			process_buffer_measurement(ns, &init_user_ns, NULL,
 						   entry->payload,
 						   entry->payload_len,
 						   entry->keyring_name,
-- 
2.31.1

