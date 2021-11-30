Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA88463B35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbhK3QLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:11:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243416AbhK3QK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:10:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFkWuq019780;
        Tue, 30 Nov 2021 16:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vnrZ/v2/umeiqe3QaMFXKuW0ci1n67xWqMD6UYz96O8=;
 b=OGzb6jxs8uj31jU1JbjOZdiA9+CzoLEI9oG+iA4ZU7CjCtgFeCbibxScJ/rTKcXUGGH1
 e/VDRChdrqa7ZIWK/gBVaVUKV1rAuMJjV5AeNaMrPWsk+lK5F2KsZCXXNdqVD6pMhUhm
 NOGYX8SBIn/vcuE+TZEbe78c0aOnVxwGR3z1PaZgv3ySk5zG9SC6aE0KTyCd6W29cFXz
 c2X3KTobmSlrXqPmdRMx2mRhvq3i/2dClGk2T/P57/ZyYGtqyK5ZYWOt69Q9OpjuUA1c
 jppuOPk5YNE/bOAxDawBeUyHXKDburVJxF2Mfy6LK5Wxkw4UO2WcP9v14jH+mPVWaxkC fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpw4ghum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:16 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUFkXTe019856;
        Tue, 30 Nov 2021 16:07:16 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpw4ghtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:15 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUG2pKj024654;
        Tue, 30 Nov 2021 16:07:14 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne1b9uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUG7C7F49742210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 16:07:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2656B208F;
        Tue, 30 Nov 2021 16:07:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D771B2082;
        Tue, 30 Nov 2021 16:07:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 16:07:11 +0000 (GMT)
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
Subject: [RFC 07/20] ima: Move ima_htable into ima_namespace
Date:   Tue, 30 Nov 2021 11:06:41 -0500
Message-Id: <20211130160654.1418231-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130160654.1418231-1-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RMew2CsO0ZGfuzwuF8arraUre0QessRw
X-Proofpoint-ORIG-GUID: gNUtBF_abFSfuvN1StJiwwWzk8Pa-qb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ima_htable into ima_namespace. This way the a front-end like
SecurityFS can show the number of violations of an IMA namespace.

Move ima_hash_key() into ima_queue.c since it's only used there.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                      | 11 +++++++
 security/integrity/ima/ima.h             | 34 +++++++------------
 security/integrity/ima/ima_api.c         | 17 ++++++----
 security/integrity/ima/ima_fs.c          |  7 ++--
 security/integrity/ima/ima_init.c        |  6 ++--
 security/integrity/ima/ima_init_ima_ns.c |  4 +++
 security/integrity/ima/ima_main.c        | 13 ++++----
 security/integrity/ima/ima_queue.c       | 42 ++++++++++++++----------
 security/integrity/ima/ima_template.c    |  4 +--
 9 files changed, 78 insertions(+), 60 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index e782b00710ad..96254dfacfa0 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -212,6 +212,15 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 }
 #endif /* CONFIG_IMA_APPRAISE */
 
