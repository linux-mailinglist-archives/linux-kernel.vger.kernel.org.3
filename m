Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2542153C9B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244174AbiFCMLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiFCMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8AC432ECF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654258263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Z3LjMiWjgpqWErjXp179I71XhKOADdNqUblxAcCwck=;
        b=EPU/W3XXi2IfFFxtNEjkmTsUIg+jp5NagseUTL44yDrc9T8+kYS/G8pRAenQ+4+p4AccNA
        mGrW6RmoL8uAvxHMgEvw/tTrb6HP4Z7MtsYp+HwZOzn3+m4z4D92yF+MONeexx8YS3TA8R
        qZgK/gE5oHOl+gC6I3/8pJcuDXU4eCY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-5EjorCBuPNimXH7GwbfUig-1; Fri, 03 Jun 2022 08:11:02 -0400
X-MC-Unique: 5EjorCBuPNimXH7GwbfUig-1
Received: by mail-pf1-f197.google.com with SMTP id 144-20020a621496000000b0051ba2e95df2so4230660pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7Z3LjMiWjgpqWErjXp179I71XhKOADdNqUblxAcCwck=;
        b=JR6vmTb3ev1ylvFiXCSpuTZe1wzW6UE7xdetkc0GozHcq7vUdCrJ64egnHJLmnasLo
         hA60AUAB56pVndnPkipSlxaCsE31AuhAAwjcB5D1Ku3L8RatJc++CM3GCLEBPaE8+Hb8
         3NLMPK2BagP8pkU+vxeCGCvuqI1bhyEx8y2nre3PNOJn6ls06c8RB9W8w6ll29MzGMJs
         mbJP9V4ex+BpMK9FF6ElhVPSZBTTlCO3YaSTyEnngwBYONdzYoMcVtlmt3nrgste0ewL
         u1rWpXTk5a4gU04U0gDsnHbbi6Op5ywAxl8nxARCZVwb78OpLgG/a+TYlaFcfb3Euctq
         Wz6Q==
X-Gm-Message-State: AOAM533PC8IRv7J5DYDL+pl+XiG0Y6t5VGwGCQEYkMenBs43u09b5Dyt
        UdvKZlnB7Xdm4Jt5xk6618m60SRFtKW3EsvFHySX6SCABB53UPmA7fkb5qU/I7OAWaoJ9JmTBiK
        6Jeg9eZFC2AJt5pxYf04/gW7RPR4wu4v2xAFcmpsFzYNs7xRamZNgrECytLiX3rsNZqw8lfgW7g
        ==
X-Received: by 2002:a17:90b:1b41:b0:1e0:17f:d17 with SMTP id nv1-20020a17090b1b4100b001e0017f0d17mr45210409pjb.85.1654258261137;
        Fri, 03 Jun 2022 05:11:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXAEt6b1gIV+ulJHkRaVntG6S3lb46daEwgSYEVScOXcm1Zd+bDgNZ0VcopvAvyGcbZbIZXw==
X-Received: by 2002:a17:90b:1b41:b0:1e0:17f:d17 with SMTP id nv1-20020a17090b1b4100b001e0017f0d17mr45210371pjb.85.1654258260673;
        Fri, 03 Jun 2022 05:11:00 -0700 (PDT)
Received: from [10.72.12.54] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001640d4744fesm5209324plg.55.2022.06.03.05.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 05:10:59 -0700 (PDT)
Subject: Re: [RFC PATCH v4] ceph: prevent a client from exceeding the MDS
 maximum xattr size
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Gregory Farnum <gfarnum@redhat.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220602143652.28244-1-lhenriques@suse.de>
 <b89ca6a2-4332-b4db-2a40-ae3b00ebdf35@redhat.com>
 <87zgiu2cc7.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <6909ff58-c821-3fe6-c20e-436014e7c217@redhat.com>
Date:   Fri, 3 Jun 2022 20:10:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87zgiu2cc7.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/22 7:52 PM, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> On 6/2/22 10:36 PM, Luís Henriques wrote:
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
>>>    fs/ceph/mdsmap.c            | 28 ++++++++++++++++++++++++----
>>>    fs/ceph/xattr.c             | 12 ++++++++----
>>>    include/linux/ceph/mdsmap.h |  1 +
>>>    3 files changed, 33 insertions(+), 8 deletions(-)
>>>
>>> * Changes since v3
>>>
>>> As per Xiubo review:
>>>     - Always force a (sync) SETXATTR Op when connecting to an old cluster
>>>     - use '>' instead of '>='
>>> Also fixed the warning detected by 0day.
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
>>> index 30387733765d..c6ce83a48175 100644
>>> --- a/fs/ceph/mdsmap.c
>>> +++ b/fs/ceph/mdsmap.c
>>> @@ -13,6 +13,12 @@
>>>      #include "super.h"
>>>    +/*
>>> + * Maximum size of xattrs the MDS can handle per inode by default.  This
>>> + * includes the attribute name and 4+4 bytes for the key/value sizes.
>>> + */
>>> +#define MDS_MAX_XATTR_SIZE (1<<16) /* 64K */
>> This macro makes no sense anymore, right ?
> Ah, yeah.  That's still leftovers from the previous version.
>
>> I will merge this patch by removing this then.
> Thanks!  Also... maybe you could also fix the (embarrassing) issue
> detected by 0day that I _tried_ to fix but failed (see below).
>
>> -- Xiubo
>>
>>
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
>>> @@ -370,6 +374,22 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
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
>>> +		/* required_client_features */
>>> +		ceph_decode_skip_set(p, end, 64, bad_ext);
>>> +		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
>>> +	} else {
>>> +		/* This forces the usage of the (sync) SETXATTR Op */
>>> +		m->m_max_xattr_size = 0;
>>> +	}
>>>    bad_ext:
>>>    	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
>>>    	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
>>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>>> index 8c2dc2c762a4..1be415e9220b 100644
>>> --- a/fs/ceph/xattr.c
>>> +++ b/fs/ceph/xattr.c
>>> @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
>>>    			flags |= CEPH_XATTR_REMOVE;
>>>    	}
>>>    -	dout("setxattr value=%.*s\n", (int)size, value);
>>> +	dout("setxattr value size: %lu\n", size);
> This should be "%zu" and not "%lu".  I'm OK sending v5 to fix these 2
> issues if you prefer.

Sure, please send a v5 for it.


>
> [ And then there's also the MDS-side which hasn't been merged yet.  But
>    this patch is probably worth in itself as it will change the client
>    behavior to do the sync operation. ]

It's okay, this will fix this issue when we are connecting to old cephs, 
and we could force to do the sync request always.

No need to wait the ceph PR.

-- Xiubo

>
> Cheers,

