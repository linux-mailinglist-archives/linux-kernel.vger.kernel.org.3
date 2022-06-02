Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7053B649
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiFBJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiFBJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F18CF13B2D8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654162981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvpBJgFNptHg6js/ah8cyCcyPzqiNcEeiwhG2uOaTXY=;
        b=gJHQtxRgGZ0HfKNskY7KnhRaxal427mrOEzJwf+TL86l7EuIk0FRiEx9ikW/dz/M/Dm7n9
        d/Ly6cdIvQz0U/DMV6Cc+AakJWn9lLn28ewkh1P/7hglE8ZYLRU1J/D8uVuqoGdECGYuWW
        BsYk2e9Nr546WOATb6eHMzlzqcB9siA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-fEo85abEN_Wsz7PzcPUGbw-1; Thu, 02 Jun 2022 05:43:00 -0400
X-MC-Unique: fEo85abEN_Wsz7PzcPUGbw-1
Received: by mail-pl1-f199.google.com with SMTP id h13-20020a170902f70d00b0015f4cc5d19aso2457223plo.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 02:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JvpBJgFNptHg6js/ah8cyCcyPzqiNcEeiwhG2uOaTXY=;
        b=W2YD/K5BEHuS12LoKW9jGhnOmolGlpJ8WOSdkY6e8nmTKevdaAMuu/6IIyiy769rn8
         D4B5rUsiOhW4rZDy6bbTXEFKr/VKwXhYMuxYqTxrJqm5i0p+XblhFR0/xQyifxeE/ZTb
         rYPhdRXeBImfu4zbFSG9Um/X78C5doH6lrMBNYzNDmHiR+Y2rpKlWWFKx8Qi3ligcLZ7
         oQvdf8ULRyn6xQgtyP6JJjCT49nI4zP1197mebkSq5MaYpSCJZDgjOxZCClb8kIj0dCh
         dDyDfu3St6xteJZ3T1/rGsgItrC4cj92RDeks04j7YGyosjNQhLNUfCwBAms/stc5tTO
         GUcg==
X-Gm-Message-State: AOAM533j5CFqmf2tfXLUz6Zmz79JOapmFELGSBD+TN0pXFIMl5prRrcy
        8qgV1+v9ZhH/BM/CjoW9clPjtLdfwfC/mTfZDl50z3Gl8PL19hwWhdTo2Un1a6/DNntZbdxgeSS
        yUl2M650252C/iNN7+W8iBmiTG65iDDqrkx+VI532Tjpmbu2gqD+aLAihg+fjXHB0JGNSRKdJXQ
        ==
X-Received: by 2002:a62:140c:0:b0:51b:bd14:6859 with SMTP id 12-20020a62140c000000b0051bbd146859mr5141556pfu.28.1654162978506;
        Thu, 02 Jun 2022 02:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv0Fnp154lJ3zdr12+hPZG//GkL7o63kRnr8RbZLa8Qyjnj/j3qGVf9FDRMZHLkQ8GOjUI9w==
X-Received: by 2002:a62:140c:0:b0:51b:bd14:6859 with SMTP id 12-20020a62140c000000b0051bbd146859mr5141520pfu.28.1654162978132;
        Thu, 02 Jun 2022 02:42:58 -0700 (PDT)
Received: from [10.72.12.107] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y71-20020a638a4a000000b003c25dfd7372sm446757pgd.26.2022.06.02.02.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 02:42:57 -0700 (PDT)
Subject: Re: [RFC PATCH v3] ceph: prevent a client from exceeding the MDS
 maximum xattr size
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Gregory Farnum <gfarnum@redhat.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220601162939.12278-1-lhenriques@suse.de>
 <b788a7f9-9177-0398-7d21-a19ce7e6c957@redhat.com>
 <87h7534dr9.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <289f5136-d2fc-1474-eb0f-521586f241b2@redhat.com>
