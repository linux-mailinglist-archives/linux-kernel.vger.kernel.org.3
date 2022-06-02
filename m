Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307353B78C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiFBK5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiFBK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF0F420A73D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654167458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILOH+9qB4kdX+wuRsiCR0WoKSLzvv92mSp/II4owxY4=;
        b=bPvd3gblWo/HdjfKW88Rsu9hCPh6P4pL/q/dfj2G3djSCkPVbU3xE06+3JXqZih9tgzHHR
        2xpvTr2Re6jHs+3LqbTrSV+rKvzYviWI35BnQcSrMrK2Vpraq5hTf2RMjbVv3i5XtovbeA
        rUSAbe3+5fns/5o20V8uUL7kLNW2Se8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-oui8lFhWP3qBbRabQIniaw-1; Thu, 02 Jun 2022 06:57:37 -0400
X-MC-Unique: oui8lFhWP3qBbRabQIniaw-1
Received: by mail-pg1-f198.google.com with SMTP id q195-20020a632acc000000b003fcb9b2b053so1731683pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ILOH+9qB4kdX+wuRsiCR0WoKSLzvv92mSp/II4owxY4=;
        b=g3MEoabu+0m1ulEdtCm48fQNRi2Q1YDAkhBnQExKsiBH523kAr+OP92ocEY16agzYH
         zdEIe3X/2yq3YUa9hEX7AFnFK1cXsNsG3sONurUwU7eXxW7j5FLvVQpSnI17DGFrkfiJ
         7nWcFqDN5UuIXF9jBKveJpbJMyMXYCsAIRCPmYBkOSlOh/8gg2O2hE0AlmYLSOZUdtUx
         8DGm/9If/ItJlOupdsS+NF1Zbs1BxylThcmuxieoCk7fIZJyPdkG8dJvzu2jrScWL2lo
         hrl0MucqbNbK5V9Qme2exCzuZ6p4RjiVFS0hEpgzMpzAaoi9G/LbVFG0ZWR2iZerRM4T
         /VIg==
X-Gm-Message-State: AOAM530qcDm8GjXjYLR7OGX5/DUDICdpJn+47G4ANRj2dsYfgffUIN5Z
        mcn0fUQT/+SQRl0UeoXg1OBwkaQ9UTd7eMlLkZ9WTbYWLybJVkWxFFnLUDf5S7zHjoCqOs7kaLB
        rCNR1mdK4M8P+pLvvJAsqJHkH0vTZEbmJd+u0ucJ9xkhBGVrJHvBum1yGEfD2leD/BgHse+QYAw
        ==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr71021377pfl.38.1654167455325;
        Thu, 02 Jun 2022 03:57:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWjC5hh3/8j1LD0iiMwtyQH0XgoH1waiLuwyJfZVxO3GOio+lEf9rK8zpnGSWpieZ9MmIHwA==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr71021348pfl.38.1654167454906;
        Thu, 02 Jun 2022 03:57:34 -0700 (PDT)
Received: from [10.72.12.107] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b0051878e8cc13sm3498622pfl.116.2022.06.02.03.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 03:57:34 -0700 (PDT)
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
 <289f5136-d2fc-1474-eb0f-521586f241b2@redhat.com>
 <87a6av4awn.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <d271bdc1-f95a-01e2-7a0f-b6511aee2d58@redhat.com>
