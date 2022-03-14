Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337414D7A14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiCNFSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiCNFSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FCE83CFDD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 22:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647235060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=122R2ow28Wkt0XPfg1K1qy90uXauLHXkqUcMVxeDF1M=;
        b=WQp/10IZdP27uetnE0dE1rCn8i2LF8vyz6MOg+Q6m1SPcYm0OsnI8iA2rluU4cjESo0RDg
        PaWOOevq+4cN522QE4Ai7lUivqNe+467sdAjdekpAxKIg3403xg4jfi8ngPE4bKCTlU4W2
        R9+vnWE9u4C9e/sktRv6/QPpAPIw8yM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-1YEKbyXEMVeTcskSpPKJKg-1; Mon, 14 Mar 2022 01:17:39 -0400
X-MC-Unique: 1YEKbyXEMVeTcskSpPKJKg-1
Received: by mail-pl1-f199.google.com with SMTP id d4-20020a170902f14400b001518350e5c7so5836663plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 22:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=122R2ow28Wkt0XPfg1K1qy90uXauLHXkqUcMVxeDF1M=;
        b=5mAyu4y+ThYnptcewfQezWNqzNR6YGlSvE6BPTMArcDBTGXf+4fQ4ngyw0oERPghRk
         3s1uNkbCS1QhjGV2Ts0jg7e0XaVKsvc+ZxYd2gJIIKbE0jHgZ72cAkSBS1v39BIf/b/2
         HpwH+jPnxvDv3nog/KbvbiJhR51Fzc0vfJA7HO00eoyDZ7Gx0xP/Sn4aaqkui4Lx3BFh
         DLqxYqXmYqptPmP0fUoZOaJQd2rtZ3X5rnb5jezcEMJUdvR5d1U7lOQgjuPngqp7JD2Q
         8ki/ZiAqsxpZBQERcJG7pCBUZSGYJIOdg7bdYNLSpwJp9SXjhTKB8p0kgpP+HUUMh2do
         E6hA==
X-Gm-Message-State: AOAM530NQKGFRR8uGQ3mJwK3K/jF3kkhehYcN4ZgJXfnEGI5y8MGUjm2
        S5NjhgQ6iYVoVlwTuy0cHeeHJsUP9xDlsP/HG4TNsfBqYY9siiox4sKyWfezPFhvt1i6VOhXv9o
        48oVXHfig4o1g3X5ciJCpWv/nVCIVO4zQFsq22UAJ1KIFLMR3NvjW/m20VWUK9pQ0Tk1ieD8p0A
        ==
X-Received: by 2002:a17:903:228a:b0:153:66b2:16d8 with SMTP id b10-20020a170903228a00b0015366b216d8mr4622006plh.62.1647235057836;
        Sun, 13 Mar 2022 22:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQAWtpajmK5K/3/eF9wnEu03eYn99x8eRlWAEARqPBSsjv352DwutKbwxP7SxxQGlda6UkNA==
X-Received: by 2002:a17:903:228a:b0:153:66b2:16d8 with SMTP id b10-20020a170903228a00b0015366b216d8mr4621975plh.62.1647235057382;
        Sun, 13 Mar 2022 22:17:37 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bh6-20020a056a00308600b004f6aa0367f6sm16311288pfb.118.2022.03.13.22.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 22:17:36 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] ceph: add support for encrypted snapshot names
From:   Xiubo Li <xiubli@redhat.com>
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220310172616.16212-1-lhenriques@suse.de>
 <20220310172616.16212-2-lhenriques@suse.de>
 <fdf774cd-3cca-14e5-d5aa-44de70bb89f0@redhat.com>
 <2d69e6dd-b047-13fe-7dc5-2c64190e0e8a@redhat.com>
