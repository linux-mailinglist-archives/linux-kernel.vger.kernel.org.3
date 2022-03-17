Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC58E4DC3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiCQKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiCQKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:15:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90501DEA84;
        Thu, 17 Mar 2022 03:14:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A71331F38D;
        Thu, 17 Mar 2022 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647512079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkHzWOqcfA+EWvx9G34ymicMu1mMDdlE+2xRd+Bpe3Y=;
        b=MgsTYbL3M8BjxDf5Pfv5izxmYt0KoJoZXvJYfbE0NhkpzvA2SdRn4OvT98c7M5ybrk8s3c
        nJHYhF9wGs8DjFfSGLWQU9bbyIX1Efmxe3Xygwv+QJPMDMhOld9L963N3zilu946fx1oYd
        GyWwjH6TroPx0ruEvbdlwLRE4uNZ/GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647512079;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkHzWOqcfA+EWvx9G34ymicMu1mMDdlE+2xRd+Bpe3Y=;
        b=6sNI6ikjHIbqqUSbSQj+pf0+tVN12oDSMIrVFr3AnE02+v4ksRcZOJQnY58iv/RssQ6qJ5
        gOGTHWxPLIzBDVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4299F13B4B;
        Thu, 17 Mar 2022 10:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BQRlDQ8KM2KvNgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 17 Mar 2022 10:14:39 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 49333f2e;
        Thu, 17 Mar 2022 10:14:58 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] ceph: add support for snapshot names encryption
References: <20220315161959.19453-1-lhenriques@suse.de>
        <5b53e812-d49b-45f0-1219-3dbc96febbc1@redhat.com>
Date:   Thu, 17 Mar 2022 10:14:58 +0000
In-Reply-To: <5b53e812-d49b-45f0-1219-3dbc96febbc1@redhat.com> (Xiubo Li's
        message of "Thu, 17 Mar 2022 13:27:01 +0800")
Message-ID: <87bky4j36l.fsf@brahms.olymp>
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

> Hi Luis,
>
> There has another issue you need to handle at the same time.
>
> Currently only the empty directory could be enabled the file encryption, =
such as
> for the following command:
>
> $ fscrypt encrypt mydir/
>
> But should we also make sure that the mydir/.snap/ is empty ?
>
> Here the 'empty' is not totally empty, which allows it should allow long =
snap
> names exist.
>
> Make sense ?

Right, actually I had came across that question in the past but completely
forgot about it.

Right now we simply check the dir stats to ensure a directory is empty.
We could add an extra check in ceph_crypt_empty_dir() to ensure that there
are no snapshots _above_ that directory (i.e. that there are no
"mydir/.snap/_name_xxxxx").

Unfortunately, I don't know enough of snapshots implementation details to
understand if it's a problem to consider a directory as being empty (in
the fscrypt context) when there are these '_name_xxx' directories.  My
feeling is that this is not a problem but I really don't know.

Do you (or anyone) have any ideas/suggestions?

Cheers,
--=20
Lu=C3=ADs

>
> - Xiubo
>
>
> On 3/16/22 12:19 AM, Lu=C3=ADs Henriques wrote:
>> Hi!
>>
>> A couple of changes since v1:
>>
>> - Dropped the dentry->d_flags change in ceph_mkdir().  Thanks to Xiubo
>>    suggestion, patch 0001 now skips calling ceph_fscrypt_prepare_context=
()
>>    if we're handling a snapshot.
>>
>> - Added error handling to ceph_get_snapdir() in patch 0001 (Jeff had
>>    already pointed that out but I forgot to include that change in previ=
ous
>>    revision).
>>
>> - Rebased patch 0002 to the latest wip-fscrypt branch.
>>
>> - Added some documentation regarding snapshots naming restrictions.
>>
>> As before, in order to test this code the following PRs are required:
>>
>>    mds: add protection from clients without fscrypt support #45073
>>    mds: use the whole string as the snapshot long name #45192
>>    mds: support alternate names for snapshots #45224
>>    mds: limit the snapshot names to 240 characters #45312
>>
>> Lu=C3=ADs Henriques (3):
>>    ceph: add support for encrypted snapshot names
>>    ceph: add support for handling encrypted snapshot names
>>    ceph: update documentation regarding snapshot naming limitations
>>
>>   Documentation/filesystems/ceph.rst |  10 ++
>>   fs/ceph/crypto.c                   | 158 +++++++++++++++++++++++++----
>>   fs/ceph/crypto.h                   |  11 +-
>>   fs/ceph/inode.c                    |  31 +++++-
>>   4 files changed, 182 insertions(+), 28 deletions(-)
>>
>
