Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8124C41B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiBYJqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbiBYJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:46:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6263B23A18E;
        Fri, 25 Feb 2022 01:45:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 213291F380;
        Fri, 25 Feb 2022 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645782345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LBl4bfGMT+fn7Rt+b0Ek5//1CvY7wnB9+HNkNJDIjU=;
        b=fWNule7cfAd0d0S/AEJ7vYsMQcLLCBWpgkjasfNafgLaKerE+u/GYEWmgoykBWiqkD7OPr
        s37PJYJ4rOtU1Xk4Lx5J1JK38m4SDwcMbsuvEFqvpWpdhXns0dxIwiBue79uNky+hgIJsU
        i3zQwstpHsV/FaHKs/we35itkQflLmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645782345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LBl4bfGMT+fn7Rt+b0Ek5//1CvY7wnB9+HNkNJDIjU=;
        b=vPaeBACAZjQJlkt6pfvtosYexKewwvCcU5Ue1kosUQs0AuMwpiDy3lhia0V5RdQOoDvlH5
        ElyfkG2miww8tPAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFD1D13B96;
        Fri, 25 Feb 2022 09:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Um0FJ0ilGGIxYAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 25 Feb 2022 09:45:44 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 5a82c583;
        Fri, 25 Feb 2022 09:45:58 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ceph: add support for encrypted snapshot names
References: <20220224112142.18052-1-lhenriques@suse.de>
        <27801620-b3fd-d556-c100-409632f91661@redhat.com>
Date:   Fri, 25 Feb 2022 09:45:58 +0000
In-Reply-To: <27801620-b3fd-d556-c100-409632f91661@redhat.com> (Xiubo Li's
        message of "Fri, 25 Feb 2022 13:36:24 +0800")
Message-ID: <87lexzi8ix.fsf@brahms.olymp>
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

> On 2/24/22 7:21 PM, Lu=C3=ADs Henriques wrote:
>> Since filenames in encrypted directories are already encrypted and shown
>> as a base64-encoded string when the directory is locked, snapshot names
>> should show a similar behaviour.
>>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/dir.c   | 15 +++++++++++++++
>>   fs/ceph/inode.c | 10 +++++++++-
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> Support on the MDS for names that'll be > MAX_NAME when base64 encoded is
>> still TBD.  I thought it would be something easy to do, but snapshots
>> don't seem to make use of the CDir/CDentry (which is where alternate_name
>> is stored on the MDS).  I'm still looking into this, but I may need some
>> help there :-(
>
> Yeah, good catch. The snapshot handler in MDS hasn't handled this case ye=
t,
> though the kclient has passed it to MDS server.
>
> The snapshot alternate_name raw ciphertext should be stored in SnapInfo s=
truct
> along with the 'name'.
>
>
>>
>> Cheers,
>> --
>> Lu=C3=ADs
>>
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index a449f4a07c07..20ae600ee7cd 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -1065,6 +1065,13 @@ static int ceph_mkdir(struct user_namespace *mnt_=
userns, struct inode *dir,
>>   		op =3D CEPH_MDS_OP_MKSNAP;
>>   		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>>   		     dentry, dentry);
>> +		/* XXX missing support for alternate_name in snapshots */
>> +		if (IS_ENCRYPTED(dir) && (dentry->d_name.len >=3D 189)) {
>> +			dout("encrypted snapshot name too long: %pd len: %d\n",
>> +			     dentry, dentry->d_name.len);
>> +			err =3D -ENAMETOOLONG;
>> +			goto out;
>> +		}
>
> We should fix the MDS side bug and then this workaroud will be no needed.

Yep, I've been looking into that too but it's taking a bit to understand
all that's going on there.  I'm still trying, but the MDS code (and C++ in
general) is a bit... challenging.

Cheers,
--=20
Lu=C3=ADs

>
> - Xiubo
>
>>   	} else if (ceph_snap(dir) =3D=3D CEPH_NOSNAP) {
>>   		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>   		op =3D CEPH_MDS_OP_MKDIR;
>> @@ -1109,6 +1116,14 @@ static int ceph_mkdir(struct user_namespace *mnt_=
userns, struct inode *dir,
>>   	    !req->r_reply_info.head->is_target &&
>>   	    !req->r_reply_info.head->is_dentry)
>>   		err =3D ceph_handle_notrace_create(dir, dentry);
>> +
>> +	/*
>> +	 * If we have created a snapshot we need to clear the cache, otherwise
>> +	 * snapshot will show encrypted filenames in readdir.
>> +	 */
>> +	if (ceph_snap(dir) =3D=3D CEPH_SNAPDIR)
>> +		d_drop(dentry);
>> +
>>   out_req:
>>   	ceph_mdsc_put_request(req);
>>   out:
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index 8b0832271fdf..080824610b73 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -182,6 +182,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>>   	ci->i_rbytes =3D 0;
>>   	ci->i_btime =3D ceph_inode(parent)->i_btime;
>>   +	/* if encrypted, just borough fscrypt_auth from parent */
>> +	if (IS_ENCRYPTED(parent)) {
>> +		struct ceph_inode_info *pci =3D ceph_inode(parent);
>> +		inode->i_flags |=3D S_ENCRYPTED;
>> +		ci->fscrypt_auth_len =3D pci->fscrypt_auth_len;
>> +		ci->fscrypt_auth =3D pci->fscrypt_auth;
>> +	}
>>   	if (inode->i_state & I_NEW) {
>>   		inode->i_op =3D &ceph_snapdir_iops;
>>   		inode->i_fop =3D &ceph_snapdir_fops;
>> @@ -632,7 +639,8 @@ void ceph_free_inode(struct inode *inode)
>>     	kfree(ci->i_symlink);
>>   #ifdef CONFIG_FS_ENCRYPTION
>> -	kfree(ci->fscrypt_auth);
>> +	if (ceph_snap(inode) !=3D CEPH_SNAPDIR)
>> +		kfree(ci->fscrypt_auth);
>>   #endif
>>   	fscrypt_free_inode(inode);
>>   	kmem_cache_free(ceph_inode_cachep, ci);
>>
>