Date:   Thu, 2 Jun 2022 18:57:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87a6av4awn.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/22 6:28 PM, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> On 6/2/22 5:26 PM, Luís Henriques wrote:
>>> Xiubo Li <xiubli@redhat.com> writes:
>>>
>>>> On 6/2/22 12:29 AM, Luís Henriques wrote:
>>>>> The MDS tries to enforce a limit on the total key/values in extended
>>>>> attributes.  However, this limit is enforced only if doing a synchronous
>>>>> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
>>>>> doesn't have a chance to enforce these limits.
>>>>>
>>>>> This patch adds support for decoding the xattrs maximum size setting that is
>>>>> distributed in the mdsmap.  Then, when setting an xattr, the kernel client
>>>>> will revert to do a synchronous operation if that maximum size is exceeded.
>>>>>
>>>>> While there, fix a dout() that would trigger a printk warning:
>>>>>
>>>>> [   98.718078] ------------[ cut here ]------------
>>>>> [   98.719012] precision 65536 too large
>>>>> [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf+0x5e3/0x600
>>>>> ...
>>>>>
>>>>> URL: https://tracker.ceph.com/issues/55725
>>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>>> ---
>>>>>     fs/ceph/mdsmap.c            | 27 +++++++++++++++++++++++----
>>>>>     fs/ceph/xattr.c             | 12 ++++++++----
>>>>>     include/linux/ceph/mdsmap.h |  1 +
>>>>>     3 files changed, 32 insertions(+), 8 deletions(-)
>>>>>
>>>>> * Changes since v2
>>>>>
>>>>> Well, a lot has changed since v2!  Now the xattr max value setting is
>>>>> obtained through the mdsmap, which needs to be decoded, and the feature
>>>>> that was used in the previous revision was dropped.  The drawback is that
>>>>> the MDS isn't unable to know in advance if a client is aware of this xattr
>>>>> max value.
>>>>>
>>>>> * Changes since v1
>>>>>
>>>>> Added support for new feature bit to get the MDS max_xattr_pairs_size
>>>>> setting.
>>>>>
>>>>> Also note that this patch relies on a patch that hasn't been merged yet
>>>>> ("ceph: use correct index when encoding client supported features"),
>>>>> otherwise the new feature bit won't be correctly encoded.
>>>>>
>>>>> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
>>>>> index 30387733765d..36b2bc18ca2a 100644
>>>>> --- a/fs/ceph/mdsmap.c
>>>>> +++ b/fs/ceph/mdsmap.c
>>>>> @@ -13,6 +13,12 @@
>>>>>       #include "super.h"
>>>>>     +/*
>>>>> + * Maximum size of xattrs the MDS can handle per inode by default.  This
>>>>> + * includes the attribute name and 4+4 bytes for the key/value sizes.
>>>>> + */
>>>>> +#define MDS_MAX_XATTR_SIZE (1<<16) /* 64K */
>>>>> +
>>>>>     #define CEPH_MDS_IS_READY(i, ignore_laggy) \
>>>>>     	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
>>>>>     @@ -352,12 +358,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void
>>>>> *end, bool msgr2)
>>>>>     		__decode_and_drop_type(p, end, u8, bad_ext);
>>>>>     	}
>>>>>     	if (mdsmap_ev >= 8) {
>>>>> -		u32 name_len;
>>>>>     		/* enabled */
>>>>>     		ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
>>>>> -		ceph_decode_32_safe(p, end, name_len, bad_ext);
>>>>> -		ceph_decode_need(p, end, name_len, bad_ext);
>>>>> -		*p += name_len;
>>>>> +		/* fs_name */
>>>>> +		ceph_decode_skip_string(p, end, bad_ext);
>>>>>     	}
>>>>>     	/* damaged */
>>>>>     	if (mdsmap_ev >= 9) {
>>>>> @@ -370,6 +374,21 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
>>>>>     	} else {
>>>>>     		m->m_damaged = false;
>>>>>     	}
>>>>> +	if (mdsmap_ev >= 17) {
>>>>> +		/* balancer */
>>>>> +		ceph_decode_skip_string(p, end, bad_ext);
>>>>> +		/* standby_count_wanted */
>>>>> +		ceph_decode_skip_32(p, end, bad_ext);
>>>>> +		/* old_max_mds */
>>>>> +		ceph_decode_skip_32(p, end, bad_ext);
>>>>> +		/* min_compat_client */
>>>>> +		ceph_decode_skip_8(p, end, bad_ext);
>>>> This is incorrect.
>>>>
>>>> If mdsmap_ev == 15 the min_compat_client will be a feature_bitset_t instead of
>>>> int8_t.
>>> Hmm... can you point me at where that's done in the code?  As usual, I'm
>>> confused with that code and simply can't see that.
>>>
>>> Also, if that happens only when mdsmap_ev == 15, then there's no problem
>>> because that branch is only taken if it's >= 17.
>> Yeah, so you should skip 32 or 32+64 bits instead here, just likes:
>>
>> 3536                 /* version >= 3, feature bits */
>> 3537                 ceph_decode_32_safe(&p, end, len, bad);
>> 3538                 if (len) {
>> 3539                         ceph_decode_64_safe(&p, end, features, bad);
>> 3540                         p += len - sizeof(features);
>> 3541                 }
>>
>> For the ceph code please see:
>>
>> Please see https://github.com/ceph/ceph/blob/main/src/mds/MDSMap.cc#L925.
> I still don't see what your saying.  From what I understand, with <= 15 we
> used to have 'min_compat_client', which is of type 'ceph_release_t',
> defined in src/common/ceph_releases.h:
>
> enum class ceph_release_t : std::uint8_t {
> ...
> }

Okay, you are right.

I miss reading that code.

-- Xiubo


> Then, starting with >= 16 the MDS ignores this 'min_compat_client' field
> (but still encodes/decodes it), and it *adds* 'required_client_features',
> which is a 'feature_bitset_t' and that is decoded immediately after (see
> bellow, the ceph_decode_skip_set() call).
>
> Cheers,

