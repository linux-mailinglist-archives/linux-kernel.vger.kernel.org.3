Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC44479ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhLRMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:41:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41684 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhLRMlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:41:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 184E8B8090A;
        Sat, 18 Dec 2021 12:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5B5C36AE5;
        Sat, 18 Dec 2021 12:41:15 +0000 (UTC)
Date:   Sat, 18 Dec 2021 13:41:12 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v7 00/14] ima: Namespace IMA with audit support in IMA-ns
Message-ID: <20211218124112.3ipdzfsbndtzel5t@wittgenstein>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216125027.fte6625wu5vxkjpi@wittgenstein>
 <20211216133148.aw3xs4sxuebkampb@wittgenstein>
 <0d6d0a22-0f3a-5f99-e603-f139d8fe7801@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d6d0a22-0f3a-5f99-e603-f139d8fe7801@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 09:38:16PM -0500, Stefan Berger wrote:
> 
> On 12/16/21 08:31, Christian Brauner wrote:
> > 
> > 1. namespace securityfs
> >     This patch is thematically standalone and should move to the
> >     beginning of the series.
> >     I would strongly recommend to fold patch 9 and 10 into a single patch
> >     and add a lengthy explanation. You should be able to recycle a lof of
> >     stuff I wrote in earlier reviews.
> > 
> > 2. Introduce struct ima_namespace and pass it through to all callers:
> >     - introduce struct ima_namespace
> >     - move all the relevant things into this structure (this also avoids
> >       the "avoid_zero_size" hack).
> 
> 
> We could defer the kmalloc() that doesn't work on a zero-sized request. I
> would say this  is minor.
> 
> 
> >     - define, setup, and expose init_ima_ns
> >     - introduce get_current_ns() and always have it return &init_ima_ns for now
> >     - replace all accesses to global variables to go through &init_ima_ns
> >     - add new infrastructure you'll need later on
> >     Bonus is that you can extend all the functions that later need access
> >     to a specific ima namespace to take a struct ima_namespace * argument
> >     and pass down &init_ima_ns down (retrieved via get_current_ns()). This
> >     will make the actual namespace patch very easy to follow.
> > 
> > 3. namespace ima
> >     - add a new entry for struct ima_namespace to struct user_namespace
> >     - add creation helpers, kmem cache etc.
> >     - create files in securityfs per ns
> 
> I have tried this now and I am looking at 4 remaining patches that need to
> somehow find its way into v8 without causing too many disturbances. At what
> point (over how many patches) can I introduce CONFIG_IMA_NS without anything
> related to IMA namespacing happening? I need it early in 'your 3rd part'
> since it is also used for conditional compilation (Makefile) and #ifdef's
> where Makefile content and what the #ifdefs are doing probably shouldn't be
> squeezed into a single patch just so it's all enabled in one patch, but it
> should probably still remain logically separated into different patches.
> Enablement of IMA namespace would be in the very last patch. But there may
> be several patches between the very last one and CONFIG_IMA_NS is
> introduced...
> 
> v7 at least, before the requirement to do late/lazy initialization, enabled
> CONFIG_IMA_NS right away and built ever step on top of it, even if the IMA
> namespace only became **configurable** in the last patch when securityfs was
> enbled and one could set a policy. From that perspective it would be easier
> to switch to late initialization in a patch on top of v7 but .. ok, we
> cannot do that.
> 
> 
> > This way at all points in the series we have clearly defined semantics
> > where ima namespacing is either fully working or fully not working and
> > the switch is atomic in the patch(es) part of 3.
> Atomic over multiple patches? So introducing CONFIG_IMA_NS that doesn't do
> anything for several patches is still considered 'atomic' then ?

I was hoping I wouldn't need to do this but I think at this point it's
easier to illustrate what I mean than it is to try and explain it
sufficiently detailed.
Here's a __completely uncompiled and untested__ series illustrating the
organization I had in mind. This should hopefully answer all of your
questions. The series can be found at

git clone https://github.com/brauner/linux.git stefanberger.v5.15+imans.v8.v2

here's it for illustration (again, completely uncompiled and untested).
(It consists of all your patches but I've changed author and sign-off
for this excercise.):

From d254b41106ad7b33ef0a7e0d131695d95f7da01b Mon Sep 17 00:00:00 2001
From: Plummy McPlumbface <plummy@mcblumbface.events>
Date: Fri, 3 Dec 2021 15:47:12 -0500
Subject: [PATCH 1/8] !!!! UNCOMPILED & UNTESTED !!!! securityfs: Extend
 securityfs with namespacing support

Extend 'securityfs' for support of IMA namespacing so that each
IMA (user) namespace can have its own front-end for showing the currently
active policy, the measurement list, number of violations and so on.

Drop the addition dentry reference to enable simple cleanup of dentries
upon umount.

Prevent mounting of an instance of securityfs in another user namespace
than it belongs to. Also, prevent accesses to directories when another
user namespace is active than the one that the instance of securityfs
belongs to.

Signed-off-by: Plummy McPlumbface <plummy@mcblumbface.events>
---
 security/inode.c | 71 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..ff720c6bedb0 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -21,9 +21,33 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include <linux/user_namespace.h>
 
-static struct vfsmount *mount;
-static int mount_count;
+static struct vfsmount *init_securityfs_mount;
+static int init_securityfs_mount_count;
+
+static int securityfs_permission(struct user_namespace *mnt_userns,
+				 struct inode *inode, int mask)
+{
+	int err;
+
+	err = generic_permission(&init_user_ns, inode, mask);
+	if (!err) {
+		if (inode->i_sb->s_user_ns != current_user_ns())
+			err = -EACCES;
+	}
+
+	return err;
+}
+
+static const struct inode_operations securityfs_dir_inode_operations = {
+	.permission	= securityfs_permission,
+	.lookup		= simple_lookup,
+};
+
+static const struct inode_operations securityfs_file_inode_operations = {
+	.permission	= securityfs_permission,
+};
 
 static void securityfs_free_inode(struct inode *inode)
 {
@@ -40,20 +64,25 @@ static const struct super_operations securityfs_super_operations = {
 static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr files[] = {{""}};
+	struct user_namespace *ns = fc->user_ns;
 	int error;
 
+	if (WARN_ON(ns != current_user_ns()))
+		return -EINVAL;
+
 	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
 	if (error)
 		return error;
 
 	sb->s_op = &securityfs_super_operations;
+	sb->s_root->d_inode->i_op = &securityfs_dir_inode_operations;
 
 	return 0;
 }
 
 static int securityfs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, securityfs_fill_super);