Message-ID: <cff2b7ac-d4bb-4096-06a9-79b41b31a57a@redhat.com>
Date:   Mon, 14 Mar 2022 13:17:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2d69e6dd-b047-13fe-7dc5-2c64190e0e8a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/14/22 10:45 AM, Xiubo Li wrote:
>
> On 3/12/22 4:30 PM, Xiubo Li wrote:
>>
>> On 3/11/22 1:26 AM, Luís Henriques wrote:
>>> Since filenames in encrypted directories are already encrypted and 
>>> shown
>>> as a base64-encoded string when the directory is locked, snapshot names
>>> should show a similar behaviour.
>>>
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>>   fs/ceph/dir.c   |  9 +++++++++
>>>   fs/ceph/inode.c | 13 +++++++++++++
>>>   2 files changed, 22 insertions(+)
>>>
>>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>>> index 6df2a91af236..123e3b9c8161 100644
>>> --- a/fs/ceph/dir.c
>>> +++ b/fs/ceph/dir.c
>>> @@ -1075,6 +1075,15 @@ static int ceph_mkdir(struct user_namespace 
>>> *mnt_userns, struct inode *dir,
>>>           op = CEPH_MDS_OP_MKSNAP;
>>>           dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>>>                dentry, dentry);
>>> +        /*
>>> +         * Encrypted snapshots require d_revalidate to force a
>>> +         * LOOKUPSNAP to cleanup dcache
>>> +         */
>>> +        if (IS_ENCRYPTED(dir)) {
>>> +            spin_lock(&dentry->d_lock);
>>> +            dentry->d_flags |= DCACHE_NOKEY_NAME;
>>
>> I think this is not correct fix of this issue.
>>
>> Actually this dentry's name is a KEY NAME, which is human readable name.
>>
>> DCACHE_NOKEY_NAME means the base64_encoded names. This usually will 
>> be set when filling a new dentry if the directory is locked. If the 
>> directory is unlocked the directory inode will be set with the key.
>>
>> The root cause should be the snapshot's inode doesn't correctly set 
>> the encrypt stuff when you are reading from it.
>>
>> NOTE: when you are 'ls -l .snap/snapXXX' the snapXXX dentry name is 
>> correct, it's just corrupted for the file or directory names under 
>> snapXXX/.
>>
> When mksnap in ceph_mkdir() before sending the request out it will 
> create a new inode for the snapshot dentry and then will fill the 
> ci->fscrypt_auth from .snap's inode, please see 
> ceph_mkdir()->ceph_new_inode().
>
> And in the mksnap request reply it will try to fill the 
> ci->fscrypt_auth again but failed because it was already filled. This 
> time the auth info is from .snap's parent dir from MDS side. In this 
> patch in theory they should be the same, but I am still not sure why 
> when decrypting the dentry names in snapXXX will fail.
>
> I just guess it possibly will depend on the inode number from the 
> related inode or something else. Before the request reply it seems the 
> inode isn't set the inode number ?
>
It should be the ci_nonce's problem.

In the ceph_mkdir()->ceph_new_inode() it will generate a new random 
nonce and then setup the fscrypt context for the inode of .snap/snapXXX. 
But this context is not correct, because the context of .snap/snapXXX 
should always be inherit from .snap's parent, which will be sent from 
the MDS in the request reply.


> - Xiubo
>
>>
>>> + spin_unlock(&dentry->d_lock);
>>> +        }
>>>       } else if (ceph_snap(dir) == CEPH_NOSNAP) {
>>>           dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>>           op = CEPH_MDS_OP_MKDIR;
>>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>>> index b573a0f33450..81d3d554d261 100644
>>> --- a/fs/ceph/inode.c
>>> +++ b/fs/ceph/inode.c
>>> @@ -182,6 +182,19 @@ struct inode *ceph_get_snapdir(struct inode 
>>> *parent)
>>>       ci->i_rbytes = 0;
>>>       ci->i_btime = ceph_inode(parent)->i_btime;
>>>   +    /* if encrypted, just borrow fscrypt_auth from parent */
>>> +    if (IS_ENCRYPTED(parent)) {
>>> +        struct ceph_inode_info *pci = ceph_inode(parent);
>>> +
>>> +        ci->fscrypt_auth = kmemdup(pci->fscrypt_auth,
>>> +                       pci->fscrypt_auth_len,
>>> +                       GFP_KERNEL);
>>> +        if (ci->fscrypt_auth) {
>>> +            inode->i_flags |= S_ENCRYPTED;
>>> +            ci->fscrypt_auth_len = pci->fscrypt_auth_len;
>>> +        } else
>>> +            dout("Failed to alloc memory for fscrypt_auth in 
>>> snapdir\n");
>>> +    }
>>
>> Here I think Jeff has already commented it in your last version, it 
>> should fail by returning NULL ?
>>
>> - Xiubo
>>
>>>       if (inode->i_state & I_NEW) {
>>>           inode->i_op = &ceph_snapdir_iops;
>>>           inode->i_fop = &ceph_snapdir_fops;
>>>

