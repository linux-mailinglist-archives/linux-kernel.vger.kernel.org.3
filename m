Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077B949BF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiAYWsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:48:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234218AbiAYWr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMh0vw011541;
        Tue, 25 Jan 2022 22:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0vN/OnpNxs2gxrQFo4ydOTrn69NRjrKOtMZh3Q4N+Js=;
 b=UxL+JZ2+j0oUZEwBpvjx5pPDKUqsQH3ABb658S2Nmlc4YvuqjyGJ2nVcCDT+IWAxpquI
 CIe+aM+6kTFw9QlskC3dylczHOhrnYSqYIEotJg1No4wKaYxE/kyP/gFMdDkG8AP5jm3
 /GuZXLlBi9QtbPfHVQ9Z8od6hDEzorVukG8Ci4PVY+PEXcZQQ0oyWrJZbDi+KdLtfBLp
 HJbM5/tHMDvuCe/KPLrReNXsMOJyr9cbMW4YeSXIo2K7kKnOX+3DH5+E16PSWzsUY4yx
 yNq86bo3ubygt09f7gYS4PToJarEPTSwCtlfSsDCD6JuCDBONXmXJ3wmu9c9ThsawTy3 bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtt83g1v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:05 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMhC3H012543;
        Tue, 25 Jan 2022 22:47:04 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtt83g1uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:04 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PMh3Mr011257;
        Tue, 25 Jan 2022 22:47:03 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3dt1x9rg8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:03 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PMkxgs31719798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:46:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C47D2AC068;
        Tue, 25 Jan 2022 22:46:59 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93EC1AC05E;
        Tue, 25 Jan 2022 22:46:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 22:46:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
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
Subject: [PATCH v9 23/23] ima: Enable IMA namespaces
Date:   Tue, 25 Jan 2022 17:46:45 -0500
Message-Id: <20220125224645.79319-24-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: grqyLkGugVKLiWcMKy70l8R11h_vfkiJ
X-Proofpoint-GUID: vGO_ywtuqZ0AMPqbdjSjap4nfpVs1T8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Introduce the IMA_NS in Kconfig for IMA namespace enablement.

Enable the lazy initialization of an IMA namespace when a user mounts
SecurityFS and writes '1' into IMA's 'active' securityfs file. A
user_namespace will now get a pointer to an ima_namespace and therefore
implement get_current_ns() for the namespacing case that returns this
pointer. Use get_current_ns() in those places that require access to the
current IMA namespace. In some places, primarily those related to
IMA-appraisal and changes to file attributes, keep the pointer to
init_ima_ns, since there flags related to file measurements may be
affected, which are not supported in IMA namespaces, yet.

Before using the ima_namespace pointer test it with ns_is_active()
to check whether it is NULL and whether the ima_namespace is active.
If it's not active, it cannot be used, yet. Therefore, return early
from those functions that may now get either get a NULL pointer from
this call or where ns->active is still 0. The init_ima_ns is always
set to be active, thus passing the check.

Implement ima_ns_from_file() for SecurityFS-related files where we can
now get the IMA namespace via the user namespace pointer associated
with the superblock of the SecurityFS filesystem instance.

Return -EACCES to IMA's securityfs files, except for the 'active' file,
until the IMA namespace has been set to active.

Switch access to userns->ima_ns to use acquire/release semantics to ensure
that a newly created ima_namespace structure is fully visible upon access.

Only emit the kernel log message 'policy update completed' for the
init_ima_ns.

Gate access to ima_appraise variable to init_ima_ns in ima_load_data().

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v9:
 - ima_post_key_create_or_update: Only handle key if in init_ima_ns
 - Removed ns == NULL checks where user_namespace is now passed
 - Defer setting of user_ns->ima_ns until end of ima_fs_ns_init();
   required new ima_free_imans() and new user_ns_set_ima_ns()
 - Only emit log message 'policy update completed' for init_ima_ns
 - Introduce get_current_ns() only in this patch
 - Check for ns == &init_ima_ns in ima_load_data()
