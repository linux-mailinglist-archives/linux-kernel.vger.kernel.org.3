Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A494D796F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiCNCrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiCNCrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F355F3204E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647225957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PA0VKpTZRusSYxnkTFa+BpKk4R0ThDUn2vzzz9+Rddc=;
        b=XoeItNkcO9VukiFWb8YLEijzROoDAX14Pmg8sZsDgIdT+jxtC2MR97PpGmaAw+KGJA9ETt
        d5ekAq+j+AtVf1zxSi7wdl3NhV/svyPk+DCM+7vvTYZoSJDOTR65jbK48uutDaOKkeXMt8
        bJR3AMD2L0Mkmha3YX9ErWfAs9XbLp8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-5htL71PSMGK6Px3I45qlcg-1; Sun, 13 Mar 2022 22:45:56 -0400
X-MC-Unique: 5htL71PSMGK6Px3I45qlcg-1
Received: by mail-pj1-f72.google.com with SMTP id t12-20020a17090a448c00b001b9cbac9c43so9425285pjg.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PA0VKpTZRusSYxnkTFa+BpKk4R0ThDUn2vzzz9+Rddc=;
        b=TtHptdZY/0If7jt7exAuxbg8Ji4LpUNdargTphXaUF7j07RjptXABz4+Z4qMWTiHCK
         nA9zxdnImSppgOZsIGO5k9g/pMwYdGWEyyz6dBxhCL8Wkco9WguUKPVWyvnsDbkRit5y
         fr5hzVVl1FxQYHKI5Yc8Qt54kpU09vZfo9WdEwWZTCJcbky5K9/uHeEuEi0NoiociFhn
         MNHFMevv5Ei7/B6wBq3dfcR4VPUdy1hDXpmRZMuHW5DZhQnS1y2ebsQ0mO4tWciqUWg1
         2od59PgXWKW5SGY1RWMyyPQRKWtDMedZhWAOgPuF+pDiv6cq7Ub/2J7SEzlgERMa3ebq
         ErXw==
X-Gm-Message-State: AOAM532wh4sMir+ITMWxQuJkXXwLhj1J1uLdNWU+JM2gXxj/jwCWXzhi
        v47JuDMrBdiGYfTYkMVeIilxqsnxz0UNoFdXmjMxVIXx21ymdcATLQq9Q5NYfUdVbBM4mzH9ES7
        E3q67WcVlhSdCU9OIisk5RrB9Fq1HNzdj7trLMOheIlf7g+dX6zJfGZwUeQqyeP1z4Y+YI/fS0Q
        ==
X-Received: by 2002:a63:82c3:0:b0:37c:7976:4dc2 with SMTP id w186-20020a6382c3000000b0037c79764dc2mr18552781pgd.477.1647225954490;
        Sun, 13 Mar 2022 19:45:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJNNorOjkRCTuI5siUGt4cKotsIuDWPDtQAABXhpTJrGiw2W+JtU0whwQqrkaAp4Ks/BM9hA==
X-Received: by 2002:a63:82c3:0:b0:37c:7976:4dc2 with SMTP id w186-20020a6382c3000000b0037c79764dc2mr18552755pgd.477.1647225954135;
        Sun, 13 Mar 2022 19:45:54 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a000cc900b004f7a986fc78sm6583042pfv.11.2022.03.13.19.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 19:45:53 -0700 (PDT)
From:   Xiubo Li <xiubli@redhat.com>
Subject: Re: [RFC PATCH 1/2] ceph: add support for encrypted snapshot names
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220310172616.16212-1-lhenriques@suse.de>
 <20220310172616.16212-2-lhenriques@suse.de>
 <fdf774cd-3cca-14e5-d5aa-44de70bb89f0@redhat.com>
