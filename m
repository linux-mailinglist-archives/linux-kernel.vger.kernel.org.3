Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA84C4647
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiBYN2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241388AbiBYN2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:28:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DA7197B41;
        Fri, 25 Feb 2022 05:27:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D90FA1F380;
        Fri, 25 Feb 2022 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645795658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgVpo4RGRckA/dOLxsNh0O2hyt7uxbE8iG6LJYGdpdQ=;
        b=FAtD2LOBb7XXvbU4XZ8w05Wd1e6Wu5z0/X9jpXtq+Nk5MLhP5EOVlyfZ/nwtVUr4+CPV6T
        39iRaSg4YAOCgD2xOKa9buoq6Fh2vNNEY4NLcD3hYE50QTcazcSh+LAzAtaa2Ni8v54KgX
        aRLFFXCPDaoTf6WVi87SQg3EbN46F0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645795658;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgVpo4RGRckA/dOLxsNh0O2hyt7uxbE8iG6LJYGdpdQ=;
        b=+o7T8mRd74XkAFDOBi32aem2Nv3z3f1JgOnGuINVhcirJZ5xhGEirlUQJEm6QeXidTTbDZ
        M1+h08mfd/PQowDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 804D413BD1;
        Fri, 25 Feb 2022 13:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L6IUHErZGGJgSgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 25 Feb 2022 13:27:38 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 6869ee24;
        Fri, 25 Feb 2022 13:27:52 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ceph: add support for encrypted snapshot names
References: <20220224112142.18052-1-lhenriques@suse.de>
        <7d2a798d-ce32-4bf7-b184-267bb79f44e3@redhat.com>
        <87h78ni8ed.fsf@brahms.olymp>
        <1945dae6-9c0d-4cf7-49d8-843ba15e1710@redhat.com>
Date:   Fri, 25 Feb 2022 13:27:52 +0000
In-Reply-To: <1945dae6-9c0d-4cf7-49d8-843ba15e1710@redhat.com> (Xiubo Li's
        message of "Fri, 25 Feb 2022 18:42:40 +0800")
Message-ID: <87czjbhy93.fsf@brahms.olymp>
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

> On 2/25/22 5:48 PM, Lu=C3=ADs Henriques wrote:
>> Xiubo Li <xiubli@redhat.com> writes:
>>
>>> On 2/24/22 7:21 PM, Lu=C3=ADs Henriques wrote:
>>>> Since filenames in encrypted directories are already encrypted and sho=
wn
>>>> as a base64-encoded string when the directory is locked, snapshot names
>>>> should show a similar behaviour.
>>>>
>>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>>> ---
>>>>    fs/ceph/dir.c   | 15 +++++++++++++++
>>>>    fs/ceph/inode.c | 10 +++++++++-
>>>>    2 files changed, 24 insertions(+), 1 deletion(-)
>>>>
>>>> Support on the MDS for names that'll be > MAX_NAME when base64 encoded=
 is
>>>> still TBD.  I thought it would be something easy to do, but snapshots
>>>> don't seem to make use of the CDir/CDentry (which is where alternate_n=
ame
>>>> is stored on the MDS).  I'm still looking into this, but I may need so=
me
>>>> help there :-(
>>>>
>>>> Cheers,
>>>> --
>>>> Lu=C3=ADs
>>>>
>>>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>>>> index a449f4a07c07..20ae600ee7cd 100644
>>>> --- a/fs/ceph/dir.c
>>>> +++ b/fs/ceph/dir.c
>>>> @@ -1065,6 +1065,13 @@ static int ceph_mkdir(struct user_namespace *mn=
t_userns, struct inode *dir,
>>>>    		op =3D CEPH_MDS_OP_MKSNAP;
>>>>    		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>>>>    		     dentry, dentry);
>>>> +		/* XXX missing support for alternate_name in snapshots */
>>>> +		if (IS_ENCRYPTED(dir) && (dentry->d_name.len >=3D 189)) {
>>>> +			dout("encrypted snapshot name too long: %pd len: %d\n",
>>>> +			     dentry, dentry->d_name.len);
>>>> +			err =3D -ENAMETOOLONG;
>>>> +			goto out;
>>>> +		}
>>>>    	} else if (ceph_snap(dir) =3D=3D CEPH_NOSNAP) {
>>>>    		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>>>    		op =3D CEPH_MDS_OP_MKDIR;
>>>> @@ -1109,6 +1116,14 @@ static int ceph_mkdir(struct user_namespace *mn=
t_userns, struct inode *dir,
>>>>    	    !req->r_reply_info.head->is_target &&
>>>>    	    !req->r_reply_info.head->is_dentry)
>>>>    		err =3D ceph_handle_notrace_create(dir, dentry);
>>>> +
>>>> +	/*
>>>> +	 * If we have created a snapshot we need to clear the cache, otherwi=
se
>>>> +	 * snapshot will show encrypted filenames in readdir.
>>>> +	 */
>>> Do you mean dencrypted filenames ?
>> What I see without this d_drop() is that, if I run an 'ls' in a snapshot
>> directory immediately after creating it, the filenames in that snapshot
>> will be encrypted.  Maybe there's a bug somewhere else and this d_drop()
>> isn't the right fix...?
>
> Maybe should fix this in ceph_fill_trace() in

Hmm... maybe, I'll have to check.  Thank's for the suggestion.  I'll try
to investigate this before sending a new revision which, hopefully, will
have some MDS-side changes to support the altname (which I'm still trying
to untangle).

Cheers,
--=20
Lu=C3=ADs

>
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 } else if ((req->r_op =3D=3D CEPH_MDS_OP_=
LOOKUPSNAP ||... {
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> ?
>
> I still haven't gotten where will encrypt it yet in mksnap case. Because =
the MDS
> will set the 'rinfo->head->is_target' but won't set the
> 'rinfo->head->is_dentry', so in this case the dentry should keep the=20
> human readable name.
>
> - Xiubo
>
>
>> Cheers,
>

