Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0635310BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiEWMLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbiEWML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:11:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 192EE6383
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653307886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNbXgB9l8vOdOuniBmasHAh701k6Zf6WkEgpGtO7Te0=;
        b=RglCt+ACbbXYros7BkXtliAkv6ln2fKablpB05hIgzTWSkx8GFrSl4lYnMqj87tV1S4Dsm
        DF1DiYbLTvVo38ZaIHeJWzqiEcznI/E3ioAElXfvKUzbCFELtvYM4zyF9Aa8fHCMMWuRnM
        83+SGrPrKdweMypibZeBx3jC+RvoEso=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-_UiTh0kRPO2cRR4AO6V-4w-1; Mon, 23 May 2022 08:11:25 -0400
X-MC-Unique: _UiTh0kRPO2cRR4AO6V-4w-1
Received: by mail-pl1-f200.google.com with SMTP id s10-20020a170902a50a00b00162359521c9so389316plq.23
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sNbXgB9l8vOdOuniBmasHAh701k6Zf6WkEgpGtO7Te0=;
        b=jgWSEWF/Fo8TpSnDEYdl0Usv9J/4YTypdb+1oaBa7oQc0bADYpmOrDqlDqgmg+2e0y
         PWgLZE+ZRCGeiqjFCONz5LTtq8BqVWbGQ1SKwnVtlOIqkzt2gUJMqW3YkMXQhyj12nv8
         MpCNn9vQnBNOb0CqQ0wfwC84WzdVb8wck8s4vRuOo7lGUmr7SPgv1KU34hUXAoj9wPfK
         RZEmYSpoyhvBZM5Dl2xBWxLXu6LYI9pWDFwZYpNDZoN9CGVUGE9IIWf6RA64FO7Tdqbv
         YgJo6FC2OkI11MpSMZBxN47tXFgsmvmlguYkAPrPJiYi75IRdCCHpHx0NMbzhJea2fSF
         R2Qw==
X-Gm-Message-State: AOAM530tJamqutMGKTZABYi+DYcH8q77IKLKn52KuoZePhBx+oJYjs7/
        GNyFq3Xy67S9TSGbHhgqo99OjyYTX1NWRQAaKYYDx+EZa/e7axTc1jzpLTWJ4JUcDqF/8Go3Aak
        Lkfzf2BmmCOiCSwR5/cWM1H95srSJ+eknhvSqWxOAbTw+9ft8goZhQ9shA0iqL0dDaBHF0kHnkQ
        ==
X-Received: by 2002:a05:6a00:1305:b0:512:ebab:3b20 with SMTP id j5-20020a056a00130500b00512ebab3b20mr23541661pfu.82.1653307881072;
        Mon, 23 May 2022 05:11:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjARsE/IdFLqCaDFd1ynXBxXiT1K+p9W1Y851QGBKKI1W8Aq3YOMPFn3GinpIYS7XW6sYgmQ==
X-Received: by 2002:a05:6a00:1305:b0:512:ebab:3b20 with SMTP id j5-20020a056a00130500b00512ebab3b20mr23541621pfu.82.1653307880623;
        Mon, 23 May 2022 05:11:20 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f2cb00b0015f33717794sm4932994plc.42.2022.05.23.05.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 05:11:19 -0700 (PDT)
Subject: Re: [RFC PATCH] ceph: try to prevent exceeding the MDS maximum xattr
 size
To:     Jeff Layton <jlayton@kernel.org>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220520115426.438-1-lhenriques@suse.de>
 <13988024-efc7-2ab1-036a-eb1d2b2fbd15@redhat.com>
 <9538ac47c919b7756d26bdb6466cc9394efefc5e.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <a7db2285-8886-34c3-6b4b-028fa134c8c7@redhat.com>
Date:   Mon, 23 May 2022 20:11:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9538ac47c919b7756d26bdb6466cc9394efefc5e.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/22 6:43 PM, Jeff Layton wrote:
> On Mon, 2022-05-23 at 09:47 +0800, Xiubo Li wrote:
>> On 5/20/22 7:54 PM, Luís Henriques wrote:
>>> The MDS tries to enforce a limit on the total key/values in extended
>>> attributes.  However, this limit is enforced only if doing a synchronous
>>> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
>>> doesn't have a chance to enforce these limits.
>>>
>>> This patch forces the usage of the synchronous operation if xattrs size hits
>>> the maximum size that is set on the MDS by default (64k).
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
>>>    fs/ceph/xattr.c | 17 +++++++++++++----
>>>    1 file changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>>> index afec84088471..09751a5f028c 100644
>>> --- a/fs/ceph/xattr.c
>>> +++ b/fs/ceph/xattr.c
>>> @@ -15,6 +15,12 @@
>>>    #define XATTR_CEPH_PREFIX "ceph."
>>>    #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
>>>    
>>> +/*
>>> + * Maximum size of xattrs the MDS can handle per inode by default.  This
>>> + * includes the attribute name and 4+4 bytes for the key/value sizes.
>>> + */
>>> +#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
>> The max size is changeable in MDS side. Possibly we should do something
>> as mentioned in your ceph PR [1].
>>
>> @Jeff, any better idea ?
>>
>>
>> [1]
>> https://github.com/ceph/ceph/pull/46357/commits/741f8ba36f14774834c0d5618519425ccf1ccc85#r878966753
>>
>> Thanks.
>>
>> -- Xiubo
>>
>>
> Not really.
>
> The idea in the github comment makes sense. Basically, make it so that
> the setting isn't changeable at runtime and then have the client query
> for the limit at appropriate times.
>
> You can probably still defeat that by changing it and rebooting the MDS,
> but I don't see that you can do much else.

Yeah, sounds good.


>
>>> +
>>>    static int __remove_xattr(struct ceph_inode_info *ci,
>>>    			  struct ceph_inode_xattr *xattr);
>>>    
>>> @@ -1078,7 +1084,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
>>>    			flags |= CEPH_XATTR_REMOVE;
>>>    	}
>>>    
>>> -	dout("setxattr value=%.*s\n", (int)size, value);
>>> +	dout("setxattr value size: ld\n", size);
>>>    
>>>    	/* do request */
>>>    	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
>>> @@ -1176,8 +1182,13 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>>>    	spin_lock(&ci->i_ceph_lock);
>>>    retry:
>>>    	issued = __ceph_caps_issued(ci, NULL);
>>> -	if (ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))
>>> +	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
>>> +	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
>>> +	    (required_blob_size >= MDS_MAX_XATTR_PAIRS_SIZE)) {
>>> +		dout("%s do sync setxattr: version: %llu blob size: %d\n",
>>> +		     __func__, ci->i_xattrs.version, required_blob_size);
>>>    		goto do_sync;
>>> +	}
>>>    
>>>    	if (!lock_snap_rwsem && !ci->i_head_snapc) {
>>>    		lock_snap_rwsem = true;
>>> @@ -1193,8 +1204,6 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>>>    	     ceph_cap_string(issued));
>>>    	__build_xattrs(inode);
>>>    
>>> -	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
>>> -
>>>    	if (!ci->i_xattrs.prealloc_blob ||
>>>    	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
>>>    		struct ceph_buffer *blob;
>>>