Message-ID: <2d69e6dd-b047-13fe-7dc5-2c64190e0e8a@redhat.com>
Date:   Mon, 14 Mar 2022 10:45:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <fdf774cd-3cca-14e5-d5aa-44de70bb89f0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/12/22 4:30 PM, Xiubo Li wrote:
>
> On 3/11/22 1:26 AM, Luís Henriques wrote:
>> Since filenames in encrypted directories are already encrypted and shown
>> as a base64-encoded string when the directory is locked, snapshot names
>> should show a similar behaviour.
>>
>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/dir.c   |  9 +++++++++
>>   fs/ceph/inode.c | 13 +++++++++++++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index 6df2a91af236..123e3b9c8161 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -1075,6 +1075,15 @@ static int ceph_mkdir(struct user_namespace 
>> *mnt_userns, struct inode *dir,
>>           op = CEPH_MDS_OP_MKSNAP;
>>           dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>>                dentry, dentry);
>> +        /*
>> +         * Encrypted snapshots require d_revalidate to force a
>> +         * LOOKUPSNAP to cleanup dcache
>> +         */
>> +        if (IS_ENCRYPTED(dir)) {
>> +            spin_lock(&dentry->d_lock);
>> +            dentry->d_flags |= DCACHE_NOKEY_NAME;
>
> I think this is not correct fix of this issue.
>
> Actually this dentry's name is a KEY NAME, which is human readable name.
>
> DCACHE_NOKEY_NAME means the base64_encoded names. This usually will be 
> set when filling a new dentry if the directory is locked. If the 
> directory is unlocked the directory inode will be set with the key.
>
> The root cause should be the snapshot's inode doesn't correctly set 
> the encrypt stuff when you are reading from it.
>
> NOTE: when you are 'ls -l .snap/snapXXX' the snapXXX dentry name is 
> correct, it's just corrupted for the file or directory names under 
> snapXXX/.
>
When mksnap in ceph_mkdir() before sending the request out it will 
create a new inode for the snapshot dentry and then will fill the 
ci->fscrypt_auth from .snap's inode, please see 
ceph_mkdir()->ceph_new_inode().

And in the mksnap request reply it will try to fill the ci->fscrypt_auth 
again but failed because it was already filled. This time the auth info 
is from .snap's parent dir from MDS side. In this patch in theory they 
should be the same, but I am still not sure why when decrypting the 
dentry names in snapXXX will fail.

I just guess it possibly will depend on the inode number from the 
related inode or something else. Before the request reply it seems the 
inode isn't set the inode number ?

- Xiubo

>
>> + spin_unlock(&dentry->d_lock);
>> +        }
>>       } else if (ceph_snap(dir) == CEPH_NOSNAP) {
>>           dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>           op = CEPH_MDS_OP_MKDIR;
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index b573a0f33450..81d3d554d261 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -182,6 +182,19 @@ struct inode *ceph_get_snapdir(struct inode 
>> *parent)
>>       ci->i_rbytes = 0;
>>       ci->i_btime = ceph_inode(parent)->i_btime;
>>   +    /* if encrypted, just borrow fscrypt_auth from parent */
>> +    if (IS_ENCRYPTED(parent)) {
>> +        struct ceph_inode_info *pci = ceph_inode(parent);
>> +
>> +        ci->fscrypt_auth = kmemdup(pci->fscrypt_auth,
>> +                       pci->fscrypt_auth_len,
>> +                       GFP_KERNEL);
>> +        if (ci->fscrypt_auth) {
>> +            inode->i_flags |= S_ENCRYPTED;
>> +            ci->fscrypt_auth_len = pci->fscrypt_auth_len;
>> +        } else
>> +            dout("Failed to alloc memory for fscrypt_auth in 
>> snapdir\n");
>> +    }
>
> Here I think Jeff has already commented it in your last version, it 
> should fail by returning NULL ?
>
> - Xiubo
>
>>       if (inode->i_state & I_NEW) {
>>           inode->i_op = &ceph_snapdir_iops;
>>           inode->i_fop = &ceph_snapdir_fops;
>>