---
 include/linux/ima.h                          | 13 ++++
 init/Kconfig                                 | 13 ++++
 kernel/user_namespace.c                      |  2 +
 security/integrity/ima/ima.h                 | 51 ++++++++++++--
 security/integrity/ima/ima_appraise.c        |  3 +
 security/integrity/ima/ima_asymmetric_keys.c |  6 +-
 security/integrity/ima/ima_fs.c              | 74 ++++++++++++++++----
 security/integrity/ima/ima_init_ima_ns.c     |  2 +
 security/integrity/ima/ima_main.c            | 35 +++++----
 security/integrity/ima/ima_ns.c              | 15 ++--
 security/integrity/ima/ima_policy.c          | 16 +++--
 11 files changed, 188 insertions(+), 42 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index c584527c0f47..4e595bd9733e 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <linux/user_namespace.h>
 #include <crypto/hash_info.h>
 struct linux_binprm;
 
@@ -68,6 +69,18 @@ static inline const char * const *arch_get_ima_policy(void)
 }
 #endif
 
+static inline struct user_namespace
+*ima_ns_to_user_ns(struct ima_namespace *ns)
+{
+	struct user_namespace *user_ns;
+
+	user_ns = current_user_ns();
+#ifdef CONFIG_IMA_NS
+	WARN_ON(user_ns->ima_ns != ns);
+#endif
+	return user_ns;
+}
+
 #else
 static inline enum hash_algo ima_get_current_hash_algo(void)
 {
diff --git a/init/Kconfig b/init/Kconfig
index 4b7bac10c72d..e27155e0ddba 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1247,6 +1247,19 @@ config NET_NS
 	  Allow user space to create what appear to be multiple instances
 	  of the network stack.
 
+config IMA_NS
+	bool "IMA namespace"
+	depends on USER_NS
+	depends on IMA
+	default n
+	help
+	  Allow the creation of an IMA namespace for each user namespace.
+	  Namespaced IMA enables having IMA features work separately
+	  in each IMA namespace.
+	  Currently, only the audit status flags are stored in the namespace,
+	  which allows the same file to be audited each time it is accessed
+	  in a new namespace.
+
 endif # NAMESPACES
 
 config CHECKPOINT_RESTORE
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..653f8fa83b69 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -20,6 +20,7 @@
 #include <linux/fs_struct.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/ima.h>
 
 static struct kmem_cache *user_ns_cachep __read_mostly;
 static DEFINE_MUTEX(userns_state_mutex);
@@ -196,6 +197,7 @@ static void free_user_ns(struct work_struct *work)
 			kfree(ns->projid_map.forward);
 			kfree(ns->projid_map.reverse);
 		}
+		free_ima_ns(ns);
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cf2f63bb5bdf..a0dbb1dccc8e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -536,32 +536,70 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
 	return file_inode(filp)->i_sb->s_user_ns;
 }
 
+#ifdef CONFIG_IMA_NS
+
 static inline struct ima_namespace
 *ima_ns_from_user_ns(struct user_namespace *user_ns)
 {
-	if (user_ns == &init_user_ns)
-		return &init_ima_ns;
-	return NULL;
+	/* Pairs with smp_store_releases() in user_ns_set_ima_ns(). */
+	return smp_load_acquire(&user_ns->ima_ns);
 }
 
-#ifdef CONFIG_IMA_NS
+static inline void user_ns_set_ima_ns(struct user_namespace *user_ns,
+				      struct ima_namespace *ns)
+{
+	/* Pairs with smp_load_acquire() in ima_ns_from_user_ns() */
+	smp_store_release(&user_ns->ima_ns, ns);
+}
+
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return ima_ns_from_user_ns(current_user_ns());
+}
 
 struct ima_namespace *create_ima_ns(void);
 
+void ima_free_ima_ns(struct ima_namespace *ns);
+
 struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 				    struct inode *inode,
 				    struct integrity_iint_cache *iint);
 
 void ima_free_ns_status_tree(struct ima_namespace *ns);
 
