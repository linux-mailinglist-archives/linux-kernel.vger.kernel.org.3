Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87D53B1C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiFBCdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiFBCdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FCBF1F7DB3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654137218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfKQiZyiru8Yvpxrs4iJay6YbdDe/dy7mWV2Ajal/ZA=;
        b=dfYuFyLN+u1Lu/tbmtU08PeTkobbVEX2/393I6t860+lN90zzjQGrMI+rLIQG6HJ3WAcJB
        PWH/mlVgobZHGyrXUXC+z/Nggs8mvA2NTad+Guyl0x6/AwsgkrGxEs9LISF+o+ZwR/5xVC
        898cR1J7dctdwzYwV7rmI5eGYAUCW2s=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-lAD4nu99Pe--j9QpQ99xdA-1; Wed, 01 Jun 2022 22:33:37 -0400
X-MC-Unique: lAD4nu99Pe--j9QpQ99xdA-1
Received: by mail-pf1-f200.google.com with SMTP id 206-20020a6218d7000000b0051893ee2888so194494pfy.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KfKQiZyiru8Yvpxrs4iJay6YbdDe/dy7mWV2Ajal/ZA=;
        b=hZF7Df1lneQotb9cNhc64P0DMH3vMBIGSNP8MwwnZTTBovm+iaJ+vLTvyQZ2XS6z8O
         WUDB4wxumJUNXbqBCw7faWFrxTooy3dfyIMTKXJBLSKuxkJFfeE6ZNTB8l9kV4njK69Z
         C/xBMEftK7MroKbkCF+gEbEktvwVya78CBe72j5hCUNNn+f9aZrY7tpplioyDSS0cQ3C
         m0mzdy9lWJWGVMtxDoqzh7ZVmqN0rubWJjh4n0biT8r3wV+Sw4hqJ6jD3dbZ6btX4EhY
         xaDVYyC9kDa/3jq1pWO8Vl8dL+juAY7uzVEerOAJGUQwq5w8CARjtkTS+FXJkCfDU0YW
         SjPg==
X-Gm-Message-State: AOAM531mSNW6fStkHO5jLNCM94qoXi6ZMgpSf6vSph0xL9PibmY0Vwmx
        +uqzJYIBP9+Kn3OMboVFFTViq+bQ2TRidECXo+weqWCEB8doiIbThLGLXTLYDjNIziUNY7JwYAM
        dZayUCW0jEuf/bYQ4kHke54XaMXZMV1TNWnpU4a9Ma1pdbx47ZSoL5x4ecGwXrBduFbYVr+LMcQ
        ==
X-Received: by 2002:a17:903:186:b0:161:f394:3e75 with SMTP id z6-20020a170903018600b00161f3943e75mr2459174plg.113.1654137215190;
        Wed, 01 Jun 2022 19:33:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwB998KxnKGHyDwCclY9nhZOHclVs+2ntkxLSrZyXPf/5nvqaSv+MCqUMW8tc7NGhaKThdiHg==
X-Received: by 2002:a17:903:186:b0:161:f394:3e75 with SMTP id z6-20020a170903018600b00161f3943e75mr2459130plg.113.1654137214545;
        Wed, 01 Jun 2022 19:33:34 -0700 (PDT)
