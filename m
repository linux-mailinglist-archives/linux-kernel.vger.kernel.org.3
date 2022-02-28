Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15644C602B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiB1Am4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 19:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiB1Amy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D97E14C795
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 16:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646008936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHrjwMpfBP3gi6xfVSDaBGn0AmRTXFmr0egdfIuL0WU=;
        b=iEaEO7wPKeX/qWZRuNn7wt5D3U/VJflPwNRK53Ov9VIwovABCt/UBKUas7y+Y6Gj67liYU
        kz/kXWO+Eab8OUeZWtHkPzlnNQRYJjsEtFC4jvS5qCPlWRlu+S+lSgw5tsyZQCYc2Row+Z
        MMJ14d9yS2BsQev/9KvgjZkEMWiAqXM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-NNDm9UU_PHCoLj9XRGbyZA-1; Sun, 27 Feb 2022 19:42:14 -0500
X-MC-Unique: NNDm9UU_PHCoLj9XRGbyZA-1
Received: by mail-pg1-f200.google.com with SMTP id u17-20020a63a911000000b0037491401c44so5626193pge.17
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 16:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JHrjwMpfBP3gi6xfVSDaBGn0AmRTXFmr0egdfIuL0WU=;
        b=VLEdWHh5cSE0h9wjDMgMQciAZ+WooydNbrqWDTbllAWwEeZXCE0jFmVi1oWHZ3Gily
         4KpbyMxVNrIZqapa/c54KuOCDyH2De7mqmzC9A1LE5h71IUGRepeMYt6kVh4MRrjNhOL
         hu1MN6I2Ec0YObyVBKnpuRU6GFVXFVBAsgvP4yKyDPOsRxyDM6fB5aQc//7kY7gSowxy
         qLEqVrkTqC9FA/6B3KnX3y0/tFMAjGghv3lSiujV8JUA0AzTEQQda3PfSZPDwEJTC2rm
         j/kS9OavN67KuQH2J5rkk7IYtyzL2furPwRENpFY63pcVP7K7P1unqVzAKx/ObFwdPs6
         dtTQ==
X-Gm-Message-State: AOAM533q7KSIpB43eSecIkiCRQCbDyFlTla8m0XCw8ENeqVWjAwG7WaA
        +ZYIDYYYQ47apuBeBc4k+LZr4k+ouDegkS1drpJKA03Tc1l9tdAotZXPQ4QIvW4jr9xBBILcgrL
        zqV6OkoviEszYM8QErmH8Pbgjebq7rg42ZqipVvyPsiYqt5bHqpjHmcxTe3Q+eAKvJgwqpXpg8Q
        ==
X-Received: by 2002:a05:6a00:248c:b0:4ce:1932:80dd with SMTP id c12-20020a056a00248c00b004ce193280ddmr18897817pfv.48.1646008933376;
        Sun, 27 Feb 2022 16:42:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMInzZhGvmQ+IHOCk2Q1kWb0M60m+eTtK6ym47pdNZvA38UDH0my5y3Qt0DVGNINJ7HSfbXw==
X-Received: by 2002:a05:6a00:248c:b0:4ce:1932:80dd with SMTP id c12-20020a056a00248c00b004ce193280ddmr18897778pfv.48.1646008932854;
        Sun, 27 Feb 2022 16:42:12 -0800 (PST)
Received: from [10.72.12.114] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm10202732pfg.165.2022.02.27.16.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 16:42:12 -0800 (PST)
Subject: Re: [RFC PATCH] ceph: add support for encrypted snapshot names
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224112142.18052-1-lhenriques@suse.de>
 <7d2a798d-ce32-4bf7-b184-267bb79f44e3@redhat.com>
 <87h78ni8ed.fsf@brahms.olymp>
 <3bc5797e-f23e-6416-4626-161e34c409ff@redhat.com>
 <871qzpu12m.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <277bf08e-2547-f29a-ec91-86647ab455d4@redhat.com>