+static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
+{
+	return ima_user_ns_from_file(filp)->ima_ns;
+}
+
 #else
 
+static inline struct ima_namespace
+*ima_ns_from_user_ns(struct user_namespace *user_ns)
+{
+	if (user_ns == &init_user_ns)
+		return &init_ima_ns;
+	return NULL;
+}
+
+static inline void user_ns_set_ima_ns(struct user_namespace *user_ns,
+				      struct ima_namespace *ns)
+{
+}
+
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return &init_ima_ns;
+}
+
 static inline struct ima_namespace *create_ima_ns(void)
 {
 	WARN(1, "Cannot create an IMA namespace\n");
 	return ERR_PTR(-EFAULT);
 }
 
+static inline void ima_free_ima_ns(struct ima_namespace *ns) {}
+
 static inline struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 						  struct inode *inode,
 						  struct integrity_iint_cache *iint)
@@ -576,6 +614,11 @@ static inline struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 	return ns_status;
 }
 
+static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
+{
+	return &init_ima_ns;
+}
+
 #endif /* CONFIG_IMA_NS */
 
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3461025f671b..2ad3327d7ce6 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -74,6 +74,9 @@ int ima_must_appraise(struct ima_namespace *ns,
 {
 	u32 secid;
 
+	if (ns != &init_ima_ns)
+		return 0;
+
 	if (!ima_appraise)
 		return 0;
 
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 70d87df26068..0d2cc1e23cde 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -30,9 +30,13 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	bool queued = false;
 
+	/* only handle key if related to init_ima_ns */
+	if (ns != &init_ima_ns)
+		return;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 79a786db79db..f6fd3abcaebf 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -49,7 +49,10 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 					  char __user *buf,
 					  size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
 
 	return ima_show_htable_value(buf, count, ppos,
 				     &ns->ima_htable.violations);
@@ -64,7 +67,10 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
 
 	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
 }
@@ -77,7 +83,7 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
@@ -95,7 +101,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 
 static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_queue_entry *qe = v;
 
 	/* lock protects when reading beyond last element
@@ -198,6 +204,11 @@ static const struct seq_operations ima_measurments_seqops = {
 
 static int ima_measurements_open(struct inode *inode, struct file *file)
 {
+	struct ima_namespace *ns = ima_ns_from_file(file);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
+
 	return seq_open(file, &ima_measurments_seqops);
 }
 
@@ -264,6 +275,11 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
 
 static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 {
+	struct ima_namespace *ns = ima_ns_from_file(file);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
+
 	return seq_open(file, &ima_ascii_measurements_seqops);
 }
 
@@ -317,10 +333,13 @@ static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(file);
 	char *data;
 	ssize_t result;
 
+	if (!ns_is_active(ns))
+		return -EACCES;
+
 	if (datalen >= PAGE_SIZE)
 		datalen = PAGE_SIZE - 1;
 
@@ -381,7 +400,10 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #ifdef CONFIG_IMA_READ_POLICY
 	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
 #endif
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
 
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
@@ -408,7 +430,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(file);
 	const char *cause = ns->valid_policy ? "completed" : "failed";
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
@@ -419,7 +441,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 		ns->valid_policy = 0;
 	}
 
-	pr_info("policy update %s\n", cause);
+	if (ns == &init_ima_ns)
+		pr_info("policy update %s\n", cause);
 	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 			    "policy_update", cause, !ns->valid_policy, 0);
 
@@ -455,7 +478,7 @@ static ssize_t ima_show_active(struct file *filp,
 			       char __user *buf,
 			       size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
 	char tmpbuf[2];
 	ssize_t len;
 
@@ -468,7 +491,7 @@ static ssize_t ima_write_active(struct file *filp,
 				const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
 	unsigned int active;
 	char tmpbuf[3];
 	ssize_t ret;
@@ -482,8 +505,11 @@ static ssize_t ima_write_active(struct file *filp,
 		return ret;
 	tmpbuf[ret] = 0;
 
-	if (!kstrtouint(tmpbuf, 10, &active) && active == 1)
-		atomic_set(&ns->active, 1);
+	if (!kstrtouint(tmpbuf, 10, &active) && active == 1) {
+		ret = ima_init_namespace(ns);
+		if (ret < 0)
+			count = -EINVAL;
+	}
 
 	return count;
 }
@@ -518,11 +544,26 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
 
+	/*
+	 * While multiple superblocks can exist they are keyed by userns in
+	 * s_fs_info for securityfs. The first time a userns mounts a
+	 * securityfs instance we lazily allocate the ima_namespace for the
+	 * userns since that's the only way a userns can meaningfully use ima.
+	 * The vfs ensures we're the only one to call fill_super() and hence
+	 * ima_fs_ns_init(), so we don't need any memory barriers here, i.e.
+	 * user_ns->ima_ns can't change while we're in here.
+	 */
+	if (!ns) {
+		ns = create_ima_ns();
+		if (IS_ERR(ns))
+			return PTR_ERR(ns);
+	}
+
 	/* FIXME: update when evm and integrity are namespaced */
 	if (user_ns != &init_user_ns) {
 		int_dir = securityfs_create_dir("integrity", root);
 		if (IS_ERR(int_dir))
-			return PTR_ERR(int_dir);
+			goto free_ns;
 	} else {
 		int_dir = integrity_dir;
 	}
@@ -575,6 +616,9 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	if (ns != &init_ima_ns && ima_fs_add_ns_files(ima_dir))
 		goto out;
 
+	if (!ima_ns_from_user_ns(user_ns))
+		user_ns_set_ima_ns(user_ns, ns);
+
 	return 0;
 out:
 	securityfs_remove(ns->ima_policy);
@@ -587,6 +631,10 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	if (user_ns != &init_user_ns)
 		securityfs_remove(int_dir);
 
+free_ns:
+	if (!ima_ns_from_user_ns(user_ns))
+		ima_free_ima_ns(ns);
+
 	return -1;
 }
 
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 39ee0c2477a6..0ff587b874bd 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -46,6 +46,8 @@ int ima_init_namespace(struct ima_namespace *ns)
 			return rc;
 	}
 
