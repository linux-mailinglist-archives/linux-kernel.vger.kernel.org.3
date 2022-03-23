Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25714E4E60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbiCWIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCWIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:41:00 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDA9205FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:39:29 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KNhbz56g6zMqCHm;
        Wed, 23 Mar 2022 09:39:27 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KNhbx4PhbzljsV2;
        Wed, 23 Mar 2022 09:39:25 +0100 (CET)
Message-ID: <b71454bb-d084-bfd6-7cd3-aa6bfdaaab00@digikod.net>
Date:   Wed, 23 Mar 2022 09:40:35 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20220222175332.384545-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [RFC PATCH v1] LSM: Remove double path_rename hook calls for
 RENAME_EXCHANGE
In-Reply-To: <20220222175332.384545-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comment? John, Tetsuo, does it look OK for AppArmor and Tomoyo?

On 22/02/2022 18:53, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> In order to be able to identify a file exchange with renameat2(2) and
> RENAME_EXCHANGE, which will be useful for Landlock [1], propagate the
> rename flags to LSMs.  This may also improve performance because of the
> switch from two set of LSM hook calls to only one, and because LSMs
> using this hook may optimize the double check (e.g. only one lock,
> reduce the number of path walks).
> 
> AppArmor, Landlock and Tomoyo are updated to leverage this change.  This
> should not change the current behavior (same check order), except
> (different level of) speed boosts.
> 
> [1] https://lore.kernel.org/r/20220221212522.320243-1-mic@digikod.net
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220222175332.384545-1-mic@digikod.net
> ---
>   include/linux/lsm_hook_defs.h |  2 +-
>   include/linux/lsm_hooks.h     |  1 +
>   security/apparmor/lsm.c       | 30 +++++++++++++++++++++++++-----
>   security/landlock/fs.c        | 12 ++++++++++--
>   security/security.c           |  9 +--------
>   security/tomoyo/tomoyo.c      | 11 ++++++++++-
>   6 files changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 819ec92dc2a8..d8b49c9c3a8a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -100,7 +100,7 @@ LSM_HOOK(int, 0, path_link, struct dentry *old_dentry,
>   	 const struct path *new_dir, struct dentry *new_dentry)
>   LSM_HOOK(int, 0, path_rename, const struct path *old_dir,
>   	 struct dentry *old_dentry, const struct path *new_dir,
> -	 struct dentry *new_dentry)
> +	 struct dentry *new_dentry, unsigned int flags)
>   LSM_HOOK(int, 0, path_chmod, const struct path *path, umode_t mode)
>   LSM_HOOK(int, 0, path_chown, const struct path *path, kuid_t uid, kgid_t gid)
>   LSM_HOOK(int, 0, path_chroot, const struct path *path)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 3bf5c658bc44..32cd2a7fe9fc 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -358,6 +358,7 @@
>    *	@old_dentry contains the dentry structure of the old link.
>    *	@new_dir contains the path structure for parent of the new link.
>    *	@new_dentry contains the dentry structure of the new link.
> + *	@flags may contain rename options such as RENAME_EXCHANGE.
>    *	Return 0 if permission is granted.
>    * @path_chmod:
>    *	Check for permission to change a mode of the file @path. The new
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 4f0eecb67dde..900bc540656a 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -354,13 +354,16 @@ static int apparmor_path_link(struct dentry *old_dentry, const struct path *new_
>   }
>   
>   static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_dentry,
> -				const struct path *new_dir, struct dentry *new_dentry)
> +				const struct path *new_dir, struct dentry *new_dentry,
> +				const unsigned int flags)
>   {
>   	struct aa_label *label;
>   	int error = 0;
>   
>   	if (!path_mediated_fs(old_dentry))
>   		return 0;
> +	if ((flags & RENAME_EXCHANGE) && !path_mediated_fs(new_dentry))
> +		return 0;
>   
>   	label = begin_current_label_crit_section();
>   	if (!unconfined(label)) {
> @@ -374,10 +377,27 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
>   			d_backing_inode(old_dentry)->i_mode
>   		};
>   
> -		error = aa_path_perm(OP_RENAME_SRC, label, &old_path, 0,
> -				     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
> -				     AA_MAY_SETATTR | AA_MAY_DELETE,
> -				     &cond);
> +		if (flags & RENAME_EXCHANGE) {
> +			struct path_cond cond_exchange = {
> +				i_uid_into_mnt(mnt_userns, d_backing_inode(new_dentry)),
> +				d_backing_inode(new_dentry)->i_mode
> +			};
> +
> +			error = aa_path_perm(OP_RENAME_SRC, label, &new_path, 0,
> +					     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
> +					     AA_MAY_SETATTR | AA_MAY_DELETE,
> +					     &cond_exchange);
> +			if (!error)
> +				error = aa_path_perm(OP_RENAME_DEST, label, &old_path,
> +						     0, MAY_WRITE | AA_MAY_SETATTR |
> +						     AA_MAY_CREATE, &cond_exchange);
> +		}
> +
> +		if (!error)
> +			error = aa_path_perm(OP_RENAME_SRC, label, &old_path, 0,
> +					     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
> +					     AA_MAY_SETATTR | AA_MAY_DELETE,
> +					     &cond);
>   		if (!error)
>   			error = aa_path_perm(OP_RENAME_DEST, label, &new_path,
>   					     0, MAY_WRITE | AA_MAY_SETATTR |
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 97b8e421f617..7e57fca6e814 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -574,10 +574,12 @@ static inline u32 maybe_remove(const struct dentry *const dentry)
>   static int hook_path_rename(const struct path *const old_dir,
>   		struct dentry *const old_dentry,
>   		const struct path *const new_dir,
> -		struct dentry *const new_dentry)
> +		struct dentry *const new_dentry,
> +		const unsigned int flags)
>   {
>   	const struct landlock_ruleset *const dom =
>   		landlock_get_current_domain();
> +	u32 exchange_access = 0;
>   
>   	if (!dom)
>   		return 0;
> @@ -585,11 +587,17 @@ static int hook_path_rename(const struct path *const old_dir,
>   	if (old_dir->dentry != new_dir->dentry)
>   		/* Gracefully forbids reparenting. */
>   		return -EXDEV;
> +	if (flags & RENAME_EXCHANGE) {
> +		if (unlikely(d_is_negative(new_dentry)))
> +			return -ENOENT;
> +		exchange_access =
> +			get_mode_access(d_backing_inode(new_dentry)->i_mode);
> +	}
>   	if (unlikely(d_is_negative(old_dentry)))
>   		return -ENOENT;
>   	/* RENAME_EXCHANGE is handled because directories are the same. */
>   	return check_access_path(dom, old_dir, maybe_remove(old_dentry) |
> -			maybe_remove(new_dentry) |
> +			maybe_remove(new_dentry) | exchange_access |
>   			get_mode_access(d_backing_inode(old_dentry)->i_mode));
>   }
>   
> diff --git a/security/security.c b/security/security.c
> index 22261d79f333..8634da4cfd46 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1184,15 +1184,8 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
>   		     (d_is_positive(new_dentry) && IS_PRIVATE(d_backing_inode(new_dentry)))))
>   		return 0;
>   
> -	if (flags & RENAME_EXCHANGE) {
> -		int err = call_int_hook(path_rename, 0, new_dir, new_dentry,
> -					old_dir, old_dentry);
> -		if (err)
> -			return err;
> -	}
> -
>   	return call_int_hook(path_rename, 0, old_dir, old_dentry, new_dir,
> -				new_dentry);
> +				new_dentry, flags);
>   }
>   EXPORT_SYMBOL(security_path_rename);
>   
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index b6a31901f289..71e82d855ebf 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -264,17 +264,26 @@ static int tomoyo_path_link(struct dentry *old_dentry, const struct path *new_di
>    * @old_dentry: Pointer to "struct dentry".
>    * @new_parent: Pointer to "struct path".
>    * @new_dentry: Pointer to "struct dentry".
> + * @flags: Rename options.
>    *
>    * Returns 0 on success, negative value otherwise.
>    */
>   static int tomoyo_path_rename(const struct path *old_parent,
>   			      struct dentry *old_dentry,
>   			      const struct path *new_parent,
> -			      struct dentry *new_dentry)
> +			      struct dentry *new_dentry,
> +			      const unsigned int flags)
>   {
>   	struct path path1 = { .mnt = old_parent->mnt, .dentry = old_dentry };
>   	struct path path2 = { .mnt = new_parent->mnt, .dentry = new_dentry };
>   
> +	if (flags & RENAME_EXCHANGE) {
> +		const int err = tomoyo_path2_perm(TOMOYO_TYPE_RENAME, &path2,
> +				&path1);
> +
> +		if (err)
> +			return err;
> +	}
>   	return tomoyo_path2_perm(TOMOYO_TYPE_RENAME, &path1, &path2);
>   }
>   
> 
> base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
