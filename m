Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3008F534A08
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 06:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbiEZEwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 00:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiEZEwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 00:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54C71BA55E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 21:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653540749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qlfZlaJh81CHICswvSIevXoT7A6CVd3gXlBXWVyY6aw=;
        b=XW0AR9CYKUV1vdWjyYZA5hORSaD5T2L9P92qX2Gzc9ZPlonnc+SLctrPqJbKmyhwC+l0Xf
        VrHi7ClPA8PWDodp/IeHVS36UxnHBzyujrWj8Cd11P96NyhUz2dPNPgy2NyBoNTDIcV7qH
        QAsmF+7tv4m+29KMeHgXtmvNRxVezUY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-X8odYZMoNSCWOXDoz50hEw-1; Thu, 26 May 2022 00:52:28 -0400
X-MC-Unique: X8odYZMoNSCWOXDoz50hEw-1
Received: by mail-pg1-f200.google.com with SMTP id e18-20020a656492000000b003fa4033f9a7so301926pgv.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 21:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qlfZlaJh81CHICswvSIevXoT7A6CVd3gXlBXWVyY6aw=;
        b=k6QD6HwWhc9oVhRQJ27F4sMcDefIQQqhXVV37rPmCY0d+RLmcYZmHpszNeam5o22au
         QMXcW+w+wp183nh2yjdkVZEcnjgzul2iU/gE+KNVQto9kXkLll1gRU+5nt6Gjl8YWtEw
         +YqE2tIZOKlTNP70SQHyF/c3UY7ZXzw3cCw/GRLN8fsKqhe8D83LrgTuFxeiIrcmCKca
         Gr+2VUnKA6uvYAziyhJl8h7B9GEHdx1wg/+pYUH89IDD0QqUhkNWibVpfI1ecyf30Jjv
         UuPK1GIAh2Z97D5vxhwuS4q8mJZAYflf/ZPpvgTqZ6gmBvq6+r0J4EuLsO0/dl+f/sDc
         pxeA==
X-Gm-Message-State: AOAM533NGqtognPKsCwHoTpiBmDjeNP1uHsIQt7apMPkN/BYu3F38EnS
        uIXLEZ5GoQ6xmIrMYMTe9Z8GXJSTZBXn1UaaTNzUfWhOhApaJEvpmOyknYBcnk1OMqveXbhEVAw
        CWVSZzfopCBDPg0QZfHOTIiubFX1dONrJ3izEtanKkAwoGV4jGTcbd2OsabbEQ6hOMX5ptYL/yA
        ==
X-Received: by 2002:a17:903:234d:b0:161:994f:f850 with SMTP id c13-20020a170903234d00b00161994ff850mr35763217plh.47.1653540746602;
        Wed, 25 May 2022 21:52:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaMGchLBAuQCrgGMWrCKQTmehew3UTAX+R2Lagw9nPqKeqLDZaojhyFRQZw4SlO8ZzIi+ksw==
X-Received: by 2002:a17:903:234d:b0:161:994f:f850 with SMTP id c13-20020a170903234d00b00161994ff850mr35763192plh.47.1653540746232;
        Wed, 25 May 2022 21:52:26 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f26-20020aa7969a000000b005187ed76a78sm295631pfk.174.2022.05.25.21.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 21:52:25 -0700 (PDT)
