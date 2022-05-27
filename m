Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996EA53573E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 03:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiE0BJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 21:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiE0BJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 21:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86E2AEAB88
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653613736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITAkTPDUyhydRVhx00amjdjQd1nX1Gjw4+2WmugbV/U=;
        b=AHyYjHdXzvQPdgSkQDknvh0a5OZ07x8/QhhO3j5GGy75Qsl3uRADOjXVUmj8AqaZVueC6A
        2X/NXLQaII9jva7RpDNkYic9/I2KICSdGwtIV9UeTG6vuALpZncbh9RoS3UYTlgntb0w4H
        xY3mSUH91zvUCR0akQEO9VGoLswlK0o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-R4CxckoHMDy_3grIA-060g-1; Thu, 26 May 2022 21:08:55 -0400
X-MC-Unique: R4CxckoHMDy_3grIA-060g-1
Received: by mail-pl1-f199.google.com with SMTP id c4-20020a170902c2c400b0015f16fb4a54so1944787pla.22
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ITAkTPDUyhydRVhx00amjdjQd1nX1Gjw4+2WmugbV/U=;
        b=DJeLyWC+lRj7e7tgjbTCQQElcFyIquAFMKdHmwkXSo1+AiqnLWFZ5foTQtxVC13mtc
         iJxaYJD9JxOE9myjjLkjgMqiBtWrY17MIqcHl7xnKHCAgt+/YpBOSD2Z1ryICkAYBlid
         J2/juozZoPSqBwMjRNmwMeXoDQVKdreS1UyHb+T1vH1pHFF2SzgnzK2qOWBggF/xjZQ/
         cThnj3b1mGp4QRBwKpts0qITwM+/vVXoDhX+HcJERc/dcGoXDcfn2/9lPymGtQd9KRpI
         2+HxKY4mFLUlB8qwZ1Wew/9rM2cVdN31apFhtzbgrmBZ5ApIXGRcoig9dBwgHYsw7L6C
         MHiA==
X-Gm-Message-State: AOAM532Su/YDGElY+3zCDl0ub68eUTBWOTnGd4cKxa4L6FBqMjAtGiwZ
        re0TNXMn6xcFF13sjR/Y6xC4uNg5rB4EQOxIRTtm7E303Ebv4X9Qab8NEOySyhk+rrMV9tgmtyE
        0QdxbWEbLReXN/qbkauBj70P6qx1a5zGN7ZHTgAa5xvBC653Cm82rIeE6UCeND7fmb+3uPvdOHA
        ==
X-Received: by 2002:a17:903:1249:b0:15e:8b15:b7d2 with SMTP id u9-20020a170903124900b0015e8b15b7d2mr41910171plh.150.1653613733934;
        Thu, 26 May 2022 18:08:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNSKHIsNTHpZu6psOTvnnkrYmyYVSeZa+Sw/7C1S6aC1sp4crrG3+0SlipHvRDTkqWiPzidQ==
X-Received: by 2002:a17:903:1249:b0:15e:8b15:b7d2 with SMTP id u9-20020a170903124900b0015e8b15b7d2mr41910138plh.150.1653613733451;
        Thu, 26 May 2022 18:08:53 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r4-20020a170903020400b0015e8d4eb2bcsm2191574plh.262.2022.05.26.18.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 18:08:52 -0700 (PDT)
Subject: Re: [RFC PATCH v2] ceph: prevent a client from exceeding the MDS
 maximum xattr size
To:     Jeff Layton <jlayton@kernel.org>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220525172427.3692-1-lhenriques@suse.de>
 <fb3d817d8b6235472e517a9fc9ad0956fb4e8cf2.camel@kernel.org>
 <3cb96552-9747-c6b4-c8d3-81af60e5ae6a@redhat.com>
 <ca4928507bdf329bbe5b32a7b71f4a4295e5bba1.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <f238e4a1-ef98-ccfe-6345-51b6d9a34319@redhat.com>
