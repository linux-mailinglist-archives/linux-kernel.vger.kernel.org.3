Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2E512880
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiD1BLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiD1BLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC2B972457
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651108100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFTbKpQDHwKeDO3R+oN4RkYXYuos3ad9xzDOGUeV9P0=;
        b=Wn5duivnaRba1kWf73nBoMZYcJM7f1fwH5cIgQVsuJi6BdR11XQnH95a8UwNQHHfeXjcMY
        Se3Lgl4823HriRk2abltFG2uEAYARrr09HcAcwXjACPzuBIvJR3mQhPrjgxy4CLt6hS4kp
        np8bTnTG6SGXk5il4GeX61UaY0oKCy4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-qLc5UqWQPMuzSrUM7UWmGA-1; Wed, 27 Apr 2022 21:08:19 -0400
X-MC-Unique: qLc5UqWQPMuzSrUM7UWmGA-1
Received: by mail-pg1-f199.google.com with SMTP id t3-20020a656083000000b0039cf337edd6so1590146pgu.18
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nFTbKpQDHwKeDO3R+oN4RkYXYuos3ad9xzDOGUeV9P0=;
        b=CeyR2WW+og0Ey766yNtRDlfOklwtMrxfvH8AG9D+6n1lWXvkXEZpVUv9KiODcWcN8Z
         PqXalVu0nOel9U6MPp3CX8un+M0KP+OUQAAIt+Snp1DX5sX6r2JsL0XT1W1D2tYPBwLk
         FUIa/6PN9cy2CYcOzsI0xYehzLhKa+TJftMxHx+N9MPZZEarkiU7EZlo+tWfy+3sJt3o
         uYmjNJ0yxApLBk6vWc6CyJ5rUAt8dZgs0lsfnXk6bu5L8al3QnaqLQkvNIB3mhMZpeyZ
         AuI7JQGYFsMSsJwVV1hIRCDc2xVH+kZUnLAzwP4jzVkOYZY9ucsW2Fc8ukhbcSTca38Z
         cihw==
X-Gm-Message-State: AOAM530DI06ZWs3kSCRuDRa4ESEEDO07XQNGU8V09Uz6uXLB6GTQDtMJ
        bSTssNu0H24/GNX38MrMmXGdoZslM21tjgtCzEj+7WhqB8nPTGX12G8EvVS37aRiGn/p9JydHDd
        gtRuIkED2ltxFwrnWX5sSzYLG
X-Received: by 2002:a63:6c0a:0:b0:3ab:894f:8309 with SMTP id h10-20020a636c0a000000b003ab894f8309mr10038745pgc.536.1651108096741;
        Wed, 27 Apr 2022 18:08:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeX/S7evZzaxVdwN7UhSXd97GtByJOf/i54snZrJAb25jNcFGNbDhCNHkhcyZwhILrunMb5Q==
X-Received: by 2002:a63:6c0a:0:b0:3ab:894f:8309 with SMTP id h10-20020a636c0a000000b003ab894f8309mr10038721pgc.536.1651108096115;
        Wed, 27 Apr 2022 18:08:16 -0700 (PDT)
