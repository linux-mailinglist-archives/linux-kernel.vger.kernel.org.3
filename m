Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED984CE567
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiCEO50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiCEO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:57:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31C9396AE;
        Sat,  5 Mar 2022 06:56:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 60E481F38E;
        Sat,  5 Mar 2022 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646492194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jp5Wvbe6b7Bf06yAjd7FM+rHWIKWVoVK1y8+Zp4O8dw=;
        b=XmvePgKUuL9Ym+RXKAAweGwNfLsajH4+93iGDbWjnheMuQqOS0Xoas9jAZJDm0GoSdHtnR
        vdAV1tw0IsDHny0zTWCgOJKYjKhcvNtnvF9uylglGvr2XG1hD4xLw03mbWt/DGge3GCbgk
        xrosyxSahLs+9AkGMBZp2L7Wt/ccIKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646492194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jp5Wvbe6b7Bf06yAjd7FM+rHWIKWVoVK1y8+Zp4O8dw=;
        b=4WmqA8beWlH1y1PFB7pNfSB3ps2EiCmHnL22xKoaLmOISE3KSHkZ3j7baUZfWhEkGjHoIF
        HT7jtf7CZH6/y0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE0F613519;
        Sat,  5 Mar 2022 14:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8abJNiF6I2KMYAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Sat, 05 Mar 2022 14:56:33 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 4730fb07;
        Sat, 5 Mar 2022 14:56:49 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ceph: minor fixes and encrypted snapshot names
References: <20220304161403.19295-1-lhenriques@suse.de>
        <87fsnx4rb3.fsf@brahms.olymp>
        <e7f91d0be0f41320e5a4f38ded1bde166626a17f.camel@kernel.org>
Date:   Sat, 05 Mar 2022 14:56:49 +0000
In-Reply-To: <e7f91d0be0f41320e5a4f38ded1bde166626a17f.camel@kernel.org> (Jeff
        Layton's message of "Fri, 04 Mar 2022 13:30:50 -0500")
Message-ID: <878rtoo3bi.fsf@brahms.olymp>
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

> On Fri, 2022-03-04 at 16:26 +0000, Lu=C3=ADs Henriques wrote:
>> Lu=C3=ADs Henriques <lhenriques@suse.de> writes:
>>=20
>> > Hi!
>> >=20
>> > I'm sending another iteration of the encrypted snapshot names patch.  =
This
>> > patch assumes PR#45224 [1] to be merged as it adds support for the
>> > alternate names.
>> >=20
>> > Two notes:
>> >=20
>> > 1. Patch 0001 is just a small fix from another fscrypt patch.  It's
>> >    probably better to simply squash it.
>> >=20
>> > 2. I'm not sure how easy it is to hit the UAF fixed by patch 0002.  I =
can
>> >    reproduce it easily by commenting the code that adds the
>> >    DCACHE_NOKEY_NAME flag in patch 0003.
>>=20
>> Obviously, immediately after sending this patchset I realized I failed to
>> mention a very (*VERY*) important note:
>>=20
>> Snapshot names can not start with a '_'.  I think the reason is related
>> with the 'long snapshot names', but I can't really remember the details
>> anymore.  The point is that an encrypted snapshot name base64-encoded
>> *may* end-up starting with an '_' as we're using the base64-url variant.
>>=20
>> I really don't know if it's possible to fix that.  I guess that in that
>> case the user will get an error and fail to create the snapshot but he'll
>> be clueless because the reason.  Probably a warning can be added to the
>> kernel logs, but maybe there are other ideas.
>>=20
>
>
> Ouch. Is that imposed by the MDS? It'd be best if we could remove that
> limitation from it altogether if we can.

I do remember hitting this limitation in the past, but a quick grep didn't
show anything in the documentation about it.  This seems to have been
added to the MDS a *long* time ago, with commit 068553473c82 ("mds: adjust
trace encoding, clean up snap naming") but (as usual) there aren't a lot
of details.

>
> If we can't, then we might be able to get away with prepending all the
> encrypted names with some legal characte. Then when we go to decrypt it
> we just strip that off.

This is probably the best way to fix it, but it's worth trying to find
out the origins of this limitation.  I do seem to remember some obscure
reasons, related with the long snap names (for which Xiubo has a patch),
which will start with '_'.  But yeah I'll have to go dig deeper.

> We could also consider changing the base64 routine to use something else
> in lieu of '_' but that's more of a hassle.

Cheers,
--=20
Lu=C3=ADs