Date:   Thu, 2 Jun 2022 17:42:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87h7534dr9.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/22 5:26 PM, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> On 6/2/22 12:29 AM, Luís Henriques wrote:
>>> The MDS tries to enforce a limit on the total key/values in extended
>>> attributes.  However, this limit is enforced only if doing a synchronous
>>> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
>>> doesn't have a chance to enforce these limits.
>>>
>>> This patch adds support for decoding the xattrs maximum size setting that is
>>> distributed in the mdsmap.  Then, when setting an xattr, the kernel client
>>> will revert to do a synchronous operation if that maximum size is exceeded.
>>>
>>> While there, fix a dout() that would trigger a printk warning:
>>>
>>> [   98.718078] ------------[ cut here ]------------
>>> [   98.719012] precision 65536 too large
>>> [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf+0x5e3/0x600
>>> ...
>>>
>>> URL: https://tracker.ceph.com/issues/55725
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>>    fs/ceph/mdsmap.c            | 27 +++++++++++++++++++++++----
>>>    fs/ceph/xattr.c             | 12 ++++++++----
>>>    include/linux/ceph/mdsmap.h |  1 +
>>>    3 files changed, 32 insertions(+), 8 deletions(-)
>>>
>>> * Changes since v2
>>>
>>> Well, a lot has changed since v2!  Now the xattr max value setting is
>>> obtained through the mdsmap, which needs to be decoded, and the feature
>>> that was used in the previous revision was dropped.  The drawback is that
>>> the MDS isn't unable to know in advance if a client is aware of this xattr
>>> max value.
>>>
>>> * Changes since v1
>>>
>>> Added support for new feature bit to get the MDS max_xattr_pairs_size
>>> setting.
>>>
>>> Also note that this patch relies on a patch that hasn't been merged yet
>>> ("ceph: use correct index when encoding client supported features"),
>>> otherwise the new feature bit won't be correctly encoded.
>>>
>>> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
>>> index 30387733765d..36b2bc18ca2a 100644
>>> --- a/fs/ceph/mdsmap.c
>>> +++ b/fs/ceph/mdsmap.c
>>> @@ -13,6 +13,12 @@
>>>      #include "super.h"
>>>    +/*
>>> + * Maximum size of xattrs the MDS can handle per inode by default.  This
>>> + * includes the attribute name and 4+4 bytes for the key/value sizes.
>>> + */
>>> +#define MDS_MAX_XATTR_SIZE (1<<16) /* 64K */
>>> +
>>>    #define CEPH_MDS_IS_READY(i, ignore_laggy) \
>>>    	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
>>>    @@ -352,12 +358,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void
>>> *end, bool msgr2)
>>>    		__decode_and_drop_type(p, end, u8, bad_ext);
>>>    	}
>>>    	if (mdsmap_ev >= 8) {
>>> -		u32 name_len;
>>>    		/* enabled */
>>>    		ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
>>> -		ceph_decode_32_safe(p, end, name_len, bad_ext);
>>> -		ceph_decode_need(p, end, name_len, bad_ext);
>>> -		*p += name_len;
>>> +		/* fs_name */
>>> +		ceph_decode_skip_string(p, end, bad_ext);
>>>    	}
>>>    	/* damaged */
>>>    	if (mdsmap_ev >= 9) {
>>> @@ -370,6 +374,21 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
>>>    	} else {
>>>    		m->m_damaged = false;
>>>    	}
>>> +	if (mdsmap_ev >= 17) {
>>> +		/* balancer */
>>> +		ceph_decode_skip_string(p, end, bad_ext);
>>> +		/* standby_count_wanted */
>>> +		ceph_decode_skip_32(p, end, bad_ext);
>>> +		/* old_max_mds */
>>> +		ceph_decode_skip_32(p, end, bad_ext);
>>> +		/* min_compat_client */
>>> +		ceph_decode_skip_8(p, end, bad_ext);
>> This is incorrect.
>>
>> If mdsmap_ev == 15 the min_compat_client will be a feature_bitset_t instead of
>> int8_t.
> Hmm... can you point me at where that's done in the code?  As usual, I'm
> confused with that code and simply can't see that.
>
> Also, if that happens only when mdsmap_ev == 15, then there's no problem
> because that branch is only taken if it's >= 17.

Yeah, so you should skip 32 or 32+64 bits instead here, just likes:

3536                 /* version >= 3, feature bits */
3537                 ceph_decode_32_safe(&p, end, len, bad);
3538                 if (len) {
3539                         ceph_decode_64_safe(&p, end, features, bad);
3540                         p += len - sizeof(features);
3541                 }

For the ceph code please see:

Please see https://github.com/ceph/ceph/blob/main/src/mds/MDSMap.cc#L925.

>>
>>> +		/* required_client_features */
>>> +		ceph_decode_skip_set(p, end, 64, bad_ext);
>>> +		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
>>> +	} else {
>>> +		m->m_max_xattr_size = MDS_MAX_XATTR_SIZE;
>>> +	}
>>>    bad_ext:
>>>    	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
>>>    	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
>>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>>> index 8c2dc2c762a4..67f046dac35c 100644
>>> --- a/fs/ceph/xattr.c
>>> +++ b/fs/ceph/xattr.c
>>> @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
>>>    			flags |= CEPH_XATTR_REMOVE;
>>>    	}
>>>    -	dout("setxattr value=%.*s\n", (int)size, value);
>>> +	dout("setxattr value size: %ld\n", size);
>>>      	/* do request */
>>>    	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
>>> @@ -1184,8 +1184,14 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>>>    	spin_lock(&ci->i_ceph_lock);
>>>    retry:
>>>    	issued = __ceph_caps_issued(ci, NULL);
>>> -	if (ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))
>>> +	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
>>> +	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
>>> +	    (required_blob_size >= mdsc->mdsmap->m_max_xattr_size)) {
>> Shouldn't it be '>' instead ?
> Ok, I'll fix that.
>
>> We'd better always force to do a sync request with old ceph. Just check if the
>> mdsmap_ev < 17. It's not safe to buffer it because it maybe discarded as your
>> ceph PR does.
> Right, that can be done.  So, I can simply set the m_max_xattr_size to '0'
> if mdsmap_ev < 17.  Then, this 'if' condition will always be evaluated to
> true because required_blob_size will be > 0.  Does that sound OK?

Yeah, sounds good.

-- Xiubo


>
> Cheers,

