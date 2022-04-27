Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F635120D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbiD0PLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiD0PK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B1853B5E;
        Wed, 27 Apr 2022 08:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86DF6B827F8;
        Wed, 27 Apr 2022 15:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93703C385AF;
        Wed, 27 Apr 2022 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651072062;
        bh=d9DFE77Zqv/ohPrixgPGqV4DVHAWzktLocb8mZeYLRk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BAbJ8Yp4LS53fdmTiHI3VhQvxjVbA3if54n/L2bOLGC4nRWJlXWMJhlxSZMYqEFIe
         yBFrkmmYL/dLKcsN2fiR+d4ZpiPcRg+0fWolnYfmBYVfXKmaahngRzrxe4K0UQlYyG
         WODCx8mD821dsoj1x2i9HlwXQwaMEFRw/RenoFo4A671I5O+w4qGxBsu3rbrJl5Oa3
         nzL/mewcycYhMcMIk1jDG3XiUnU4KJaeglHKLeasiq4HP6qKrcADRvvUtPk95C/a68
         3XqKGYy+sVHqTFsjtcWW8QmhbkZlQlBbmfK9ZCoCyXEBRSsZwsURQZL5lDh197Wbnp
         MS53wD24XxsIw==
Message-ID: <9beddcc315595751d5fbcb83f73cd94533b62cbd.camel@kernel.org>
Subject: Re: [PATCH v2] ceph: fix statfs for subdir mounts
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Taylor <rptaylor@uvic.ca>
Date:   Wed, 27 Apr 2022 11:07:40 -0400
In-Reply-To: <20220427143303.950-1-lhenriques@suse.de>
References: <20220427143303.950-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
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

On Wed, 2022-04-27 at 15:33 +0100, Luís Henriques wrote:
> When doing a mount using as base a directory that has 'max_bytes' quotas
> statfs uses that value as the total; if a subdirectory is used instead,
> the same 'max_bytes' too in statfs, unless there is another quota set.
> 
> Unfortunately, if this subdirectory only has the 'max_files' quota set,
> then statfs uses the filesystem total.  Fix this by making sure we only
> lookup realms that contain the 'max_bytes' quota.
> 
> Link: https://tracker.ceph.com/issues/55090
> Cc: Ryan Taylor <rptaylor@uvic.ca>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> As I mentioned in v1, I do *not* think this really fixes the tracker
> above, as the bug reporter never mentioned setting quotas in the subdir.
> 
> Changes since v1:
> Moved some more logic into __ceph_has_any_quota() function.
> 
>  fs/ceph/inode.c |  2 +-
>  fs/ceph/quota.c | 19 +++++++++++--------
>  fs/ceph/super.h | 28 ++++++++++++++++++++++++----
>  3 files changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 5de7bb9048b7..4b7406d6fbe4 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -691,7 +691,7 @@ void ceph_evict_inode(struct inode *inode)
>  
>  	__ceph_remove_caps(ci);
>  
> -	if (__ceph_has_any_quota(ci))
> +	if (__ceph_has_any_quota(ci, QUOTA_GET_ANY))
>  		ceph_adjust_quota_realms_count(inode, false);
>  
>  	/*
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index a338a3ec0dc4..e9f7ca18cdb7 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -195,9 +195,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
>  
>  /*
>   * This function walks through the snaprealm for an inode and returns the
> - * ceph_snap_realm for the first snaprealm that has quotas set (either max_files
> - * or max_bytes).  If the root is reached, return the root ceph_snap_realm
> - * instead.
> + * ceph_snap_realm for the first snaprealm that has quotas set (max_files,
> + * max_bytes, or any, depending on the 'which_quota' argument).  If the root is
> + * reached, return the root ceph_snap_realm instead.
>   *
>   * Note that the caller is responsible for calling ceph_put_snap_realm() on the
>   * returned realm.
> @@ -209,7 +209,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
>   * will be restarted.
>   */
>  static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
> -					       struct inode *inode, bool retry)
> +					       struct inode *inode,
> +					       enum quota_get_realm which_quota,
> +					       bool retry)
>  {
>  	struct ceph_inode_info *ci = NULL;
>  	struct ceph_snap_realm *realm, *next;
> @@ -248,7 +250,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>  		}
>  
>  		ci = ceph_inode(in);
> -		has_quota = __ceph_has_any_quota(ci);
> +		has_quota = __ceph_has_any_quota(ci, which_quota);
>  		iput(in);
>  
>  		next = realm->parent;
> @@ -279,8 +281,8 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
>  	 * dropped and we can then restart the whole operation.
>  	 */
>  	down_read(&mdsc->snap_rwsem);
> -	old_realm = get_quota_realm(mdsc, old, true);
> -	new_realm = get_quota_realm(mdsc, new, false);
> +	old_realm = get_quota_realm(mdsc, old, QUOTA_GET_ANY, true);
> +	new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
>  	if (PTR_ERR(new_realm) == -EAGAIN) {
>  		up_read(&mdsc->snap_rwsem);
>  		if (old_realm)
> @@ -483,7 +485,8 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>  	bool is_updated = false;
>  
>  	down_read(&mdsc->snap_rwsem);
> -	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root), true);
> +	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
> +				QUOTA_GET_MAX_BYTES, true);
>  	up_read(&mdsc->snap_rwsem);
>  	if (!realm)
>  		return false;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index a2e1c83ab29a..3cd96720f14a 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1317,9 +1317,29 @@ extern void ceph_fs_debugfs_init(struct ceph_fs_client *client);
>  extern void ceph_fs_debugfs_cleanup(struct ceph_fs_client *client);
>  
>  /* quota.c */
> -static inline bool __ceph_has_any_quota(struct ceph_inode_info *ci)
> +
> +enum quota_get_realm {
> +	QUOTA_GET_MAX_FILES,
> +	QUOTA_GET_MAX_BYTES,
> +	QUOTA_GET_ANY
> +};
> +
> +static inline bool __ceph_has_any_quota(struct ceph_inode_info *ci,
> +					enum quota_get_realm which)
>  {
> -	return ci->i_max_files || ci->i_max_bytes;
> +	bool has_quota = false;
> +
> +	switch (which) {
> +	case QUOTA_GET_MAX_BYTES:
> +		has_quota = !!ci->i_max_bytes;
> +		break;
> +	case QUOTA_GET_MAX_FILES:
> +		has_quota = !!ci->i_max_files;
> +		break;
> +	default:
> +		has_quota = !!(ci->i_max_files || ci->i_max_bytes);
> +	}
> +	return has_quota;
>  }
>  
>  extern void ceph_adjust_quota_realms_count(struct inode *inode, bool inc);
> @@ -1328,10 +1348,10 @@ static inline void __ceph_update_quota(struct ceph_inode_info *ci,
>  				       u64 max_bytes, u64 max_files)
>  {
>  	bool had_quota, has_quota;
> -	had_quota = __ceph_has_any_quota(ci);
> +	had_quota = __ceph_has_any_quota(ci, QUOTA_GET_ANY);
>  	ci->i_max_bytes = max_bytes;
>  	ci->i_max_files = max_files;
> -	has_quota = __ceph_has_any_quota(ci);
> +	has_quota = __ceph_has_any_quota(ci, QUOTA_GET_ANY);
>  
>  	if (had_quota != has_quota)
>  		ceph_adjust_quota_realms_count(&ci->vfs_inode, has_quota);

Code looks fine. I think Xiubo had suggested renaming the funtion to
__ceph_has_quota(), but other than that this looks good.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