Received: from [10.72.12.77] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v189-20020a622fc6000000b004fb72e95806sm19944358pfv.48.2022.04.27.18.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 18:08:15 -0700 (PDT)
Subject: Re: [PATCH v3] ceph: fix statfs for subdir mounts
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Taylor <rptaylor@uvic.ca>
References: <20220427155704.4758-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <8bbf90c4-e292-9918-f3c9-6823ae2e652c@redhat.com>
Date:   Thu, 28 Apr 2022 09:08:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220427155704.4758-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/22 11:57 PM, Luís Henriques wrote:
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
> Changes since v2:
> Renamed function __ceph_has_any_quota() to __ceph_has_quota()
>
> Changes since v1:
> Moved some more logic into __ceph_has_any_quota() function.
>
>   fs/ceph/inode.c |  2 +-
>   fs/ceph/quota.c | 19 +++++++++++--------
>   fs/ceph/super.h | 28 ++++++++++++++++++++++++----
>   3 files changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 5de7bb9048b7..1067209cf6f6 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -691,7 +691,7 @@ void ceph_evict_inode(struct inode *inode)
>   
>   	__ceph_remove_caps(ci);
>   
> -	if (__ceph_has_any_quota(ci))
> +	if (__ceph_has_quota(ci, QUOTA_GET_ANY))
>   		ceph_adjust_quota_realms_count(inode, false);
>   
>   	/*
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index a338a3ec0dc4..64592adfe48f 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -195,9 +195,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
>   
>   /*
>    * This function walks through the snaprealm for an inode and returns the
> - * ceph_snap_realm for the first snaprealm that has quotas set (either max_files
> - * or max_bytes).  If the root is reached, return the root ceph_snap_realm
> - * instead.
> + * ceph_snap_realm for the first snaprealm that has quotas set (max_files,
> + * max_bytes, or any, depending on the 'which_quota' argument).  If the root is
> + * reached, return the root ceph_snap_realm instead.
>    *
>    * Note that the caller is responsible for calling ceph_put_snap_realm() on the
>    * returned realm.
> @@ -209,7 +209,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
>    * will be restarted.
>    */
>   static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
> -					       struct inode *inode, bool retry)
> +					       struct inode *inode,
> +					       enum quota_get_realm which_quota,
> +					       bool retry)
>   {
>   	struct ceph_inode_info *ci = NULL;
>   	struct ceph_snap_realm *realm, *next;
> @@ -248,7 +250,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>   		}
>   
>   		ci = ceph_inode(in);
> -		has_quota = __ceph_has_any_quota(ci);
> +		has_quota = __ceph_has_quota(ci, which_quota);
>   		iput(in);
>   
>   		next = realm->parent;
> @@ -279,8 +281,8 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
>   	 * dropped and we can then restart the whole operation.
>   	 */
>   	down_read(&mdsc->snap_rwsem);
> -	old_realm = get_quota_realm(mdsc, old, true);
> -	new_realm = get_quota_realm(mdsc, new, false);
> +	old_realm = get_quota_realm(mdsc, old, QUOTA_GET_ANY, true);
> +	new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
>   	if (PTR_ERR(new_realm) == -EAGAIN) {
>   		up_read(&mdsc->snap_rwsem);
>   		if (old_realm)
> @@ -483,7 +485,8 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>   	bool is_updated = false;
>   
>   	down_read(&mdsc->snap_rwsem);
> -	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root), true);
> +	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
> +				QUOTA_GET_MAX_BYTES, true);
>   	up_read(&mdsc->snap_rwsem);
>   	if (!realm)
>   		return false;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index a2e1c83ab29a..0ecde1c12fee 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1317,9 +1317,29 @@ extern void ceph_fs_debugfs_init(struct ceph_fs_client *client);
>   extern void ceph_fs_debugfs_cleanup(struct ceph_fs_client *client);
>   
>   /* quota.c */
> -static inline bool __ceph_has_any_quota(struct ceph_inode_info *ci)
> +
> +enum quota_get_realm {
> +	QUOTA_GET_MAX_FILES,
> +	QUOTA_GET_MAX_BYTES,
> +	QUOTA_GET_ANY
> +};
> +
> +static inline bool __ceph_has_quota(struct ceph_inode_info *ci,
> +				    enum quota_get_realm which)
>   {
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
>   }
>   
>   extern void ceph_adjust_quota_realms_count(struct inode *inode, bool inc);
> @@ -1328,10 +1348,10 @@ static inline void __ceph_update_quota(struct ceph_inode_info *ci,
>   				       u64 max_bytes, u64 max_files)
>   {
>   	bool had_quota, has_quota;
> -	had_quota = __ceph_has_any_quota(ci);
> +	had_quota = __ceph_has_quota(ci, QUOTA_GET_ANY);
>   	ci->i_max_bytes = max_bytes;
>   	ci->i_max_files = max_files;
> -	has_quota = __ceph_has_any_quota(ci);
> +	has_quota = __ceph_has_quota(ci, QUOTA_GET_ANY);
>   
>   	if (had_quota != has_quota)
>   		ceph_adjust_quota_realms_count(&ci->vfs_inode, has_quota);
>
Looks good. Merged into the testing branch.

Thanks Luis.

-- Xiubo