+#define IMA_HASH_BITS 10
+#define IMA_MEASURE_HTABLE_SIZE (1 << IMA_HASH_BITS)
+
+struct ima_h_table {
+	atomic_long_t len;	/* number of stored measurements in the list */
+	atomic_long_t violations;
+	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
+};
+
 struct ima_namespace {
 	struct kref kref;
 	struct user_namespace *user_ns;
@@ -249,6 +258,8 @@ struct ima_namespace {
 	struct list_head __rcu *ima_rules;
 	/* current content of the policy */
 	int ima_policy_flag;
+
+	struct ima_h_table ima_htable;
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e295141f2478..a7e6c8fb152a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -32,9 +32,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
 #define IMA_EVENT_NAME_LEN_MAX	255
 
-#define IMA_HASH_BITS 10
-#define IMA_MEASURE_HTABLE_SIZE (1 << IMA_HASH_BITS)
-
 #define IMA_TEMPLATE_FIELD_ID_MAX_LEN	16
 #define IMA_TEMPLATE_NUM_FIELDS_MAX	15
 
@@ -143,7 +140,8 @@ struct ns_status {
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
-int ima_add_template_entry(struct ima_template_entry *entry, int violation,
+int ima_add_template_entry(struct ima_namespace *ns,
+			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename);
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
@@ -152,7 +150,8 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_entry *entry);
 int ima_calc_boot_aggregate(struct ima_digest_data *hash);
-void ima_add_violation(struct file *file, const unsigned char *filename,
+void ima_add_violation(struct ima_namespace *ns,
+		       struct file *file, const unsigned char *filename,
 		       struct integrity_iint_cache *iint,
 		       const char *op, const char *cause);
 int ima_init_crypto(void);
@@ -165,8 +164,10 @@ struct ima_template_desc *ima_template_desc_current(void);
 struct ima_template_desc *ima_template_desc_buf(void);
 struct ima_template_desc *lookup_template_desc(const char *name);
 bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
-int ima_restore_measurement_entry(struct ima_template_entry *entry);
-int ima_restore_measurement_list(loff_t bufsize, void *buf);
+int ima_restore_measurement_entry(struct ima_namespace *ns,
+				  struct ima_template_entry *entry);
+int ima_restore_measurement_list(struct ima_namespace *ns,
+				 loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
@@ -180,19 +181,6 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
  */
 extern spinlock_t ima_queue_lock;
 
-struct ima_h_table {
-	atomic_long_t len;	/* number of stored measurements in the list */
-	atomic_long_t violations;
-	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
-};
-extern struct ima_h_table ima_htable;
-
-static inline unsigned int ima_hash_key(u8 *digest)
-{
-	/* there is no point in taking a hash of part of a digest */
-	return (digest[0] | digest[1] << 8) % IMA_MEASURE_HTABLE_SIZE;
-}
-
 #define __ima_hooks(hook)				\
 	hook(NONE, none)				\
 	hook(FILE_CHECK, file)				\
@@ -272,7 +260,8 @@ int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
 			    enum hash_algo algo, struct modsig *modsig);
-void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
+void ima_store_measurement(struct ima_namespace *ns,
+			   struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
@@ -289,7 +278,8 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_entry **entry,
 			    struct ima_template_desc *template_desc);
-int ima_store_template(struct ima_template_entry *entry, int violation,
+int ima_store_template(struct ima_namespace *ns,
+		       struct ima_template_entry *entry, int violation,
 		       struct inode *inode,
 		       const unsigned char *filename, int pcr);
 void ima_free_template_entry(struct ima_template_entry *entry);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 808aec56dbb6..71c5517fe8bc 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -100,7 +100,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
  *
  * Returns 0 on success, error code otherwise
  */
-int ima_store_template(struct ima_template_entry *entry,
+int ima_store_template(struct ima_namespace *ns,
+		       struct ima_template_entry *entry,
 		       int violation, struct inode *inode,
 		       const unsigned char *filename, int pcr)
 {
@@ -120,7 +121,7 @@ int ima_store_template(struct ima_template_entry *entry,
 		}
 	}
 	entry->pcr = pcr;
-	result = ima_add_template_entry(entry, violation, op, inode, filename);
+	result = ima_add_template_entry(ns, entry, violation, op, inode, filename);
 	return result;
 }
 
@@ -131,7 +132,8 @@ int ima_store_template(struct ima_template_entry *entry,
  * By extending the PCR with 0xFF's instead of with zeroes, the PCR
  * value is invalidated.
  */
-void ima_add_violation(struct file *file, const unsigned char *filename,
+void ima_add_violation(struct ima_namespace *ns,
+		       struct file *file, const unsigned char *filename,
 		       struct integrity_iint_cache *iint,
 		       const char *op, const char *cause)
 {
@@ -145,14 +147,14 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	int result;
 
 	/* can overflow, only indicator */
-	atomic_long_inc(&ima_htable.violations);
+	atomic_long_inc(&ns->ima_htable.violations);
 
 	result = ima_alloc_init_template(&event_data, &entry, NULL);
 	if (result < 0) {
 		result = -ENOMEM;
 		goto err_out;
 	}
-	result = ima_store_template(entry, violation, inode,
+	result = ima_store_template(ns, entry, violation, inode,
 				    filename, CONFIG_IMA_MEASURE_PCR_IDX);
 	if (result < 0)
 		ima_free_template_entry(entry);
@@ -299,7 +301,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
  *
  * Must be called with iint->mutex held.
  */
-void ima_store_measurement(struct integrity_iint_cache *iint,
+void ima_store_measurement(struct ima_namespace *ns,
+			   struct integrity_iint_cache *iint,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
@@ -334,7 +337,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 		return;
 	}
 
-	result = ima_store_template(entry, violation, inode, filename, pcr);
+	result = ima_store_template(ns, entry, violation, inode, filename, pcr);
 	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
 		iint->flags |= IMA_MEASURED;
 		iint->measured_pcrs |= (0x1 << pcr);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index fc0413c8c358..9df8648ad64d 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -53,7 +53,9 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 					  char __user *buf,
 					  size_t count, loff_t *ppos)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
+	struct ima_namespace *ns = get_current_ns();
+
+	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.violations);
 }
 
 static const struct file_operations ima_htable_violations_ops = {
@@ -65,8 +67,9 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
+	struct ima_namespace *ns = get_current_ns();
 
+	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
 }
 
 static const struct file_operations ima_measurements_count_ops = {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 2ec9a22bbddf..6104d5116a7f 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -39,7 +39,7 @@ struct tpm_chip *ima_tpm_chip;
  * a different value.) Violations add a zero entry to the measurement
  * list and extend the aggregate PCR value with ff...ff's.
  */
-static int __init ima_add_boot_aggregate(void)
+static int __init ima_add_boot_aggregate(struct ima_namespace *ns)
 {
 	static const char op[] = "add_boot_aggregate";
 	const char *audit_cause = "ENOMEM";
@@ -86,7 +86,7 @@ static int __init ima_add_boot_aggregate(void)
 		goto err_out;
 	}
 
-	result = ima_store_template(entry, violation, NULL,
+	result = ima_store_template(ns, entry, violation, NULL,
 				    boot_aggregate_name,
 				    CONFIG_IMA_MEASURE_PCR_IDX);
 	if (result < 0) {
@@ -145,7 +145,7 @@ int __init ima_init(void)
 	rc = ima_init_digests();
 	if (rc != 0)
 		return rc;
-	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
+	rc = ima_add_boot_aggregate(&init_ima_ns);	/* boot aggregate must be first entry */
 	if (rc != 0)
 		return rc;
 
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 2d644791a795..e13adc3287ed 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -40,6 +40,10 @@ int ima_init_namespace(struct ima_namespace *ns)
 	ns->ima_rules = (struct list_head __rcu *)(&ns->ima_default_rules);
 	ns->ima_policy_flag = 0;
 
+	atomic_long_set(&ns->ima_htable.len, 0);
+	atomic_long_set(&ns->ima_htable.violations, 0);
+	memset(&ns->ima_htable.queue, 0, sizeof(ns->ima_htable.queue));
+
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9cf1fd7c70bf..d692c9d53a98 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -112,7 +112,8 @@ static int mmap_violation_check(enum ima_hooks func, struct file *file,
  *	  could result in a file measurement error.
  *
  */
-static void ima_rdwr_violation_check(struct file *file,
+static void ima_rdwr_violation_check(struct ima_namespace *ns,
+				     struct file *file,
 				     struct integrity_iint_cache *iint,
 				     int must_measure,
 				     char **pathbuf,
@@ -145,10 +146,10 @@ static void ima_rdwr_violation_check(struct file *file,
 	*pathname = ima_d_path(&file->f_path, pathbuf, filename);
 
 	if (send_tomtou)
-		ima_add_violation(file, *pathname, iint,
+		ima_add_violation(ns, file, *pathname, iint,
 				  "invalid_pcr", "ToMToU");
 	if (send_writers)
-		ima_add_violation(file, *pathname, iint,
+		ima_add_violation(ns, file, *pathname, iint,
 				  "invalid_pcr", "open_writers");
 }
 
@@ -256,7 +257,7 @@ static int process_measurement(struct ima_namespace *ns,
 	}
 
 	if (!rc && violation_check)
-		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
+		ima_rdwr_violation_check(ns, file, iint, action & IMA_MEASURE,
 					 &pathbuf, &pathname, filename);
 
 	inode_unlock(inode);
@@ -353,7 +354,7 @@ static int process_measurement(struct ima_namespace *ns,
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
 	if (action & IMA_MEASURE)
-		ima_store_measurement(iint, file, pathname,
+		ima_store_measurement(ns, iint, file, pathname,
 				      xattr_value, xattr_len, modsig, pcr,
 				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
@@ -969,7 +970,7 @@ int process_buffer_measurement(struct ima_namespace *ns,
 		goto out;
 	}
 
-	ret = ima_store_template(entry, violation, NULL, event_data.buf, pcr);
+	ret = ima_store_template(ns, entry, violation, NULL, event_data.buf, pcr);
 	if (ret < 0) {
 		audit_cause = "store_entry";
 		ima_free_template_entry(entry);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..373154039b91 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -17,6 +17,7 @@
 
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <linux/ima.h>
 #include "ima.h"
 
 #define AUDIT_CAUSE_LEN_MAX 32
@@ -31,21 +32,22 @@ static unsigned long binary_runtime_size;
 static unsigned long binary_runtime_size = ULONG_MAX;
 #endif
 
-/* key: inode (before secure-hashing a file) */
-struct ima_h_table ima_htable = {
-	.len = ATOMIC_LONG_INIT(0),
-	.violations = ATOMIC_LONG_INIT(0),
-	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
-};
-
 /* mutex protects atomicity of extending measurement list
  * and extending the TPM PCR aggregate. Since tpm_extend can take
  * long (and the tpm driver uses a mutex), we can't use the spinlock.
  */
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
+
+static inline unsigned int ima_hash_key(u8 *digest)
+{
+	/* there is no point in taking a hash of part of a digest */
+	return (digest[0] | digest[1] << 8) % IMA_MEASURE_HTABLE_SIZE;
+}
+
 /* lookup up the digest value in the hash table, and return the entry */
-static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
+static struct ima_queue_entry *ima_lookup_digest_entry(struct ima_namespace *ns,
+						       u8 *digest_value,
 						       int pcr)
 {
 	struct ima_queue_entry *qe, *ret = NULL;
@@ -54,7 +56,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 
 	key = ima_hash_key(digest_value);
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
+	hlist_for_each_entry_rcu(qe, &ns->ima_htable.queue[key], hnext) {
 		rc = memcmp(qe->entry->digests[ima_hash_algo_idx].digest,
 			    digest_value, hash_digest_size[ima_hash_algo]);
 		if ((rc == 0) && (qe->entry->pcr == pcr)) {
@@ -90,7 +92,8 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
  *
  * (Called with ima_extend_list_mutex held.)
  */
-static int ima_add_digest_entry(struct ima_template_entry *entry,
+static int ima_add_digest_entry(struct ima_namespace *ns,
+				struct ima_template_entry *entry,
 				bool update_htable)
 {
 	struct ima_queue_entry *qe;
@@ -106,11 +109,12 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	INIT_LIST_HEAD(&qe->later);
 	list_add_tail_rcu(&qe->later, &ima_measurements);
 
-	atomic_long_inc(&ima_htable.len);
+	atomic_long_inc(&ns->ima_htable.len);
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
-		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
-	}
+		hlist_add_head_rcu(&qe->hnext, &ns->ima_htable.queue[key]);
+	} else
+		INIT_HLIST_NODE(&qe->hnext);
 
 	if (binary_runtime_size != ULONG_MAX) {
 		int size;
@@ -156,7 +160,8 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
  * kexec, maintain the total memory size required for serializing the
  * binary_runtime_measurements.
  */
-int ima_add_template_entry(struct ima_template_entry *entry, int violation,
+int ima_add_template_entry(struct ima_namespace *ns,
+			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename)
 {
@@ -169,14 +174,14 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 
 	mutex_lock(&ima_extend_list_mutex);
 	if (!violation && !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
-		if (ima_lookup_digest_entry(digest, entry->pcr)) {
+		if (ima_lookup_digest_entry(ns, digest, entry->pcr)) {
 			audit_cause = "hash_exists";
 			result = -EEXIST;
 			goto out;
 		}
 	}
 
-	result = ima_add_digest_entry(entry,
+	result = ima_add_digest_entry(ns, entry,
 				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
 	if (result < 0) {
 		audit_cause = "ENOMEM";
@@ -201,12 +206,13 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	return result;
 }
 
-int ima_restore_measurement_entry(struct ima_template_entry *entry)
+int ima_restore_measurement_entry(struct ima_namespace *ns,
+				  struct ima_template_entry *entry)
 {
 	int result = 0;
 
 	mutex_lock(&ima_extend_list_mutex);
-	result = ima_add_digest_entry(entry, 0);
+	result = ima_add_digest_entry(ns, entry, 0);
 	mutex_unlock(&ima_extend_list_mutex);
 	return result;
 }
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 694560396be0..2ae87eb23a59 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -400,7 +400,7 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 }
 
 /* Restore the serialized binary measurement list without extending PCRs. */
-int ima_restore_measurement_list(loff_t size, void *buf)
+int ima_restore_measurement_list(struct ima_namespace *ns, loff_t size, void *buf)
 {
 	char template_name[MAX_TEMPLATE_NAME_LEN];
 	unsigned char zero[TPM_DIGEST_SIZE] = { 0 };
@@ -516,7 +516,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(__le32 *)(hdr[HDR_PCR].data));
-		ret = ima_restore_measurement_entry(entry);
+		ret = ima_restore_measurement_entry(ns, entry);
 		if (ret < 0)
 			break;
 
-- 
2.31.1

