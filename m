Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2BB535D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349957AbiE0JNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349941AbiE0JNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:13:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B19BC6D9;
        Fri, 27 May 2022 02:13:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55D4C1F961;
        Fri, 27 May 2022 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653642802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/x3GfcbIeHxfmZKZaoEc1B6HHcPO/+Q1qQPyWlKfoTs=;
        b=vXZvJ91QGPdxITgEw3AO++0MmHn14vv+IzzM8Fm4LSSnFzYzOx4tko3xvF4NbBmHheWond
        psk+kwj8+Pv3j65Sz7dpsULK+4BUH3/irWqj7VDmPSEZrmotKAQxWCQRUng1mXshJ1nPiE
        LzL8yw/0B3T8K6QBf9SVyJZKsm69Rn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653642802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/x3GfcbIeHxfmZKZaoEc1B6HHcPO/+Q1qQPyWlKfoTs=;
        b=0hDkZzS2MCGEHpEjkTSwn1e8NchRqfuVy3T8UiuSXdkBRXzX516P0My85tBQpPjMmSB+Ym
        NTE3XVywBXw3EsAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB7F4139C4;
        Fri, 27 May 2022 09:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9lJwMjGWkGLETQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 27 May 2022 09:13:21 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 53ebd536;
        Fri, 27 May 2022 09:14:00 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Gregory Farnum <gfarnum@redhat.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] ceph: prevent a client from exceeding the MDS
 maximum xattr size
References: <20220525172427.3692-1-lhenriques@suse.de>
        <fb3d817d8b6235472e517a9fc9ad0956fb4e8cf2.camel@kernel.org>
        <3cb96552-9747-c6b4-c8d3-81af60e5ae6a@redhat.com>
        <ca4928507bdf329bbe5b32a7b71f4a4295e5bba1.camel@kernel.org>
        <f238e4a1-ef98-ccfe-6345-51b6d9a34319@redhat.com>
        <CAJ4mKGZyw+uKjwkSBseETtKXwJOSV2D8J9mLH-8yB8w98Ow=fA@mail.gmail.com>
Date:   Fri, 27 May 2022 10:14:00 +0100
In-Reply-To: <CAJ4mKGZyw+uKjwkSBseETtKXwJOSV2D8J9mLH-8yB8w98Ow=fA@mail.gmail.com>
        (Gregory Farnum's message of "Thu, 26 May 2022 20:23:39 -0700")
Message-ID: <87leunwd5z.fsf@brahms.olymp>
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

Gregory Farnum <gfarnum@redhat.com> writes:

> On Thu, May 26, 2022 at 6:10 PM Xiubo Li <xiubli@redhat.com> wrote:
>>
>>
>> On 5/27/22 8:44 AM, Jeff Layton wrote:
>> > On Fri, 2022-05-27 at 08:36 +0800, Xiubo Li wrote:
>> >> On 5/27/22 2:39 AM, Jeff Layton wrote:
>> >>> A question:
>> >>>
>> >>> How do the MDS's discover this setting? Do they get it from the mons=
? If
>> >>> so, I wonder if there is a way for the clients to query the mon for =
this
>> >>> instead of having to extend the MDS protocol?
>> >> It sounds like what the "max_file_size" does, which will be recorded =
in
>> >> the 'mdsmap'.
>> >>
>> >> While currently the "max_xattr_pairs_size" is one MDS's option for ea=
ch
>> >> daemon and could set different values for each MDS.
>> >>
>> >>
>> > Right, but the MDS's in general don't use local config files. Where are
>> > these settings stored? Could the client (potentially) query for them?
>>
>> AFAIK, each process in ceph it will have its own copy of the
>> "CephContext". I don't know how to query all of them but I know there
>> have some API such as "rados_conf_set/get" could do similar things.
>>
>> Not sure whether will it work in our case.
>>
>> >
>> > I'm pretty sure the client does fetch and parse the mdsmap. If it's
>> > there then it could grab the setting for all of the MDS's at mount time
>> > and settle on the lowest one.
>> >
>> > I think a solution like that might be more resilient than having to
>> > fiddle with feature bits and such...
>>
>> Yeah, IMO just making this option to be like the "max_file_size" is more
>> appropriate.
>
> Makes sense to me =E2=80=94 this is really a property of the filesystem, =
not a
> daemon, so it should be propagated through common filesystem state.

Right now the max_xattr_pairs_size seems to be something that can be set
on each MDS, so definitely not a filesystem property.  To be honest, I
think it's nasty to have this knob in the first place because it will
allow an admin to set it to a value that will allow clients to blowup the
MDS cluster.

> I guess Luis' https://github.com/ceph/ceph/pull/46357 should be
> updated to do it that way?

Just to confirm, by "to do it that way" you mean to move that setting into
the mdsmap, right?

> I see some discussion there about handling
> old clients which don't recognize these limits as well.

Yeah, this is where the feature bit came from.  This would allow old
clients to be identified so that the MDS would not give them 'Xx'
capabilities.  Old clients would be able to set xattrs but not to buffer
them, i.e. they'd be forced to do the SETXATTR synchronously.

Cheers,
--=20
Lu=C3=ADs
