Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA84D9548
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbiCOHae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345425AbiCOHa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44BCD4B1E0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647329351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqny6Q9W5Y9KFhHBJHThu4E5vRlpSkXvSXYfrC4FolQ=;
        b=Hp7HijigsSdAamRqmNgT6yyHxPV6Q/2f0n8IFVGXRzA4klGpUDtsIGDSSijq08VEFwEzgh
        qmfa19cNugoMc8IhqXiHpzDw2UXcRYA0S8gbHeB+kkZs3vICeQ2sd4nmuuOUA5WVZJoBLq
        G7jpd1caDAdZhzRdIkgQ2O7DeXT8qW0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-boMAxUoNMVa4Ku0HWcBAIw-1; Tue, 15 Mar 2022 03:29:10 -0400
X-MC-Unique: boMAxUoNMVa4Ku0HWcBAIw-1
Received: by mail-pj1-f72.google.com with SMTP id md4-20020a17090b23c400b001bf675ff745so1373436pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tqny6Q9W5Y9KFhHBJHThu4E5vRlpSkXvSXYfrC4FolQ=;
        b=QH/NvW7QDT3CwUMSL0zIdQzlKOS+0IUan9AzTTJdzHCnxCVI4vaTYRwjigK8edpSt6
         AA6v4O+QWPw6ER+wLpzrIxMuBMBpLx3EDNgBnhwz79dUghKgJ3vYYEfSGrqUoak07Sqr
         JiXBD5X6XOrhUnWJS3TQlTVZSAgNCDPhXr8/HicJfDlVurIbFMFkL73Yq74ii4XAE6W4
         S8kxP3iNe7VHMx7yfuYolDY5IC1B2auxRIxlovpEFOdLpsHDeQFvp0tU0qUP1sC9Rn+q
         giAhjkipIBysxB2BVuyKyrHWkzR40dbUSo72jz7Jn243pYCK0ZgfLn/CmMnfgUSRe+8s
         8kcg==
X-Gm-Message-State: AOAM5307m3wYoCRbxcHKhasO8Ul5FSOAssRVwJfRQElarWyMUE++VsqJ
        X0mOdW7NHNcyZLeGl8ZS4WwCm2B7ky/SX+A9zSXGOqy6l8OhilouYvn2PTAozH5D3XDecDxUttc
        3xP7srs4eXBvfjelMw7HD/Gynfxe6/4AtFkikdtyqBoQIWsgGcVivgxLmAThAEOyGpZM1RbFb9w
        ==
X-Received: by 2002:a17:902:cec4:b0:151:a696:149b with SMTP id d4-20020a170902cec400b00151a696149bmr26713376plg.145.1647329349039;
        Tue, 15 Mar 2022 00:29:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJnBiLRzkOX84CVfstDVr/suiTNGdSD8dC1pni0NyqO4P/FclTzCF09xoWY3NWAehzrSuEoA==
X-Received: by 2002:a17:902:cec4:b0:151:a696:149b with SMTP id d4-20020a170902cec400b00151a696149bmr26713339plg.145.1647329348485;
        Tue, 15 Mar 2022 00:29:08 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a001acd00b004f76d35c1dcsm18839886pfv.104.2022.03.15.00.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:29:07 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] ceph: add support for encrypted snapshot names
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220310172616.16212-1-lhenriques@suse.de>
 <20220310172616.16212-2-lhenriques@suse.de>
 <fdf774cd-3cca-14e5-d5aa-44de70bb89f0@redhat.com>
 <2d69e6dd-b047-13fe-7dc5-2c64190e0e8a@redhat.com>
 <cff2b7ac-d4bb-4096-06a9-79b41b31a57a@redhat.com>
 <87o8288jwd.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <7aedb4b9-11e4-cfa1-986f-75cf8706c6c0@redhat.com>