Received: from [10.72.12.107] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 137-20020a63018f000000b003fbfd5e4ddcsm2054751pgb.75.2022.06.01.19.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 19:33:33 -0700 (PDT)
Subject: Re: [RFC PATCH v3] ceph: prevent a client from exceeding the MDS
 maximum xattr size
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Gregory Farnum <gfarnum@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220601162939.12278-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <b788a7f9-9177-0398-7d21-a19ce7e6c957@redhat.com>
Date:   Thu, 2 Jun 2022 10:33:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220601162939.12278-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/22 12:29 AM, Luís Henriques wrote:
> The MDS tries to enforce a limit on the total key/values in extended
> attributes.  However, this limit is enforced only if doing a synchronous
> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
> doesn't have a chance to enforce these limits.
>
> This patch adds support for decoding the xattrs maximum size setting that is
> distributed in the mdsmap.  Then, when setting an xattr, the kernel client
> will revert to do a synchronous operation if that maximum size is exceeded.
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
>   fs/ceph/mdsmap.c            | 27 +++++++++++++++++++++++----
>   fs/ceph/xattr.c             | 12 ++++++++----
>   include/linux/ceph/mdsmap.h |  1 +
>   3 files changed, 32 insertions(+), 8 deletions(-)
>
> * Changes since v2
>
> Well, a lot has changed since v2!  Now the xattr max value setting is
> obtained through the mdsmap, which needs to be decoded, and the feature
> that was used in the previous revision was dropped.  The drawback is that
> the MDS isn't unable to know in advance if a client is aware of this xattr
> max value.
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
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index 30387733765d..36b2bc18ca2a 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -13,6 +13,12 @@
>   
>   #include "super.h"
>   
> +/*
> + * Maximum size of xattrs the MDS can handle per inode by default.  This
> + * includes the attribute name and 4+4 bytes for the key/value sizes.
> + */
> +#define MDS_MAX_XATTR_SIZE (1<<16) /* 64K */
> +
>   #define CEPH_MDS_IS_READY(i, ignore_laggy) \
>   	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
>   
> @@ -352,12 +358,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
>   		__decode_and_drop_type(p, end, u8, bad_ext);
>   	}
>   	if (mdsmap_ev >= 8) {
> -		u32 name_len;
>   		/* enabled */
>   		ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
> -		ceph_decode_32_safe(p, end, name_len, bad_ext);
> -		ceph_decode_need(p, end, name_len, bad_ext);
> -		*p += name_len;
> +		/* fs_name */
> +		ceph_decode_skip_string(p, end, bad_ext);
>   	}
>   	/* damaged */
>   	if (mdsmap_ev >= 9) {
> @@ -370,6 +374,21 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
>   	} else {
>   		m->m_damaged = false;
>   	}
> +	if (mdsmap_ev >= 17) {
> +		/* balancer */
> +		ceph_decode_skip_string(p, end, bad_ext);
> +		/* standby_count_wanted */
> +		ceph_decode_skip_32(p, end, bad_ext);
> +		/* old_max_mds */
> +		ceph_decode_skip_32(p, end, bad_ext);
> +		/* min_compat_client */
> +		ceph_decode_skip_8(p, end, bad_ext);

This is incorrect.

If mdsmap_ev == 15 the min_compat_client will be a feature_bitset_t 
instead of int8_t.


> +		/* required_client_features */
> +		ceph_decode_skip_set(p, end, 64, bad_ext);
> +		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
> +	} else {
> +		m->m_max_xattr_size = MDS_MAX_XATTR_SIZE;
> +	}
>   bad_ext:
>   	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
>   	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 8c2dc2c762a4..67f046dac35c 100644
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
> +	    (required_blob_size >= mdsc->mdsmap->m_max_xattr_size)) {

Shouldn't it be '>' instead ?

We'd better always force to do a sync request with old ceph. Just check 
if the mdsmap_ev < 17. It's not safe to buffer it because it maybe 
discarded as your ceph PR does.

-- Xiubo

> +		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
> +		     __func__, ci->i_xattrs.version, required_blob_size,
> +		     mdsc->mdsmap->m_max_xattr_size);
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
> diff --git a/include/linux/ceph/mdsmap.h b/include/linux/ceph/mdsmap.h
> index 523fd0452856..4c3e0648dc27 100644
> --- a/include/linux/ceph/mdsmap.h
> +++ b/include/linux/ceph/mdsmap.h
> @@ -25,6 +25,7 @@ struct ceph_mdsmap {
>   	u32 m_session_timeout;          /* seconds */
>   	u32 m_session_autoclose;        /* seconds */
>   	u64 m_max_file_size;
> +	u64 m_max_xattr_size;		/* maximum size for xattrs blob */
>   	u32 m_max_mds;			/* expected up:active mds number */
>   	u32 m_num_active_mds;		/* actual up:active mds number */
>   	u32 possible_max_rank;		/* possible max rank index */
>

