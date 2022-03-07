Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9544D00FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiCGOV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiCGOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:21:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA064FC46;
        Mon,  7 Mar 2022 06:20:30 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEED81F394;
        Mon,  7 Mar 2022 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646662828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTJgLLKxkZ6Y3UwRG+LjMmdZQI1eA90Se6Y6fXAhHGE=;
        b=1JSDp5aGb6BLPshhe6iloyGeUSSqP+BOQnffu2VWjbIDkDBitGhft/hFRY64EGxksWTeZS
        ZYqQCLWrOyx61gW2JGo2hAUtYmbadQwWwTGdG56+qXArfXgVOS1ZPQaOO8CUMVVAEGDP2S
        U9inRRYwjtKK2kTOYqelYoRMZU22vcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646662828;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTJgLLKxkZ6Y3UwRG+LjMmdZQI1eA90Se6Y6fXAhHGE=;
        b=nuNVwf3tGbQ0PxS1uuA4gumzUsCo2nShv0pbSxHom/cJgqwWrPy12lsWM89+m32nmpzUmX
        l+r1ZBnPqUYp2nBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 61C7413943;
        Mon,  7 Mar 2022 14:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id utwBFawUJmK0GgAAGKfGzw
        (envelope-from <lhenriques@suse.de>); Mon, 07 Mar 2022 14:20:28 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 706166e7;
        Mon, 7 Mar 2022 14:20:34 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ceph: minor fixes and encrypted snapshot names
References: <20220304161403.19295-1-lhenriques@suse.de>
        <87fsnx4rb3.fsf@brahms.olymp>
        <e7f91d0be0f41320e5a4f38ded1bde166626a17f.camel@kernel.org>
        <878rtoo3bi.fsf@brahms.olymp>
        <66d31a84-2774-3fa1-2a0e-e9125c484755@redhat.com>
Date:   Mon, 07 Mar 2022 14:20:34 +0000
In-Reply-To: <66d31a84-2774-3fa1-2a0e-e9125c484755@redhat.com> (Xiubo Li's
        message of "Mon, 7 Mar 2022 08:49:54 +0800")
Message-ID: <87pmmxu9n1.fsf@brahms.olymp>
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

> On 3/5/22 10:56 PM, Lu=C3=ADs Henriques wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>>
>>> On Fri, 2022-03-04 at 16:26 +0000, Lu=C3=ADs Henriques wrote:
>>>> Lu=C3=ADs Henriques <lhenriques@suse.de> writes:
>>>>
>>>>> Hi!
>>>>>
>>>>> I'm sending another iteration of the encrypted snapshot names patch. =
 This
>>>>> patch assumes PR#45224 [1] to be merged as it adds support for the
>>>>> alternate names.
>>>>>
>>>>> Two notes:
>>>>>
>>>>> 1. Patch 0001 is just a small fix from another fscrypt patch.  It's
>>>>>     probably better to simply squash it.
>>>>>
>>>>> 2. I'm not sure how easy it is to hit the UAF fixed by patch 0002.  I=
 can
>>>>>     reproduce it easily by commenting the code that adds the
>>>>>     DCACHE_NOKEY_NAME flag in patch 0003.
>>>> Obviously, immediately after sending this patchset I realized I failed=
 to
>>>> mention a very (*VERY*) important note:
>>>>
>>>> Snapshot names can not start with a '_'.  I think the reason is related
>>>> with the 'long snapshot names', but I can't really remember the details
>>>> anymore.  The point is that an encrypted snapshot name base64-encoded
>>>> *may* end-up starting with an '_' as we're using the base64-url varian=
t.
>>>>
>>>> I really don't know if it's possible to fix that.  I guess that in that
>>>> case the user will get an error and fail to create the snapshot but he=
'll
>>>> be clueless because the reason.  Probably a warning can be added to the
>>>> kernel logs, but maybe there are other ideas.
>>>>
>>>
>>> Ouch. Is that imposed by the MDS? It'd be best if we could remove that
>>> limitation from it altogether if we can.
>> I do remember hitting this limitation in the past, but a quick grep didn=
't
>> show anything in the documentation about it.  This seems to have been
>> added to the MDS a *long* time ago, with commit 068553473c82 ("mds: adju=
st
>> trace encoding, clean up snap naming") but (as usual) there aren't a lot
>> of details.
>
> When making a snapshot and in MDS code:
>
> 10458=C2=A0=C2=A0 if (snapname.length() =3D=3D 0 ||
> 10459=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snapname[0] =3D=3D '_') {
> 10460=C2=A0=C2=A0=C2=A0=C2=A0 respond_to_request(mdr, -CEPHFS_EINVAL);
> 10461=C2=A0=C2=A0=C2=A0=C2=A0 return;
> 10462=C2=A0=C2=A0 }
>
>
>>> If we can't, then we might be able to get away with prepending all the
>>> encrypted names with some legal characte. Then when we go to decrypt it
>>> we just strip that off.
>> This is probably the best way to fix it, but it's worth trying to find
>> out the origins of this limitation.  I do seem to remember some obscure
>> reasons, related with the long snap names (for which Xiubo has a patch),
>> which will start with '_'.  But yeah I'll have to go dig deeper.
>
> It will recognize the encrypted "_XYZ_${DIGIT}" snapshot name as the long
> snapshot name inherited from its parent snap realm, and will parse the
> "${DIGIT}" as an ino in other places.
>
> Maybe in MDS we should fail the request only when snapshot name is in typ=
e of
> "_XYZ_${DIGIT}" instead of only "_XYZ", and in client side should also pr=
int one
> error or warn log about this ?

I think this will only make the encrypted snapshot creation less likely to
fail, but it's still possible that the base64 encoded of the encrypted
snapshot name to start with '_' and end with '_${DIGIT}'.  Or have I
misunderstood your suggestion?

> This why added the ceph PR[1] to tell the kclient current snapshot name i=
s a
> long snap name in lssnap. So if we can forbid the snap shot name begin wi=
th '_'
> it will simple in kclient code to handle the long snap name, or it will be
> complex in both MDS and kclient.

Yeah, that PR doesn't look too bad, but I'm still looking into your
kernel-side patch.  Which adds a *lot* of complexity to this.  This whole
fscrypt thing is really getting on my nerves -- every single step that
seems simple ends up being a huge pain :-/

Xiubo, have you tested your PR (and corresponding kernel changes) with my
patch?  Do they work correctly?  (I'm about to start looking into doing
that myself, so no worries if you didn't tried that.)

Cheers,
--=20
Lu=C3=ADs

>
> [1] https://github.com/ceph/ceph/pull/45208
>
> -- Xiubo
>
>
>>> We could also consider changing the base64 routine to use something else
>>> in lieu of '_' but that's more of a hassle.
>> Cheers,
>
