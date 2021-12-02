Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333A846648E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358255AbhLBNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:38:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34410 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346849AbhLBNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:38:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 614B4B8214D;
        Thu,  2 Dec 2021 13:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F4FC00446;
        Thu,  2 Dec 2021 13:35:04 +0000 (UTC)
Date:   Thu, 2 Dec 2021 14:35:00 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [RFC 13/20] securityfs: Build securityfs_ns for namespacing
 support
Message-ID: <20211202133500.ms5u5ze7sztfyyjh@wittgenstein>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-14-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130160654.1418231-14-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:06:47AM -0500, Stefan Berger wrote:
> Implement 'securityfs_ns' for support of IMA namespacing so that each
> IMA (user) namespace can have its own front-end for showing the currently
> active policy, the measurement list, number of violations and so on. This
> filesystem shares much of the existing code of SecurityFS but requires a
> new API call securityfs_ns_create_mount() for creating a new instance.
> 
> The API calls of securityfs_ns have the prefix securityfs_ns_ and take
> additional parameters struct vfsmount * and mount_count that allow for
> multiple instances of this filesystem to exist.
> 
> The filesystem can be mounted to the usual securityfs mount point like
> this:
> 
> mount -t securityfs_ns /sys/kernel/security /sys/kernel/security
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/security.h   |  18 ++++
>  include/uapi/linux/magic.h |   1 +
>  security/inode.c           | 197 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 210 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7e0ba63b5dde..8e479266f544 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1929,6 +1929,24 @@ struct dentry *securityfs_create_symlink(const char *name,
>  					 const struct inode_operations *iops);
>  extern void securityfs_remove(struct dentry *dentry);
>  
> +extern struct dentry *securityfs_ns_create_file(const char *name, umode_t mode,
> +						struct dentry *parent, void *data,
> +						const struct file_operations *fops,
> +						const struct inode_operations *iops,
> +						struct vfsmount **mount, int *mount_count);
> +extern struct dentry *securityfs_ns_create_dir(const char *name, struct dentry *parent,
> +					       const struct inode_operations *iops,
> +					       struct vfsmount **mount, int *mount_count);
> +struct dentry *securityfs_ns_create_symlink(const char *name,
> +					    struct dentry *parent,
> +					    const char *target,
> +					    const struct inode_operations *iops,
> +					    struct vfsmount **mount, int *mount_count);
> +extern void securityfs_ns_remove(struct dentry *dentry,
> +				 struct vfsmount **mount, int *mount_count);
> +struct vfsmount *securityfs_ns_create_mount(struct user_namespace *user_ns);
> +extern struct vfsmount *securityfs_ns_mount;
> +
>  #else /* CONFIG_SECURITYFS */
>  
>  static inline struct dentry *securityfs_create_dir(const char *name,
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 35687dcb1a42..5c1cc6088dd2 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -11,6 +11,7 @@
>  #define CRAMFS_MAGIC_WEND	0x453dcd28	/* magic number with the wrong endianess */
>  #define DEBUGFS_MAGIC          0x64626720
>  #define SECURITYFS_MAGIC	0x73636673
> +#define SECURITYFS_NS_MAGIC	0x73334473
>  #define SELINUX_MAGIC		0xf97cff8c
>  #define SMACK_MAGIC		0x43415d53	/* "SMAC" */
>  #define RAMFS_MAGIC		0x858458f6	/* some random number */
> diff --git a/security/inode.c b/security/inode.c
> index 429744ff4ab3..8077d1f31489 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -21,6 +21,7 @@
>  #include <linux/security.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
> +#include <linux/user_namespace.h>
>  
>  static struct vfsmount *securityfs_mount;
>  static int securityfs_mount_count;
> @@ -73,6 +74,61 @@ static struct file_system_type securityfs_type = {
>  	.kill_sb =	kill_litter_super,
>  };
>  
> +static int securityfs_ns_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	static const struct tree_descr files[] = {{""}};
> +	int error;
> +
> +	error = simple_fill_super(sb, SECURITYFS_NS_MAGIC, files);
> +	if (error)
> +		return error;
> +
> +	sb->s_op = &securityfs_super_operations;
> +
> +	return 0;
> +}
> +
> +static int securityfs_ns_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_keyed(fc, securityfs_ns_fill_super, fc->user_ns);
> +}
> +
> +static const struct fs_context_operations securityfs_ns_context_ops = {
> +	.get_tree	= securityfs_ns_get_tree,
> +};
> +
> +static int securityfs_ns_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &securityfs_ns_context_ops;
> +	return 0;
> +}
> +
> +static struct file_system_type securityfs_ns_type = {
> +	.owner			= THIS_MODULE,
> +	.name			= "securityfs_ns",
> +	.init_fs_context	= securityfs_ns_init_fs_context,
> +	.kill_sb		= kill_litter_super,
> +	.fs_flags		= FS_USERNS_MOUNT,
> +};
> +
> +struct vfsmount *securityfs_ns_create_mount(struct user_namespace *user_ns)
> +{
> +	struct fs_context *fc;
> +	struct vfsmount *mnt;
> +
> +	fc = fs_context_for_mount(&securityfs_ns_type, SB_KERNMOUNT);
> +	if (IS_ERR(fc))
> +		return ERR_CAST(fc);
> +
> +	put_user_ns(fc->user_ns);
> +	fc->user_ns = get_user_ns(user_ns);
> +
> +	mnt = fc_mount(fc);
> +	put_fs_context(fc);
> +	return mnt;
> +}
> +
> +
>  /**
>   * securityfs_create_dentry - create a dentry in the securityfs filesystem
>   *
> @@ -155,8 +211,8 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
>  	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
>  	inode->i_private = data;
>  	if (S_ISDIR(mode)) {
> -		inode->i_op = &simple_dir_inode_operations;
> -		inode->i_fop = &simple_dir_operations;
> +		inode->i_op = iops ? iops : &simple_dir_inode_operations;
> +		inode->i_fop = fops ? fops : &simple_dir_operations;
>  		inc_nlink(inode);
>  		inc_nlink(dir);
>  	} else if (S_ISLNK(mode)) {
> @@ -214,6 +270,41 @@ struct dentry *securityfs_create_file(const char *name, umode_t mode,
>  }
>  EXPORT_SYMBOL_GPL(securityfs_create_file);
>  
> +/**
> + * securityfs_ns_create_file - create a file in the securityfs_ns filesystem
> + *
> + * @name: a pointer to a string containing the name of the file to create.
> + * @mode: the permission that the file should have
> + * @parent: a pointer to the parent dentry for this file.  This should be a
> + *          directory dentry if set.  If this parameter is %NULL, then the
> + *          file will be created in the root of the securityfs_ns filesystem.
> + * @data: a pointer to something that the caller will want to get to later
> + *        on.  The inode.i_private pointer will point to this value on
> + *        the open() call.
> + * @fops: a pointer to a struct file_operations that should be used for
> + *        this file.
> + * @mount: Pointer to a pointer of a an existing vfsmount
> + * @mount_count: The mount_count that goes along with the @mount
> + *
> + * This function creates a file in securityfs_ns with the given @name.
> + *
> + * This function returns a pointer to a dentry if it succeeds.  This
> + * pointer must be passed to the securityfs_ns_remove() function when the file
> + * is to be removed (no automatic cleanup happens if your module is unloaded,
> + * you are responsible here).  If an error occurs, the function will return
> + * the error value (via ERR_PTR).
> + */
> +struct dentry *securityfs_ns_create_file(const char *name, umode_t mode,
> +					 struct dentry *parent, void *data,
> +					 const struct file_operations *fops,
> +					 const struct inode_operations *iops,
> +					 struct vfsmount **mount, int *mount_count)
> +{
> +	return securityfs_create_dentry(name, mode, parent, data, fops, iops,
> +					&securityfs_ns_type, mount, mount_count);
> +}
> +EXPORT_SYMBOL_GPL(securityfs_ns_create_file);
> +
>  /**
>   * securityfs_create_dir - create a directory in the securityfs filesystem
>   *
> @@ -240,6 +331,34 @@ struct dentry *securityfs_create_dir(const char *name, struct dentry *parent)
>  }
>  EXPORT_SYMBOL_GPL(securityfs_create_dir);
>  
> +/**
> + * securityfs_ns_create_dir - create a directory in the securityfs_ns filesystem
> + *
> + * @name: a pointer to a string containing the name of the directory to
> + *        create.
> + * @parent: a pointer to the parent dentry for this file.  This should be a
> + *          directory dentry if set.  If this parameter is %NULL, then the
> + *          directory will be created in the root of the securityfs_ns filesystem.
> + * @mount: Pointer to a pointer of a an existing vfsmount
> + * @mount_count: The mount_count that goes along with the @mount
> + *
> + * This function creates a directory in securityfs_ns with the given @name.
> + *
> + * This function returns a pointer to a dentry if it succeeds.  This
> + * pointer must be passed to the securityfs_ns_remove() function when the file
> + * is to be removed (no automatic cleanup happens if your module is unloaded,
> + * you are responsible here).  If an error occurs, the function will return
> + * the error value (via ERR_PTR).
> + */
> +struct dentry *securityfs_ns_create_dir(const char *name, struct dentry *parent,
> +					const struct inode_operations *iops,
> +					struct vfsmount **mount, int *mount_count)
> +{
> +	return securityfs_ns_create_file(name, S_IFDIR | 0755, parent, NULL, NULL,
> +					 iops, mount, mount_count);
> +}
> +EXPORT_SYMBOL_GPL(securityfs_ns_create_dir);
> +
>  struct dentry *_securityfs_create_symlink(const char *name,
>  					  struct dentry *parent,
>  					  const char *target,
> @@ -263,6 +382,7 @@ struct dentry *_securityfs_create_symlink(const char *name,
>  
>  	return dent;
>  }
> +
>  /**
>   * securityfs_create_symlink - create a symlink in the securityfs filesystem
>   *
> @@ -300,6 +420,42 @@ struct dentry *securityfs_create_symlink(const char *name,
>  }
>  EXPORT_SYMBOL_GPL(securityfs_create_symlink);
>  
> +/**
> + * securityfs_ns_create_symlink - create a symlink in the securityfs_ns filesystem
> + *
> + * @name: a pointer to a string containing the name of the symlink to
> + *        create.
> + * @parent: a pointer to the parent dentry for the symlink.  This should be a
> + *          directory dentry if set.  If this parameter is %NULL, then the
> + *          directory will be created in the root of the securityfs_ns filesystem.
> + * @target: a pointer to a string containing the name of the symlink's target.
> + *          If this parameter is %NULL, then the @iops parameter needs to be
> + *          setup to handle .readlink and .get_link inode_operations.
> + * @iops: a pointer to the struct inode_operations to use for the symlink. If
> + *        this parameter is %NULL, then the default simple_symlink_inode
> + *        operations will be used.
> + * @mount: Pointer to a pointer of a an existing vfsmount
> + * @mount_count: The mount_count that goes along with the @mount
> + *
> + * This function creates a symlink in securityfs_ns with the given @name.
> + *
> + * This function returns a pointer to a dentry if it succeeds.  This
> + * pointer must be passed to the securityfs_ns_remove() function when the file
> + * is to be removed (no automatic cleanup happens if your module is unloaded,
> + * you are responsible here).  If an error occurs, the function will return
> + * the error value (via ERR_PTR).
> + */
> +struct dentry *securityfs_ns_create_symlink(const char *name,
> +					    struct dentry *parent,
> +					    const char *target,
> +					    const struct inode_operations *iops,
> +					    struct vfsmount **mount, int *mount_count)
> +{
> +	return _securityfs_create_symlink(name, parent, target, iops,
> +					  &securityfs_ns_type, mount, mount_count);
> +}
> +EXPORT_SYMBOL_GPL(securityfs_ns_create_symlink);
> +
>  void _securityfs_remove(struct dentry *dentry, struct vfsmount **mount, int *mount_count)
>  {
>  	struct inode *dir;
> @@ -340,6 +496,27 @@ void securityfs_remove(struct dentry *dentry)
>  
>  EXPORT_SYMBOL_GPL(securityfs_remove);
>  
> +/**
> + * securityfs_ns_remove - removes a file or directory from the securityfs_ns filesystem
> + *
> + * @dentry: a pointer to a the dentry of the file or directory to be removed.
> + * @mount: Pointer to a pointer of a an existing vfsmount
> + * @mount_count: The mount_count that goes along with the @mount
> + *
> + * This function removes a file or directory in securityfs_ns that was previously
> + * created with a call to another securityfs_ns function (like
> + * securityfs_ns_create_file() or variants thereof.)
> + *
> + * This function is required to be called in order for the file to be
> + * removed. No automatic cleanup of files will happen when a module is
> + * removed; you are responsible here.
> + */
> +void securityfs_ns_remove(struct dentry *dentry, struct vfsmount **mount, int *mount_count)
> +{
> +	_securityfs_remove(dentry, mount, mount_count);
> +}
> +EXPORT_SYMBOL_GPL(securityfs_ns_remove);
> +
>  #ifdef CONFIG_SECURITY
>  static struct dentry *lsm_dentry;
>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
> @@ -364,14 +541,22 @@ static int __init securityfs_init(void)
>  		return retval;
>  
>  	retval = register_filesystem(&securityfs_type);
> -	if (retval) {
> -		sysfs_remove_mount_point(kernel_kobj, "security");
> -		return retval;
> -	}
> +	if (retval)
> +		goto remove_mount;
> +	retval = register_filesystem(&securityfs_ns_type);
> +	if (retval)
> +		goto unregister_filesystem;

So you're introducing a new filesystem type securityfs_ns. Ithink that's
simply wrong and feels like a hack. What issues did you run into when
trying to convert the existing securityfs itself?

I see no immediate reason why a get_tree_keyed() conversion for
securityfs wouldn't work even with the debugfs pin/unpin logic in there
kept for the securityfs mounted in the initial userns.