+	return get_tree_keyed(fc, securityfs_fill_super, fc->user_ns);
 }
 
 static const struct fs_context_operations securityfs_context_ops = {
@@ -71,6 +100,7 @@ static struct file_system_type fs_type = {
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_USERNS_MOUNT,
 };
 
 /**
@@ -109,6 +139,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 					const struct file_operations *fops,
 					const struct inode_operations *iops)
 {
+	struct user_namespace *ns = current_user_ns();
 	struct dentry *dentry;
 	struct inode *dir, *inode;
 	int error;
@@ -118,12 +149,19 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
-	if (error)
-		return ERR_PTR(error);
+	if (ns == &init_user_ns) {
+		error = simple_pin_fs(&fs_type, &init_securityfs_mount,
+				      &init_securityfs_mount_count);
+		if (error)
+			return ERR_PTR(error);
+	}
 
-	if (!parent)
-		parent = mount->mnt_root;
+	if (!parent) {
+		if (ns == &init_user_ns)
+			parent = init_securityfs_mount->mnt_root;
+		else
+			return ERR_PTR(-EINVAL);
+	}
 
 	dir = d_inode(parent);
 
@@ -148,7 +186,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
-		inode->i_op = &simple_dir_inode_operations;
+		inode->i_op = &securityfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 		inc_nlink(inode);
 		inc_nlink(dir);
@@ -156,10 +194,10 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_op = iops ? iops : &simple_symlink_inode_operations;
 		inode->i_link = data;
 	} else {
+		inode->i_op = &securityfs_file_inode_operations;
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
@@ -168,7 +206,9 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&init_securityfs_mount,
+				  &init_securityfs_mount_count);
 	return dentry;
 }
 
@@ -294,22 +334,29 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
  */
 void securityfs_remove(struct dentry *dentry)
 {
+	struct user_namespace *ns;
 	struct inode *dir;
 
 	if (!dentry || IS_ERR(dentry))
 		return;
 
+	ns = dentry->d_sb->s_user_ns;
+
 	dir = d_inode(dentry->d_parent);
 	inode_lock(dir);
 	if (simple_positive(dentry)) {
+		dget(dentry);
 		if (d_is_dir(dentry))
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&init_securityfs_mount,
+				  &init_securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
-- 
2.30.2


From 6a4165f8092e245355c9f8c00f0e89f325020e2b Mon Sep 17 00:00:00 2001
From: Plummy McPlumbface <plummy@mcblumbface.events>
Date: Sat, 18 Dec 2021 11:37:42 +0100
Subject: [PATCH 2/8] !!!!! UNCOMPILED & UNTESTED !!!! ima: add and pass
 through ima namespace

In order to prepare ima for namespace support, introduce struct ima_namespace
and start passing it through ima.

Signed-off-by: Plummy McPlumbface <plummy@mcblumbface.events>
---
 include/linux/ima.h                          |   3 +
 security/integrity/ima/Makefile              |   2 +-
 security/integrity/ima/ima.h                 |  51 ++++++----
 security/integrity/ima/ima_api.c             |   8 +-
 security/integrity/ima/ima_appraise.c        |  28 +++--
 security/integrity/ima/ima_asymmetric_keys.c |   4 +-
 security/integrity/ima/ima_fs.c              |  16 +--
 security/integrity/ima/ima_init.c            |   8 +-
 security/integrity/ima/ima_init_ima_ns.c     |  29 ++++++
 security/integrity/ima/ima_main.c            |  83 +++++++++------
 security/integrity/ima/ima_policy.c          | 101 +++++++++++--------
 security/integrity/ima/ima_queue_keys.c      |  11 +-
 12 files changed, 223 insertions(+), 121 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b6ab66a546ae..08d507084b72 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -218,4 +218,7 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
 	return false;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
+
+extern struct ima_namespace init_ima_ns;
+
 #endif /* _LINUX_IMA_H */
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 2499f2485c04..f8a5e5f3975d 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -7,7 +7,7 @@
 obj-$(CONFIG_IMA) += ima.o
 
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o
+	 ima_policy.o ima_template.o ima_template_lib.o ima_init_ima_ns.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..1febb618b982 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -43,9 +43,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
-/* current content of the policy */
-extern int ima_policy_flag;
-
 /* bitset of digests algorithms allowed in the setxattr hook */
 extern atomic_t ima_setxattr_allowed_hash_algorithms;
 
@@ -119,6 +116,12 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+struct ima_namespace {
+	/* current content of the policy */
+	int ima_policy_flag;
+} __randomize_layout;
+extern struct ima_namespace init_ima_ns;
+
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
@@ -243,18 +246,19 @@ void ima_init_key_queue(void);
 bool ima_should_queue_key(void);
 bool ima_queue_key(struct key *keyring, const void *payload,
 		   size_t payload_len);
-void ima_process_queued_keys(void);
+void ima_process_queued_keys(struct ima_namespace *ns);
 #else
 static inline void ima_init_key_queue(void) {}
 static inline bool ima_should_queue_key(void) { return false; }
 static inline bool ima_queue_key(struct key *keyring,
 				 const void *payload,
 				 size_t payload_len) { return false; }
-static inline void ima_process_queued_keys(void) {}
+static inline void ima_process_queued_keys(struct ima_namespace *ns) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
 
 /* LIM API function definitions */
-int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_get_action(struct ima_namespace *ns,
+		   struct user_namespace *mnt_userns, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
@@ -268,7 +272,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
-int process_buffer_measurement(struct user_namespace *mnt_userns,
+int process_buffer_measurement(struct ima_namespace *ns,
+			       struct user_namespace *mnt_userns,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
@@ -285,17 +290,18 @@ void ima_free_template_entry(struct ima_template_entry *entry);
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
-void ima_update_policy(void);
-void ima_update_policy_flags(void);
-ssize_t ima_parse_add_rule(char *);
-void ima_delete_rules(void);
-int ima_check_policy(void);
+void ima_init_policy(struct ima_namespace *ns);
+void ima_update_policy(struct ima_namespace *ns);
+void ima_update_policy_flags(struct ima_namespace *ns);
+ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
+void ima_delete_rules(struct ima_namespace *ns);
+int ima_check_policy(struct ima_namespace *ns);
 void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
@@ -311,14 +317,16 @@ int ima_policy_show(struct seq_file *m, void *v);
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
@@ -329,7 +337,8 @@ int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value);
 
 #else
-static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
+static inline int ima_check_blacklist(struct ima_namespace *ns,
+				      struct integrity_iint_cache *iint,
 				      const struct modsig *modsig, int pcr)
 {
 	return 0;
@@ -346,7 +355,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 	return INTEGRITY_UNKNOWN;
 }
 
-static inline int ima_must_appraise(struct user_namespace *mnt_userns,
+static inline int ima_must_appraise(struct ima_namespace *ns,
+				    struct user_namespace *mnt_userns,
 				    struct inode *inode, int mask,
 				    enum ima_hooks func)
 {
@@ -450,4 +460,9 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #define	POLICY_FILE_FLAGS	S_IWUSR
 #endif /* CONFIG_IMA_READ_POLICY */
 
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return &init_ima_ns;
+}
+
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index a64fb0130b01..2df0d8549c13 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -162,6 +162,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 
 /**
  * ima_get_action - appraise & measure decision based on policy.
+ * @ns: IMA namespace that has the policy
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
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
index dbba51583e7c..3461025f671b 100644
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
@@ -357,7 +359,8 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 
 		rc = is_binary_blacklisted(digest, digestsize);
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
-			process_buffer_measurement(&init_user_ns, NULL, digest, digestsize,
+			process_buffer_measurement(ns, &init_user_ns, NULL,
+						   digest, digestsize,
 						   "blacklisted-hash", NONE,
 						   pcr, NULL, false, NULL, 0);
 	}
@@ -527,14 +530,16 @@ void ima_inode_post_setattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
+	struct ima_namespace *ns = &init_ima_ns;
 	struct integrity_iint_cache *iint;
 	int action;
 
-	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
+	if (!(ns->ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
 	    || !(inode->i_opflags & IOP_XATTR))
 		return;
 
-	action = ima_must_appraise(mnt_userns, inode, MAY_ACCESS, POST_SETATTR);
+	action = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS,
+				   POST_SETATTR);
 	iint = integrity_iint_find(inode);
 	if (iint) {
 		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
@@ -559,11 +564,12 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
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
@@ -641,6 +647,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len)
 {
 	const struct evm_ima_xattr_data *xvalue = xattr_value;
+	struct ima_namespace *ns = &init_ima_ns;
 	int digsig = 0;
 	int result;
 
@@ -658,18 +665,19 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		if (result)
 			return result;
 
-		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
+		ima_reset_appraise_flags(ns, d_backing_inode(dentry), digsig);
 	}
 	return result;
 }
 
 int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	int result;
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		ima_reset_appraise_flags(ns, d_backing_inode(dentry), 0);
 		if (result == 1)
 			result = 0;
 	}
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index f6aa0b47a772..70d87df26068 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -30,6 +30,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	bool queued = false;
 
 	/* Only asymmetric keys are handled by this hook. */
@@ -60,7 +61,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
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
index 3d8e9d5db5aa..b7f379cfcb74 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -271,7 +271,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
-static ssize_t ima_read_policy(char *path)
+static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
 {
 	void *data = NULL;
 	char *datap;
@@ -296,7 +296,7 @@ static ssize_t ima_read_policy(char *path)
 	datap = data;
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
 		pr_debug("rule: %s\n", p);
-		rc = ima_parse_add_rule(p);
+		rc = ima_parse_add_rule(ns, p);
 		if (rc < 0)
 			break;
 		size -= rc;
@@ -314,6 +314,7 @@ static ssize_t ima_read_policy(char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	char *data;
 	ssize_t result;
 
@@ -336,7 +337,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out_free;
 
 	if (data[0] == '/') {
-		result = ima_read_policy(data);
+		result = ima_read_policy(ns, data);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
@@ -344,7 +345,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				    1, 0);
 		result = -EACCES;
 	} else {
-		result = ima_parse_add_rule(data);
+		result = ima_parse_add_rule(ns, data);
 	}
 	mutex_unlock(&ima_write_mutex);
 out_free:
@@ -410,11 +411,12 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
 	const char *cause = valid_policy ? "completed" : "failed";
+	struct ima_namespace *ns = &init_ima_ns;
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
-	if (valid_policy && ima_check_policy() < 0) {
+	if (valid_policy && ima_check_policy(ns) < 0) {
 		cause = "failed";
 		valid_policy = 0;
 	}
@@ -424,13 +426,13 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 			    "policy_update", cause, !valid_policy, 0);
 
 	if (!valid_policy) {
-		ima_delete_rules();
+		ima_delete_rules(ns);
 		valid_policy = 1;
 		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
 		return 0;
 	}
 
-	ima_update_policy();
+	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
 	securityfs_remove(ima_policy);
 	ima_policy = NULL;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index b26fa67476b4..a314f4caca69 100644
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
 
@@ -145,7 +145,7 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
-	ima_init_policy();
+	ima_init_policy(&init_ima_ns);
 
 	rc = ima_fs_init();
 	if (rc != 0)
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
new file mode 100644
index 000000000000..56640881ce72
--- /dev/null
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2021 IBM Corporation
+ * Author:
+ *   Yuqiong Sun <suny@us.ibm.com>
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ */
+
+#include <linux/export.h>
+#include <linux/proc_ns.h>
+#include <linux/ima.h>
+#include <linux/slab.h>
+
+#include "ima.h"
+
+int ima_init_namespace(struct ima_namespace *ns)
+{
+	ns->ima_policy_flag = 0;
+
+	return 0;
+}
+
+int __init ima_ns_init(void)
+{
+	return ima_init_namespace(&init_ima_ns);
+}
+
+EXPORT_SYMBOL(init_ima_ns);
+
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 465865412100..a1408bf389c2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -185,10 +185,11 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
  */
 void ima_file_free(struct file *file)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint;
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
 	iint = integrity_iint_find(inode);
@@ -198,7 +199,8 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct file *file, const struct cred *cred,
+static int process_measurement(struct ima_namespace *ns,
+			       struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
@@ -217,18 +219,18 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
 
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
 
@@ -346,7 +348,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				      xattr_value, xattr_len, modsig, pcr,
 				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
-		rc = ima_check_blacklist(iint, modsig, pcr);
+		rc = ima_check_blacklist(ns, iint, modsig, pcr);
 		if (rc != -EPERM) {
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
@@ -405,12 +407,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
  */
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	u32 secid;
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid_subj(current, &secid);
-		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+		return process_measurement(ns, file, current_cred(), secid,
+					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
 	return 0;
@@ -430,6 +433,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	struct ima_template_desc *template = NULL;
 	struct file *file = vma->vm_file;
 	char filename[NAME_MAX];
@@ -442,13 +446,13 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
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
 
@@ -484,17 +488,18 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
  */
 int ima_bprm_check(struct linux_binprm *bprm)
 {
+	struct ima_namespace *ns = &init_ima_ns;
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
 
@@ -510,21 +515,23 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
+	struct ima_namespace *ns = &init_ima_ns;
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
@@ -574,10 +581,12 @@ static int __ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
  */
 int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
+	struct ima_namespace *ns = &init_ima_ns;
+
 	if (!file)
 		return -EINVAL;
 
-	return __ima_inode_hash(file_inode(file), buf, buf_size);
+	return __ima_inode_hash(ns, file_inode(file), buf, buf_size);
 }
 EXPORT_SYMBOL_GPL(ima_file_hash);
 
@@ -601,10 +610,12 @@ EXPORT_SYMBOL_GPL(ima_file_hash);
  */
 int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
+	struct ima_namespace *ns = &init_ima_ns;
+
 	if (!inode)
 		return -EINVAL;
 
-	return __ima_inode_hash(inode, buf, buf_size);
+	return __ima_inode_hash(ns, inode, buf, buf_size);
 }
 EXPORT_SYMBOL_GPL(ima_inode_hash);
 
@@ -620,13 +631,14 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
 void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 			     struct inode *inode)
 {
+	struct ima_namespace *ns = &init_ima_ns;
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
@@ -652,14 +664,15 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 void ima_post_path_mknod(struct user_namespace *mnt_userns,
 			 struct dentry *dentry)
 {
+	struct ima_namespace *ns = &init_ima_ns;
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
@@ -688,6 +701,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 		  bool contents)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	enum ima_hooks func;
 	u32 secid;
 
@@ -710,7 +724,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &secid);
-	return process_measurement(file, current_cred(), secid, NULL,
+	return process_measurement(ns, file, current_cred(), secid, NULL,
 				   0, MAY_READ, func);
 }
 
@@ -738,6 +752,7 @@ const int read_idmap[READING_MAX_ID] = {
 int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	enum ima_hooks func;
 	u32 secid;
 
@@ -753,7 +768,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
+	return process_measurement(ns, file, current_cred(), secid, buf, size,
 				   MAY_READ, func);
 }
 
@@ -841,6 +856,7 @@ int ima_post_load_data(char *buf, loff_t size,
 
 /**
  * process_buffer_measurement - Measure the buffer or the buffer data hash
+ * @ns: IMA namespace that has the policy
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
  * @buf: pointer to the buffer that needs to be added to the log.
@@ -859,7 +875,8 @@ int ima_post_load_data(char *buf, loff_t size,
  * has been written to the passed location but not added to a measurement entry,
  * a negative value otherwise.
  */
-int process_buffer_measurement(struct user_namespace *mnt_userns,
+int process_buffer_measurement(struct ima_namespace *ns,
+			       struct user_namespace *mnt_userns,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
@@ -887,7 +904,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	if (digest && digest_len < digest_hash_len)
 		return -EINVAL;
 
-	if (!ima_policy_flag && !digest)
+	if (!ns->ima_policy_flag && !digest)
 		return -ENOENT;
 
 	template = ima_template_desc_buf();
@@ -906,7 +923,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	 */
 	if (func) {
 		security_task_getsecid_subj(current, &secid);
-		action = ima_get_action(mnt_userns, inode, current_cred(),
+		action = ima_get_action(ns, mnt_userns, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
 					func_data, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
@@ -943,7 +960,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	if (digest)
 		memcpy(digest, iint.ima_hash->digest, digest_hash_len);
 
-	if (!ima_policy_flag || (func && !(action & IMA_MEASURE)))
+	if (!ns->ima_policy_flag || (func && !(action & IMA_MEASURE)))
 		return 1;
 
 	ret = ima_alloc_init_template(&event_data, &entry, template);
@@ -977,6 +994,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
  */
 void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	struct fd f;
 
 	if (!buf || !size)
@@ -986,7 +1004,8 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	if (!f.file)
 		return;
 
-	process_buffer_measurement(file_mnt_user_ns(f.file), file_inode(f.file),
+	process_buffer_measurement(ns,
+				   file_mnt_user_ns(f.file), file_inode(f.file),
 				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
 				   NULL, false, NULL, 0);
 	fdput(f);
@@ -1016,10 +1035,12 @@ int ima_measure_critical_data(const char *event_label,
 			      const void *buf, size_t buf_len,
 			      bool hash, u8 *digest, size_t digest_len)
 {
+	struct ima_namespace *ns = &init_ima_ns;
+
 	if (!event_name || !event_label || !buf || !buf_len)
 		return -ENOPARAM;
 
-	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
+	return process_buffer_measurement(ns, &init_user_ns, NULL, buf, buf_len,
 					  event_name, CRITICAL_DATA, 0,
 					  event_label, hash, digest,
 					  digest_len);
@@ -1052,7 +1073,7 @@ static int __init init_ima(void)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
 	if (!error)
-		ima_update_policy_flags();
+		ima_update_policy_flags(&init_ima_ns);
 
 	return error;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 320ca80aacab..835e5079bf9c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -52,7 +52,6 @@
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (sizeof_field(struct integrity_iint_cache, measured_pcrs) * 8))
 
-int ima_policy_flag;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
 
@@ -454,7 +453,7 @@ static bool ima_rule_contains_lsm_cond(struct ima_rule_entry *entry)
  * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
  * the reloaded LSM policy.
  */
-static void ima_lsm_update_rules(void)
+static void ima_lsm_update_rules(struct ima_namespace *ns)
 {
 	struct ima_rule_entry *entry, *e;
 	int result;
@@ -474,10 +473,12 @@ static void ima_lsm_update_rules(void)
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data)
 {
+	struct ima_namespace *ns = &init_ima_ns;
+
 	if (event != LSM_POLICY_CHANGE)
 		return NOTIFY_DONE;
 
-	ima_lsm_update_rules();
+	ima_lsm_update_rules(ns);
 	return NOTIFY_OK;
 }
 
@@ -669,6 +670,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 
 /**
  * ima_match_policy - decision based on LSM and other conditions
+ * @ns: IMA namespace that has the policy
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
@@ -688,7 +690,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_match_policy(struct ima_namespace *ns,
+		     struct user_namespace *mnt_userns, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
@@ -746,8 +749,8 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 }
 
 /**
- * ima_update_policy_flags() - Update global IMA variables
- *
+ * ima_update_policy_flags() - Update namespaced IMA variables
+ * @ns: IMA namespace that has the policy
  * Update ima_policy_flag and ima_setxattr_allowed_hash_algorithms
  * based on the currently loaded policy.
  *
@@ -760,7 +763,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
  *
  * Context: called after a policy update and at system initialization.
  */
-void ima_update_policy_flags(void)
+void ima_update_policy_flags(struct ima_namespace *ns)
 {
 	struct ima_rule_entry *entry;
 	int new_policy_flag = 0;
@@ -797,7 +800,7 @@ void ima_update_policy_flags(void)
 	if (!ima_appraise)
 		new_policy_flag &= ~IMA_APPRAISE;
 
-	ima_policy_flag = new_policy_flag;
+	ns->ima_policy_flag = new_policy_flag;
 }
 
 static int ima_appraise_flag(enum ima_hooks func)
@@ -813,7 +816,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 	return 0;
 }
 
-static void add_rules(struct ima_rule_entry *entries, int count,
+static void add_rules(struct ima_namespace *ns,
+		      struct ima_rule_entry *entries, int count,
 		      enum policy_rule_list policy_rule)
 {
 	int i = 0;
@@ -843,9 +847,10 @@ static void add_rules(struct ima_rule_entry *entries, int count,
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
@@ -873,7 +878,7 @@ static int __init ima_init_arch_policy(void)
 		result = strscpy(rule, *rules, sizeof(rule));
 
 		INIT_LIST_HEAD(&arch_policy_entry[i].list);
-		result = ima_parse_rule(rule, &arch_policy_entry[i]);
+		result = ima_parse_rule(ns, rule, &arch_policy_entry[i]);
 		if (result) {
 			pr_warn("Skipping unknown architecture policy rule: %s\n",
 				rule);
@@ -888,26 +893,27 @@ static int __init ima_init_arch_policy(void)
 
 /**
  * ima_init_policy - initialize the default measure rules.
- *
+ * @ns: IMA namespace to which the policy belongs to
  * ima_rules points to either the ima_default_rules or the new ima_policy_rules.
  */
-void __init ima_init_policy(void)
+void __init ima_init_policy(struct ima_namespace *ns)
 {
 	int build_appraise_entries, arch_entries;
 
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
-		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
+		add_rules(ns, dont_measure_rules,
+			  ARRAY_SIZE(dont_measure_rules),
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
@@ -921,11 +927,11 @@ void __init ima_init_policy(void)
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
@@ -933,7 +939,7 @@ void __init ima_init_policy(void)
 	 * signatures, prior to other appraise rules.
 	 */
 	if (ima_use_secure_boot)
-		add_rules(secure_boot_rules, ARRAY_SIZE(secure_boot_rules),
+		add_rules(ns, secure_boot_rules, ARRAY_SIZE(secure_boot_rules),
 			  IMA_DEFAULT_POLICY);
 
 	/*
@@ -945,30 +951,32 @@ void __init ima_init_policy(void)
 	build_appraise_entries = ARRAY_SIZE(build_appraise_rules);
 	if (build_appraise_entries) {
 		if (ima_use_secure_boot)
-			add_rules(build_appraise_rules, build_appraise_entries,
+			add_rules(ns, build_appraise_rules,
+				  build_appraise_entries,
 				  IMA_CUSTOM_POLICY);
 		else
-			add_rules(build_appraise_rules, build_appraise_entries,
+			add_rules(ns, build_appraise_rules,
+				  build_appraise_entries,
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
 	if (list_empty(&ima_temp_rules))
 		return -EINVAL;
@@ -977,7 +985,7 @@ int ima_check_policy(void)
 
 /**
  * ima_update_policy - update default_rules with new measure rules
- *
+ * @ns: IMA namespace that has the policy
  * Called on file .release to update the default rules with a complete new
  * policy.  What we do here is to splice ima_policy_rules and ima_temp_rules so
  * they make a queue.  The policy may be updated multiple times and this is the
@@ -986,14 +994,14 @@ int ima_check_policy(void)
  * Policy rules are never deleted so ima_policy_flag gets zeroed only once when
  * we switch from the default policy to user defined.
  */
-void ima_update_policy(void)
+void ima_update_policy(struct ima_namespace *ns)
 {
 	struct list_head *policy = &ima_policy_rules;
 
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
 
 	if (ima_rules != (struct list_head __rcu *)policy) {
-		ima_policy_flag = 0;
+		ns->ima_policy_flag = 0;
 
 		rcu_assign_pointer(ima_rules, policy);
 		/*
@@ -1004,10 +1012,10 @@ void ima_update_policy(void)
 		 */
 		kfree(arch_policy_entry);
 	}
-	ima_update_policy_flags();
+	ima_update_policy_flags(ns);
 
 	/* Custom IMA policy has been loaded */
-	ima_process_queued_keys();
+	ima_process_queued_keys(ns);
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
@@ -1077,7 +1085,8 @@ static const match_table_t policy_tokens = {
 	{Opt_err, NULL}
 };
 
-static int ima_lsm_rule_init(struct ima_rule_entry *entry,
+static int ima_lsm_rule_init(struct ima_namespace *ns,
+			     struct ima_rule_entry *entry,
 			     substring_t *args, int lsm_rule, int audit_type)
 {
 	int result;
@@ -1324,7 +1333,8 @@ static unsigned int ima_parse_appraise_algos(char *arg)
 	return res;
 }
 
-static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
+static int ima_parse_rule(struct ima_namespace *ns,
+			  char *rule, struct ima_rule_entry *entry)
 {
 	struct audit_buffer *ab;
 	char *from;
@@ -1674,37 +1684,37 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
@@ -1805,12 +1815,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 /**
  * ima_parse_add_rule - add a rule to ima_policy_rules
+ * @ns: IMA namespace that has the policy
  * @rule - ima measurement policy rule
  *
  * Avoid locking by allowing just one writer at a time in ima_write_policy()
  * Returns the length of the rule parsed, an error code on failure
  */
-ssize_t ima_parse_add_rule(char *rule)
+ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 {
 	static const char op[] = "update_policy";
 	char *p;
@@ -1834,7 +1845,7 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
-	result = ima_parse_rule(p, entry);
+	result = ima_parse_rule(ns, p, entry);
 	if (result) {
 		ima_free_rule(entry);
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
@@ -1849,12 +1860,13 @@ ssize_t ima_parse_add_rule(char *rule)
 }
 
 /**
- * ima_delete_rules() called to cleanup invalid in-flight policy.
+ * ima_delete_rules - called to cleanup invalid in-flight policy.
+ * @ns: IMA namespace that has the policy
  * We don't need locking as we operate on the temp list, which is
  * different from the active one.  There is also only one user of
  * ima_delete_rules() at a time.
  */
-void ima_delete_rules(void)
+void ima_delete_rules(struct ima_namespace *ns)
 {
 	struct ima_rule_entry *entry, *tmp;
 
@@ -1885,6 +1897,7 @@ static const char *const mask_tokens[] = {
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
@@ -1903,6 +1916,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	struct ima_rule_entry *entry = v;
 
 	rcu_read_lock();
@@ -2166,6 +2180,7 @@ int ima_policy_show(struct seq_file *m, void *v)
  */
 bool ima_appraise_signature(enum kernel_read_file_id id)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	struct ima_rule_entry *entry;
 	bool found = false;
 	enum ima_hooks func;
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 93056c03bf5a..e366a21dd8be 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -10,6 +10,7 @@
 
 #include <linux/user_namespace.h>
 #include <linux/workqueue.h>
+#include <linux/ima.h>
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
@@ -42,7 +43,7 @@ static bool timer_expired;
 static void ima_keys_handler(struct work_struct *work)
 {
 	timer_expired = true;
-	ima_process_queued_keys();
+	ima_process_queued_keys(&init_ima_ns);
 }
 
 /*
@@ -130,11 +131,15 @@ bool ima_queue_key(struct key *keyring, const void *payload,
  * This function sets ima_process_keys to true and processes queued keys.
  * From here on keys will be processed right away (not queued).
  */
-void ima_process_queued_keys(void)
+void ima_process_queued_keys(struct ima_namespace *ns)
 {
 	struct ima_key_entry *entry, *tmp;
 	bool process = false;
 
+	/* only applies to init_ima_ns */
+	if (ns != &init_ima_ns)
+		return;
+
 	if (ima_process_keys)
 		return;
 
@@ -159,7 +164,7 @@ void ima_process_queued_keys(void)
 
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
 		if (!timer_expired)
-			process_buffer_measurement(&init_user_ns, NULL,
+			process_buffer_measurement(ns, &init_user_ns, NULL,
 						   entry->payload,
 						   entry->payload_len,
 						   entry->keyring_name,
-- 
2.30.2


From cf9eb7f23d1336afe9cab6ad329c368a47ee0824 Mon Sep 17 00:00:00 2001
From: Plummy McPlumbface <plummy@mcblumbface.events>
Date: Sat, 18 Dec 2021 12:19:55 +0100
Subject: [PATCH 3/8] !!!! UNCOMPILED & UNTESTED !!!! ima: Move policy related
 variables into ima_namespace

Move variables related to the IMA policy into the ima_namespace. This way
the IMA policy of an IMA namespace can be set and displayed using a
front-end like SecurityFS.

Implement ima_ns_from_file() to get the IMA namespace via the user
namespace of the SecurityFS superblock that a file belongs to.

To get the current ima_namespace use get_current_ns() when a function, that
is related to a policy rule, is called. In other cases where file attributes
are changed, use the init_ima_ns, since these functions are related to
IMA appraisal and changes to file attributes are only relevant to the
init_ima_ns until IMA namespaces also support IMA appraisal.

Signed-off-by: Plummy McPlumbface <plummy@mcblumbface.events>
---
 security/integrity/ima/ima.h             |  6 ++++
 security/integrity/ima/ima_init_ima_ns.c |  4 +++
 security/integrity/ima/ima_policy.c      | 41 +++++++++++-------------
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 1febb618b982..a24cc4f7106a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -117,6 +117,12 @@ struct ima_kexec_hdr {
 };
 
 struct ima_namespace {
+	struct list_head ima_default_rules;
+	/* ns's policy rules */
+	struct list_head ima_policy_rules;
+	struct list_head ima_temp_rules;
+	/* Pointer to ns's current policy */
+	struct list_head __rcu *ima_rules;
 	/* current content of the policy */
 	int ima_policy_flag;
 } __randomize_layout;
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 56640881ce72..8647e1906374 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -15,6 +15,10 @@
 
 int ima_init_namespace(struct ima_namespace *ns)
 {
+	INIT_LIST_HEAD(&ns->ima_default_rules);
+	INIT_LIST_HEAD(&ns->ima_policy_rules);
+	INIT_LIST_HEAD(&ns->ima_temp_rules);
+	ns->ima_rules = (struct list_head __rcu *)(&ns->ima_default_rules);
 	ns->ima_policy_flag = 0;
 
 	return 0;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 835e5079bf9c..66d005be3577 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -232,11 +232,6 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
 /* An array of architecture specific rules */
 static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 
-static LIST_HEAD(ima_default_rules);
-static LIST_HEAD(ima_policy_rules);
-static LIST_HEAD(ima_temp_rules);
-static struct list_head __rcu *ima_rules = (struct list_head __rcu *)(&ima_default_rules);
-
 static int ima_policy __initdata;
 
 static int __init default_measure_policy_setup(char *str)
@@ -458,7 +453,7 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
 	struct ima_rule_entry *entry, *e;
 	int result;
 
-	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
+	list_for_each_entry_safe(entry, e, &ns->ima_policy_rules, list) {
 		if (!ima_rule_contains_lsm_cond(entry))
 			continue;
 
@@ -705,7 +700,7 @@ int ima_match_policy(struct ima_namespace *ns,
 		*template_desc = ima_template_desc_current();
 
 	rcu_read_lock();
-	ima_rules_tmp = rcu_dereference(ima_rules);
+	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 
 		if (!(entry->action & actmask))
@@ -770,7 +765,7 @@ void ima_update_policy_flags(struct ima_namespace *ns)
 	struct list_head *ima_rules_tmp;
 
 	rcu_read_lock();
-	ima_rules_tmp = rcu_dereference(ima_rules);
+	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		/*
 		 * SETXATTR_CHECK rules do not implement a full policy check
@@ -826,7 +821,7 @@ static void add_rules(struct ima_namespace *ns,
 		struct ima_rule_entry *entry;
 
 		if (policy_rule & IMA_DEFAULT_POLICY)
-			list_add_tail(&entries[i].list, &ima_default_rules);
+			list_add_tail(&entries[i].list, &ns->ima_default_rules);
 
 		if (policy_rule & IMA_CUSTOM_POLICY) {
 			entry = kmemdup(&entries[i], sizeof(*entry),
@@ -834,7 +829,7 @@ static void add_rules(struct ima_namespace *ns,
 			if (!entry)
 				continue;
 
-			list_add_tail(&entry->list, &ima_policy_rules);
+			list_add_tail(&entry->list, &ns->ima_policy_rules);
 		}
 		if (entries[i].action == APPRAISE) {
 			if (entries != build_appraise_rules)
@@ -978,7 +973,7 @@ void __init ima_init_policy(struct ima_namespace *ns)
 /* Make sure we have a valid policy, at least containing some rules. */
 int ima_check_policy(struct ima_namespace *ns)
 {
-	if (list_empty(&ima_temp_rules))
+	if (list_empty(&ns->ima_temp_rules))
 		return -EINVAL;
 	return 0;
 }
@@ -996,14 +991,15 @@ int ima_check_policy(struct ima_namespace *ns)
  */
 void ima_update_policy(struct ima_namespace *ns)
 {
-	struct list_head *policy = &ima_policy_rules;
+	struct list_head *policy = &ns->ima_policy_rules;
 
-	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
+	list_splice_tail_init_rcu(&ns->ima_temp_rules, policy,
+				  synchronize_rcu);
 
-	if (ima_rules != (struct list_head __rcu *)policy) {
+	if (ns->ima_rules != (struct list_head __rcu *)policy) {
 		ns->ima_policy_flag = 0;
 
-		rcu_assign_pointer(ima_rules, policy);
+		rcu_assign_pointer(ns->ima_rules, policy);
 		/*
 		 * IMA architecture specific policy rules are specified
 		 * as strings and converted to an array of ima_entry_rules
@@ -1106,7 +1102,8 @@ static int ima_lsm_rule_init(struct ima_namespace *ns,
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
-		if (ima_rules == (struct list_head __rcu *)(&ima_default_rules)) {
+		if (ns->ima_rules ==
+			(struct list_head __rcu *)(&ns->ima_default_rules)) {
 			kfree(entry->lsm[lsm_rule].args_p);
 			entry->lsm[lsm_rule].args_p = NULL;
 			result = -EINVAL;
@@ -1854,7 +1851,7 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 		return result;
 	}
 
-	list_add_tail(&entry->list, &ima_temp_rules);
+	list_add_tail(&entry->list, &ns->ima_temp_rules);
 
 	return len;
 }
@@ -1871,7 +1868,7 @@ void ima_delete_rules(struct ima_namespace *ns)
 	struct ima_rule_entry *entry, *tmp;
 
 	temp_ima_appraise = 0;
-	list_for_each_entry_safe(entry, tmp, &ima_temp_rules, list) {
+	list_for_each_entry_safe(entry, tmp, &ns->ima_temp_rules, list) {
 		list_del(&entry->list);
 		ima_free_rule(entry);
 	}
@@ -1903,7 +1900,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 	struct list_head *ima_rules_tmp;
 
 	rcu_read_lock();
-	ima_rules_tmp = rcu_dereference(ima_rules);
+	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (!l--) {
 			rcu_read_unlock();
@@ -1924,8 +1921,8 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&entry->list == &ima_default_rules ||
-		&entry->list == &ima_policy_rules) ? NULL : entry;
+	return (&entry->list == &ns->ima_default_rules ||
+		&entry->list == &ns->ima_policy_rules) ? NULL : entry;
 }
 
 void ima_policy_stop(struct seq_file *m, void *v)
@@ -2192,7 +2189,7 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	func = read_idmap[id] ?: FILE_CHECK;
 
 	rcu_read_lock();
-	ima_rules_tmp = rcu_dereference(ima_rules);
+	ima_rules_tmp = rcu_dereference(ns->ima_rules);
 	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (entry->action != APPRAISE)
 			continue;
-- 
2.30.2


From 23670fab7176b2efa7cf21a0023c07871ada4723 Mon Sep 17 00:00:00 2001
From: Plummy McPlumbface <plummy@mcblumbface.events>
Date: Sat, 18 Dec 2021 12:25:26 +0100
Subject: [PATCH 4/8] !!!! UNCOMPILED & UNTESTED !!!! ima: Move ima_htable into
 ima_namespace

Move ima_htable into ima_namespace. This way a front-end like
SecurityFS can show the number of violations of an IMA namespace.

Signed-off-by: Plummy McPlumbface <plummy@mcblumbface.events>
---
 security/integrity/ima/ima.h             | 33 ++++++++++++---------
 security/integrity/ima/ima_api.c         | 18 +++++++-----
 security/integrity/ima/ima_fs.c          |  8 +++--
 security/integrity/ima/ima_init.c        |  7 +++--
 security/integrity/ima/ima_init_ima_ns.c |  4 +++
 security/integrity/ima/ima_kexec.c       |  3 +-
 security/integrity/ima/ima_main.c        | 14 +++++----
 security/integrity/ima/ima_queue.c       | 37 ++++++++++++------------
 security/integrity/ima/ima_template.c    |  5 ++--
 9 files changed, 76 insertions(+), 53 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a24cc4f7106a..c6ee3b6e2ac3 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -116,6 +116,12 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+struct ima_h_table {
+	atomic_long_t len;	/* number of stored measurements in the list */
+	atomic_long_t violations;
+	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
+};
+
 struct ima_namespace {
 	struct list_head ima_default_rules;
 	/* ns's policy rules */
@@ -125,6 +131,8 @@ struct ima_namespace {
 	struct list_head __rcu *ima_rules;
 	/* current content of the policy */
 	int ima_policy_flag;
+
+	struct ima_h_table ima_htable;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
@@ -145,7 +153,8 @@ extern bool ima_canonical_fmt;
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
-int ima_add_template_entry(struct ima_template_entry *entry, int violation,
+int ima_add_template_entry(struct ima_namespace *ns,
+			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename);
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
@@ -154,7 +163,8 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_entry *entry);
 int ima_calc_boot_aggregate(struct ima_digest_data *hash);
-void ima_add_violation(struct file *file, const unsigned char *filename,
+void ima_add_violation(struct ima_namespace *ns,
+		       struct file *file, const unsigned char *filename,
 		       struct integrity_iint_cache *iint,
 		       const char *op, const char *cause);
 int ima_init_crypto(void);
@@ -167,8 +177,10 @@ struct ima_template_desc *ima_template_desc_current(void);
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
@@ -182,13 +194,6 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
  */
 extern spinlock_t ima_queue_lock;
 
-struct ima_h_table {
-	atomic_long_t len;	/* number of stored measurements in the list */
-	atomic_long_t violations;
-	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
-};
-extern struct ima_h_table ima_htable;
-
 static inline unsigned int ima_hash_key(u8 *digest)
 {
 	/* there is no point in taking a hash of part of a digest */
@@ -273,7 +278,8 @@ int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
 			    enum hash_algo algo, struct modsig *modsig);
-void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
+void ima_store_measurement(struct ima_namespace *ns,
+			   struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
@@ -289,7 +295,8 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
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
index 2df0d8549c13..bee35ebb3a38 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -99,7 +99,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
  *
  * Returns 0 on success, error code otherwise
  */
-int ima_store_template(struct ima_template_entry *entry,
+int ima_store_template(struct ima_namespace *ns,
+		       struct ima_template_entry *entry,
 		       int violation, struct inode *inode,
 		       const unsigned char *filename, int pcr)
 {
@@ -119,7 +120,8 @@ int ima_store_template(struct ima_template_entry *entry,
 		}
 	}
 	entry->pcr = pcr;
-	result = ima_add_template_entry(entry, violation, op, inode, filename);
+	result = ima_add_template_entry(ns, entry, violation, op, inode,
+					filename);
 	return result;
 }
 
@@ -130,7 +132,8 @@ int ima_store_template(struct ima_template_entry *entry,
  * By extending the PCR with 0xFF's instead of with zeroes, the PCR
  * value is invalidated.
  */
-void ima_add_violation(struct file *file, const unsigned char *filename,
+void ima_add_violation(struct ima_namespace *ns,
+		       struct file *file, const unsigned char *filename,
 		       struct integrity_iint_cache *iint,
 		       const char *op, const char *cause)
 {
@@ -144,14 +147,14 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
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
@@ -299,7 +302,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
  *
  * Must be called with iint->mutex held.
  */
-void ima_store_measurement(struct integrity_iint_cache *iint,
+void ima_store_measurement(struct ima_namespace *ns,
+			   struct integrity_iint_cache *iint,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
@@ -334,7 +338,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 		return;
 	}
 
-	result = ima_store_template(entry, violation, inode, filename, pcr);
+	result = ima_store_template(ns, entry, violation, inode, filename, pcr);
 	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
 		iint->flags |= IMA_MEASURED;
 		iint->measured_pcrs |= (0x1 << pcr);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index b7f379cfcb74..e5468031acdb 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -52,7 +52,10 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 					  char __user *buf,
 					  size_t count, loff_t *ppos)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
+	struct ima_namespace *ns = &init_ima_ns;
+
+	return ima_show_htable_value(buf, count, ppos,
+				     &ns->ima_htable.violations);
 }
 
 static const struct file_operations ima_htable_violations_ops = {
@@ -64,8 +67,9 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
+	struct ima_namespace *ns = &init_ima_ns;
 
+	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
 }
 
 static const struct file_operations ima_measurements_count_ops = {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index a314f4caca69..548b73e1921a 100644
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
@@ -141,7 +141,8 @@ int __init ima_init(void)
 	rc = ima_init_digests();
 	if (rc != 0)
 		return rc;
-	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
+	/* boot aggregate must be first entry */
+	rc = ima_add_boot_aggregate(&init_ima_ns);
 	if (rc != 0)
 		return rc;
 
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 8647e1906374..45916afefd69 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -21,6 +21,10 @@ int ima_init_namespace(struct ima_namespace *ns)
 	ns->ima_rules = (struct list_head __rcu *)(&ns->ima_default_rules);
 	ns->ima_policy_flag = 0;
 
+	atomic_long_set(&ns->ima_htable.len, 0);
+	atomic_long_set(&ns->ima_htable.violations, 0);
+	memset(&ns->ima_htable.queue, 0, sizeof(ns->ima_htable.queue));
+
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index f799cc278a9a..f3ef8a0df992 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -146,7 +146,8 @@ void ima_load_kexec_buffer(void)
 	rc = ima_get_kexec_buffer(&kexec_buffer, &kexec_buffer_size);
 	switch (rc) {
 	case 0:
-		rc = ima_restore_measurement_list(kexec_buffer_size,
+		rc = ima_restore_measurement_list(&init_ima_ns,
+						  kexec_buffer_size,
 						  kexec_buffer);
 		if (rc != 0)
 			pr_err("Failed to restore the measurement list: %d\n",
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a1408bf389c2..b34ab2a9eef9 100644
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
 
@@ -249,7 +250,7 @@ static int process_measurement(struct ima_namespace *ns,
 	}
 
 	if (!rc && violation_check)
-		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
+		ima_rdwr_violation_check(ns, file, iint, action & IMA_MEASURE,
 					 &pathbuf, &pathname, filename);
 
 	inode_unlock(inode);
@@ -344,7 +345,7 @@ static int process_measurement(struct ima_namespace *ns,
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
 	if (action & IMA_MEASURE)
-		ima_store_measurement(iint, file, pathname,
+		ima_store_measurement(ns, iint, file, pathname,
 				      xattr_value, xattr_len, modsig, pcr,
 				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
@@ -969,7 +970,8 @@ int process_buffer_measurement(struct ima_namespace *ns,
 		goto out;
 	}
 
-	ret = ima_store_template(entry, violation, NULL, event_data.buf, pcr);
+	ret = ima_store_template(ns, entry, violation, NULL, event_data.buf,
+				 pcr);
 	if (ret < 0) {
 		audit_cause = "store_entry";
 		ima_free_template_entry(entry);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..ba1cffd083b8 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -31,13 +31,6 @@ static unsigned long binary_runtime_size;
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
@@ -45,8 +38,10 @@ struct ima_h_table ima_htable = {
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
 /* lookup up the digest value in the hash table, and return the entry */
-static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
-						       int pcr)
+static struct ima_queue_entry *ima_lookup_digest_entry(
+						struct ima_namespace *ns,
+						u8 *digest_value,
+						int pcr)
 {
 	struct ima_queue_entry *qe, *ret = NULL;
 	unsigned int key;
@@ -54,7 +49,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 
 	key = ima_hash_key(digest_value);
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
+	hlist_for_each_entry_rcu(qe, &ns->ima_htable.queue[key], hnext) {
 		rc = memcmp(qe->entry->digests[ima_hash_algo_idx].digest,
 			    digest_value, hash_digest_size[ima_hash_algo]);
 		if ((rc == 0) && (qe->entry->pcr == pcr)) {
@@ -90,7 +85,8 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
  *
  * (Called with ima_extend_list_mutex held.)
  */
-static int ima_add_digest_entry(struct ima_template_entry *entry,
+static int ima_add_digest_entry(struct ima_namespace *ns,
+				struct ima_template_entry *entry,
 				bool update_htable)
 {
 	struct ima_queue_entry *qe;
@@ -106,11 +102,12 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
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
@@ -156,7 +153,8 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
  * kexec, maintain the total memory size required for serializing the
  * binary_runtime_measurements.
  */
-int ima_add_template_entry(struct ima_template_entry *entry, int violation,
+int ima_add_template_entry(struct ima_namespace *ns,
+			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename)
 {
@@ -169,14 +167,14 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 
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
@@ -201,12 +199,13 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
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
index 694560396be0..0f8aa10b56fc 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -400,7 +400,8 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 }
 
 /* Restore the serialized binary measurement list without extending PCRs. */
-int ima_restore_measurement_list(loff_t size, void *buf)
+int ima_restore_measurement_list(struct ima_namespace *ns,
+				 loff_t size, void *buf)
 {
 	char template_name[MAX_TEMPLATE_NAME_LEN];
 	unsigned char zero[TPM_DIGEST_SIZE] = { 0 };
@@ -516,7 +517,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(__le32 *)(hdr[HDR_PCR].data));
-		ret = ima_restore_measurement_entry(entry);
+		ret = ima_restore_measurement_entry(ns, entry);
 		if (ret < 0)
 			break;
 
-- 
2.30.2


From c98a41828b75a75faaa11c28cea9ff1a7c53b8a8 Mon Sep 17 00:00:00 2001
From: Plummy McPlumbface <plummy@mcblumbface.events>
Date: Sat, 18 Dec 2021 12:27:10 +0100
Subject: [PATCH 5/8] !!!! UNCOMPILED & UNTESTED !!!! ima: Move measurement
 list related variables into ima_namespace

Move measurement list related variables into the ima_namespace. This way a
front-end like SecurityFS can show the measurement list inside an IMA
namespace.

Signed-off-by: Plummy McPlumbface <plummy@mcblumbface.events>
---
 security/integrity/ima/ima.h             |  5 +++--
 security/integrity/ima/ima_fs.c          |  6 ++++--
 security/integrity/ima/ima_init_ima_ns.c |  5 +++++
 security/integrity/ima/ima_kexec.c       | 12 +++++++-----
 security/integrity/ima/ima_queue.c       | 24 ++++++++++--------------
 5 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c6ee3b6e2ac3..5906503ffdce 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -105,7 +105,6 @@ struct ima_queue_entry {
 	struct list_head later;		/* place in ima_measurements list */
 	struct ima_template_entry *entry;
 };
-extern struct list_head ima_measurements;	/* list of all measurements */
 
 /* Some details preceding the binary serialized measurement list */
 struct ima_kexec_hdr {
@@ -133,6 +132,8 @@ struct ima_namespace {
 	int ima_policy_flag;
 
 	struct ima_h_table ima_htable;
+	struct list_head ima_measurements;
+	unsigned long binary_runtime_size;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
@@ -182,7 +183,7 @@ int ima_restore_measurement_entry(struct ima_namespace *ns,
 int ima_restore_measurement_list(struct ima_namespace *ns,
 				 loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
-unsigned long ima_get_binary_runtime_size(void);
+unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e5468031acdb..5462cb49e455 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -80,12 +80,13 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
 	/* we need a lock since pos could point beyond last element */
 	rcu_read_lock();
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	list_for_each_entry_rcu(qe, &ns->ima_measurements, later) {
 		if (!l--) {
 			rcu_read_unlock();
 			return qe;
@@ -97,6 +98,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 
 static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 {
+	struct ima_namespace *ns = &init_ima_ns;
 	struct ima_queue_entry *qe = v;
 
 	/* lock protects when reading beyond last element
@@ -107,7 +109,7 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&qe->later == &ima_measurements) ? NULL : qe;
+	return (&qe->later == &ns->ima_measurements) ? NULL : qe;
 }
 
 static void ima_measurements_stop(struct seq_file *m, void *v)
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 45916afefd69..b53e4cdaabe7 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -24,6 +24,11 @@ int ima_init_namespace(struct ima_namespace *ns)
 	atomic_long_set(&ns->ima_htable.len, 0);
 	atomic_long_set(&ns->ima_htable.violations, 0);
 	memset(&ns->ima_htable.queue, 0, sizeof(ns->ima_htable.queue));
+	INIT_LIST_HEAD(&ns->ima_measurements);
+	if (IS_ENABLED(CONFIG_IMA_KEXEC) && ns == &init_ima_ns)
+		ns->binary_runtime_size = 0;
+	else
+		ns->binary_runtime_size = ULONG_MAX;
 
 	return 0;
 }
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index f3ef8a0df992..c07149228013 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,7 +15,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
-static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
+static int ima_dump_measurement_list(struct ima_namespace *ns,
+				    unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
 	struct ima_queue_entry *qe;
@@ -36,7 +37,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	list_for_each_entry_rcu(qe, &ns->ima_measurements, later) {
 		if (file.count < file.size) {
 			khdr.count++;
 			ima_measurements_show(&file, qe);
@@ -84,6 +85,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
+	struct ima_namespace *ns = &init_ima_ns;
 	unsigned long binary_runtime_size;
 
 	/* use more understandable variable names than defined in kbuf */
@@ -96,11 +98,11 @@ void ima_add_kexec_buffer(struct kimage *image)
 	 * Reserve an extra half page of memory for additional measurements
 	 * added during the kexec load.
 	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
+	binary_runtime_size = ima_get_binary_runtime_size(ns);
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
 		kexec_segment_size = ULONG_MAX;
 	else
-		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
+		kexec_segment_size = ALIGN(ima_get_binary_runtime_size(ns) +
 					   PAGE_SIZE / 2, PAGE_SIZE);
 	if ((kexec_segment_size == ULONG_MAX) ||
 	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
@@ -108,7 +110,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
+	ima_dump_measurement_list(ns, &kexec_buffer_size, &kexec_buffer,
 				  kexec_segment_size);
 	if (!kexec_buffer) {
 		pr_err("Not enough memory for the kexec measurement buffer.\n");
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index ba1cffd083b8..9d2cb9ab5d8c 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -24,13 +24,6 @@
 /* pre-allocated array of tpm_digest structures to extend a PCR */
 static struct tpm_digest *digests;
 
-LIST_HEAD(ima_measurements);	/* list of all measurements */
-#ifdef CONFIG_IMA_KEXEC
-static unsigned long binary_runtime_size;
-#else
-static unsigned long binary_runtime_size = ULONG_MAX;
-#endif
-
 /* mutex protects atomicity of extending measurement list
  * and extending the TPM PCR aggregate. Since tpm_extend can take
  * long (and the tpm driver uses a mutex), we can't use the spinlock.
@@ -100,7 +93,7 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
 	qe->entry = entry;
 
 	INIT_LIST_HEAD(&qe->later);
-	list_add_tail_rcu(&qe->later, &ima_measurements);
+	list_add_tail_rcu(&qe->later, &ns->ima_measurements);
 
 	atomic_long_inc(&ns->ima_htable.len);
 	if (update_htable) {
@@ -109,12 +102,14 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
 	} else
 		INIT_HLIST_NODE(&qe->hnext);
 
-	if (binary_runtime_size != ULONG_MAX) {
+	if (ns->binary_runtime_size != ULONG_MAX) {
 		int size;
 
 		size = get_binary_runtime_size(entry);
-		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
-		     binary_runtime_size + size : ULONG_MAX;
+		ns->binary_runtime_size =
+			(ns->binary_runtime_size < ULONG_MAX - size)
+			? ns->binary_runtime_size + size
+			: ULONG_MAX;
 	}
 	return 0;
 }
@@ -124,12 +119,13 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
  * entire binary_runtime_measurement list, including the ima_kexec_hdr
  * structure.
  */
-unsigned long ima_get_binary_runtime_size(void)
+unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns)
 {
-	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
+	if (ns->binary_runtime_size >=
+				(ULONG_MAX - sizeof(struct ima_kexec_hdr)))
 		return ULONG_MAX;
 	else
-		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
+		return ns->binary_runtime_size + sizeof(struct ima_kexec_hdr);
 }
 
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
-- 
2.30.2


From da03bf2407bff86988d8e78b7158c3cf092de18f Mon Sep 17 00:00:00 2001
From: Plummy McPlumbface <plummy@mcblumbface.events>
Date: Sat, 18 Dec 2021 12:30:53 +0100
Subject: [PATCH 6/8] !!!! UNCOMPILED & UNTESTED !!!! ima: Move some IMA policy
 and filesystem related variables into ima_namespace

Move the ima_write_mutex, ima_fs_flag, and valid_policy variables into
ima_namespace. This way each IMA namespace can set those variables
independently.

Signed-off-by: Plummy McPlumbface <plummy@mcblumbface.events>
---
 security/integrity/ima/ima.h             |  5 ++++
 security/integrity/ima/ima_fs.c          | 32 +++++++++++-------------
 security/integrity/ima/ima_init_ima_ns.c |  4 +++
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 5906503ffdce..e2ebbc5c1dd1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -134,6 +134,11 @@ struct ima_namespace {
 	struct ima_h_table ima_htable;
 	struct list_head ima_measurements;
 	unsigned long binary_runtime_size;
+
+	/* IMA's filesystem */
+	struct mutex ima_write_mutex;
+	unsigned long ima_fs_flags;
+	int valid_policy;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 5462cb49e455..973bf17754b2 100644
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
index b53e4cdaabe7..dec2bc9217da 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -30,6 +30,10 @@ int ima_init_namespace(struct ima_namespace *ns)
 	else
 		ns->binary_runtime_size = ULONG_MAX;
 
+	mutex_init(&ns->ima_write_mutex);
+	ns->valid_policy = 1;
+	ns->ima_fs_flags = 0;
+
 	return 0;
 }
 
-- 
2.30.2


From 976e67278785c424d31d8955b684b627286d2034 Mon Sep 17 00:00:00 2001
From: Plummy McPlumbface <plummy@mcblumbface.events>
Date: Fri, 3 Dec 2021 18:10:22 -0500
Subject: [PATCH 7/8] !!!! UNCOMPILED & UNTESTED !!!! ma: Move dentry into
 ima_namespace and others onto stack

Move the policy file dentry into the ima_namespace for reuse by
virtualized SecurityFS and for being able to remove it from
the filesystem. Move the other dentries onto the stack.

Signed-off-by: Plummy McPlumbface <plummy@mcblumbface.events>
---
 security/integrity/ima/ima.h    |  2 ++
 security/integrity/ima/ima_fs.c | 33 +++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e2ebbc5c1dd1..7ae197185db6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -139,6 +139,8 @@ struct ima_namespace {
 	struct mutex ima_write_mutex;
 	unsigned long ima_fs_flags;
 	int valid_policy;
+
+	struct dentry *policy_dentry;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 973bf17754b2..7cf66cd26b81 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -359,14 +359,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
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
@@ -436,8 +428,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	securityfs_remove(ima_policy);
-	ima_policy = NULL;
+	securityfs_remove(ns->policy_dentry);
+	ns->policy_dentry = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -454,8 +446,16 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-int __init ima_fs_init(void)
+static int __init ima_fs_ns_init(struct user_namespace *user_ns)
 {
+	struct ima_namespace *ns = user_ns->ima_ns;
+	struct dentry *ima_dir;
+	struct dentry *ima_symlink = NULL;
+	struct dentry *binary_runtime_measurements = NULL;
+	struct dentry *ascii_runtime_measurements = NULL;
+	struct dentry *runtime_measurements_count = NULL;
+	struct dentry *violations = NULL;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return -1;
@@ -492,20 +492,25 @@ int __init ima_fs_init(void)
 	if (IS_ERR(violations))
 		goto out;
 
-	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
+	ns->policy_dentry = securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
 					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy))
+	if (IS_ERR(ns->policy_dentry))
 		goto out;
 
 	return 0;
 out:
+	securityfs_remove(ns->policy_dentry);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
 	securityfs_remove(binary_runtime_measurements);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
-	securityfs_remove(ima_policy);
 	return -1;
 }
+
+int __init ima_fs_init(void)
+{
+	return ima_fs_ns_init(&init_user_ns);
+}
-- 
2.30.2


From 87e4cfc4651cb28964a118386d8c4b425841dd33 Mon Sep 17 00:00:00 2001
From: Plummy McPlumbface <plummy@mcblumbface.events>
Date: Sat, 18 Dec 2021 12:31:20 +0100
Subject: [PATCH 8/8] !!!! UNCOMPILED & UNTESTED !!!! ima: support ima
 namespaces

Signed-off-by: Plummy McPlumbface <plummy@mcblumbface.events>
---
 include/linux/capability.h                   |  6 ++
 include/linux/ima.h                          | 38 +++++++++++
 include/linux/user_namespace.h               |  4 ++
 init/Kconfig                                 | 10 +++
 kernel/user.c                                |  8 +++
 kernel/user_namespace.c                      |  2 +
 security/integrity/ima/Makefile              |  1 +
 security/integrity/ima/ima.h                 | 17 +++++
 security/integrity/ima/ima_appraise.c        |  6 +-
 security/integrity/ima/ima_asymmetric_keys.c |  2 +-
 security/integrity/ima/ima_fs.c              | 48 +++++++++++---
 security/integrity/ima/ima_init.c            |  4 ++
 security/integrity/ima/ima_init_ima_ns.c     |  6 ++
 security/integrity/ima/ima_kexec.c           |  4 +-
 security/integrity/ima/ima_main.c            | 68 ++++++++++++++-----
 security/integrity/ima/ima_ns.c              | 70 ++++++++++++++++++++
 security/integrity/ima/ima_policy.c          | 18 +++--
 17 files changed, 273 insertions(+), 39 deletions(-)
 create mode 100644 security/integrity/ima/ima_ns.c

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..991579178f32 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool mac_admin_ns_capable(struct user_namespace *ns)
+{
+	return ns_capable(ns, CAP_MAC_ADMIN) ||
+		ns_capable(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 			   const struct dentry *dentry,
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 08d507084b72..51f996f3c4c7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <linux/user_namespace.h>
 #include <crypto/hash_info.h>
 struct linux_binprm;
 
@@ -210,6 +211,43 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 }
 #endif /* CONFIG_IMA_APPRAISE */
 
+extern struct ima_namespace init_ima_ns;
+
+#ifdef CONFIG_IMA_NS
+
+void free_ima_ns(struct user_namespace *ns);
+int create_ima_ns(struct user_namespace *user_ns);
+
+static inline struct ima_namespace *get_ima_ns(struct user_namespace *user_ns)
+{
+	return smp_load_acquire(&user_ns->ima_ns);
+}
+
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return get_ima_ns(current_user_ns());
+}
+
+#else
+
+static inline void free_ima_ns(struct user_namespace *user_ns)
+{
+}
+
+static inline int create_ima_ns(struct user_namespace *user_ns)
+{
+#ifdef CONFIG_IMA
+	user_ns->ima_ns = &init_ima_ns;
+#endif
+	return 0;
+}
+
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return &init_ima_ns;
+}
+#endif /* CONFIG_IMA_NS */
+
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
 extern bool ima_appraise_signature(enum kernel_read_file_id func);
 #else
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f..5249db04d62b 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
 #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
 
 struct ucounts;
+struct ima_namespace;
 
 enum ucount_type {
 	UCOUNT_USER_NAMESPACES,
@@ -99,6 +100,9 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
+#ifdef CONFIG_IMA
+	struct ima_namespace	*ima_ns;
+#endif
 } __randomize_layout;
 
 struct ucounts {
diff --git a/init/Kconfig b/init/Kconfig
index 11f8a845f259..27890607e8cb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1242,6 +1242,16 @@ config NET_NS
 	  Allow user space to create what appear to be multiple instances
 	  of the network stack.
 
+config IMA_NS
+	bool "IMA namespace"
+	depends on USER_NS
+	depends on IMA
+	default y
+	help
+	  Allow the creation of IMA namespaces for each user namespace.
+	  Namespaced IMA enables having IMA features work separately
+	  in each IMA namespace.
+
 endif # NAMESPACES
 
 config CHECKPOINT_RESTORE
diff --git a/kernel/user.c b/kernel/user.c
index e2cf8c22b539..5aac06e29298 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -19,6 +19,11 @@
 #include <linux/export.h>
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
+#include <linux/ima.h>
+
+#ifdef CONFIG_IMA
+extern struct ima_namespace init_ima_ns;
+#endif
 
 /*
  * userns count is 1 for root user, 1 for init_uts_ns,
@@ -67,6 +72,9 @@ struct user_namespace init_user_ns = {
 	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
 	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
 #endif
+#ifdef CONFIG_IMA
+	.ima_ns = &init_ima_ns,
+#endif
 };
 EXPORT_SYMBOL_GPL(init_user_ns);
 
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
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index f8a5e5f3975d..b86a35fbed60 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,6 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_IMA_NS) += ima_ns.o
 
 ifeq ($(CONFIG_EFI),y)
 ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7ae197185db6..9ea10f4f65fb 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -20,6 +20,7 @@
 #include <linux/hash.h>
 #include <linux/tpm.h>
 #include <linux/audit.h>
+#include <linux/user_namespace.h>
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
@@ -161,6 +162,7 @@ extern bool ima_canonical_fmt;
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
+int ima_ns_init(void);
 int ima_add_template_entry(struct ima_namespace *ns,
 			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
@@ -449,6 +451,10 @@ static inline void ima_free_modsig(struct modsig *modsig)
 }
 #endif /* CONFIG_IMA_APPRAISE_MODSIG */
 
+int ima_ns_init(void);
+struct ima_namespace;
+int ima_init_namespace(struct ima_namespace *ns);
+
 /* LSM based policy rules require audit */
 #ifdef CONFIG_IMA_LSM_RULES
 
@@ -486,4 +492,15 @@ static inline struct ima_namespace *get_current_ns(void)
 	return &init_ima_ns;
 }
 
+static inline
+struct user_namespace *ima_user_ns_from_file(const struct file *filp)
+{
+	return file_inode(filp)->i_sb->s_user_ns;
+}
+
+static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
+{
+	return ima_user_ns_from_file(filp)->ima_ns;
+}
+
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3461025f671b..b6cc9244855a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -530,7 +530,7 @@ void ima_inode_post_setattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	int action;
 
@@ -647,7 +647,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len)
 {
 	const struct evm_ima_xattr_data *xvalue = xattr_value;
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	int digsig = 0;
 	int result;
 
@@ -672,7 +672,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 
 int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	int result;
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 70d87df26068..bc95f9ae4214 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -30,7 +30,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	bool queued = false;
 
 	/* Only asymmetric keys are handled by this hook. */
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 7cf66cd26b81..6c21096a29d2 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -48,7 +48,7 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 					  char __user *buf,
 					  size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
 
 	return ima_show_htable_value(buf, count, ppos,
 				     &ns->ima_htable.violations);
@@ -63,7 +63,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
 
 	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
 }
@@ -76,7 +76,7 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
@@ -94,7 +94,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 
 static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_queue_entry *qe = v;
 
 	/* lock protects when reading beyond last element
@@ -316,7 +316,7 @@ static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(file);
 	char *data;
 	ssize_t result;
 
@@ -377,7 +377,8 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
+	struct ima_namespace *ns = user_ns->ima_ns; /* no need to use acquire semantics it's guaranteed to be initialized */
 
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
@@ -385,7 +386,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!capable(CAP_SYS_ADMIN))
+		if (!mac_admin_ns_capable(user_ns))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
@@ -404,7 +405,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(file);
 	const char *cause = ns->valid_policy ? "completed" : "failed";
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
@@ -448,15 +449,40 @@ static const struct file_operations ima_measure_policy_ops = {
 
 static int __init ima_fs_ns_init(struct user_namespace *user_ns)
 {
-	struct ima_namespace *ns = user_ns->ima_ns;
-	struct dentry *ima_dir;
+	int ret;
+	struct ima_namespace *ns = user_ns->ima_ns; /* no need to use acquire semantics it's guaranteed to be initialized */
+	struct dentry *int_dir;
+	struct dentry *ima_dir = NULL;
 	struct dentry *ima_symlink = NULL;
 	struct dentry *binary_runtime_measurements = NULL;
 	struct dentry *ascii_runtime_measurements = NULL;
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
 
-	ima_dir = securityfs_create_dir("ima", integrity_dir);
+	/*
+	 * While multiple superblocks can exist they are keyed by userns in
+	 * s_fs_info for securityfs. The first time a userns mounts a
+	 * securityfs instance we lazily allocate the ima_namespace for the
+	 * userns since that's the only way a userns can meaningfully use ima.
+	 * The vfs ensure we're the only one to call fill_super() and hence
+	 * ima_fs_ns_init() so we don't need any memory barriers here, i.e.
+	 * user_ns->ima_ns can't change while we're in here.
+	 */
+	if (!ns) {
+		ret = create_ima_ns(user_ns);
+		if (ret)
+			return ret;
+	}
+
+	/* FIXME: update when evm and integrity are namespaced */
+	if (user_ns != &init_user_ns) {
+		int_dir = securityfs_create_dir("integrity", root);
+		if (IS_ERR(int_dir))
+			return -1;
+	} else
+		int_dir = integrity_dir;
+
+	ima_dir = securityfs_create_dir("ima", int_dir);
 	if (IS_ERR(ima_dir))
 		return -1;
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 548b73e1921a..22ca5d872be0 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -120,6 +120,10 @@ int __init ima_init(void)
 {
 	int rc;
 
+	rc = ima_ns_init();
+	if (rc)
+		return rc;
+
 	ima_tpm_chip = tpm_default_chip();
 	if (!ima_tpm_chip)
 		pr_info("No TPM chip found, activating TPM-bypass!\n");
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index dec2bc9217da..d282a1f9ee36 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/ima.h>
 #include <linux/slab.h>
@@ -15,6 +16,11 @@
 
 int ima_init_namespace(struct ima_namespace *ns)
 {
+	ns->ns_status_tree = RB_ROOT;
+	rwlock_init(&ns->ns_status_lock);
+	/* Use KMEM_CACHE for simplicity ? */
+	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
+
 	INIT_LIST_HEAD(&ns->ima_default_rules);
 	INIT_LIST_HEAD(&ns->ima_policy_rules);
 	INIT_LIST_HEAD(&ns->ima_temp_rules);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index c07149228013..4f0d74d1a91a 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -85,7 +85,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	unsigned long binary_runtime_size;
 
 	/* use more understandable variable names than defined in kbuf */
@@ -148,7 +148,7 @@ void ima_load_kexec_buffer(void)
 	rc = ima_get_kexec_buffer(&kexec_buffer, &kexec_buffer_size);
 	switch (rc) {
 	case 0:
-		rc = ima_restore_measurement_list(&init_ima_ns,
+		rc = ima_restore_measurement_list(get_current_ns(),
 						  kexec_buffer_size,
 						  kexec_buffer);
 		if (rc != 0)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b34ab2a9eef9..3c6db254064b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -186,7 +186,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
  */
 void ima_file_free(struct file *file)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(file);
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint;
 
@@ -200,10 +200,10 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct ima_namespace *ns,
-			       struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+static int __process_measurement(struct ima_namespace *ns,
+				 struct file *file, const struct cred *cred,
+				 u32 secid, char *buf, loff_t size, int mask,
+				 enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -395,6 +395,38 @@ static int process_measurement(struct ima_namespace *ns,
 	return 0;
 }
 
+static int process_measurement(struct ima_namespace *ns,
+			       struct file *file, const struct cred *cred,
+			       u32 secid, char *buf, loff_t size, int mask,
+			       enum ima_hooks func)
+{
+	struct user_namespace *user_ns = current_user_ns();
+	int ret = 0;
+
+	/*
+	 * We currently assume that this is always called from current's
+	 * context, i.e. the passed ns must be the same as
+	 * current_user_ns()->im_ns. Notice when that changes.
+	 */
+	if (WARN_ON(get_ima_ns(user_ns) != ns))
+		return -EINVAL;
+
+	while (user_ns) {
+		/* the container has not loaded a separate policy (yet) */
+		ns = get_ima_ns(user_ns);
+		if (ns) {
+			ret = __process_measurement(ns, file, cred, secid, buf,
+						    size, mask, func);
+			if (ret)
+				break;
+		}
+
+		user_ns = user_ns->parent;
+	};
+
+	return ret;
+}
+
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
@@ -408,7 +440,7 @@ static int process_measurement(struct ima_namespace *ns,
  */
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	u32 secid;
 
 	if (file && (prot & PROT_EXEC)) {
@@ -434,7 +466,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct ima_template_desc *template = NULL;
 	struct file *file = vma->vm_file;
 	char filename[NAME_MAX];
@@ -489,7 +521,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
  */
 int ima_bprm_check(struct linux_binprm *bprm)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	int ret;
 	u32 secid;
 
@@ -516,7 +548,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	u32 secid;
 
 	security_task_getsecid_subj(current, &secid);
@@ -582,7 +614,7 @@ static int __ima_inode_hash(struct ima_namespace *ns,
  */
 int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
 	if (!file)
 		return -EINVAL;
@@ -611,7 +643,7 @@ EXPORT_SYMBOL_GPL(ima_file_hash);
  */
 int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
 	if (!inode)
 		return -EINVAL;
@@ -632,7 +664,7 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
 void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 			     struct inode *inode)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
@@ -665,7 +697,7 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 void ima_post_path_mknod(struct user_namespace *mnt_userns,
 			 struct dentry *dentry)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
@@ -702,7 +734,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 		  bool contents)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	enum ima_hooks func;
 	u32 secid;
 
@@ -753,7 +785,7 @@ const int read_idmap[READING_MAX_ID] = {
 int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	enum ima_hooks func;
 	u32 secid;
 
@@ -996,7 +1028,7 @@ int process_buffer_measurement(struct ima_namespace *ns,
  */
 void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct fd f;
 
 	if (!buf || !size)
@@ -1037,7 +1069,7 @@ int ima_measure_critical_data(const char *event_label,
 			      const void *buf, size_t buf_len,
 			      bool hash, u8 *digest, size_t digest_len)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
 	if (!event_name || !event_label || !buf || !buf_len)
 		return -ENOPARAM;
@@ -1075,7 +1107,7 @@ static int __init init_ima(void)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
 	if (!error)
-		ima_update_policy_flags(&init_ima_ns);
+		ima_update_policy_flags(get_current_ns());
 
 	return error;
 }
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
new file mode 100644
index 000000000000..eb1e1e4cfc78
--- /dev/null
+++ b/security/integrity/ima/ima_ns.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2021 IBM Corporation
+ * Author:
+ *  Yuqiong Sun <suny@us.ibm.com>
+ *  Stefan Berger <stefanb@linux.vnet.ibm.com>
+ */
+
+#include <linux/kref.h>
+#include <linux/slab.h>
+#include <linux/ima.h>
+#include <linux/mount.h>
+#include <linux/proc_ns.h>
+#include <linux/lsm_hooks.h>
+
+#include "ima.h"
+
+static struct kmem_cache *imans_cachep;
+
+int create_ima_ns(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns;
+	int err;
+
+	ns = kmem_cache_zalloc(imans_cachep, GFP_KERNEL);
+	if (!ns)
+		return -ENOMEM;
+	pr_debug("NEW     ima_ns: 0x%p\n", ns);
+
+	err = ima_init_namespace(ns);
+	if (err)
+		goto fail_free;
+
+	/* Pairs with smp_load_acquire() in ima_fs_ns_init(). */
+	smp_store_release(&user_ns->ima_ns, ns);
+
+	return 0;
+
+fail_free:
+	kmem_cache_free(imans_cachep, ns);
+
+	return err;
+}
+
+static void destroy_ima_ns(struct ima_namespace *ns)
+{
+	pr_debug("DESTROY ima_ns: 0x%p\n", ns);
+	kmem_cache_free(imans_cachep, ns);
+}
+
+void free_ima_ns(struct user_namespace *user_ns)
+{
+	/* No need to use acquire semantics as the userns can't be reached
+	 * anymore from userspace so either ima_ns has been initialized or it
+	 * never has.
+	 */
+	struct ima_namespace *ns = user_ns->ima_ns;
+
+	if (WARN_ON(ns == &init_ima_ns))
+		return;
+
+	destroy_ima_ns(ns);
+}
+
+static int __init imans_cache_init(void)
+{
+	imans_cachep = KMEM_CACHE(ima_namespace, SLAB_PANIC);
+	return 0;
+}
+subsys_initcall(imans_cache_init)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 66d005be3577..74d8ba594356 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -468,7 +468,7 @@ static void ima_lsm_update_rules(struct ima_namespace *ns)
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
 	if (event != LSM_POLICY_CHANGE)
 		return NOTIFY_DONE;
@@ -1793,6 +1793,16 @@ static int ima_parse_rule(struct ima_namespace *ns,
 			result = -EINVAL;
 			break;
 		}
+
+		/* IMA namespace only accepts AUDIT rules */
+		if (ns != &init_ima_ns) {
+			switch (entry->action) {
+			case MEASURE:
+			case APPRAISE:
+			case HASH:
+				result = -EINVAL;
+			}
+		}
 	}
 	if (!result && !ima_validate_rule(entry))
 		result = -EINVAL;
@@ -1894,7 +1904,7 @@ static const char *const mask_tokens[] = {
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
@@ -1913,7 +1923,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_rule_entry *entry = v;
 
 	rcu_read_lock();
@@ -2177,7 +2187,7 @@ int ima_policy_show(struct seq_file *m, void *v)
  */
 bool ima_appraise_signature(enum kernel_read_file_id id)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct ima_rule_entry *entry;
 	bool found = false;
 	enum ima_hooks func;
-- 
2.30.2