Subject: Re: [RFC PATCH v2] ceph: prevent a client from exceeding the MDS
 maximum xattr size
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220525172427.3692-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <6619607f-091d-321f-bd14-02d5c1fd84c9@redhat.com>
Date:   Thu, 26 May 2022 12:52:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220525172427.3692-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/26/22 1:24 AM, Luís Henriques wrote:
> The MDS tries to enforce a limit on the total key/values in extended
> attributes.  However, this limit is enforced only if doing a synchronous
> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
> doesn't have a chance to enforce these limits.
>
> This patch adds support for an extra feature bit that will allow the
> client to get the MDS max_xattr_pairs_size setting in the session message.
> Then, when setting an xattr, the kernel will revert to do a synchronous
> operation if that maximum size is exceeded.
>
> While there, fix a dout() that would trigger a printk warning:
>
> [   98.718078] ------------[ cut here ]------------
> [   98.719012] precision 65536 too large
> [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf+0x5e3/0x600
> ...
>
> URL: https://tracker.ceph.com/issues/55725
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/mds_client.c | 12 ++++++++++++
>   fs/ceph/mds_client.h | 15 ++++++++++++++-
>   fs/ceph/xattr.c      | 12 ++++++++----
>   3 files changed, 34 insertions(+), 5 deletions(-)
>
> * Changes since v1
>
> Added support for new feature bit to get the MDS max_xattr_pairs_size
> setting.
>
> Also note that this patch relies on a patch that hasn't been merged yet
> ("ceph: use correct index when encoding client supported features"),
> otherwise the new feature bit won't be correctly encoded.
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 35597fafb48c..87a25b7cf496 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3500,6 +3500,7 @@ static void handle_session(struct ceph_mds_session *session,
>   	struct ceph_mds_session_head *h;
>   	u32 op;
>   	u64 seq, features = 0;
> +	u64 max_xattr_pairs_size = 0;
>   	int wake = 0;
>   	bool blocklisted = false;
>   
> @@ -3545,6 +3546,9 @@ static void handle_session(struct ceph_mds_session *session,
>   		}
>   	}
>   
> +	if (msg_version >= 6)
> +		ceph_decode_64_safe(&p, end, max_xattr_pairs_size, bad);
> +
>   	mutex_lock(&mdsc->mutex);
>   	if (op == CEPH_SESSION_CLOSE) {
>   		ceph_get_mds_session(session);
> @@ -3552,6 +3556,12 @@ static void handle_session(struct ceph_mds_session *session,
>   	}
>   	/* FIXME: this ttl calculation is generous */
>   	session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
> +
> +	if (max_xattr_pairs_size && (op == CEPH_SESSION_OPEN)) {
> +		dout("Changing MDS max xattrs pairs size: %llu => %llu\n",
> +		     mdsc->max_xattr_pairs_size, max_xattr_pairs_size);
> +		mdsc->max_xattr_pairs_size = max_xattr_pairs_size;
> +	}

Is there any case that in the ceph cluster some MDSes are still using 
the default size, while some have changed the size ?

In that case IMO we should make sure the mdsc->max_xattr_pairs_size is 
always the smallest size.


>   	mutex_unlock(&mdsc->mutex);
>   
>   	mutex_lock(&session->s_mutex);
> @@ -4761,6 +4771,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>   	strscpy(mdsc->nodename, utsname()->nodename,
>   		sizeof(mdsc->nodename));
>   
> +	mdsc->max_xattr_pairs_size = MDS_MAX_XATTR_PAIRS_SIZE;
> +
>   	fsc->mdsc = mdsc;
>   	return 0;
>   
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index ca32f26f5eed..3db777df6d88 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -29,8 +29,11 @@ enum ceph_feature_type {
>   	CEPHFS_FEATURE_MULTI_RECONNECT,
>   	CEPHFS_FEATURE_DELEG_INO,
>   	CEPHFS_FEATURE_METRIC_COLLECT,
> +	CEPHFS_FEATURE_ALTERNATE_NAME,
> +	CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
> +	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,
>   
> -	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
> +	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,
>   };
>   
>   /*
> @@ -45,9 +48,16 @@ enum ceph_feature_type {
>   	CEPHFS_FEATURE_MULTI_RECONNECT,		\
>   	CEPHFS_FEATURE_DELEG_INO,		\
>   	CEPHFS_FEATURE_METRIC_COLLECT,		\
> +	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,	\
>   }
>   #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
>   
> +/*
> + * Maximum size of xattrs the MDS can handle per inode by default.  This
> + * includes the attribute name and 4+4 bytes for the key/value sizes.
> + */
> +#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
> +
>   /*
>    * Some lock dependencies:
>    *
> @@ -404,6 +414,9 @@ struct ceph_mds_client {
>   	struct rb_root		quotarealms_inodes;
>   	struct mutex		quotarealms_inodes_mutex;
>   
> +	/* maximum aggregate size of extended attributes on a file */
> +	u64			max_xattr_pairs_size;
> +
>   	/*
>   	 * snap_rwsem will cover cap linkage into snaprealms, and
>   	 * realm snap contexts.  (later, we can do per-realm snap
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 8c2dc2c762a4..175a8c1449aa 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
>   			flags |= CEPH_XATTR_REMOVE;
>   	}
>   
> -	dout("setxattr value=%.*s\n", (int)size, value);
> +	dout("setxattr value size: %ld\n", size);
>   
>   	/* do request */
>   	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> @@ -1184,8 +1184,14 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>   	spin_lock(&ci->i_ceph_lock);
>   retry:
>   	issued = __ceph_caps_issued(ci, NULL);
> -	if (ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))
> +	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
> +	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
> +	    (required_blob_size >= mdsc->max_xattr_pairs_size)) {

required_blob_size > mdsc->max_xattr_pairs_size ?

Thanks,

-- Xiubo
> +		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
> +		     __func__, ci->i_xattrs.version, required_blob_size,
> +		     mdsc->max_xattr_pairs_size);
>   		goto do_sync;
> +	}
>   
>   	if (!lock_snap_rwsem && !ci->i_head_snapc) {
>   		lock_snap_rwsem = true;
> @@ -1201,8 +1207,6 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>   	     ceph_cap_string(issued));
>   	__build_xattrs(inode);
>   
> -	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
> -
>   	if (!ci->i_xattrs.prealloc_blob ||
>   	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
>   		struct ceph_buffer *blob;
>

