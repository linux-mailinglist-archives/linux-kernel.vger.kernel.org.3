Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F444CE54B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiCEOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCEOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:35:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0583A4162C;
        Sat,  5 Mar 2022 06:34:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD2E61F38E;
        Sat,  5 Mar 2022 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646490876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jvn6usLbCQxA25jgqsaOq2N8KJNQyCUH1bEKc0db2E=;
        b=Q7CfJfHjazC7014CUJGGnkKeMXAl3lc2wmQBXKwFuTeZo5Ho0FPCZrJ43XfDoUwZ9LwjRG
        BgrP0SfJhkWS1dKGV7vZEhOwFPB/fc3VVom+5v7/LYdGLAzkwjckYx+hareU1dvZRCDaMf
        pMvxP0AM5CR8D6zAdsqOTDj8GuQhcHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646490876;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jvn6usLbCQxA25jgqsaOq2N8KJNQyCUH1bEKc0db2E=;
        b=QCkWaB9jJGkBr3ycD0Hg1xGa5k0pESBOOTA6OhBDklaY1LUFfw/Yst8PQ1LdztG9Br4+4/
        pvublvB1uWq222Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 428D813519;
        Sat,  5 Mar 2022 14:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZD+WDPx0I2K4WgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Sat, 05 Mar 2022 14:34:36 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 13ded349;
        Sat, 5 Mar 2022 14:34:52 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ceph: add support for encrypted snapshot names
References: <20220304161403.19295-1-lhenriques@suse.de>
        <20220304161403.19295-4-lhenriques@suse.de>
        <c3d26fbd7691155cedc06dd44344d868f4d9112a.camel@kernel.org>
Date:   Sat, 05 Mar 2022 14:34:52 +0000
In-Reply-To: <c3d26fbd7691155cedc06dd44344d868f4d9112a.camel@kernel.org> (Jeff
        Layton's message of "Fri, 04 Mar 2022 13:25:44 -0500")
Message-ID: <87czj0o4c3.fsf@brahms.olymp>
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

> On Fri, 2022-03-04 at 16:14 +0000, Lu=C3=ADs Henriques wrote:
>> Since filenames in encrypted directories are already encrypted and shown
>> as a base64-encoded string when the directory is locked, snapshot names
>> should show a similar behaviour.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  fs/ceph/dir.c   |  9 +++++++++
>>  fs/ceph/inode.c | 13 +++++++++++++
>>  2 files changed, 22 insertions(+)
>>=20
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index 934402f5e9e6..17d2f18a1fd1 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -1069,6 +1069,15 @@ static int ceph_mkdir(struct user_namespace *mnt_=
userns, struct inode *dir,
>>  		op =3D CEPH_MDS_OP_MKSNAP;
>>  		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>>  		     dentry, dentry);
>> +		/*
>> +		 * Encrypted snapshots require d_revalidate to force a
>> +		 * LOOKUPSNAP to cleanup dcache
>> +		 */
>> +		if (IS_ENCRYPTED(dir)) {
>> +			spin_lock(&dentry->d_lock);
>> +			dentry->d_flags |=3D DCACHE_NOKEY_NAME;
>> +			spin_unlock(&dentry->d_lock);
>> +		}
>>  	} else if (ceph_snap(dir) =3D=3D CEPH_NOSNAP) {
>>  		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>  		op =3D CEPH_MDS_OP_MKDIR;
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index 8b0832271fdf..357335a11384 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -182,6 +182,19 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>>  	ci->i_rbytes =3D 0;
>>  	ci->i_btime =3D ceph_inode(parent)->i_btime;
>>=20=20
>> +	/* if encrypted, just borrow fscrypt_auth from parent */
>> +	if (IS_ENCRYPTED(parent)) {
>> +		struct ceph_inode_info *pci =3D ceph_inode(parent);
>> +
>> +		ci->fscrypt_auth =3D kmemdup(pci->fscrypt_auth,
>> +					   pci->fscrypt_auth_len,
>> +					   GFP_KERNEL);
>> +		if (ci->fscrypt_auth) {
>> +			inode->i_flags |=3D S_ENCRYPTED;
>> +			ci->fscrypt_auth_len =3D pci->fscrypt_auth_len;
>> +		} else
>> +			dout("Failed to alloc memory for fscrypt_auth in snapdir\n");
>
> Should we return an error in this case?

Yeah, definitely.  I'll add that and send out v2.  Thanks.

Cheers,
--=20
Lu=C3=ADs


>
>> +	}
>>  	if (inode->i_state & I_NEW) {
>>  		inode->i_op =3D &ceph_snapdir_iops;
>>  		inode->i_fop =3D &ceph_snapdir_fops;
>
> Seems simple and straightforward at first glance.
> --=20
> Jeff Layton <jlayton@kernel.org>