Date:   Mon, 28 Feb 2022 08:42:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <871qzpu12m.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/26/22 10:58 PM, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> On 2/25/22 5:48 PM, Luís Henriques wrote:
>>> Xiubo Li <xiubli@redhat.com> writes:
>>>
>>>> On 2/24/22 7:21 PM, Luís Henriques wrote:
>>>>> Since filenames in encrypted directories are already encrypted and shown
>>>>> as a base64-encoded string when the directory is locked, snapshot names
>>>>> should show a similar behaviour.
>>>>>
>>>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>>>> ---
>>>>>     fs/ceph/dir.c   | 15 +++++++++++++++
>>>>>     fs/ceph/inode.c | 10 +++++++++-
>>>>>     2 files changed, 24 insertions(+), 1 deletion(-)
>>>>>
>>>>> Support on the MDS for names that'll be > MAX_NAME when base64 encoded is
>>>>> still TBD.  I thought it would be something easy to do, but snapshots
>>>>> don't seem to make use of the CDir/CDentry (which is where alternate_name
>>>>> is stored on the MDS).  I'm still looking into this, but I may need some
>>>>> help there :-(
>>>>>
>>>>> Cheers,
>>>>> --
>>>>> Luís
>>>>>
>>>>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>>>>> index a449f4a07c07..20ae600ee7cd 100644
>>>>> --- a/fs/ceph/dir.c
>>>>> +++ b/fs/ceph/dir.c
>>>>> @@ -1065,6 +1065,13 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>>>>     		op = CEPH_MDS_OP_MKSNAP;
>>>>>     		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>>>>>     		     dentry, dentry);
>>>>> +		/* XXX missing support for alternate_name in snapshots */
>>>>> +		if (IS_ENCRYPTED(dir) && (dentry->d_name.len >= 189)) {
>>>>> +			dout("encrypted snapshot name too long: %pd len: %d\n",
>>>>> +			     dentry, dentry->d_name.len);
>>>>> +			err = -ENAMETOOLONG;
>>>>> +			goto out;
>>>>> +		}
>>>>>     	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
>>>>>     		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>>>>     		op = CEPH_MDS_OP_MKDIR;
>>>>> @@ -1109,6 +1116,14 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>>>>     	    !req->r_reply_info.head->is_target &&
>>>>>     	    !req->r_reply_info.head->is_dentry)
>>>>>     		err = ceph_handle_notrace_create(dir, dentry);
>>>>> +
>>>>> +	/*
>>>>> +	 * If we have created a snapshot we need to clear the cache, otherwise
>>>>> +	 * snapshot will show encrypted filenames in readdir.
>>>>> +	 */
>>>> Do you mean dencrypted filenames ?
>>> What I see without this d_drop() is that, if I run an 'ls' in a snapshot
>>> directory immediately after creating it, the filenames in that snapshot
>>> will be encrypted.  Maybe there's a bug somewhere else and this d_drop()
>>> isn't the right fix...?
>> BTW, how did you reproduce this ?
>>
>> The snapshot name hasn't encrypted yet ? Did you add one patch to do this ?
> I don't think I understand what you're referring to.  I haven't looked
> into you patch (probably won't be able to do in before Wednesday) but if
> you remove the d_drop() in ceph_mkdir() in this patch, here's what I use
> to reproduce the issue:
>
> 	# mkdir mydir
> 	# fscrypt encrypt mydir
> 	# cd mydir
> 	# create a few files
> 	# mkdir .snap/snapshot-01
> 	# ls -l .snap/snapshot-01

This is my test by using the branch 'wip-fscrypt' branch:

[root@lxbceph1 kcephfs]# cd mydir/
[root@lxbceph1 mydir]# mkdir a b cd
[root@lxbceph1 mydir]# ls
a  b  c
[root@lxbceph1 mydir]# ls .snap
[root@lxbceph1 mydir]# mkdir .snap/mydir_snap1
[root@lxbceph1 mydir]# ls .snap/mydir_snap1
a  b  c
[root@lxbceph1 mydir]# ls .snap/
mydir_snap1
[root@lxbceph1 mydir]# touch file1 file2 file3
[root@lxbceph1 mydir]# mkdir .snap/mydir_snap2
[root@lxbceph1 mydir]# ls .snap/mydir_snap2
a  b  c  file1  file2  file3
[root@lxbceph1 mydir]# ls .snap/
mydir_snap1  mydir_snap2
[root@lxbceph1 mydir]# ls
a  b  c  file1  file2  file3

[root@lxbceph1 mydir]# cd ..
[root@lxbceph1 kcephfs]# fscrypt lock mydir/
"mydir/" is now locked.
[root@lxbceph1 kcephfs]# cd mydir/
[root@lxbceph1 mydir]# ls
5D7Q8T0rdSRiJZnvbpCWRFQnLb3BxO4-zyVHsFCH98o 
LWbsdS2rvuCALUXE0TrTqbuElw4zU6cZHg62-LY5GMA 
u2nEDclQZAdtetYqQ7aCWNFwu8-1FDH9vI6pM4o6ZN8
-fKqUSM9DGlT1KNE-pkygEXAdjwf9fTDROA_6ZkDEio 
m42jW1zJs75o2dx0bEHNmEWx9GmYXxHveSmBFagwPOw 
ZLYwBnb7WT78Saz5RFEOdrKn3OLb6AfHk-IElAmEVps

[root@lxbceph1 mydir]# ls .snap/
mydir_snap1  mydir_snap2

[root@lxbceph1 mydir]# ls .snap/mydir_snap1
LWbsdS2rvuCALUXE0TrTqbuElw4zU6cZHg62-LY5GMA 
m42jW1zJs75o2dx0bEHNmEWx9GmYXxHveSmBFagwPOw 
ZLYwBnb7WT78Saz5RFEOdrKn3OLb6AfHk-IElAmEVps
[root@lxbceph1 mydir]# ls .snap/mydir_snap2
5D7Q8T0rdSRiJZnvbpCWRFQnLb3BxO4-zyVHsFCH98o 
LWbsdS2rvuCALUXE0TrTqbuElw4zU6cZHg62-LY5GMA 
u2nEDclQZAdtetYqQ7aCWNFwu8-1FDH9vI6pM4o6ZN8
-fKqUSM9DGlT1KNE-pkygEXAdjwf9fTDROA_6ZkDEio 
m42jW1zJs75o2dx0bEHNmEWx9GmYXxHveSmBFagwPOw 
ZLYwBnb7WT78Saz5RFEOdrKn3OLb6AfHk-IElAmEVps

[root@lxbceph1 mydir]# cd ..
[root@lxbceph1 kcephfs]# fscrypt unlock mydir/
Enter custom passphrase for protector "l":
"mydir/" is now unlocked and ready for use.
[root@lxbceph1 kcephfs]# cd mydir/
[root@lxbceph1 mydir]# ls
a  b  c  file1  file2  file3
[root@lxbceph1 mydir]# ls .snap/mydir_snap1
a  b  c
[root@lxbceph1 mydir]# ls .snap/mydir_snap2
a  b  c  file1  file2  file3
[root@lxbceph1 mydir]#


We can see that only the "mydir_snap1" and "mydir_snap2" snapshot names 
are not encrypted when the 'mydir' is locked, my patch above is fixing 
this issue. All the others work as expected.


>
> And this would show the contents 'snapshot-01' but with the filenames
> encrypted, even with 'mydir' isn't locked.
>
> With this d_drop(), this behaviour will go away, i.e. you'll see the
> correct (unencrypted) filenames.

The tests above without this changes in your patch.


> Also, after locking 'mydir' (fscrypt lock mydir), an 'ls' in the snapshot
> directory ('ls mydir/.snap') will show the _encrypted_ snapshot names and
> an 'ls' in the snapshot itself ('ls mydir/.snap/<ENCRYPTED NAME>') will
> show the encrypted filenames as in an 'ls mydir'.

Not sure whether I missed something here, so strange I couldn't 
reproduce it.

BTW, which branch were you using to test this ?

I will post my patch to fix the issue I mentioned.

- Xiubo

> Cheers,

