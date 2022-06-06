Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7105553DF21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 02:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351874AbiFFAkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351840AbiFFAkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 20:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B6A549CA6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 17:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654476046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztkmqVnlNudKHK3nozyJXARq4S0vh4WAgBlCzt1poB4=;
        b=ZCR8gUOtBs8GfyTl4v5saAEYw2QiaO5s95CGvVxXkji8BlaRGksHBkjPu9LddH1nhMRggk
        6ZrY+OIjjFRAEN/XRy4ZOc2Qbuj36Dcuik+OJQudgy1Fzy+npTCrdOjIv/E5rHEz3uiJCZ
        CO/Cu8AVQVmPtRtLYyWQrzk96im0RV8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-kvQKwdxqMN6R5aSBM1O4dw-1; Sun, 05 Jun 2022 20:40:45 -0400
X-MC-Unique: kvQKwdxqMN6R5aSBM1O4dw-1
Received: by mail-pg1-f197.google.com with SMTP id x16-20020a63f710000000b003f6082673afso6126521pgh.15
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 17:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ztkmqVnlNudKHK3nozyJXARq4S0vh4WAgBlCzt1poB4=;
        b=zvwHFCw7u2WAmQQgaPBwzwOI4tpqS7Mw2VGsciwC2jTXQufEkswCZLX0cv4nKkQIxN
         Tro/gSrs0ipp8hVaNMaAhrBa4k8w2MSqMjUDCK36eqh1DVmjrSFhM0VO/56niQJbftN/
         kDScdUCIckNaJzTn+d22JqjvqWDGO5oF1EezmvtGV8VsFkYtARv+cdQ0lYP44wgWnJH9
         dbPsez8Z4fo6t6iSxqhLLFBfYnq7s3WxxCpygNo6czNFbhobq7F7WezQQPg8g+Ai68M3
         ve7bQLLkdjeiMBdhZkDOYCPZBv5Q58+OvvDVkfcwS41tJFNxMjBTt407D77aeMt2x6g1
         tt+A==
X-Gm-Message-State: AOAM530Kof09H76jDPbMAOkubLpNMEBAedXBRGZTzCv/vVxgoyWFgz75
        Jph4IOrjUtDFiuoosuHzrdMVi2DAEi0MNjWx6aVJHPhnZqbEqKv/A9+j0tyRX3eV/1exUupDnlp
        3vEmwUh7tdR1F2UWDTHB03PI5omk7ZIUTKE/4ivigAczxE09CRTvsOKUMkq83vcOZQ7m5FvFdYg
        ==
X-Received: by 2002:a63:844a:0:b0:3fc:e1a0:b80d with SMTP id k71-20020a63844a000000b003fce1a0b80dmr16846802pgd.616.1654476044154;
        Sun, 05 Jun 2022 17:40:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtQsB/rHO6jVQtH0zjxtudP5oSFGZvjZj1UdtuM5h8TVy5SvctlmWYisl02MPCrsEhKmKlBA==
X-Received: by 2002:a63:844a:0:b0:3fc:e1a0:b80d with SMTP id k71-20020a63844a000000b003fce1a0b80dmr16846781pgd.616.1654476043766;
        Sun, 05 Jun 2022 17:40:43 -0700 (PDT)
Received: from [10.72.12.54] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902a38500b001640beeebf1sm9128120pla.268.2022.06.05.17.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 17:40:42 -0700 (PDT)
Subject: Re: [PATCH v5] ceph: prevent a client from exceeding the MDS maximum
 xattr size
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Gregory Farnum <gfarnum@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220603132909.10166-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <54a87be1-d46a-bc50-cf2d-1a094bb4c176@redhat.com>
Date:   Mon, 6 Jun 2022 08:40:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220603132909.10166-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/22 9:29 PM, Luís Henriques wrote:
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
>   fs/ceph/mdsmap.c            | 22 ++++++++++++++++++----
>   fs/ceph/xattr.c             | 12 ++++++++----
>   include/linux/ceph/mdsmap.h |  1 +
>   3 files changed, 27 insertions(+), 8 deletions(-)
>
> * Changes since v4
>
> - Dropped definition of MDS_MAX_XATTR_SIZE, which isn't needed anymore
> - Fixed (finally?) the compilation warning detected by bot
> (also dropped the RFC from the subject)
>
> * Changes since v3
>
> As per Xiubo review:
>    - Always force a (sync) SETXATTR Op when connecting to an old cluster
>    - use '>' instead of '>='
> Also fixed the warning detected by 0day.
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
> index 30387733765d..8d0a6d2c2da4 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -352,12 +352,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
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
> @@ -370,6 +368,22 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
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
> +		/* required_client_features */
> +		ceph_decode_skip_set(p, end, 64, bad_ext);
> +		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
> +	} else {
> +		/* This forces the usage of the (sync) SETXATTR Op */
> +		m->m_max_xattr_size = 0;
> +	}
>   bad_ext:
>   	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
>   	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 8c2dc2c762a4..902323b12c35 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
>   			flags |= CEPH_XATTR_REMOVE;
>   	}
>   
> -	dout("setxattr value=%.*s\n", (int)size, value);
> +	dout("setxattr value size: %zu\n", size);
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
> +	    (required_blob_size > mdsc->mdsmap->m_max_xattr_size)) {
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
Merged into the testing branch. Thanks Luis.

-- Xiubo