Date:   Tue, 15 Mar 2022 15:28:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87o8288jwd.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/15/22 2:32 AM, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> On 3/14/22 10:45 AM, Xiubo Li wrote:
>>> On 3/12/22 4:30 PM, Xiubo Li wrote:
>>>> On 3/11/22 1:26 AM, Luís Henriques wrote:
>>>>> Since filenames in encrypted directories are already encrypted and shown
>>>>> as a base64-encoded string when the directory is locked, snapshot names
>>>>> should show a similar behaviour.
>>>>>
>>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>>> ---
>>>>>    fs/ceph/dir.c   |  9 +++++++++
>>>>>    fs/ceph/inode.c | 13 +++++++++++++
>>>>>    2 files changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>>>>> index 6df2a91af236..123e3b9c8161 100644
>>>>> --- a/fs/ceph/dir.c
>>>>> +++ b/fs/ceph/dir.c
>>>>> @@ -1075,6 +1075,15 @@ static int ceph_mkdir(struct user_namespace
>>>>> *mnt_userns, struct inode *dir,
>>>>>            op = CEPH_MDS_OP_MKSNAP;
>>>>>            dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>>>>>                 dentry, dentry);
>>>>> +        /*
>>>>> +         * Encrypted snapshots require d_revalidate to force a
>>>>> +         * LOOKUPSNAP to cleanup dcache
>>>>> +         */
>>>>> +        if (IS_ENCRYPTED(dir)) {
>>>>> +            spin_lock(&dentry->d_lock);
>>>>> +            dentry->d_flags |= DCACHE_NOKEY_NAME;
>>>> I think this is not correct fix of this issue.
>>>>
>>>> Actually this dentry's name is a KEY NAME, which is human readable name.
>>>>
>>>> DCACHE_NOKEY_NAME means the base64_encoded names. This usually will be set
>>>> when filling a new dentry if the directory is locked. If the directory is
>>>> unlocked the directory inode will be set with the key.
>>>>
>>>> The root cause should be the snapshot's inode doesn't correctly set the
>>>> encrypt stuff when you are reading from it.
>>>>
>>>> NOTE: when you are 'ls -l .snap/snapXXX' the snapXXX dentry name is correct,
>>>> it's just corrupted for the file or directory names under snapXXX/.
>>>>
>>> When mksnap in ceph_mkdir() before sending the request out it will create a
>>> new inode for the snapshot dentry and then will fill the ci->fscrypt_auth from
>>> .snap's inode, please see ceph_mkdir()->ceph_new_inode().
>>>
>>> And in the mksnap request reply it will try to fill the ci->fscrypt_auth again
>>> but failed because it was already filled. This time the auth info is from
>>> .snap's parent dir from MDS side. In this patch in theory they should be the
>>> same, but I am still not sure why when decrypting the dentry names in snapXXX
>>> will fail.
>>>
>>> I just guess it possibly will depend on the inode number from the related
>>> inode or something else. Before the request reply it seems the inode isn't set
>>> the inode number ?
>>>
>> It should be the ci_nonce's problem.
> OK, you were right.  However, I don't see a simple way around it.  And I
> don't think that adding a fscrypt new interface to copy an existent nonce
> makes sense.
>
> So, here's another possible option: instead of setting the
> DCACHE_NOKEY_NAME flag, we could simply do d_invalidate(dentry) before
> leaving ceph_mkdir (if we're creating an encrypted snapshot, of course).
> Would this be acceptable?

I think there has one simple way. Just think about without setting the 
fscrypt_auth for the '.snap' dir's inode, that is without your this 
patch it works well.

That's because when we create a snapshot under '.snap' dir, since the 
'.snap' dir related inode doesn't have the fscrypt_auth been filled, so 
when creating a new inode for the snapshot it won't fill the 
fscrypt_auth for the new inode. And then in the handle_reply() it can 
fill the fscrypt auth as expected.

You can make sure that in the ceph_new_inode() just skip setting the 
fscrypt_auth for the new inode if the parent dir is a snapdir, that is 
'.snap/'. And this will just leave it to be filled in the handle_reply().

-- Xiubo


>
> Cheers,

