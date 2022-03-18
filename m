Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A414DD93D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiCRLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiCRLun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:50:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C69D3E0F4;
        Fri, 18 Mar 2022 04:49:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 40C5D210FA;
        Fri, 18 Mar 2022 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647604160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2OQ24OsfMwaiN+mK75UNzZhX0XQ5LVCCQJKtfe2W/8=;
        b=UUPNVyMFr93r9LqLoV52p37b34f6NvDqpC6LqPOamU1ne5XEv7tO7MDBun1AlHw4/QQdWt
        vshoXcxABKAFtfUHqpef8CrH20TSJMMLBvSlG6bc4f5jbhpZ5wxSMN5Ale6FwOQItlHy0f
        Yxa4Jy4fb2zWc+o+OICytFhuLoLmxjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647604160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2OQ24OsfMwaiN+mK75UNzZhX0XQ5LVCCQJKtfe2W/8=;
        b=Plk8UN2MVFYExSm1cPVj88gOtxpo9NjEZyGZww1uKnwAjExAQuIcAqcwfa4thscqKjG0Yg
        Z2dDs2tQzxPVl4Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D94E813B67;
        Fri, 18 Mar 2022 11:49:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wvMSMr9xNGL9fwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 18 Mar 2022 11:49:19 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 7e73c2df;
        Fri, 18 Mar 2022 11:49:38 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/4] ceph: handle encrypted snapshot names in
 subdirectories
References: <20220317154521.6615-1-lhenriques@suse.de>
        <20220317154521.6615-3-lhenriques@suse.de>
        <61d831de-1589-3a19-8f46-a162099e75df@redhat.com>
        <878rt7h6qs.fsf@brahms.olymp>
        <15c60a74-73a9-a509-2b0e-2d9c6bfd9398@redhat.com>
Date:   Fri, 18 Mar 2022 11:49:38 +0000
In-Reply-To: <15c60a74-73a9-a509-2b0e-2d9c6bfd9398@redhat.com> (Xiubo Li's
        message of "Fri, 18 Mar 2022 19:28:46 +0800")
Message-ID: <87y217fpkd.fsf@brahms.olymp>
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

> On 3/18/22 6:53 PM, Lu=C3=ADs Henriques wrote:
>> Xiubo Li <xiubli@redhat.com> writes:
>>
>>> On 3/17/22 11:45 PM, Lu=C3=ADs Henriques wrote:
>>>> When creating a snapshot, the .snap directories for every subdirectory=
 will