+	atomic_set(&ns->active, 1);
+
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 059917182960..1ffac9c04df1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -506,7 +506,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct ima_template_desc *template = NULL;
 	struct file *file = vma->vm_file;
 	char filename[NAME_MAX];
@@ -519,7 +519,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
-	if (!(ns->ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
+	if (!ns_is_active(ns) ||
+	    !(ns->ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
@@ -655,9 +656,9 @@ static int __ima_inode_hash(struct ima_namespace *ns,
  */
 int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
-	if (!file)
+	if (!ns_is_active(ns) || !file)
 		return -EINVAL;
 
 	return __ima_inode_hash(ns, file_inode(file), buf, buf_size);
@@ -684,9 +685,9 @@ EXPORT_SYMBOL_GPL(ima_file_hash);
  */
 int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
-	if (!inode)
+	if (!ns_is_active(ns) || !inode)
 		return -EINVAL;
 
 	return __ima_inode_hash(ns, inode, buf, buf_size);
@@ -705,11 +706,11 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
 void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 			     struct inode *inode)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
-	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns_is_active(ns) || !ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
 	must_appraise = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS,
@@ -738,12 +739,12 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 void ima_post_path_mknod(struct user_namespace *mnt_userns,
 			 struct dentry *dentry)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
-	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns_is_active(ns) || !ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
 	must_appraise = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS,
@@ -827,6 +828,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
 	struct user_namespace *user_ns = current_user_ns();
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 	enum ima_hooks func;
 	u32 secid;
 
@@ -861,8 +863,12 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  */
 int ima_load_data(enum kernel_load_data_id id, bool contents)
 {
+	struct ima_namespace *ns = get_current_ns();
 	bool ima_enforce, sig_enforce;
 
+	if (ns != &init_ima_ns)
+		return 0;
+
 	ima_enforce =
 		(ima_appraise & IMA_APPRAISE_ENFORCE) == IMA_APPRAISE_ENFORCE;
 
@@ -1070,10 +1076,10 @@ int process_buffer_measurement(struct ima_namespace *ns,
  */
 void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct fd f;
 
-	if (!buf || !size)
+	if (!ns_is_active(ns) || !buf || !size)
 		return;
 
 	f = fdget(kernel_fd);
@@ -1111,7 +1117,10 @@ int ima_measure_critical_data(const char *event_label,
 			      const void *buf, size_t buf_len,
 			      bool hash, u8 *digest, size_t digest_len)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
+
+	if (!ns_is_active(ns))
+		return -EINVAL;
 
 	if (!event_name || !event_label || !buf || !buf_len)
 		return -ENOPARAM;
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 29af6fea2d74..244dc9d66fb1 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -26,22 +26,29 @@ struct ima_namespace *create_ima_ns(void)
 /* destroy_ima_ns() must only be called after ima_init_namespace() was called */
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
+	atomic_set(&ns->active, 0);
 	unregister_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
 	kfree(ns->arch_policy_entry);
 	ima_free_policy_rules(ns);
 	ima_free_ns_status_tree(ns);
 }
 
-void free_ima_ns(struct user_namespace *user_ns)
+void ima_free_ima_ns(struct ima_namespace *ns)
 {
-	struct ima_namespace *ns = user_ns->ima_ns;
-
 	if (!ns || WARN_ON(ns == &init_ima_ns))
 		return;
 
-	destroy_ima_ns(ns);
+	if (ns_is_active(ns))
+		destroy_ima_ns(ns);
 
 	kmem_cache_free(imans_cachep, ns);
+}
+
+void free_ima_ns(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
+
+	ima_free_ima_ns(ns);
 
 	user_ns->ima_ns = NULL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 151f418036ee..2b8210f0be44 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -471,7 +471,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;
 
 	ns = container_of(nb, struct ima_namespace, ima_lsm_policy_notifier);
-	ima_lsm_update_rules(ns);
+	if (ns_is_active(ns))
+		ima_lsm_update_rules(ns);
 
 	return NOTIFY_OK;
 }
@@ -1334,6 +1335,7 @@ static unsigned int ima_parse_appraise_algos(char *arg)
 static int ima_parse_rule(struct ima_namespace *ns,
 			  char *rule, struct ima_rule_entry *entry)
 {
+	struct user_namespace *user_ns = ima_ns_to_user_ns(ns);
 	struct audit_buffer *ab;
 	char *from;
 	char *p;
@@ -1583,7 +1585,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->uid = make_kuid(current_user_ns(),
+				entry->uid = make_kuid(user_ns,
 						       (uid_t) lnum);
 				if (!uid_valid(entry->uid) ||
 				    (uid_t)lnum != lnum)
@@ -1618,7 +1620,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->gid = make_kgid(current_user_ns(),
+				entry->gid = make_kgid(user_ns,
 						       (gid_t)lnum);
 				if (!gid_valid(entry->gid) ||
 				    (((gid_t)lnum) != lnum))
@@ -1645,7 +1647,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fowner = make_kuid(current_user_ns(),
+				entry->fowner = make_kuid(user_ns,
 							  (uid_t)lnum);
 				if (!uid_valid(entry->fowner) ||
 				    (((uid_t)lnum) != lnum))
@@ -1671,7 +1673,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fgroup = make_kgid(current_user_ns(),
+				entry->fgroup = make_kgid(user_ns,
 							  (gid_t)lnum);
 				if (!gid_valid(entry->fgroup) ||
 				    (((gid_t)lnum) != lnum))
@@ -1925,7 +1927,7 @@ static const char *const mask_tokens[] = {
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
@@ -1944,7 +1946,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_rule_entry *entry = v;
 
 	rcu_read_lock();
-- 
2.31.1

