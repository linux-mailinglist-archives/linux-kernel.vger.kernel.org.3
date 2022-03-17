Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19924DC485
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiCQLMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiCQLMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:12:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358D1CAF0F;
        Thu, 17 Mar 2022 04:11:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C968B1F37F;
        Thu, 17 Mar 2022 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647515493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRWwxLu6tSwi4l2M+4CwPACdz/Ep8oZjcYHhi+zSnZo=;
        b=wJrdaEiRrIq/v/zHa0n/T9So7Z/OgV9e6X9nB71bgOzvHXx5CrbIROlDYJ2L9po1akdsM/
        u/ehH1s4g2BHMyYM3RDp8KgrC6mLNP9egXKFxkh5n2RJfWnWzkXV7U4NV33tiOgExerr2V
        osPLNhQWfkCv8Yay1us2m2/TFAvKWg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647515493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRWwxLu6tSwi4l2M+4CwPACdz/Ep8oZjcYHhi+zSnZo=;
        b=kQJdk8Lb8wmauRJGsEpbnB3nlPP7su+Wfz+O8UauXC7T86RuGZjzQ+ZJh4iwXBkdmcQVkI
        kTFPNzjKJMcVMCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64BA613B64;
        Thu, 17 Mar 2022 11:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 57LBFWUXM2KFUAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 17 Mar 2022 11:11:33 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id ae5107b0;
        Thu, 17 Mar 2022 11:11:52 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] ceph: add support for snapshot names encryption
References: <20220315161959.19453-1-lhenriques@suse.de>
        <5b53e812-d49b-45f0-1219-3dbc96febbc1@redhat.com>
        <329abedd9d9938de95bf4f5600acdcd6a846e6be.camel@kernel.org>
        <3c8b78c4-5392-b81c-e76f-64fcce4f3c0f@redhat.com>
Date:   Thu, 17 Mar 2022 11:11:52 +0000
In-Reply-To: <3c8b78c4-5392-b81c-e76f-64fcce4f3c0f@redhat.com> (Xiubo Li's
        message of "Thu, 17 Mar 2022 18:52:49 +0800")
Message-ID: <87wngshlzb.fsf@brahms.olymp>
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

> On 3/17/22 6:01 PM, Jeff Layton wrote:
>> I'm not sure we want to worry about .snap directories here since they
>> aren't "real". IIRC, snaps are inherited from parents too, so you could
>> do something like
>>
>>      mkdir dir1
>>      mkdir dir1/.snap/snap1
>>      mkdir dir1/dir2
>>      fscrypt encrypt dir1/dir2
>>
>> There should be nothing to prevent encrypting dir2, but I'm pretty sure
>> dir2/.snap will not be empty at that point.
>
> If we don't take care of this. Then we don't know which snapshots should =
do
> encrypt/dencrypt and which shouldn't when building the path in lookup and=
 when
> reading the snapdir ?

In my patchset (which I plan to send a new revision later today, I think I
still need to rebase it) this is handled by using the *real* snapshot
parent inode.  If we're decrypting/encrypting a name for a snapshot that
starts with a '_' character, we first find the parent inode for that
snapshot and only do the operation if that parent is encrypted.

In the other email I suggested that we could prevent enabling encryption
in a directory when there are snapshots above in the hierarchy.  But now
that I think more about it, it won't solve any problem because you could
create those snapshots later and then you would still need to handle these
(non-encrypted) "_name_xxxx" snapshots anyway.

Cheers,
--=20
Lu=C3=ADs

>
> -- Xiubo
>
>>
>> -- Jeff
>>
>> On Thu, 2022-03-17 at 13:27 +0800, Xiubo Li wrote:
>>> Hi Luis,
>>>
>>> There has another issue you need to handle at the same time.
>>>
>>> Currently only the empty directory could be enabled the file encryption,
>>> such as for the following command:
>>>
>>> $ fscrypt encrypt mydir/
>>>
>>> But should we also make sure that the mydir/.snap/ is empty ?
>>>
>>> Here the 'empty' is not totally empty, which allows it should allow long
>>> snap names exist.
>>>
>>> Make sense ?
>>>
>>> - Xiubo
>>>
>>>
>>> On 3/16/22 12:19 AM, Lu=C3=ADs Henriques wrote:
>>>> Hi!
>>>>
>>>> A couple of changes since v1:
>>>>
>>>> - Dropped the dentry->d_flags change in ceph_mkdir().  Thanks to Xiubo
>>>>     suggestion, patch 0001 now skips calling ceph_fscrypt_prepare_cont=
ext()
>>>>     if we're handling a snapshot.
>>>>
>>>> - Added error handling to ceph_get_snapdir() in patch 0001 (Jeff had
>>>>     already pointed that out but I forgot to include that change in pr=
evious
>>>>     revision).
>>>>
>>>> - Rebased patch 0002 to the latest wip-fscrypt branch.
>>>>
>>>> - Added some documentation regarding snapshots naming restrictions.
>>>>
>>>> As before, in order to test this code the following PRs are required:
>>>>
>>>>     mds: add protection from clients without fscrypt support #45073
>>>>     mds: use the whole string as the snapshot long name #45192
>>>>     mds: support alternate names for snapshots #45224
>>>>     mds: limit the snapshot names to 240 characters #45312
>>>>
>>>> Lu=C3=ADs Henriques (3):
>>>>     ceph: add support for encrypted snapshot names
>>>>     ceph: add support for handling encrypted snapshot names
>>>>     ceph: update documentation regarding snapshot naming limitations
>>>>
>>>>    Documentation/filesystems/ceph.rst |  10 ++
>>>>    fs/ceph/crypto.c                   | 158 +++++++++++++++++++++++++-=
---
>>>>    fs/ceph/crypto.h                   |  11 +-
>>>>    fs/ceph/inode.c                    |  31 +++++-
>>>>    4 files changed, 182 insertions(+), 28 deletions(-)
>>>>
>

