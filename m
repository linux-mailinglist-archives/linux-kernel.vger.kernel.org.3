Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1822588C07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiHCM0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiHCM0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:26:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C250B7FB;
        Wed,  3 Aug 2022 05:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0574ACE2343;
        Wed,  3 Aug 2022 12:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E419FC433D7;
        Wed,  3 Aug 2022 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659529566;
        bh=IJl2l0MSKjk0iEtEAj1QgHwSr8hy3z9e9aA/z5o4w/8=;
        h=From:To:Cc:Subject:Date:From;
        b=UiKwH376ABhHScZTZX+kun7qB4aExme4mnAv0GznnSaM/PsMMK/5XACJyKJkTT/9y
         w0M+l811QgoMJ12DUnBjEnWymTXzCvrm0VvA5FQAJyTuAwM3153v+UKTSwkLe4TLSG
         4sB2SsijbFuzkTsHY9NupZZFLY4uJa6yeuGGvC+KyqWjWs6o/J1GmFfIRM1j/jJxi5
         9qGfsMZb/QOs8T+4lk6qWpYF3AJbbEav1L+1exhGJiAhPOgNPGsEYhGzHSSE8EAD42
         R776r2Xiplf7dVy0wVInD2WVC4q8jc4H8AxW7yDdFdwcMqpm+XiBLZwcQE9r6dBR1w
         k5h4rN4SSM4xw==
From:   broonie@kernel.org
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: linux-next: manual merge of the overlayfs tree with the origin tree
Date:   Wed,  3 Aug 2022 13:26:00 +0100
Message-Id: <20220803122600.55053-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the overlayfs tree got a conflict in:

  fs/overlayfs/inode.c

between commit:

  1aa5fef575a83 ("ovl: handle idmappings in ovl_get_acl()")

from the origin tree and commit:

  ded536561a367 ("ovl: improve ovl_get_acl() if POSIX ACL support is off")

from the overlayfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/overlayfs/inode.c
index 7922b619f6c8b,beef5e2ff5639..0000000000000
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@@ -454,95 -454,26 +454,97 @@@ ssize_t ovl_listxattr(struct dentry *de
  	return res;
  }
  
 +/*
 + * Apply the idmapping of the layer to POSIX ACLs. The caller must pass a clone
 + * of the POSIX ACLs retrieved from the lower layer to this function to not
 + * alter the POSIX ACLs for the underlying filesystem.
 + */
 +static void ovl_idmap_posix_acl(struct user_namespace *mnt_userns,
 +				struct posix_acl *acl)
 +{
 +	for (unsigned int i = 0; i < acl->a_count; i++) {
 +		vfsuid_t vfsuid;
 +		vfsgid_t vfsgid;
 +
 +		struct posix_acl_entry *e = &acl->a_entries[i];
 +		switch (e->e_tag) {
 +		case ACL_USER:
 +			vfsuid = make_vfsuid(mnt_userns, &init_user_ns, e->e_uid);
 +			e->e_uid = vfsuid_into_kuid(vfsuid);
 +			break;
 +		case ACL_GROUP:
 +			vfsgid = make_vfsgid(mnt_userns, &init_user_ns, e->e_gid);
 +			e->e_gid = vfsgid_into_kgid(vfsgid);
 +			break;
 +		}
 +	}
 +}
 +
 +/*
 + * When the relevant layer is an idmapped mount we need to take the idmapping
 + * of the layer into account and translate any ACL_{GROUP,USER} values
 + * according to the idmapped mount.
 + *
 + * We cannot alter the ACLs returned from the relevant layer as that would
 + * alter the cached values filesystem wide for the lower filesystem. Instead we
 + * can clone the ACLs and then apply the relevant idmapping of the layer.
 + *
 + * This is obviously only relevant when idmapped layers are used.
 + */
+ #ifdef CONFIG_FS_POSIX_ACL
  struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
  {
  	struct inode *realinode = ovl_inode_real(inode);
 -	const struct cred *old_cred;
 -	struct posix_acl *acl;
 +	struct posix_acl *acl, *clone;
 +	struct path realpath;
  
- 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
+ 	if (!IS_POSIXACL(realinode))
  		return NULL;
  
 -	if (rcu)
 -		return get_cached_acl_rcu(realinode, type);
 +	/* Careful in RCU walk mode */
 +	ovl_i_path_real(inode, &realpath);
 +	if (!realpath.dentry) {
 +		WARN_ON(!rcu);
 +		return ERR_PTR(-ECHILD);
 +	}
  
 -	old_cred = ovl_override_creds(inode->i_sb);
 -	acl = get_acl(realinode, type);
 -	revert_creds(old_cred);
 +	if (rcu) {
 +		acl = get_cached_acl_rcu(realinode, type);
 +	} else {
 +		const struct cred *old_cred;
 +
 +		old_cred = ovl_override_creds(inode->i_sb);
 +		acl = get_acl(realinode, type);
 +		revert_creds(old_cred);
 +	}
 +	/*
 +	 * If there are no POSIX ACLs, or we encountered an error,
 +	 * or the layer isn't idmapped we don't need to do anything.
 +	 */
 +	if (!is_idmapped_mnt(realpath.mnt) || IS_ERR_OR_NULL(acl))
 +		return acl;
  
 -	return acl;
 +	/*
 +	 * We only get here if the layer is idmapped. So drop out of RCU path
 +	 * walk so we can clone the ACLs. There's no need to release the ACLs
 +	 * since get_cached_acl_rcu() doesn't take a reference on the ACLs.
 +	 */
 +	if (rcu)
 +		return ERR_PTR(-ECHILD);
 +
 +	clone = posix_acl_clone(acl, GFP_KERNEL);
 +	if (!clone)
 +		clone = ERR_PTR(-ENOMEM);
 +	else
 +		ovl_idmap_posix_acl(mnt_user_ns(realpath.mnt), clone);
 +	/*
 +	 * Since we're not in RCU path walk we always need to release the
 +	 * original ACLs.
 +	 */
 +	posix_acl_release(acl);
 +	return clone;
  }
+ #endif
  
  int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
  {
