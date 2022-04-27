Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6B5110AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiD0F5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiD0F53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2418326AD4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651038859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFatqASgOsrjhCi84vXgEfjQDe8mSgqkDQ0MAnnoZtI=;
        b=XiSCVrGkMLuOcqI5xaKsV69j7O2ftp4RPszSiL7Ad6weRXL0XT/y/dqleULmlfgktYteJp
        ahHfT/Bn7ENImETQJxctNRTB4qbxdNmUuVRE1/3UeMx5GlOKN3RvJ3Y5yI7R0c4Z5u+wtP
        wEc5pwKl6DYxLbml9Osk7IdQGNL3Buo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-pDL4zHysMaSgrS5RYs_54g-1; Wed, 27 Apr 2022 01:54:17 -0400
X-MC-Unique: pDL4zHysMaSgrS5RYs_54g-1
Received: by mail-pl1-f197.google.com with SMTP id b6-20020a170903228600b0015d22ba49a9so498943plh.16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cFatqASgOsrjhCi84vXgEfjQDe8mSgqkDQ0MAnnoZtI=;
        b=UycEteQTZalYCQd08k8I0OSDXYVD9SlJT+XvfgsMCgWRWfIofNg64c7F1SAylUx6A6
         E2u/YuEdiFYeQDu6mqn2XT8ZYEwtxCjvuSzXxu9Lh4LIC4Mk7hWmcF8X6h8CFZCWQCKH
         dJeMt9oT5y5j6PeOvlGBlNQWCey+W43yv6N0EyVIy4/O0slxHMFzxCW6MUsca15Kjc+L
         4UQcUewo88AiOBlQ+/1dvNUaBqJcTkkuoSGvuVhLNi68vlZX8vPz/ZPsNa1AamPI+f2T
         Nq+r/wKRxLoeQjemp8T7LCz4BxQcRFNeLXLG/H3jL6T6tYWHW2/SP3Fy7kPgO/3X3CpW
         PC8g==
X-Gm-Message-State: AOAM5327PvbA9oUSTolSMjCnxAPhYZInVpIcj8itkkc68oHKU+RpX1LN
        5ng+MSPLGUNlxYXzLa1ej02kfDkSU5yhdzPbYkAU93dqf4qmcrQCFEUbXhmpDhu7RVgVpSVquvz
        PXRIxEkpHLJyL3D8KcKO3ZJgs
X-Received: by 2002:a05:6a00:1c53:b0:50d:5860:5b58 with SMTP id s19-20020a056a001c5300b0050d58605b58mr7258103pfw.85.1651038856508;
        Tue, 26 Apr 2022 22:54:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKGMM1U5dSMJW72mOpdNfH/5wDxuGd1gEn4S7irx8u9xosNbtMTiCSMdgQ0sMRjXWEVZWlQg==
X-Received: by 2002:a05:6a00:1c53:b0:50d:5860:5b58 with SMTP id s19-20020a056a001c5300b0050d58605b58mr7258084pfw.85.1651038856230;
        Tue, 26 Apr 2022 22:54:16 -0700 (PDT)
Received: from [10.72.12.77] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090a8e8400b001d2b4d3e900sm4772598pjo.41.2022.04.26.22.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 22:54:15 -0700 (PDT)
Subject: Re: [PATCH] ceph: fix statfs for subdir mounts
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, rptaylor@uvic.ca
References: <20220426161204.17896-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <461ed973-0d09-5049-7ffc-48e499448e63@redhat.com>
Date:   Wed, 27 Apr 2022 13:54:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220426161204.17896-1-lhenriques@suse.de>
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


On 4/27/22 12:12 AM, Luís Henriques wrote:
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
> Hi!
>
> Unfortunately, I don't think this is the real fix for the bug reported in
> the tracker (or by Ryan on the mailing-list).  I haven't seen any
> reference to 'max_files' so I suspect Ryan and Dan are hitting another
> bug.  This can be easily checked by 'getfattr -n ceph.quota <subdir>'.
>
> Also, Dan (in the tracker) states the bug is on the kernel client only but
> I can also see if in the fuse client.
>
> Anyway, this patch fixes a real bug.
>
>   fs/ceph/quota.c | 35 +++++++++++++++++++++++++++--------
>   1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index a338a3ec0dc4..235a8d06a8ee 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -193,11 +193,17 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
>   	mutex_unlock(&mdsc->quotarealms_inodes_mutex);
>   }
>   
> +enum quota_get_realm {
> +	QUOTA_GET_MAX_FILES,
> +	QUOTA_GET_MAX_BYTES,
> +	QUOTA_GET_ANY
> +};
> +
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
> @@ -209,7 +215,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
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
> @@ -248,7 +256,17 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>   		}
>   
>   		ci = ceph_inode(in);
> -		has_quota = __ceph_has_any_quota(ci);
> +		switch (which_quota) {
> +		case QUOTA_GET_MAX_BYTES:
> +			has_quota = ci->i_max_bytes;
> +			break;
> +		case QUOTA_GET_MAX_FILES:
> +			has_quota = ci->i_max_files;
> +			break;
> +		default: /* QUOTA_GET_ANY */
> +			has_quota = __ceph_has_any_quota(ci);

How about moving this logic to __ceph_has_any_quota() by renaming it to 
__ceph_has_quota(ci, enum quota_get_realm which) ?

+ static inline bool __ceph_has_quota(ci, enum quota_get_realm which) {
+		switch (which) {
+		case QUOTA_GET_MAX_BYTES:
+			return !!ci->i_max_bytes;
+			break;
+		case QUOTA_GET_MAX_FILES:
+			return !!ci->i_max_files;
+			break;
+		default: /* QUOTA_GET_ANY */
+			return !!(ci->i_max_files || ci->i_max_bytes);
+ }

The other LGTM.

-- Xiubo


> +			break;
> +		}
>   		iput(in);
>   
>   		next = realm->parent;
> @@ -279,8 +297,8 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
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
> @@ -483,7 +501,8 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>   	bool is_updated = false;
>   
>   	down_read(&mdsc->snap_rwsem);
> -	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root), true);
> +	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
> +				QUOTA_GET_MAX_BYTES, true);
>   	up_read(&mdsc->snap_rwsem);
>   	if (!realm)
>   		return false;
>