Date:   Fri, 27 May 2022 09:08:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ca4928507bdf329bbe5b32a7b71f4a4295e5bba1.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/27/22 8:44 AM, Jeff Layton wrote:
> On Fri, 2022-05-27 at 08:36 +0800, Xiubo Li wrote:
>> On 5/27/22 2:39 AM, Jeff Layton wrote:
>>> On Wed, 2022-05-25 at 18:24 +0100, Luís Henriques wrote:
>>>> The MDS tries to enforce a limit on the total key/values in extended
>>>> attributes.  However, this limit is enforced only if doing a synchronous
>>>> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
>>>> doesn't have a chance to enforce these limits.
>>>>
>>>> This patch adds support for an extra feature bit that will allow the
>>>> client to get the MDS max_xattr_pairs_size setting in the session message.
>>>> Then, when setting an xattr, the kernel will revert to do a synchronous
>>>> operation if that maximum size is exceeded.
>>>>
>>>> While there, fix a dout() that would trigger a printk warning:
>>>>
>>>> [   98.718078] ------------[ cut here ]------------
>>>> [   98.719012] precision 65536 too large
>>>> [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf+0x5e3/0x600
>>>> ...
>>>>
>>>> URL: https://tracker.ceph.com/issues/55725
>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>> ---
>>>>    fs/ceph/mds_client.c | 12 ++++++++++++
>>>>    fs/ceph/mds_client.h | 15 ++++++++++++++-
>>>>    fs/ceph/xattr.c      | 12 ++++++++----
>>>>    3 files changed, 34 insertions(+), 5 deletions(-)
>>>>
>>>> * Changes since v1
>>>>
>>>> Added support for new feature bit to get the MDS max_xattr_pairs_size
>>>> setting.
>>>>
>>>> Also note that this patch relies on a patch that hasn't been merged yet
>>>> ("ceph: use correct index when encoding client supported features"),
>>>> otherwise the new feature bit won't be correctly encoded.
>>>>
>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>> index 35597fafb48c..87a25b7cf496 100644
>>>> --- a/fs/ceph/mds_client.c
>>>> +++ b/fs/ceph/mds_client.c
>>>> @@ -3500,6 +3500,7 @@ static void handle_session(struct ceph_mds_session *session,
>>>>    	struct ceph_mds_session_head *h;
>>>>    	u32 op;
>>>>    	u64 seq, features = 0;
>>>> +	u64 max_xattr_pairs_size = 0;
>>>>    	int wake = 0;
>>>>    	bool blocklisted = false;
>>>>    
>>>> @@ -3545,6 +3546,9 @@ static void handle_session(struct ceph_mds_session *session,
>>>>    		}
>>>>    	}
>>>>    
>>>> +	if (msg_version >= 6)
>>>> +		ceph_decode_64_safe(&p, end, max_xattr_pairs_size, bad);
>>>> +
>>>>    	mutex_lock(&mdsc->mutex);
>>>>    	if (op == CEPH_SESSION_CLOSE) {
>>>>    		ceph_get_mds_session(session);
>>>> @@ -3552,6 +3556,12 @@ static void handle_session(struct ceph_mds_session *session,
>>>>    	}
>>>>    	/* FIXME: this ttl calculation is generous */
>>>>    	session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
>>>> +
>>>> +	if (max_xattr_pairs_size && (op == CEPH_SESSION_OPEN)) {
>>>> +		dout("Changing MDS max xattrs pairs size: %llu => %llu\n",
>>>> +		     mdsc->max_xattr_pairs_size, max_xattr_pairs_size);
>>>> +		mdsc->max_xattr_pairs_size = max_xattr_pairs_size;
>>>> +	}
>>>>    	mutex_unlock(&mdsc->mutex);
>>>>    
>>>>    	mutex_lock(&session->s_mutex);
>>>> @@ -4761,6 +4771,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>>>>    	strscpy(mdsc->nodename, utsname()->nodename,
>>>>    		sizeof(mdsc->nodename));
>>>>    
>>>> +	mdsc->max_xattr_pairs_size = MDS_MAX_XATTR_PAIRS_SIZE;
>>>> +
>>>>    	fsc->mdsc = mdsc;
>>>>    	return 0;
>>>>    
>>>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>>>> index ca32f26f5eed..3db777df6d88 100644
>>>> --- a/fs/ceph/mds_client.h
>>>> +++ b/fs/ceph/mds_client.h
>>>> @@ -29,8 +29,11 @@ enum ceph_feature_type {
>>>>    	CEPHFS_FEATURE_MULTI_RECONNECT,
>>>>    	CEPHFS_FEATURE_DELEG_INO,
>>>>    	CEPHFS_FEATURE_METRIC_COLLECT,
>>>> +	CEPHFS_FEATURE_ALTERNATE_NAME,
>>>> +	CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
>>>> +	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,
>>> Having to make this feature-bit-dependent kind of sucks. I wonder if it
>>> could be avoided...
>>>
>>> A question:
>>>
>>> How do the MDS's discover this setting? Do they get it from the mons? If
>>> so, I wonder if there is a way for the clients to query the mon for this
>>> instead of having to extend the MDS protocol?
>> It sounds like what the "max_file_size" does, which will be recorded in
>> the 'mdsmap'.
>>
>> While currently the "max_xattr_pairs_size" is one MDS's option for each
>> daemon and could set different values for each MDS.
>>
>>
> Right, but the MDS's in general don't use local config files. Where are
> these settings stored? Could the client (potentially) query for them?

AFAIK, each process in ceph it will have its own copy of the 
"CephContext". I don't know how to query all of them but I know there 
have some API such as "rados_conf_set/get" could do similar things.

Not sure whether will it work in our case.

>
> I'm pretty sure the client does fetch and parse the mdsmap. If it's
> there then it could grab the setting for all of the MDS's at mount time
> and settle on the lowest one.
>
> I think a solution like that might be more resilient than having to
> fiddle with feature bits and such...

Yeah, IMO just making this option to be like the "max_file_size" is more 
appropriate.

-- Xiubo

>
>>>>    
>>>> -	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
>>>> +	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,
>>>>    };
>>>>    
>>>>    /*
>>>> @@ -45,9 +48,16 @@ enum ceph_feature_type {
>>>>    	CEPHFS_FEATURE_MULTI_RECONNECT,		\
>>>>    	CEPHFS_FEATURE_DELEG_INO,		\
>>>>    	CEPHFS_FEATURE_METRIC_COLLECT,		\
>>>> +	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,	\
>>>>    }
>>>>    #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
>>>>    
>>>> +/*
>>>> + * Maximum size of xattrs the MDS can handle per inode by default.  This
>>>> + * includes the attribute name and 4+4 bytes for the key/value sizes.
>>>> + */
>>>> +#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
>>>> +
>>>>    /*
>>>>     * Some lock dependencies:
>>>>     *
>>>> @@ -404,6 +414,9 @@ struct ceph_mds_client {
>>>>    	struct rb_root		quotarealms_inodes;
>>>>    	struct mutex		quotarealms_inodes_mutex;
>>>>    
>>>> +	/* maximum aggregate size of extended attributes on a file */
>>>> +	u64			max_xattr_pairs_size;
>>>> +
>>>>    	/*
>>>>    	 * snap_rwsem will cover cap linkage into snaprealms, and
>>>>    	 * realm snap contexts.  (later, we can do per-realm snap
>>>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>>>> index 8c2dc2c762a4..175a8c1449aa 100644
>>>> --- a/fs/ceph/xattr.c
>>>> +++ b/fs/ceph/xattr.c
>>>> @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
>>>>    			flags |= CEPH_XATTR_REMOVE;
>>>>    	}
>>>>    
>>>> -	dout("setxattr value=%.*s\n", (int)size, value);
>>>> +	dout("setxattr value size: %ld\n", size);
>>>>    
>>>>    	/* do request */
>>>>    	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
>>>> @@ -1184,8 +1184,14 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>>>>    	spin_lock(&ci->i_ceph_lock);
>>>>    retry:
>>>>    	issued = __ceph_caps_issued(ci, NULL);
>>>> -	if (ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))
>>>> +	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
>>>> +	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
>>>> +	    (required_blob_size >= mdsc->max_xattr_pairs_size)) {
>>>> +		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
>>>> +		     __func__, ci->i_xattrs.version, required_blob_size,
>>>> +		     mdsc->max_xattr_pairs_size);
>>>>    		goto do_sync;
>>>> +	}
>>>>    
>>>>    	if (!lock_snap_rwsem && !ci->i_head_snapc) {
>>>>    		lock_snap_rwsem = true;
>>>> @@ -1201,8 +1207,6 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>>>>    	     ceph_cap_string(issued));
>>>>    	__build_xattrs(inode);
>>>>    
>>>> -	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
>>>> -
>>>>    	if (!ci->i_xattrs.prealloc_blob ||
>>>>    	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
>>>>    		struct ceph_buffer *blob;

