Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2ED4C568E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiBZPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiBZPGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 10:06:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A91DC9BE;
        Sat, 26 Feb 2022 07:06:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D0C51F38C;
        Sat, 26 Feb 2022 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645887964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDsP/KJRR4Vpd0qCpYOd9ME4dfRhzYnbAg1qkh1b/RA=;
        b=GYBEf/a9CDD2OCciwmqn/koLYYU5Wt1BD1x8bP1iiupSVpNtWORy9C41tag4jWmnuw11DA
        ZPtgIqjl/YGQ9Bls7jQpEWvba7MkuK7cZSA/2G27kwZJRLROgvjGR24jgbcUFK/ABiBcxo
        i7iigYA+At1v+3wX7/Rx1YL35NlJf3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645887964;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDsP/KJRR4Vpd0qCpYOd9ME4dfRhzYnbAg1qkh1b/RA=;
        b=iORTMO3zETfafm2F7C4K47SxKggvPkuA60rFhKh/mv6aSwgZr0QpmO9rB+fQaN8DlJPh+N
        kQRBVToNC2G2y0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DABB139B5;
        Sat, 26 Feb 2022 15:06:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DkdECNxBGmJsMAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Sat, 26 Feb 2022 15:06:04 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 13dda296;
        Sat, 26 Feb 2022 15:06:18 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ceph: add support for encrypted snapshot names
References: <20220224112142.18052-1-lhenriques@suse.de>
        <57461c8994f5eb15409ae1cfe452b3d6b2263645.camel@kernel.org>
Date:   Sat, 26 Feb 2022 15:06:18 +0000
In-Reply-To: <57461c8994f5eb15409ae1cfe452b3d6b2263645.camel@kernel.org> (Jeff
        Layton's message of "Fri, 25 Feb 2022 15:57:34 -0500")
Message-ID: <87v8x1sm51.fsf@brahms.olymp>
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

Jeff Layton <jlayton@kernel.org> writes:

> On Thu, 2022-02-24 at 11:21 +0000, Lu=C3=ADs Henriques wrote:
>> Since filenames in encrypted directories are already encrypted and shown
>> as a base64-encoded string when the directory is locked, snapshot names
>> should show a similar behaviour.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  fs/ceph/dir.c   | 15 +++++++++++++++
>>  fs/ceph/inode.c | 10 +++++++++-
>>  2 files changed, 24 insertions(+), 1 deletion(-)
>>=20
>> Support on the MDS for names that'll be > MAX_NAME when base64 encoded is
>> still TBD.  I thought it would be something easy to do, but snapshots
>> don't seem to make use of the CDir/CDentry (which is where alternate_name
>> is stored on the MDS).  I'm still looking into this, but I may need some
>> help there :-(
>>=20
>> Cheers,
>> --
>> Lu=C3=ADs
>>=20
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index a449f4a07c07..20ae600ee7cd 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -1065,6 +1065,13 @@ static int ceph_mkdir(struct user_namespace *mnt_=
userns, struct inode *dir,
>>  		op =3D CEPH_MDS_OP_MKSNAP;
>>  		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>>  		     dentry, dentry);
>> +		/* XXX missing support for alternate_name in snapshots */
>> +		if (IS_ENCRYPTED(dir) && (dentry->d_name.len >=3D 189)) {
>> +			dout("encrypted snapshot name too long: %pd len: %d\n",
>> +			     dentry, dentry->d_name.len);
>> +			err =3D -ENAMETOOLONG;
>> +			goto out;
>> +		}
>
> Where does 189 come from? You probably want to use CEPH_NOHASH_NAME_MAX.
>

Yeah, this is just a temporary workaround while the support for altnames
isn't implemented in snapshots.  (189 is the max size that will result in
a base64-encoded that is < MAX_NAME; 190 will be result in a filename that
is too long).

>>  	} else if (ceph_snap(dir) =3D=3D CEPH_NOSNAP) {
>>  		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>  		op =3D CEPH_MDS_OP_MKDIR;
>> @@ -1109,6 +1116,14 @@ static int ceph_mkdir(struct user_namespace *mnt_=
userns, struct inode *dir,
>>  	    !req->r_reply_info.head->is_target &&
>>  	    !req->r_reply_info.head->is_dentry)
>>  		err =3D ceph_handle_notrace_create(dir, dentry);
>> +
>> +	/*
>> +	 * If we have created a snapshot we need to clear the cache, otherwise
>> +	 * snapshot will show encrypted filenames in readdir.
>> +	 */
>> +	if (ceph_snap(dir) =3D=3D CEPH_SNAPDIR)
>> +		d_drop(dentry);
>> +
>
> This looks hacky, but I just caught up on the discussion between you and
> Xiubo, so I assume you're addressing that.

Right, I still need to investigate this further.  It may actually be a bug
somewhere else.  Right now I was trying to get the MDS code written and
decided to look at this later.  I just thought I could send out this RFC
anyway in case someone had an idea -- and Xiubo already gave some
suggestions (which I still have to look at...).

>
>>  out_req:
>>  	ceph_mdsc_put_request(req);
>>  out:
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index 8b0832271fdf..080824610b73 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -182,6 +182,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>>  	ci->i_rbytes =3D 0;
>>  	ci->i_btime =3D ceph_inode(parent)->i_btime;
>>=20=20
>> +	/* if encrypted, just borough fscrypt_auth from parent */
>> +	if (IS_ENCRYPTED(parent)) {
>> +		struct ceph_inode_info *pci =3D ceph_inode(parent);
>> +		inode->i_flags |=3D S_ENCRYPTED;
>> +		ci->fscrypt_auth_len =3D pci->fscrypt_auth_len;
>> +		ci->fscrypt_auth =3D pci->fscrypt_auth;
>> +	}
>>  	if (inode->i_state & I_NEW) {
>>  		inode->i_op =3D &ceph_snapdir_iops;
>>  		inode->i_fop =3D &ceph_snapdir_fops;
>> @@ -632,7 +639,8 @@ void ceph_free_inode(struct inode *inode)
>>=20=20
>>  	kfree(ci->i_symlink);
>>  #ifdef CONFIG_FS_ENCRYPTION
>> -	kfree(ci->fscrypt_auth);
>> +	if (ceph_snap(inode) !=3D CEPH_SNAPDIR)
>> +		kfree(ci->fscrypt_auth);
>
> Can a snapdir inode outlive its parent?

Good question.  That actually occurred to me and I assumed it can not.
But maybe a better/safer option is to create a new copy of fscrypt_auth
into the snapdir and kfree it here.

Cheers,
--=20
Lu=C3=ADs

>
>>  #endif
>>  	fscrypt_free_inode(inode);
>>  	kmem_cache_free(ceph_inode_cachep, ci);
>
> --=20
> Jeff Layton <jlayton@kernel.org>

