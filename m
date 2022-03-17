Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C71F4DCA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiCQQAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbiCQQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:00:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9801C6EEB;
        Thu, 17 Mar 2022 08:58:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A18931F38D;
        Thu, 17 Mar 2022 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647532724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KnvKkMkKV+AkQh16DqNsG50faWxcS2O+JpiJc4G40BM=;
        b=Rk7UBFafzjCj4QFrQz8aKxdQtZfJjeU0TbP9DSdZU6ngd6/ROIQoKSaYBFmLs3T0xGG7ql
        9BkJcwCxCWLIx+JOXgDZqh1IupzkOXNoMP0yEV8MQyVbQNzc+XkiLK+XOVUmIdy7yUH3Yw
        yG6Fj/0t9f17KWxK8kDLozDVdP3yRdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647532724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KnvKkMkKV+AkQh16DqNsG50faWxcS2O+JpiJc4G40BM=;
        b=HQqXeJ+XU0kwpRtchanpWMsyLCZ4sR8+Q8JhLnACx/OXvdjbU4r5K4+Lu88BIXYPXoLwz5
        QIR9gafjitP1i6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CDA1132BE;
        Thu, 17 Mar 2022 15:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V3L4C7RaM2L3YgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 17 Mar 2022 15:58:44 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id f232acc7;
        Thu, 17 Mar 2022 15:59:02 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] ceph: add support for snapshot names encryption
References: <20220315161959.19453-1-lhenriques@suse.de>
        <5b53e812-d49b-45f0-1219-3dbc96febbc1@redhat.com>
        <329abedd9d9938de95bf4f5600acdcd6a846e6be.camel@kernel.org>
        <3c8b78c4-5392-b81c-e76f-64fcce4f3c0f@redhat.com>
        <87wngshlzb.fsf@brahms.olymp>
        <c2f494b61674e63985e4e2a0fb3b6c503e17334b.camel@kernel.org>
Date:   Thu, 17 Mar 2022 15:59:02 +0000
In-Reply-To: <c2f494b61674e63985e4e2a0fb3b6c503e17334b.camel@kernel.org> (Jeff
        Layton's message of "Thu, 17 Mar 2022 08:01:17 -0400")
Message-ID: <87czikh8op.fsf@brahms.olymp>
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

> On Thu, 2022-03-17 at 11:11 +0000, Lu=C3=ADs Henriques wrote:
>> Xiubo Li <xiubli@redhat.com> writes:
>>=20
>> > On 3/17/22 6:01 PM, Jeff Layton wrote:
>> > > I'm not sure we want to worry about .snap directories here since they
>> > > aren't "real". IIRC, snaps are inherited from parents too, so you co=
uld
>> > > do something like
>> > >=20
>> > >      mkdir dir1
>> > >      mkdir dir1/.snap/snap1
>> > >      mkdir dir1/dir2
>> > >      fscrypt encrypt dir1/dir2
>> > >=20
>> > > There should be nothing to prevent encrypting dir2, but I'm pretty s=
ure
>> > > dir2/.snap will not be empty at that point.
>> >=20
>> > If we don't take care of this. Then we don't know which snapshots shou=
ld do
>> > encrypt/dencrypt and which shouldn't when building the path in lookup =
and when
>> > reading the snapdir ?
>>=20
>> In my patchset (which I plan to send a new revision later today, I think=
 I
>> still need to rebase it) this is handled by using the *real* snapshot
>> parent inode.  If we're decrypting/encrypting a name for a snapshot that
>> starts with a '_' character, we first find the parent inode for that
>> snapshot and only do the operation if that parent is encrypted.
>>=20
>> In the other email I suggested that we could prevent enabling encryption
>> in a directory when there are snapshots above in the hierarchy.  But now
>> that I think more about it, it won't solve any problem because you could
>> create those snapshots later and then you would still need to handle the=
se
>> (non-encrypted) "_name_xxxx" snapshots anyway.
>>=20
>
> Yeah, that sounds about right.
>
> What happens if you don't have the snapshot parent's inode in cache?
> That can happen if you (e.g.) are running NFS over ceph, or if you get
> crafty with name_to_handle_at() and open_by_handle_at().
>
> Do we have to do a LOOKUPINO in that case or does the trace contain that
> info? If it doesn't then that could really suck in a big hierarchy if
> there are a lot of different snapshot parent inodes to hunt down.
>
> I think this is a case where the client just doesn't have complete
> control over the dentry name. It may be better to just not encrypt them
> if it's too ugly.

I *think* this is covered by my last revision.  I didn't really tested
NFS, but this was why the patches are using ceph_get_inode() and falling
back to ceph_find_inode().  I tested this by directly mounting an
encrypted directory that had snapshots from a realm that wasn't in the
mount root.

(Obviously, these snapshot names are *not* encrypted because they belong
to snapshots that are not encrypted either.)

Cheers,
--=20
Lu=C3=ADs

> Another idea might be to just use the same parent inode (maybe the
> root?) for all snapshot names. It's not as secure, but it's probably
> better than nothing.
> --=20
> Jeff Layton <jlayton@kernel.org>