>>>> show the snapshot name in the "long format":
>>>>
>>>>     # mkdir .snap/my-snap
>>>>     # ls my-dir/.snap/
>>>>     _my-snap_1099511627782
>>>>
>>>> Encrypted snapshots will need to be able to handle these snapshot name=
s by
>>>> encrypting/decrypting only the snapshot part of the string ('my-snap').
>>>>
>>>> Also, since the MDS prevents snapshot names to be bigger than 240 char=
acters
>>>> it is necessary to adapt CEPH_NOHASH_NAME_MAX to accommodate this extra
>>>> limitation.
>>>>
>>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>>> ---
>>>>    fs/ceph/crypto.c | 189 ++++++++++++++++++++++++++++++++++++++++----=
---
>>>>    fs/ceph/crypto.h |  11 ++-
>>>>    2 files changed, 169 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>>>> index beb73bbdd868..caa9863dee93 100644
>>>> --- a/fs/ceph/crypto.c
>>>> +++ b/fs/ceph/crypto.c
>>>> @@ -128,16 +128,100 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds=
_request *req, struct ceph_acl_se
>>>>    	swap(req->r_fscrypt_auth, as->fscrypt_auth);
>>>>    }
>>>>    -int ceph_encode_encrypted_dname(const struct inode *parent, struct=
 qstr
>>>> *d_name, char *buf)
>>>> +/*
>>>> + * User-created snapshots can't start with '_'.  Snapshots that start=
 with this
>>>> + * character are special (hint: there aren't real snapshots) and use =
the
>>>> + * following format:
>>>> + *
>>>> + *   _<SNAPSHOT-NAME>_<INODE-NUMBER>
>>>> + *
>>>> + * where:
>>>> + *  - <SNAPSHOT-NAME> - the real snapshot name that may need to be de=
crypted,
>>>> + *  - <INODE-NUMBER> - the inode number for the actual snapshot
>>>> + *
>>>> + * This function parses these snapshot names and returns the inode
>>>> + * <INODE-NUMBER>.  'name_len' will also bet set with the <SNAPSHOT-N=
AME>
>>>> + * length.
>>>> + */
>>>> +static struct inode *parse_longname(const struct inode *parent, const=
 char *name,
>>>> +				    int *name_len)
>>>>    {
>>>> +	struct inode *dir =3D NULL;
>>>> +	struct ceph_vino vino =3D { .snap =3D CEPH_NOSNAP };
>>>> +	char *inode_number;
>>>> +	char *name_end;
>>>> +	int orig_len =3D *name_len;
>>>> +	int ret =3D -EIO;
>>>> +
>>>> +	/* Skip initial '_' */
>>>> +	name++;
>>>> +	name_end =3D strrchr(name, '_');
>>>> +	if (!name_end) {
>>>> +		dout("Failed to parse long snapshot name: %s\n", name);
>>>> +		return ERR_PTR(-EIO);
>>>> +	}
>>>> +	*name_len =3D (name_end - name);
>>>> +	if (*name_len <=3D 0) {
>>>> +		pr_err("Failed to parse long snapshot name\n");
>>>> +		return ERR_PTR(-EIO);
>>>> +	}
>>>> +
>>>> +	/* Get the inode number */
>>>> +	inode_number =3D kmemdup_nul(name_end + 1,
>>>> +				   orig_len - *name_len - 2,
>>>> +				   GFP_KERNEL);
>>>> +	if (!inode_number)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +	ret =3D kstrtou64(inode_number, 0, &vino.ino);
>>>> +	if (ret) {
>>>> +		dout("Failed to parse inode number: %s\n", name);
>>>> +		dir =3D ERR_PTR(ret);
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	/* And finally the inode */
>>>> +	dir =3D ceph_find_inode(parent->i_sb, vino);
>>>> +	if (!dir) {
>>>> +		/* This can happen if we're not mounting cephfs on the root */
>>>> +		dir =3D ceph_get_inode(parent->i_sb, vino, NULL);
>>> In this case IMO you should lookup the inode from MDS instead create it=
 in the
>>> cache, which won't setup the encryption info needed.
>>>
>>> So later when you try to use this to dencrypt the snapshot names, you w=
ill hit
>>> errors ? And also the case Jeff mentioned in previous thread could happ=
en.
>> No, I don't see any errors.  The reason is that if we get a I_NEW inode,
>> we do not have the keys to even decrypt the names.  If you mount a
>> filesystem using as root a directory that is inside an encrypted
>> directory, you'll see the encrypted snapshot name:
>>
>>   # mkdir mydir
>>   # fscrypt encrypt mydir
>>   # mkdir -p mydir/a/b/c/d
>>   # mkdir mydir/a/.snap/myspan
>>   # umount ...
>>   # mount <mon>:<port>:/a
>>   # ls .snap
>>
>> And we simply can't decrypt it because for that we'd need to have access
>> to the .fscrypt in the original filesystem mount root.
>
> Should we resolve this issue ? Something like try to copy the .fscrypt wh=
en
> mounting '/a' ?

I don't think this is an issue.  If an admin mounts a filesystem this way,
he must know what he's doing.  Being unable to decrypt a directory because
he picked the wrong root is a user error.  (Having documentation will
help, of course.)

Also, where would we copy the .fscrypt from?  You can run 'fscrypt setup'
as many times as you want in a single cephfs, you simply need to use
different root directories.  So, yeah, my opinion is that we simply need
to hand this gracefully in the client.

Cheers,
--=20
Lu=C3=ADs
