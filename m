Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC0F4D8BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiCNSda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiCNSd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:33:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342E3DDC9;
        Mon, 14 Mar 2022 11:32:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7E221F380;
        Mon, 14 Mar 2022 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647282736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98d+th+oWPXG7Pqx5Hg0uyktonyAKLNM8DWBEN4FGOA=;
        b=VaXRnyNdaa1th6WOphggldbQAGMnRhvIE5R5k2Kcaujv3HN/p079HyuSf/QzFOsHPuqwyw
        A3+FvIXLWES5tZU4O3x1gdoMr8Jz+ChAqIOqZNwpUtH9FQOj4eerasf75Y/j7B3NP/rRDM
        X1HwGu7mKxdIjTWspUS4MrA+tYREPwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647282736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98d+th+oWPXG7Pqx5Hg0uyktonyAKLNM8DWBEN4FGOA=;
        b=Gq8GL66dBWLI3fEGo7mNNUZ3BtFRz76CWtMt6m7VXXyPvG7MxrQQAPIiDm8P/ctrjNxy7A
        EYNwwqJTa7yOVMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FA6A13ADA;
        Mon, 14 Mar 2022 18:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lTdWGzCKL2JvYAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 14 Mar 2022 18:32:16 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 649ed029;
        Mon, 14 Mar 2022 18:32:34 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] ceph: add support for encrypted snapshot names
References: <20220310172616.16212-1-lhenriques@suse.de>
        <20220310172616.16212-2-lhenriques@suse.de>
        <fdf774cd-3cca-14e5-d5aa-44de70bb89f0@redhat.com>
        <2d69e6dd-b047-13fe-7dc5-2c64190e0e8a@redhat.com>
        <cff2b7ac-d4bb-4096-06a9-79b41b31a57a@redhat.com>
Date:   Mon, 14 Mar 2022 18:32:34 +0000
In-Reply-To: <cff2b7ac-d4bb-4096-06a9-79b41b31a57a@redhat.com> (Xiubo Li's
        message of "Mon, 14 Mar 2022 13:17:30 +0800")
Message-ID: <87o8288jwd.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> writes:

> On 3/14/22 10:45 AM, Xiubo Li wrote:
>>
>> On 3/12/22 4:30 PM, Xiubo Li wrote:
>>>
>>> On 3/11/22 1:26 AM, Lu=C3=ADs Henriques wrote:
>>>> Since filenames in encrypted directories are already encrypted and sho=
wn
>>>> as a base64-encoded string when the directory is locked, snapshot names
>>>> should show a similar behaviour.
>>>>
>>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>>> ---
>>>> =C2=A0 fs/ceph/dir.c=C2=A0=C2=A0 |=C2=A0 9 +++++++++
>>>> =C2=A0 fs/ceph/inode.c | 13 +++++++++++++
>>>> =C2=A0 2 files changed, 22 insertions(+)
>>>>
>>>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>>>> index 6df2a91af236..123e3b9c8161 100644
>>>> --- a/fs/ceph/dir.c
>>>> +++ b/fs/ceph/dir.c
>>>> @@ -1075,6 +1075,15 @@ static int ceph_mkdir(struct user_namespace
>>>> *mnt_userns, struct inode *dir,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D CEPH_MDS=
_OP_MKSNAP;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dout("mksnap di=
r %p snap '%pd' dn %p\n", dir,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dentry, dentry);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Encrypted snapshot=
s require d_revalidate to force a
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * LOOKUPSNAP to clea=
nup dcache
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENCRYPTED(dir)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp=
in_lock(&dentry->d_lock);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
ntry->d_flags |=3D DCACHE_NOKEY_NAME;
>>>
>>> I think this is not correct fix of this issue.
>>>
>>> Actually this dentry's name is a KEY NAME, which is human readable name.
>>>
>>> DCACHE_NOKEY_NAME means the base64_encoded names. This usually will be =
set
>>> when filling a new dentry if the directory is locked. If the directory =
is
>>> unlocked the directory inode will be set with the key.
>>>
>>> The root cause should be the snapshot's inode doesn't correctly set the
>>> encrypt stuff when you are reading from it.
>>>
>>> NOTE: when you are 'ls -l .snap/snapXXX' the snapXXX dentry name is cor=
rect,
>>> it's just corrupted for the file or directory names under snapXXX/.
>>>
>> When mksnap in ceph_mkdir() before sending the request out it will creat=
e a
>> new inode for the snapshot dentry and then will fill the ci->fscrypt_aut=
h from
>> .snap's inode, please see ceph_mkdir()->ceph_new_inode().
>>
>> And in the mksnap request reply it will try to fill the ci->fscrypt_auth=
 again
>> but failed because it was already filled. This time the auth info is from
>> .snap's parent dir from MDS side. In this patch in theory they should be=
 the
>> same, but I am still not sure why when decrypting the dentry names in sn=
apXXX
>> will fail.
>>
>> I just guess it possibly will depend on the inode number from the related
>> inode or something else. Before the request reply it seems the inode isn=
't set
>> the inode number ?
>>
> It should be the ci_nonce's problem.

OK, you were right.  However, I don't see a simple way around it.  And I
don't think that adding a fscrypt new interface to copy an existent nonce
makes sense.

So, here's another possible option: instead of setting the
DCACHE_NOKEY_NAME flag, we could simply do d_invalidate(dentry) before
leaving ceph_mkdir (if we're creating an encrypted snapshot, of course).
Would this be acceptable?

Cheers,
--=20
Lu=C3=ADs


> In the ceph_mkdir()->ceph_new_inode() it will generate a new random nonce=
 and
> then setup the fscrypt context for the inode of .snap/snapXXX. But this c=
ontext
> is not correct, because the context of .snap/snapXXX should always be inh=
erit
> from .snap's parent, which will be sent from the MDS in the request reply.
>
>
>> - Xiubo
>>
>>>
>>>> + spin_unlock(&dentry->d_lock);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (ceph_snap(dir) =3D=3D CEPH_N=
OSNAP) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dout("mkdir dir=
 %p dn %p mode 0%ho\n", dir, dentry, mode);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D CEPH_MDS=
_OP_MKDIR;
>>>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>>>> index b573a0f33450..81d3d554d261 100644
>>>> --- a/fs/ceph/inode.c
>>>> +++ b/fs/ceph/inode.c
>>>> @@ -182,6 +182,19 @@ struct inode *ceph_get_snapdir(struct inode *pare=
nt)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci->i_rbytes =3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci->i_btime =3D ceph_inode(parent)->i_b=
time;
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* if encrypted, just borrow fscrypt_auth f=
rom parent */
>>>> +=C2=A0=C2=A0=C2=A0 if (IS_ENCRYPTED(parent)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_inode_info *pc=
i =3D ceph_inode(parent);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci->fscrypt_auth =3D kmemd=
up(pci->fscrypt_auth,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci->fscryp=
t_auth_len,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ci->fscrypt_auth) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
ode->i_flags |=3D S_ENCRYPTED;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci=
->fscrypt_auth_len =3D pci->fscrypt_auth_len;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
ut("Failed to alloc memory for fscrypt_auth in snapdir\n");
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> Here I think Jeff has already commented it in your last version, it sho=
uld
>>> fail by returning NULL ?
>>>
>>> - Xiubo
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inode->i_state & I_NEW) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode->i_op =3D=
 &ceph_snapdir_iops;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode->i_fop =
=3D &ceph_snapdir_fops;
>>>>
>
